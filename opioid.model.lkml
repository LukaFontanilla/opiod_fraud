connection: "snow_demo_db"

label: "Opioid Fraud"

include: "*.view.lkml"                       # include all views in this project
# include: "*.dashboard.lookml"   # include a LookML dashboard called my_dashboard

persist_with: once_yearly

### Main Explores

explore: claims {

  always_join: [beneficiary]

  join: events_MED {
    view_label: "Events (OD / Death)"
    relationship: many_to_many
    sql_on: ${claims.bene_id} = ${events_MED.bene_id} ;;
  }

  join: beneficiary {
    relationship: many_to_one
    type: inner
    sql_on: ${claims.bene_id} = ${beneficiary.bene_id} ;;
  }

  join: doctor {
    relationship: many_to_one
    type: inner
    sql_on: ${claims.doctor_id} = ${doctor.doctor_id} ;;
  }

  join: pharmacy {
    relationship: many_to_one
    type: inner
    sql_on: ${claims.pharmacy_id} = ${pharmacy.pharmacy_id} ;;
  }

  join: drug {
    view_label: "Claims"
    relationship: many_to_one
    sql_on: ${claims.drug_id} = ${drug.drug_id} ;;
  }

  join: stats_by_doctor_combined {
    view_label: "Doctor"
    relationship: one_to_one
    sql_on: ${doctor.doctor_id} = ${stats_by_doctor_combined.doctor_id} ;;
  }

  join: stats_by_pharmacy_combined {
    view_label: "Pharmacy"
    relationship: one_to_one
    sql_on: ${pharmacy.pharmacy_id} = ${stats_by_pharmacy_combined.pharmacy_id} ;;
  }

  join: count_events_by_doctor {
    relationship: one_to_one
    sql_on: ${doctor.doctor_id} = ${count_events_by_doctor.doctor_id} ;;
  }

  join: count_events_by_pharmacy {
    relationship: one_to_one
    sql_on: ${pharmacy.pharmacy_id} = ${count_events_by_pharmacy.pharmacy_id} ;;
  }

  join: unique_stats_by_bene {
    view_label: "Beneficiary"
    relationship: one_to_one
    sql_on: ${beneficiary.bene_id} = ${unique_stats_by_bene.bene_id} ;;
  }

  join: unique_stats_by_doctor {
    view_label: "Doctor"
    relationship: one_to_one
    sql_on: ${doctor.doctor_id} = ${unique_stats_by_doctor.doctor_id} ;;
  }

  join: unique_stats_by_pharmacy {
    view_label: "Pharmacy"
    relationship: one_to_one
    sql_on: ${pharmacy.pharmacy_id} = ${unique_stats_by_pharmacy.pharmacy_id} ;;
  }

  join: applied_model_results {
    view_label: "Data Science"
    relationship: one_to_one
    sql_on: ${doctor.doctor_id} = ${applied_model_results.doctor_id} ;;
  }

  join: sms_alerts {
    view_label: "Investigator"
    relationship: many_to_many
    sql_on: 1 = 1  ;;
  }

}

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

## Hidden Explores

explore: machine_learning_raw { hidden: yes }
explore: predictive_power_raw { hidden: yes }
explore: med_usage_by_date_by_bene { hidden: yes }
explore: med_usage_by_date_by_bene_365_rolling { hidden: yes }
explore: events_pre { hidden: yes }
explore: events_pre_aggd { hidden: yes  }
explore: events { hidden: yes }
explore: sms_alerts { hidden: yes }
explore: claims_pre {

  hidden: yes

  from:  claims

  join: events {
    relationship: many_to_many
    sql_on: ${claims_pre.bene_id} = ${events.bene_id} ;;
  }

  join: beneficiary {
    relationship: many_to_one
    type: inner
    sql_on: ${claims_pre.bene_id} = ${beneficiary.bene_id} ;;
  }

  join: doctor {
    relationship: many_to_one
    type: inner
    sql_on: ${claims_pre.doctor_id} = ${doctor.doctor_id} ;;
  }

  join: pharmacy {
    relationship: many_to_one
    type: inner
    sql_on: ${claims_pre.pharmacy_id} = ${pharmacy.pharmacy_id} ;;
  }

  join: drug {
    relationship: many_to_one
    sql_on: ${claims_pre.drug_id} = ${drug.drug_id} ;;
  }
}
