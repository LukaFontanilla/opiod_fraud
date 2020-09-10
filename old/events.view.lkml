
view: events_MED {

  dimension: pk {
    hidden: yes
    type: number
    primary_key: yes
    sql: concat(cast(${bene_id} as varchar(50)),concat(${event_type},cast(${event_date} as varchar(50)))) ;;
  }

  dimension: bene_id {
    hidden: yes
    type: number
  }

  dimension: event_type {
    type: string
    drill_fields: [beneficiary.bene_id_code]
  }

  dimension_group: event {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: cast(${TABLE}.event_date as timestamp) ;;
  }

  measure: count_events {
    type: number
    sql: ${count_overdoses} + ${count_deaths} ;;
    drill_fields: [drill*]
  }

  measure: count_overdoses {
    type: count
    filters: {
      field: event_type
      value: "Overdose"
    }
    drill_fields: [drill*]
  }

  measure: count_deaths {
    type: count
    filters: {
      field: event_type
      value: "Death"
    }
    drill_fields: [drill*]
  }

  dimension: daily_MED {
    hidden: yes
    type: number
  }

  dimension: rolling_MED_365 {
    hidden: yes
    type: number
  }

  measure: avg_total_MED {
    label: "MED Daily"
    type: average
    sql: ${daily_MED} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }

  measure: avg_rolling_MED_365 {
    label: "MED Rolling 365"
    type: average
    sql: ${rolling_MED_365} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }

  measure: max_avg_rolling_MED_365 {
    label: "MED Max Rolling 365"
    type: max
    sql: ${rolling_MED_365} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      beneficiary.bene_id_code,
      count_overdoses,
      count_deaths,
      avg_total_MED,
      max_avg_rolling_MED_365
    ]
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:
  SELECT bene_id, 'MED' as event_type, date as event_date, daily_MED, rolling_MED_365 FROM ${med_usage_by_date_by_bene_365_rolling.SQL_TABLE_NAME}
  UNION ALL
  SELECT *, NULL as daily_MED, NULL as rolling_MED_365 FROM ${events.SQL_TABLE_NAME}
;;
  }
}

view: events {

  dimension: pk {
    hidden: yes
    type: number
    primary_key: yes
    sql: concat(cast(${bene_id} as varchar(50)),concat('-',cast(${event_date} as varchar(50)))) ;;
  }

  dimension: bene_id {
    hidden: yes
    type: number
  }

  dimension: event_type {
    type: string
  }

  dimension_group: event {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: cast(${TABLE}.event_date as timestamp) ;;
  }

  measure: count_events {
    type: count
  }

  measure: count_overdoses {
    type: count
    filters: {
      field: event_type
      value: "Overdose"
    }
  }

  measure: count_deaths {
    type: count
    filters: {
      field: event_type
      value: "Death"
    }
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:
SELECT bene_id, 'Overdose' as event_type, first_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 1 UNION ALL
SELECT bene_id, 'Overdose' as event_type, second_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 1 UNION ALL
SELECT bene_id, 'Overdose' as event_type, third_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 1 UNION ALL
SELECT bene_id, 'Overdose' as event_type, first_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 2 UNION ALL
SELECT bene_id, 'Overdose' as event_type, second_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 2 UNION ALL
SELECT bene_id, 'Death' as event_type, third_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 2 UNION ALL
SELECT bene_id, 'Overdose' as event_type, first_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 8 UNION ALL
SELECT bene_id, 'Overdose' as event_type, second_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 8 UNION ALL
SELECT bene_id, 'Death' as event_type, death as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 8 UNION ALL
--SELECT bene_id, 'Death' as event_type, death as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 2 UNION ALL
SELECT bene_id, 'Overdose' as event_type, first_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 3 UNION ALL
SELECT bene_id, 'Overdose' as event_type, second_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 3 UNION ALL
SELECT bene_id, 'Overdose' as event_type, second_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 4 UNION ALL
SELECT bene_id, 'Death' as event_type, third_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 4 UNION ALL
SELECT bene_id, 'Overdose' as event_type, second_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 9 UNION ALL
SELECT bene_id, 'Death' as event_type, death as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 9 UNION ALL
SELECT bene_id, 'Overdose' as event_type, second_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 5 UNION ALL
SELECT bene_id, 'Overdose' as event_type, third_overdose as event_date FROM ${events_pre_aggd_with_type.SQL_TABLE_NAME} WHERE type = 6
;;
  }
}

