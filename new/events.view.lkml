view: events {
  sql_table_name: `lookerdata.opioid_fraud_new.events_final`
    ;;

#############
### Original Dimensions
#############

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: concat(${bene_id}, ' | ', ${event_raw}) ;;
  }

  dimension: bene_id {
    type: number
    sql: ${TABLE}.bene_id ;;
  }

  dimension_group: event {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_date ;;
  }

  dimension: is_death {
    type: yesno
    sql: ${TABLE}.is_death ;;
  }

  dimension: is_overdose {
    type: yesno
    sql: ${TABLE}.is_overdose ;;
  }

#############
### Derived Dimensions
#############

#############
### Measures
#############

  measure: count {
    type: count
    drill_fields: []
  }
}
