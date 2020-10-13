view: bene_daily_summary {
  sql_table_name: `lookerdata.looker_scratch.XH_demo_datasets_by_bene_by_patient_summary`
    ;;

#############
### Original Dimensions
#############

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: concat(${bene_id}, ' | ', ${observation_raw}) ;;
  }

  dimension: bene_id {
    hidden: yes
    type: number
    sql: ${TABLE}.bene_id ;;
  }

  dimension: daily_med {
    group_label: "MED Reading"
    label: "MED"
    type: number
    sql: ${TABLE}.daily_med ;;
  }

  dimension: is_death {
    group_label: "Dangerous Events"
    type: yesno
    sql: ${TABLE}.is_death ;;
  }

  dimension: is_overdose {
    group_label: "Dangerous Events"
    type: yesno
    sql: ${TABLE}.is_overdose ;;
  }

  dimension_group: observation {
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
    sql: ${TABLE}.observation_date ;;
    drill_fields: [observation_month, observation_week, beneficiary.name, provider.name]
  }

  dimension: rolling_med_365 {
    group_label: "MED Reading"
    label: "MED, Rolling 365 Average"
    type: number
    sql: ${TABLE}.rolling_med_365 ;;
  }

#############
### Derived Dimensions
#############

  dimension: is_dangerous_event {
    group_label: "Dangerous Events"
    type: yesno
    sql: ${is_death} OR ${is_overdose} ;;
  }

  dimension: type {
    group_label: "Dangerous Events"
    description: "Death, Overdose"
    type: string
    sql:
      CASE
        WHEN ${is_death} THEN 'Death'
        WHEN ${is_overdose} THEN 'Overdose'
        ELSE NULL
      END
    ;;
  }

#############
### Measures
#############

  measure: count {
    hidden: yes
    type: count
  }

## MED Reading

  measure: average_med {
    group_label: "MED Reading"
    label: "Average Daily MED"
    type: average
    sql: ${daily_med} ;;
    value_format_name: decimal_1
    drill_fields: [event_drill*]
  }

  measure: average_med_365 {
    group_label: "MED Reading"
    label: "Average MED, Rolling 365"
    type: average
    sql: ${rolling_med_365} ;;
    value_format_name: decimal_1
    drill_fields: [event_drill*]
  }


## Dangerous Events

  measure: count_overdoses {
    group_label: "Dangerous Events"
    type: count
    filters: [is_overdose: "Yes"]
    drill_fields: [event_drill*]
  }

  measure: count_deaths {
    group_label: "Dangerous Events"
    type: count
    filters: [is_death: "Yes"]
    drill_fields: [event_drill*]
  }

  measure: count_dangerous_events {
    group_label: "Dangerous Events"
    type: count
    filters: [is_dangerous_event: "Yes"]
    drill_fields: [event_drill*]
  }

### Risk Factors
  parameter: weight_opioid_claims {
    group_label: "Risk Score Weights"
    type:  number
    default_value: "3"
  }

  parameter: weight_supply_length {
    group_label: "Risk Score Weights"
    type:  number
    default_value: "1"
  }

  parameter: weight_dangerous_events {
    group_label: "Risk Score Weights"
    type:  number
    default_value: "4"
  }

  parameter: weight_distance {
    group_label: "Risk Score Weights"
    type:  number
    default_value: "2"
  }

  measure: risk_score {
    group_label: "Risk Factors"
    label: "*Risk Score"
    type: number
    value_format_name: percent_1
    sql:
          (
            ${prescriptions.percent_opioid_prescriptions} *     {% parameter weight_opioid_claims %}
        +   ${prescriptions.percent_dangerous_supply_lengths} * {% parameter weight_supply_length %}
        +   ${bene_dangerous_events.percent_dangerous_event} *  {% parameter weight_dangerous_events %}
        +   ${prescriptions.percent_dangerous_distances} *      {% parameter weight_distance %}
      ) /
      nullif(({% parameter weight_opioid_claims %} + {% parameter weight_supply_length %}
      + {% parameter weight_dangerous_events %} + {% parameter weight_distance %}),0)
    ;;
    link: {
      label: "Data Science Dashboard"
      url: "/dashboards/11"
      icon_url: "http://www.google.com/s2/favicons?domain=looker.com"
    }
    drill_fields: [risk_drill*]
  }

  set: event_drill {
    fields: [
      beneficiary.name,
      observation_date,
      type,
      average_med,
      average_med_365
    ]
  }

  set: risk_drill {
    fields: [
        beneficiary.name
      , risk_score
      , prescriptions.percent_opioid_prescriptions
      , prescriptions.percent_dangerous_supply_lengths
      , bene_dangerous_events.percent_dangerous_event
      , prescriptions.percent_dangerous_distances
    ]
  }
}
