
view: by_bene_by_patient_summary {
  derived_table: {
    datagroup_trigger: once_daily
    publish_as_db_view: yes
    create_process: {
      sql_step:
        CREATE OR REPLACE TABLE ${SQL_TABLE_NAME} AS
        SELECT observation_date, bene_id
        FROM (SELECT distinct bene_id FROM `lookerdata.opioid_fraud_new.prescriptions_final`) a
        CROSS JOIN (
          SELECT cast(generated as date) as observation_date
          FROM UNNEST(GENERATE_DATE_ARRAY(DATE((SELECT min(prescription_date) FROM ${prescriptions.SQL_TABLE_NAME})), CURRENT_DATE(),INTERVAL 1 DAY)) AS generated
        ) b
      ;;

      sql_step:
        CREATE OR REPLACE TABLE ${SQL_TABLE_NAME} AS
        SELECT a.bene_id, a.observation_date, sum(ifnull(c.MED,0)) as sum_med
        FROM ${SQL_TABLE_NAME} a
        LEFT JOIN ${prescriptions.SQL_TABLE_NAME} b
          ON a.bene_id = b.bene_id
          AND a.observation_date BETWEEN b.prescription_date and date_add(prescription_date, INTERVAL b.length*30 day)
        LEFT JOIN ${drug.SQL_TABLE_NAME} c
          ON b.drug_id = c.drug_id
        GROUP BY 1,2
      ;;

      sql_step:
        CREATE OR REPLACE TABLE ${SQL_TABLE_NAME} AS
        SELECT a.bene_id, a.observation_date, avg(a.sum_med) as daily_med, avg(b.sum_med) as rolling_med_365
        FROM ${SQL_TABLE_NAME} a
        LEFT JOIN ${SQL_TABLE_NAME} b
          ON a.bene_id = b.bene_id
          AND a.observation_date BETWEEN date_add(b.observation_date, INTERVAL -1 year) and b.observation_date
        GROUP BY 1,2
      ;;

      sql_step:
        CREATE OR REPLACE TABLE ${SQL_TABLE_NAME} AS
        SELECT a.*, b.is_overdose, b.is_death
        FROM ${SQL_TABLE_NAME} a
        LEFT JOIN ${events.SQL_TABLE_NAME} b
          ON a.bene_id = b.bene_id
          AND a.observation_date = b.event_date
      ;;
    }
  }
  dimension: bene_id {}
}

view: bene_dangerous_events {
  derived_table: {
    # datagroup_trigger: once_daily
    explore_source: bene_daily_summary {
      column: bene_id {}
      column: count_deaths {}
      column: count_overdoses {}
      column: count_dangerous_events {}
    }
  }
  dimension: bene_id {
    hidden: yes
  }
  dimension: count_deaths {
    type: number
    hidden: yes
  }
  dimension: count_overdoses {
    type: number
    hidden: yes
  }
  dimension: count_dangerous_events {
    type: number
    hidden: yes
  }
  dimension: has_dangerous_event {
    hidden: yes
    type: yesno
    sql: ${count_dangerous_events} > 1 ;;
  }
  measure: count_beneficaries {
    hidden: yes
    type: count_distinct
    sql: ${bene_id} ;;
  }
  measure: count_beneficaries_dangerous_event {
    hidden: yes
    type: count_distinct
    sql: ${bene_id} ;;
    filters: [has_dangerous_event: "Yes"]
  }
  measure: percent_dangerous_event {
    group_label: "Risk Factors"
    label: "3 % - Dangerous Event"
    type: number
    sql: 1.0 * ${count_beneficaries_dangerous_event} / nullif(${count_beneficaries},0) ;;
    value_format_name: percent_1
    drill_fields: [bene_daily_summary.event_drill*]
  }
}

