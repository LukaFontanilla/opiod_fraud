
view: stats_by_doctor_combined {

  dimension: doctor_id {
    primary_key: yes
    hidden: yes
    type: number
  }
  dimension: average_distance_bene_doctor {
    hidden: yes
    type: number
  }
  dimension: count_events {
    hidden: yes
    type: number
  }
  dimension: percent_opioid_claims {
    hidden: yes
    type: number
  }
  dimension: average_opioid_supply_length {
    hidden: yes
    type: number
  }
  dimension: average_distance_bene_doctor_cohort {
    hidden: yes
    type: number
  }
  dimension: count_events_cohort {
    hidden: yes
    type: number
  }
  dimension: percent_opioid_claims_cohort {
    hidden: yes
    type: number
  }
  dimension: average_opioid_supply_length_cohort {
    hidden: yes
    type: number
  }
  measure: average__distance_bene_doctor {
    group_label: "KPIs - Doctor"
    type: average
    sql: ${average_distance_bene_doctor} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: count__events {
    group_label: "KPIs - Doctor"
    type: average
    sql: ${count_events} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: percent__opioid_claims {
    group_label: "KPIs - Doctor"
    type: average
    sql: ${percent_opioid_claims} ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }
  measure: percent__non_opioid_claims {
    group_label: "KPIs - Doctor"
    type: number
    sql: 1.0 - ${percent__opioid_claims} ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }
  measure: average__opioid_supply_length {
    group_label: "KPIs - Doctor"
    type: average
    sql: ${average_opioid_supply_length} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: average__distance_bene_doctor_cohort {
    group_label: "KPIs - Cohort"
    type: average
    sql: ${average_distance_bene_doctor_cohort} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: count__events_cohort {
    group_label: "KPIs - Cohort"
    type: average
    sql: ${count_events_cohort} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: percent__opioid_claims_cohort {
    group_label: "KPIs - Cohort"
    type: average
    sql: ${percent_opioid_claims_cohort} ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }
  measure: percent__non_opioid_claims_cohort {
    group_label: "KPIs - Cohort"
    type: number
    sql: 1.0 - ${percent__opioid_claims_cohort} ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }
  measure: average__opioid_supply_length_cohort {
    group_label: "KPIs - Cohort"
    type: average
    sql: ${average_opioid_supply_length_cohort} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: percent_from_cohort_average_distance_bene_doctor {
    label: "5 - Distance Risk"
    type: number
    sql: 1.0*(${average__distance_bene_doctor} - ${average__distance_bene_doctor_cohort}) / nullif(${average__distance_bene_doctor},0) ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }
  measure: percent_from_cohort_count_events {
    label: "4 - Overdose Risk"
    type: number
    sql: 1.0*(${count__events} - ${count__events_cohort}) / nullif(${count__events},0) ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }
  measure: percent_from_cohort_percent_opioid_claims {
    label: "2 - % Opioids Risk"
    type: number
    sql: 1.0*(${percent__opioid_claims} - ${percent__opioid_claims_cohort}) / nullif(${percent__opioid_claims},0) ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }
  measure: percent_from_cohort_average_opioid_supply_length {
    label: "3 - Supply Length Risk"
    type: number
    sql: 1.0*(${average__opioid_supply_length} - ${average__opioid_supply_length_cohort}) / nullif(${average__opioid_supply_length},0) ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }

  parameter: weight_distance {
    type:  unquoted
    default_value: "1"
  }

  parameter: weight_events {
    type:  unquoted
    default_value: "2"
  }

  parameter: weight_percent_opioid_claims {
    type:  unquoted
    default_value: "3"
  }

  parameter: weight_supply_length {
    type:  unquoted
    default_value: "1"
  }

  dimension: weight_distance_value {
    type: number
    sql: {% parameter weight_distance %} ;;
    hidden:  yes
  }

  dimension: weight_events_value {
    type: number
    sql: {% parameter weight_events %} ;;
    hidden:  yes
  }

  dimension: weight_percent_opioid_claims_value {
    type: number
    sql: {% parameter weight_percent_opioid_claims %} ;;
    hidden:  yes
  }

  dimension: weight_supply_length_value {
    type: number
    sql: {% parameter weight_supply_length %} ;;
    hidden:  yes
  }

  dimension: sum_weights_dimension {
    type: number
    hidden: yes
    sql:    ${weight_distance_value} +
            ${weight_events_value} +
            ${weight_percent_opioid_claims_value} +
            ${weight_supply_length_value}
            ;;
  }

  measure: sum_weights {
    hidden: yes
    type: number
    sql:    ${weight_distance_value} +
            ${weight_events_value} +
            ${weight_percent_opioid_claims_value} +
            ${weight_supply_length_value}
    ;;
  }

  measure: risk_score_dimension {
    label: "1 - Risk Score"
    type: number
    value_format_name: percent_1
    sql:
          (
            ${percent_from_cohort_average_distance_bene_doctor} * ${weight_distance_value}
        +   ${percent_from_cohort_count_events} * ${weight_events_value}
        +   ${percent_from_cohort_percent_opioid_claims} * ${weight_percent_opioid_claims_value}
        +  ${percent_from_cohort_average_opioid_supply_length} * ${weight_supply_length_value}
      ) /   nullif(${sum_weights},0)
    ;;
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      doctor.npi,
      doctor.specialty,
      count__events,
      percent__opioid_claims,
      average__opioid_supply_length,
      average_distance_bene_doctor,
      risk_score_dimension
    ]
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:
    SELECT a.*,
      b.average_distance_bene_doctor as average_distance_bene_doctor_cohort,
      b.count_events_by_doctor count_events_cohort,
      b.percent_opioid_claims as percent_opioid_claims_cohort,
      b.average_opioid_supply_length as average_opioid_supply_length_cohort
    FROM ${stats_by_doctor.SQL_TABLE_NAME} a
    JOIN ${stats_by_doctor_cohort.SQL_TABLE_NAME} b
      ON a.specialty = b.specialty
;;
  }
}

view: stats_by_doctor {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: claims {
      column: doctor_id { field: doctor.doctor_id }
      column: average_distance_bene_doctor {}
      column: count_events { field: events_MED.count_events }
      column: percent_opioid_claims {}
      column: average_opioid_supply_length {}
      column: specialty { field: doctor.specialty }
    }
  }
  dimension: doctor_id {
    primary_key: yes
    type: number
  }
  dimension: average_distance_bene_doctor {
    value_format: "#,##0.0"
    type: number
  }
  dimension: count_events {
    type: number
  }
  dimension: percent_opioid_claims {
    value_format: "#,##0.0%"
    type: number
  }
  dimension: average_opioid_supply_length {
    value_format: "#,##0.0"
    type: number
  }
  dimension: specialty {}
}

view: count_events_by_doctor {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: claims {
      column: count_events { field: events_MED.count_events }
      column: doctor_id { field: doctor.doctor_id }
      column: specialty { field: doctor.specialty }
    }
  }
  dimension: count_events {
    type: number
    hidden: yes
  }
  dimension: doctor_id {
    primary_key: yes
    type: number
    hidden: yes
  }
  dimension: specialty {
    hidden: yes
  }
  measure: count_events_by_doctor {
    hidden: yes
    type: average
    sql: ${count_events} ;;
  }
}

view: stats_by_doctor_cohort {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: claims {
      column: average_distance_bene_doctor {}
      column: count_events_by_doctor { field: count_events_by_doctor.count_events_by_doctor }
      column: percent_opioid_claims {}
      column: average_opioid_supply_length {}
      column: specialty { field: doctor.specialty }
      column: count { field: doctor.count }
    }
  }

  dimension: average_distance_bene_doctor {
    value_format: "#,##0.0"
    type: number
  }
  dimension: count_events_by_doctor {
    type: number
  }
  dimension: percent_opioid_claims {
    value_format: "#,##0.0%"
    type: number
  }
  dimension: average_opioid_supply_length {
    value_format: "#,##0.0"
    type: number
  }
  dimension: count {}
  dimension: specialty {
    primary_key: yes
  }
}

view: stats_by_pharmacy_combined {

  dimension: pharmacy_id {
    primary_key: yes
    hidden: yes
    type: number
  }
  dimension: average_distance_bene_pharmacy {
    hidden: yes
    type: number
  }
  dimension: count_events {
    hidden: yes
    type: number
  }
  dimension: percent_opioid_claims {
    hidden: yes
    type: number
  }
  dimension: average_opioid_supply_length {
    hidden: yes
    type: number
  }
  dimension: average_distance_bene_pharmacy_cohort {
    hidden: yes
    type: number
  }
  dimension: count_events_cohort {
    hidden: yes
    type: number
  }
  dimension: percent_opioid_claims_cohort {
    hidden: yes
    type: number
  }
  dimension: average_opioid_supply_length_cohort {
    hidden: yes
    type: number
  }
  measure: average__distance_bene_pharmacy {
    type: average
    group_label: "KPIs - Pharmacy"
    sql: ${average_distance_bene_pharmacy} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: count__events {
    type: average
    sql: ${count_events} ;;
    group_label: "KPIs - Pharmacy"
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: percent__opioid_claims {
    type: average
    sql: ${percent_opioid_claims} ;;
    group_label: "KPIs - Pharmacy"
    value_format_name: percent_1
    drill_fields: [drill*]
  }
  measure: average__opioid_supply_length {
    type: average
    sql: ${average_opioid_supply_length} ;;
    group_label: "KPIs - Pharmacy"
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: average__distance_bene_pharmacy_cohort {
    type: average
    sql: ${average_distance_bene_pharmacy_cohort} ;;
    group_label: "KPIs - Cohort"
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: count__events_cohort {
    type: average
    sql: ${count_events_cohort} ;;
    group_label: "KPIs - Cohort"
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: percent__opioid_claims_cohort {
    type: average
    sql: ${percent_opioid_claims_cohort} ;;
    group_label: "KPIs - Cohort"
    value_format_name: percent_1
    drill_fields: [drill*]
  }
  measure: average__opioid_supply_length_cohort {
    type: average
    sql: ${average_opioid_supply_length_cohort} ;;
    group_label: "KPIs - Cohort"
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: percent_from_cohort_average_distance_bene_pharmacy {
    label: "5 - Distance Risk"
    type: number
    sql: 1.0*(${average__distance_bene_pharmacy} - ${average__distance_bene_pharmacy_cohort}) / nullif(${average__distance_bene_pharmacy},0) ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }
  measure: percent_from_cohort_count_events {
    label: "4 - Overdose Risk"
    type: number
    sql: 1.0*(${count__events} - ${count__events_cohort}) / nullif(${count__events},0) ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }
  measure: percent_from_cohort_percent_opioid_claims {
    label: "2 - % Opioids Risk"
    type: number
    sql: 1.0*(${percent__opioid_claims} - ${percent__opioid_claims_cohort}) / nullif(${percent__opioid_claims},0) ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }
  measure: percent_from_cohort_average_opioid_supply_length {
    label: "3 - Supply Length Risk"
    type: number
    sql: 1.0*(${average__opioid_supply_length} - ${average__opioid_supply_length_cohort}) / nullif(${average__opioid_supply_length},0) ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }

  parameter: weight_distance {
    type:  unquoted
    default_value: "1"
  }

  parameter: weight_events {
    type:  unquoted
    default_value: "2"
  }

  parameter: weight_percent_opioid_claims {
    type:  unquoted
    default_value: "3"
  }

  parameter: weight_supply_length {
    type:  unquoted
    default_value: "1"
  }

  dimension: weight_distance_value {
    type: number
    sql: {% parameter weight_distance %} ;;
    hidden:  yes
  }

  dimension: weight_events_value {
    type: number
    sql: {% parameter weight_events %} ;;
    hidden:  yes
  }

  dimension: weight_percent_opioid_claims_value {
    type: number
    sql: {% parameter weight_percent_opioid_claims %} ;;
    hidden:  yes
  }

  dimension: weight_supply_length_value {
    type: number
    sql: {% parameter weight_supply_length %} ;;
    hidden:  yes
  }

  dimension: sum_weights_dimension {
    type: number
    hidden: yes
    sql:    ${weight_distance_value} +
            ${weight_events_value} +
            ${weight_percent_opioid_claims_value} +
            ${weight_supply_length_value}
            ;;
  }

  measure: sum_weights {
    hidden: yes
    type: number
    sql:    ${weight_distance_value} +
            ${weight_events_value} +
            ${weight_percent_opioid_claims_value} +
            ${weight_supply_length_value}
    ;;
  }

  measure: risk_score_dimension {
    label: "1 - Risk Score"
    type: number
    value_format_name: percent_1
    sql:
          (
            ${percent_from_cohort_average_distance_bene_pharmacy} * ${weight_distance_value}
        +   ${percent_from_cohort_count_events} * ${weight_events_value}
        +   ${percent_from_cohort_percent_opioid_claims} * ${weight_percent_opioid_claims_value}
        +  ${percent_from_cohort_average_opioid_supply_length} * ${weight_supply_length_value}
      ) /   nullif(${sum_weights},0)
    ;;
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      pharmacy.pharmacy_name,
      count__events,
      percent__opioid_claims,
      average__opioid_supply_length,
      average__distance_bene_pharmacy,
      risk_score_dimension
    ]
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:
    SELECT a.*,
      b.average_distance_bene_pharmacy as average_distance_bene_pharmacy_cohort,
      b.count_events_by_pharmacy as count_events_cohort,
      b.percent_opioid_claims as percent_opioid_claims_cohort,
      b.average_opioid_supply_length as average_opioid_supply_length_cohort
    FROM ${stats_by_pharmacy.SQL_TABLE_NAME} a
    JOIN ${stats_by_pharmacy_cohort.SQL_TABLE_NAME} b
      ON a.pharmacy_company = b.pharmacy_company
;;
  }
}

view: stats_by_pharmacy {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: claims {
      column: average_distance_bene_pharmacy {}
      column: count_events { field: events_MED.count_events }
      column: percent_opioid_claims {}
      column: average_opioid_supply_length {}
      column: pharmacy_id { field: pharmacy.pharmacy_id }
      column: pharmacy_company { field: pharmacy.pharmacy_company }
    }
  }
  dimension: average_distance_bene_pharmacy {
    value_format: "#,##0.0"
    type: number
  }
  dimension: count_events {
    type: number
  }
  dimension: percent_opioid_claims {
    value_format: "#,##0.0%"
    type: number
  }
  dimension: average_opioid_supply_length {
    value_format: "#,##0.0"
    type: number
  }
  dimension: pharmacy_id {
    primary_key: yes
  }
  dimension: pharmacy_company {}
}

view: count_events_by_pharmacy {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: claims {
      column: count_events { field: events_MED.count_events }
      column: pharmacy_id { field: pharmacy.pharmacy_id }
      column: pharmacy_company { field: pharmacy.pharmacy_company }
    }
  }
  dimension: count_events {
    type: number
    hidden: yes
  }
  dimension: pharmacy_id {
    primary_key: yes
    hidden: yes
  }
  dimension: pharmacy_company {
    hidden: yes
  }
  measure: count_events_by_pharmacy {
    hidden: yes
    type: average
    sql: ${count_events} ;;
  }
}

view: stats_by_pharmacy_cohort {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: claims {
      column: average_distance_bene_pharmacy {}
      column: count_events_by_pharmacy { field: count_events_by_pharmacy.count_events_by_pharmacy }
      column: percent_opioid_claims {}
      column: average_opioid_supply_length {}
      column: pharmacy_company { field: pharmacy.pharmacy_company }
      column: count { field: pharmacy.count }
    }
  }
  dimension: average_distance_bene_pharmacy {
    value_format: "#,##0.0"
    type: number
  }
  dimension: count_events_by_pharmacy {
    type: number
  }
  dimension: percent_opioid_claims {
    value_format: "#,##0.0%"
    type: number
  }
  dimension: average_opioid_supply_length {
    value_format: "#,##0.0"
    type: number
  }
  dimension: pharmacy_company {
    primary_key: yes
  }
  dimension: count {}
}

view: unique_stats_by_bene {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: claims {
      column: bene_id { field: beneficiary.bene_id }
      column: count_distinct_opioid_benes {}
      column: count_distinct_opioid_providers {}
      column: count_distinct_opioid_pharmacies {}
      column: percent_opioid_claims {}
      column: count_deaths { field: events_MED.count_deaths }
      column: count_overdoses { field: events_MED.count_overdoses }
      column: risk_score_dimension { field: beneficiary.risk_score_dimension }
    }
  }
  dimension: bene_id {
    primary_key: yes
    hidden: yes
    type: number
  }
  dimension: count_distinct_opioid_benes {
    group_label: "Stats"
    type: number
    hidden: yes
  }
  dimension: count_distinct_opioid_providers {
    group_label: "Stats"
    type: number
  }
  dimension: count_distinct_opioid_pharmacies {
    group_label: "Stats"
    type: number
  }
  dimension: percent_opioid_claims {
    group_label: "Stats"
    value_format: "#,##0.0%"
    type: number
  }
  dimension: count_deaths {
    group_label: "Stats"
    type: number
  }
  dimension: count_overdoses {
    group_label: "Stats"
    type: number
  }
  dimension: risk_score_dimension {
    group_label: "Stats"
    label: "Risk Score"
    value_format: "#,##0.0%"
    type: number
  }

}

view: unique_stats_by_doctor {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: claims {
      column: doctor_id { field: doctor.doctor_id }
      column: count_distinct_opioid_benes {}
      column: count_distinct_opioid_providers {}
      column: count_distinct_opioid_pharmacies {}
      column: percent_opioid_claims {}
      column: count_deaths { field: events_MED.count_deaths }
      column: count_overdoses { field: events_MED.count_overdoses }
      column: risk_score_dimension { field: stats_by_doctor_combined.risk_score_dimension }
    }
  }
  dimension: doctor_id {
    hidden: yes
    primary_key: yes
    type: number
  }
  dimension: count_distinct_opioid_benes {
    group_label: "Stats"
    type: number
  }
  dimension: count_distinct_opioid_providers {
    group_label: "Stats"
    type: number
    hidden: yes
  }
  dimension: count_distinct_opioid_pharmacies {
    group_label: "Stats"
    type: number
  }
  dimension: percent_opioid_claims {
    group_label: "Stats"
    value_format: "#,##0.0%"
    type: number
  }
  dimension: count_deaths {
    group_label: "Stats"
    type: number
  }
  dimension: count_overdoses {
    group_label: "Stats"
    type: number
  }
  dimension: risk_score_dimension {
    group_label: "Stats"
    label: "Risk Score"
    value_format: "#,##0.0%"
    type: number
  }
  dimension: risk_score_status {
    group_label: "Stats"
    type: string
    sql:
      CASE
        WHEN ${risk_score_dimension} > .05 then '1 - High Risk'
        WHEN ${risk_score_dimension} > -.2 then '2 - Medium Risk'
        ELSE '3 - Low Risk'
      END
    ;;
  }
}

view: unique_stats_by_pharmacy {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: claims {
      column: pharmacy_id { field: pharmacy.pharmacy_id }
      column: count_distinct_opioid_benes {}
      column: count_distinct_opioid_providers {}
      column: count_distinct_opioid_pharmacies {}
      column: percent_opioid_claims {}
      column: count_deaths { field: events_MED.count_deaths }
      column: count_overdoses { field: events_MED.count_overdoses }
      column: risk_score_dimension { field: stats_by_pharmacy_combined.risk_score_dimension }
    }
  }
  dimension: pharmacy_id {
    hidden: yes
    primary_key: yes
  }
  dimension: count_distinct_opioid_benes {
    group_label: "Stats"
    type: number
  }
  dimension: count_distinct_opioid_providers {
    group_label: "Stats"
    type: number
  }
  dimension: count_distinct_opioid_pharmacies {
    group_label: "Stats"
    hidden: yes
    type: number
  }
  dimension: percent_opioid_claims {
    group_label: "Stats"
    value_format: "#,##0.0%"
    type: number
  }
  dimension: count_deaths {
    group_label: "Stats"
    type: number
  }
  dimension: count_overdoses {
    group_label: "Stats"
    type: number
  }
  dimension: risk_score_dimension {
    group_label: "Stats"
    label: "Risk Score"
    value_format: "#,##0.0%"
    type: number
  }
}