view: events_pre_aggd_with_type {
  derived_table: {
    explore_source: events_pre_aggd {
      column: bene_id {}
      column: type {}
      column: first_overdose {}
      column: second_overdose {}
      column: third_overdose {}
      column: death {}
    }
  }
  dimension: bene_id {
    type: number
  }
  dimension: type {
    type: number
  }
  dimension: first_overdose {
    type: date
  }
  dimension: second_overdose {
    type: date
  }
  dimension: third_overdose {
    type: date
  }
  dimension: death {
    type: date
  }
}


view: events_pre_aggd {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: events_pre {
      column: bene_id {}
      column: count {}
      column: max_date {}
      column: first_overdose {}
      column: second_overdose {}
      column: third_overdose {}
      column: death {}
    }
  }
  dimension: bene_id {
    type: number
  }
  dimension: count {
    type: number
  }
  dimension: max_date {
    type: date
  }
  dimension: first_overdose {
    type: date
  }
  dimension: second_overdose {
    type: date
  }
  dimension: third_overdose {
    type: date
  }
  dimension: death {
    type: date
  }
  dimension: type {
    type: number
    sql:
      CASE
        WHEN ${count} > 8 and right(cast(${bene_id} as varchar(5)),1) in ('0','2','4','6','8') then 1
        WHEN ${count} > 8 and right(cast(${bene_id} as varchar(5)),1) in ('5','7') then 8
        WHEN ${count} > 8 and right(cast(${bene_id} as varchar(5)),1) not in ('0','2','4','6','8') then 2
        WHEN ${count} > 4 and right(cast(${bene_id} as varchar(5)),1) in ('0','2','4','6','8') then 3
        WHEN ${count} > 4 and right(cast(${bene_id} as varchar(5)),1) in ('5','7') then 9
        WHEN ${count} > 4 and right(cast(${bene_id} as varchar(5)),1) not in ('0','2','4','6','8') then 4
        WHEN ${count} > 0 and right(cast(${bene_id} as varchar(5)),1) in ('0','2','4','6','8') then 5
        WHEN ${count} > 0 and right(cast(${bene_id} as varchar(5)),1) not in ('0','2','4','6','8') then 6
        ELSE 7
      END
        ;;
  }
  measure: counts {
    type: count
  }
}


view: events_pre {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: med_usage_by_date_by_bene_365_rolling {
      column: bene_month {}
      column: bene_id {}
      column: date_month {}
      column: avg_total_MED {}
      filters: {
        field: med_usage_by_date_by_bene_365_rolling.avg_total_MED
        value: ">200"
      }
      filters: {
        field: med_usage_by_date_by_bene_365_rolling.avg_rolling_MED_365
        value: ">150"
      }
    }
  }
  dimension: bene_month {}
  dimension: bene_id {
    type: number
  }
  dimension: date_month {
    type: date_month
  }
  dimension: avg_total_MED {
    type: number
  }
  measure: max_date {
    type: date
    sql: max(concat(${date_month},'-01')) ;;
  }
  measure: first_overdose {
    type: date
    sql: dateadd(day,-1*round(${bene_id}*(30/50),0),dateadd(week,round(${bene_id}*(30/200),0),dateadd(month,-11,${max_date}))) ;;
  }
  measure: second_overdose {
    type: date
    sql: dateadd(day,-1*round(${bene_id}*(30/50),0)+5,dateadd(week,round(${bene_id}*(30/200),0)+1,dateadd(month,-8,${max_date}))) ;;
  }
  measure: third_overdose {
    type: date
    sql: dateadd(day,-1*round(${bene_id}*(30/50),0)-10,dateadd(week,round(${bene_id}*(30/200),0)-1,dateadd(month,-5,${max_date}))) ;;
  }
  measure: death {
    type: date
    sql: dateadd(day,-1*round(${bene_id}*(30/50),0)+35,dateadd(week,round(${bene_id}*(30/200),0)-1,dateadd(month,-1,${max_date}))) ;;
  }
  measure: count {
    type: count
  }
}