view: benchmark_value {
  dimension: dim_percent_opioid_prescriptions { hidden: yes }
  dimension: dim_percent_dangerous_supply_lengths { hidden: yes }
  dimension: dim_percent_dangerous_event { hidden: yes }
  dimension: dim_percent_dangerous_distances { hidden: yes }
  dimension: dim_risk_score { hidden: yes }
  measure: percent_opioid_prescriptions {
    group_label: "Lifetime Risk Factors" label: "1 % - Opioid Prescription"
    type: average sql: ${dim_percent_opioid_prescriptions} ;; value_format_name: percent_1}
  measure: percent_dangerous_supply_lengths {
    group_label: "Lifetime Risk Factors" label: "2 % - Supply Length"
    type: average sql: ${dim_percent_dangerous_supply_lengths} ;; value_format_name: percent_1}
  measure: percent_dangerous_event {
    group_label: "Lifetime Risk Factors" label: "3 % - Dangerous Event"
    type: average sql: ${dim_percent_dangerous_event} ;; value_format_name: percent_1}
  measure: percent_dangerous_distances {
    group_label: "Lifetime Risk Factors" label: "4 % - Distance"
    type: average sql: ${dim_percent_dangerous_distances} ;; value_format_name: percent_1}
  measure: risk_score {
    group_label: "Lifetime Risk Factors" label: "*Risk Score"
    type: average sql: ${dim_risk_score} ;; value_format_name: percent_1 }

#   dimension: count_opioid_prescriptions { hidden: yes }
#   dimension: count_prescriptions { hidden: yes }
#   dimension: count_dangerous_supply_lengths { hidden: yes }
#   dimension: count_dangerous_events { hidden: yes }
#   dimension: count_beneficaries { hidden: yes }
#   dimension: count_dangerous_distances { hidden: yes }
#   measure: sum_count_opioid_prescriptions { hidden: yes type: sum sql: ${count_opioid_prescriptions} ;; }
#   measure: sum_count { hidden: yes type: sum sql: ${count_prescriptions} ;; }
#   measure: sum_count_dangerous_supply_lengths { hidden: yes type: sum sql: ${count_dangerous_supply_lengths} ;; }
#   measure: sum_count_dangerous_events { hidden: yes type: sum sql: ${count_dangerous_events} ;; }
#   measure: sum_count_beneficaries { hidden: yes type: sum sql: ${count_beneficaries} ;; }
#   measure: sum_count_dangerous_distances { hidden: yes type: sum sql: ${count_dangerous_distances} ;; }
#   measure: percent_opioid_prescriptions {
#     group_label: "Lifetime Risk Factors"
#     label: "1 % - Opioid Prescription"
#     type: number
#     sql: 1.0 * ${sum_count_opioid_prescriptions} / nullif(${sum_count},0);;
#     value_format_name: percent_1
#   }
#   measure: percent_dangerous_supply_lengths {
#     group_label: "Lifetime Risk Factors"
#     label: "2 % - Supply Length"
#     type: number
#     sql: 1.0 * ${sum_count_dangerous_supply_lengths} / nullif(${sum_count},0);;
#     value_format_name: percent_1
#   }
#   measure: percent_dangerous_event {
#     group_label: "Lifetime Risk Factors"
#     label: "3 % - Dangerous Event"
#     type: number
#     sql: 1.0 * ${sum_count_dangerous_events} / nullif(${sum_count_beneficaries},0);;
#     value_format_name: percent_1
#   }
#   measure: percent_dangerous_distances {
#     group_label: "Lifetime Risk Factors"
#     label: "4 % - Distance"
#     type: number
#     sql: 1.0 * ${sum_count_dangerous_distances} / nullif(${sum_count},0);;
#     value_format_name: percent_1
#   }
#   measure: risk_score {
#     group_label: "Lifetime Risk Factors"
#     label: "*Risk Score"
#     type: number
#     value_format_name: percent_1
#     sql:
#           (
#             ${percent_opioid_prescriptions} *     {% parameter bene_daily_summary.weight_opioid_claims %}
#         +   ${percent_dangerous_supply_lengths} * {% parameter bene_daily_summary.weight_supply_length %}
#         +   ${percent_dangerous_event} *          {% parameter bene_daily_summary.weight_dangerous_events %}
#         +   ${percent_dangerous_distances} *      {% parameter bene_daily_summary.weight_distance %}
#       ) /
#       nullif(({% parameter bene_daily_summary.weight_opioid_claims %} + {% parameter bene_daily_summary.weight_supply_length %}
#       + {% parameter bene_daily_summary.weight_dangerous_events %} + {% parameter bene_daily_summary.weight_distance %}),0)
#     ;;
#   }
}

