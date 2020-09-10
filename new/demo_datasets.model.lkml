connection: "lookerdata"

include: "/new/*.view.lkml"
include: "/new/*.dashboard"

## Opioid Fraud

explore: bene_daily_summary {
  view_label: " Events: Prescriptions & Overdoses"
  label: "Opioid Fraud"

  sql_always_where: ${daily_med} >= 0 ;;

  join: prescriptions {
    view_label: " Events: Prescriptions & Overdoses"
    relationship: one_to_many
    sql_on:
          ${bene_daily_summary.bene_id} = ${prescriptions.bene_id}
      AND ${bene_daily_summary.observation_raw} = ${prescriptions.prescription_raw}
      ;;
  }

  join: beneficiary {
    relationship: many_to_one
    sql_on: ${bene_daily_summary.bene_id} = ${beneficiary.bene_id} ;;
  }

  join: provider {
    relationship: many_to_one
    sql_on: ${prescriptions.provider_id} = ${provider.provider_id} ;;
  }

  join: pharmacy {
    relationship: many_to_one
    sql_on: ${prescriptions.pharmacy_id} = ${pharmacy.pharmacy_id} ;;
  }

  join: drug {
    relationship: many_to_one
    sql_on: ${prescriptions.drug_id} = ${drug.drug_id} ;;
  }

  join: bene_dangerous_events {
    view_label: " Events: Prescriptions & Overdoses"
    relationship: many_to_one
    sql_on: ${bene_daily_summary.bene_id} = ${bene_dangerous_events.bene_id} ;;
  }

  join: cohort_value {
    view_label: "Advanced KPIs"
    relationship: one_to_one
    sql_on: 1 = 1 ;;
  }

  join: bene_lifetime_value {
    view_label: "Beneficiary"
    relationship: many_to_one
    sql_on: ${bene_daily_summary.bene_id} = ${bene_lifetime_value.bene_id} ;;
  }

  join: provider_lifetime_value {
    view_label: "Provider"
    relationship: many_to_one
    sql_on: ${prescriptions.provider_id} = ${provider_lifetime_value.provider_id} ;;
  }

  join: pharmacy_lifetime_value {
    view_label: "Pharmacy"
    relationship: many_to_one
    sql_on: ${prescriptions.pharmacy_id} = ${pharmacy_lifetime_value.pharmacy_id} ;;
  }

  join: benchmark_value {
    fields: []
    relationship: one_to_one
    sql:  ;;
  }

  join: applied_model_results {
    view_label: "Advanced KPIs"
    relationship: one_to_one
    sql_on: ${provider.provider_id} = ${applied_model_results.provider_id} ;;
  }

  ## Security Parameter
  access_filter: {
    field: bene_id
    user_attribute: allowed_beneficiary
  }
}

## Unit Test

test: med_within_expected_range {
  explore_source: bene_daily_summary {
    column: average_med {}
    filters: {
      field: prescriptions.length
      value: ">0"
    }
  }
  assert: average_med_under_600 {
    expression: ${bene_daily_summary.average_med} < 600 ;;
  }
  assert: average_med_over_50 {
    expression: ${bene_daily_summary.average_med} > 50 ;;
  }
}

## Security

access_grant: can_see_sensitive_data {
  user_attribute: can_see_sensitive_data
  allowed_values: ["yes"]
}

access_grant: only_regular_advanced_users {
  user_attribute: user_type
  allowed_values: ["Regular","Advanced"]
}

access_grant: only_advanced_users {
  user_attribute: user_type
  allowed_values: ["Advanced"]
}

## PDT Workflow

explore: by_bene_by_patient_summary { hidden: yes }
explore: machine_learning_raw { hidden: yes }
explore: predictive_power_raw { hidden: yes }

### PDT Timeframes

datagroup: once_daily {
  max_cache_age: "24 hours"
  sql_trigger: SELECT current_date() ;;
}

datagroup: once_weekly {
  max_cache_age: "168 hours"
  sql_trigger: SELECT extract(week from current_date()) ;;
}

datagroup: once_monthly {
  max_cache_age: "720 hours"
  sql_trigger: SELECT extract(month from current_date()) ;;
}

datagroup: once_yearly {
  max_cache_age: "9000 hours"
  sql_trigger: SELECT extract(year from current_date()) ;;
}
