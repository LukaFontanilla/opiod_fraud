
view: med_usage_by_date_by_bene_365_rolling {

  dimension: pk {
    hidden: yes
    type: string
    primary_key: yes
    sql: concat(cast(${bene_id} as varchar(50)),concat('-',cast(${date_date} as varchar(50))));;
  }

  dimension: bene_id {
    hidden: yes
    type: number
  }

  dimension_group: date {
    label: "MED"
    sql: cast(${TABLE}.date as timestamp) ;;
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
  }

  dimension: daily_MED {
    hidden: yes
    type: number
  }

  dimension: rolling_MED_365 {
    hidden: yes
    type: number
  }

  dimension: bene_month {
    hidden: yes
    type: string
    sql: concat(cast(${bene_id} as varchar(50)),concat('-',cast(${date_month} as varchar(50)))) ;;
  }

  measure: avg_total_MED {
    type: average
    sql: ${daily_MED} ;;
    value_format_name: decimal_1
  }

  measure: avg_rolling_MED_365 {
    type: average
    sql: ${rolling_MED_365} ;;
    value_format_name: decimal_1
  }

  measure: max_avg_rolling_MED_365 {
    type: max
    sql: ${rolling_MED_365} ;;
    value_format_name: decimal_1
  }

  measure: count_distinct_months {
    hidden: yes
    type: count_distinct
    sql: ${date_month} ;;
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:
      SELECT a.bene_id, a.date, avg(a.sum_MED) as daily_MED, avg(b.sum_MED) as rolling_MED_365
      FROM ${med_usage_by_date_by_bene.SQL_TABLE_NAME} a
      LEFT JOIN ${med_usage_by_date_by_bene.SQL_TABLE_NAME} b
        ON a.bene_id = b.bene_id
        AND a.date BETWEEN dateadd(year,-1,b.date) and b.date
      GROUP BY 1,2
;;
  }
}

view: med_usage_by_date_by_bene {

  dimension: bene_id {
    type: number
  }

  dimension: date {
    type: date
  }

  dimension: sum_MED {
    type: number
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:
      SELECT a.bene_id, a.date, sum(ifnull(c.MED,0)) as sum_MED
      FROM ${by_date_by_bene_cross.SQL_TABLE_NAME} a
      LEFT JOIN ${claims_raw.SQL_TABLE_NAME} b
        ON a.bene_id = b.bene_id
        AND a.date BETWEEN b.date and dateadd(day, b.length*30, b.date)
      LEFT JOIN ${drug_raw.SQL_TABLE_NAME} c
        ON b.drug_id = c.drug_id
      GROUP BY 1,2

;;
  }
}

view: by_date_by_bene_cross {
  derived_table: {
    datagroup_trigger: once_yearly
    sql:
      SELECT bene_id, date
      FROM ${date_raw.SQL_TABLE_NAME}
      CROSS JOIN ${beneficiary_raw.SQL_TABLE_NAME}
      GROUP BY 1, 2
;;
  }
}