view: cohort_value {
  extends: [benchmark_value]
  derived_table: {
    # datagroup_trigger: once_daily
    explore_source: bene_daily_summary {
      column: dim_percent_opioid_prescriptions { field: prescriptions.percent_opioid_prescriptions }
      column: dim_percent_dangerous_supply_lengths { field: prescriptions.percent_dangerous_supply_lengths }
      column: dim_percent_dangerous_event { field: bene_dangerous_events.percent_dangerous_event }
      column: dim_percent_dangerous_distances { field: prescriptions.percent_dangerous_distances }
      column: dim_risk_score { field: bene_daily_summary.risk_score }
      derived_column: x {
        sql: 'X' ;;
      }
    }
  }
  dimension: x { hidden: yes primary_key: yes }
  measure: percent_opioid_prescriptions { group_label: "Cohort" }
  measure: percent_dangerous_supply_lengths { group_label: "Cohort" }
  measure: percent_dangerous_event { group_label: "Cohort" }
  measure: percent_dangerous_distances { group_label: "Cohort" }
  measure: risk_score { group_label: "Cohort" }
  measure: difference_risk_score {
    group_label: "Cohort (% Difference)"
    label: "*Risk Score (vs. Cohort)"
    type: number
    sql: 1.0 * (${bene_daily_summary.risk_score} - ${risk_score}) / nullif(${bene_daily_summary.risk_score},0) ;;
    value_format_name: percent_1
  }
  measure: difference_percent_opioid_prescriptions {
    group_label: "Cohort (% Difference)"
    label: "1 % Opioid Prescriptions (vs. Cohort)"
    type: number
    sql: 1.0 * (${prescriptions.percent_opioid_prescriptions} - ${percent_opioid_prescriptions}) / nullif(${prescriptions.percent_opioid_prescriptions},0) ;;
    value_format_name: percent_1
  }
  measure: difference_percent_dangerous_supply_lengths {
    group_label: "Cohort (% Difference)"
    label: "2 % Supply Length (vs. Cohort)"
    type: number
    sql: 1.0 * (${prescriptions.percent_dangerous_supply_lengths} - ${percent_dangerous_supply_lengths}) / nullif(${prescriptions.percent_dangerous_supply_lengths},0) ;;
    value_format_name: percent_1
  }
  measure: difference_percent_dangerous_event {
    group_label: "Cohort (% Difference)"
    label: "3 % Dangerous Event (vs. Cohort)"
    type: number
    sql: 1.0 * (${bene_dangerous_events.percent_dangerous_event} - ${percent_dangerous_event}) / nullif(${bene_dangerous_events.percent_dangerous_event},0) ;;
    value_format_name: percent_1
  }
  measure: difference_percent_dangerous_distances {
    group_label: "Cohort (% Difference)"
    label: "4 % Distance (vs. Cohort)"
    type: number
    sql: 1.0 * (${prescriptions.percent_dangerous_distances} - ${percent_dangerous_distances}) / nullif(${prescriptions.percent_dangerous_distances},0) ;;
    value_format_name: percent_1
  }
}

view: bene_lifetime_value {
  extends: [benchmark_value]
  derived_table: {
    # datagroup_trigger: once_daily
    explore_source: bene_daily_summary {
      column: bene_id {}
      column: dim_percent_opioid_prescriptions { field: prescriptions.percent_opioid_prescriptions }
      column: dim_percent_dangerous_supply_lengths { field: prescriptions.percent_dangerous_supply_lengths }
      column: dim_percent_dangerous_event { field: bene_dangerous_events.percent_dangerous_event }
      column: dim_percent_dangerous_distances { field: prescriptions.percent_dangerous_distances }
      column: dim_risk_score { field: bene_daily_summary.risk_score }
#       column: count_opioid_prescriptions { field: prescriptions.count_opioid_prescriptions }
#       column: count_prescriptions { field: prescriptions.count }
#       column: count_dangerous_supply_lengths { field: prescriptions.count_dangerous_supply_lengths }
#       column: count_dangerous_events { field: bene_dangerous_events.count_dangerous_events }
#       column: count_beneficaries { field: bene_dangerous_events.count_beneficaries }
#       column: count_dangerous_distances { field: prescriptions.count_dangerous_distances }
      column: count_providers { field: provider.count }
      column: count_pharmacy { field: pharmacy.count }
      column: average_med_365 {}
    }
  }
  dimension: bene_id { hidden: no primary_key: yes }
  dimension: dim_count_providers { hidden: yes sql: ${TABLE}.count_providers ;;}
  dimension: dim_count_pharmacy { hidden: yes sql: ${TABLE}.count_pharmacy ;;}
  dimension: dim_average_med_365 { hidden: yes sql: ${TABLE}.average_med_365 ;;}
  dimension: doctor_shopper {
    description: "Doctor shopper refers to a beneficiary who sees 2+ doctors and 2+ pharmacies"
    type: yesno
    sql: ${dim_count_providers} >= 2 AND ${dim_count_pharmacy} >= 2  ;;
  }
  measure: count_providers {group_label: "Lifetime Risk Factors" type: average sql: ${dim_count_providers} ;; }
  measure: count_pharmacy {group_label: "Lifetime Risk Factors" type: average sql: ${dim_count_pharmacy} ;; }
  measure: average_med_365 {group_label: "Lifetime Risk Factors" type: average sql: ${dim_average_med_365} ;; }
}

view: provider_lifetime_value {
  extends: [benchmark_value]
  derived_table: {
    # datagroup_trigger: once_daily
    explore_source: bene_daily_summary {
      column: provider_id { field: prescriptions.provider_id }
      column: dim_percent_opioid_prescriptions { field: prescriptions.percent_opioid_prescriptions }
      column: dim_percent_dangerous_supply_lengths { field: prescriptions.percent_dangerous_supply_lengths }
      column: dim_percent_dangerous_event { field: bene_dangerous_events.percent_dangerous_event }
      column: dim_percent_dangerous_distances { field: prescriptions.percent_dangerous_distances }
      column: dim_risk_score { field: bene_daily_summary.risk_score }
#       column: count_opioid_prescriptions { field: prescriptions.count_opioid_prescriptions }
#       column: count_prescriptions { field: prescriptions.count }
#       column: count_dangerous_supply_lengths { field: prescriptions.count_dangerous_supply_lengths }
#       column: count_dangerous_events { field: bene_dangerous_events.count_dangerous_events }
#       column: count_beneficaries { field: bene_dangerous_events.count_beneficaries }
#       column: count_dangerous_distances { field: prescriptions.count_dangerous_distances }
    }
  }
  dimension: provider_id { hidden: yes primary_key: yes }
}

view: pharmacy_lifetime_value {
  extends: [benchmark_value]
  derived_table: {
    # datagroup_trigger: once_daily
    explore_source: bene_daily_summary {
      column: pharmacy_id { field: prescriptions.pharmacy_id }
      column: dim_percent_opioid_prescriptions { field: prescriptions.percent_opioid_prescriptions }
      column: dim_percent_dangerous_supply_lengths { field: prescriptions.percent_dangerous_supply_lengths }
      column: dim_percent_dangerous_event { field: bene_dangerous_events.percent_dangerous_event }
      column: dim_percent_dangerous_distances { field: prescriptions.percent_dangerous_distances }
      column: dim_risk_score { field: bene_daily_summary.risk_score }
#       column: count_opioid_prescriptions { field: prescriptions.count_opioid_prescriptions }
#       column: count_prescriptions { field: prescriptions.count }
#       column: count_dangerous_supply_lengths { field: prescriptions.count_dangerous_supply_lengths }
#       column: count_dangerous_events { field: bene_dangerous_events.count_dangerous_events }
#       column: count_beneficaries { field: bene_dangerous_events.count_beneficaries }
#       column: count_dangerous_distances { field: prescriptions.count_dangerous_distances }
    }
  }
  dimension: pharmacy_id { hidden: yes primary_key: yes }
}


# view: bene_lifetime_value_2 {
#   derived_table: {
#     datagroup_trigger: once_daily
#     explore_source: bene_daily_summary {
#       column: bene_id {}
#       column: dim_percent_opioid_prescriptions { field: prescriptions.percent_opioid_prescriptions }
#       column: dim_percent_dangerous_supply_lengths { field: prescriptions.percent_dangerous_supply_lengths }
#       column: dim_percent_dangerous_event { field: bene_dangerous_events.percent_dangerous_event }
#       column: dim_percent_dangerous_distances { field: prescriptions.percent_dangerous_distances }
#     }
#   }
#   dimension: bene_id { hidden: no primary_key: yes }
#   dimension: dim_percent_opioid_prescriptions { hidden: yes }
#   dimension: dim_percent_dangerous_supply_lengths { hidden: yes }
#   dimension: dim_percent_dangerous_event { hidden: yes }
#   dimension: dim_percent_dangerous_distances { hidden: yes }
#   measure: percent_opioid_prescriptions { type: average sql: ${dim_percent_opioid_prescriptions} ;; value_format_name: percent_1}
#   measure: percent_dangerous_supply_lengths { type: average sql: ${dim_percent_dangerous_supply_lengths} ;; value_format_name: percent_1}
#   measure: percent_dangerous_event { type: average sql: ${dim_percent_dangerous_event} ;; value_format_name: percent_1}
#   measure: percent_dangerous_distances { type: average sql: ${dim_percent_dangerous_distances} ;; value_format_name: percent_1}
# }

# view: cohort_lifetime_value_2 {}
