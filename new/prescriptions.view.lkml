view: prescriptions {
  sql_table_name: `lookerdata.opioid_fraud_new.prescriptions_final`
    ;;

#############
### Original Dimensions
#############

  dimension: bene_id {
    hidden: yes
    type: number
    sql: ${TABLE}.bene_id ;;
  }

  dimension: drug_id {
    hidden: yes
    type: number
    sql: ${TABLE}.drug_id ;;
  }

  dimension: length {
    group_label: "Supply Length"
    label: "Supply Length"
    type: number
    sql: ${TABLE}.length ;;
    html:
    {% if value > dangerous_supply_length_number._value %} <font color="red">{{ rendered_value }}</font>
    {% else %} {{ rendered_value }}
    {% endif %}
    ;;
  }

  dimension: length_no_html {
    group_label: "Supply Length"
    hidden: yes
    type: number
    sql: ${length} ;;
  }

  dimension: pharmacy_id {
    hidden: yes
    type: number
    sql: ${TABLE}.pharmacy_id ;;
  }

  dimension_group: prescription {
    hidden: yes
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
    sql: ${TABLE}.prescription_date ;;
  }

  dimension: prescription_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.prescription_id ;;
  }

  dimension: provider_id {
    hidden: yes
    type: number
    sql: ${TABLE}.provider_id ;;
  }

#############
### Derived Dimensions
#############

  parameter: dangerous_supply_length {
    group_label: "Risk Variables"
    type: number
    default_value: "4"
  }

  dimension: dangerous_supply_length_number {
    hidden: yes
    type: number
    sql: {% parameter dangerous_supply_length %} ;;
  }

  parameter: dangerous_distance {
    group_label: "Risk Variables"
    type: number
    default_value: "10"
  }

  dimension: dangerous_distance_number {
    hidden: yes
    type: number
    sql: {% parameter dangerous_distance %} ;;
  }

  dimension: is_over_supply_length {
    group_label: "Supply Length"
    type: yesno
    sql: ${length} > {% parameter dangerous_supply_length %} ;;
  }

  dimension: distance_bene_provider {
    group_label: "Distance"
    type: distance
    start_location_field: beneficiary.location
    end_location_field: provider.location
    units: miles
    value_format_name: decimal_1
    html:
    {% if value > dangerous_distance_number._value %} <font color="red">{{ rendered_value }}</font>
    {% else %} {{ rendered_value }}
    {% endif %}
    ;;
  }

  dimension: distance_bene_pharmacy {
    group_label: "Distance"
    type: distance
    start_location_field: beneficiary.location
    end_location_field: pharmacy.location
    units: miles
    value_format_name: decimal_1
    html:
    {% if value > dangerous_distance._parameter_value %} <font color="red">{{ rendered_value }}</font>
    {% else %} {{ rendered_value }}
    {% endif %}
    ;;
  }

  dimension: distance_provider_pharmacy {
    group_label: "Distance"
    type: distance
    start_location_field: provider.location
    end_location_field: pharmacy.location
    units: miles
    value_format_name: decimal_1
    html:
    {% if value > dangerous_distance._parameter_value %} <font color="red">{{ rendered_value }}</font>
    {% else %} {{ rendered_value }}
    {% endif %}
    ;;
  }

  dimension: is_over_distance {
    group_label: "Distance"
    type: yesno
    sql: ${distance_provider_pharmacy} > {% parameter dangerous_distance %} ;;
  }

#############
### Measures
#############

## Prescription Counts

  measure: count {
    group_label: "Prescription Counts"
    label: "Count Prescriptions"
    type: count
    drill_fields: [prescription_drill*]
  }

  measure: count_opioid_prescriptions {
    group_label: "Prescription Counts"
    type: count
    filters: [drug.opioid_drug: "Yes"]
    drill_fields: [prescription_drill*]
  }

  measure: percent_opioid_prescriptions {
    group_label: "Risk Factors"
    label: "1 % - Opioid Prescription"
    type: number
    sql: 1.0 * ${count_opioid_prescriptions} / nullif(${count},0) ;;
    value_format_name: percent_1
    drill_fields: [prescription_drill*]
  }

## Supply Length

  measure: average_supply_length {
    group_label: "Supply Length"
    type: average
    sql: ${length} ;;
    value_format_name: decimal_1
    drill_fields: [prescription_drill*]
  }

  measure: average_supply_length_opioid {
    group_label: "Supply Length"
    type: average
    sql: ${length} ;;
    filters: [drug.opioid_drug: "Yes"]
    value_format_name: decimal_1
    drill_fields: [prescription_drill*]
  }

  measure: count_dangerous_supply_lengths {
    group_label: "Supply Length"
    type: count
    filters: [drug.opioid_drug: "Yes", is_over_supply_length: "Yes"]
    drill_fields: [prescription_drill*]
  }

  measure: percent_dangerous_supply_lengths {
    group_label: "Risk Factors"
    label: "2  % - Supply Length"
    type: number
    sql: 1.0 * ${count_dangerous_supply_lengths} / nullif(${count_opioid_prescriptions},0) ;;
    value_format_name: percent_1
    drill_fields: [prescription_drill*]
  }

## Distance

  measure: average_distance_bene_provider {
    group_label: "Distance"
    type: average
    sql: ${distance_bene_provider} ;;
    value_format_name: decimal_1
    drill_fields: [prescription_drill*]
  }

  measure: average_distance_bene_pharmacy {
    group_label: "Distance"
    type: average
    sql: ${distance_bene_pharmacy} ;;
    value_format_name: decimal_1
    drill_fields: [prescription_drill*]
  }

  measure: average_distance_provider_pharmacy {
    group_label: "Distance"
    type: average
    sql: ${distance_provider_pharmacy} ;;
    value_format_name: decimal_1
    drill_fields: [prescription_drill*]
  }

  measure: count_dangerous_distances {
    group_label: "Distance"
    type: count
    filters: [drug.opioid_drug: "Yes", is_over_distance: "Yes"]
    drill_fields: [prescription_drill*]
  }

  measure: percent_dangerous_distances {
    group_label: "Risk Factors"
    label: "4 % - Long Distance"
    type: number
    sql: 1.0 * ${count_dangerous_distances} / nullif(${count_opioid_prescriptions},0) ;;
    value_format_name: percent_1
    drill_fields: [prescription_drill*]
  }

  set: prescription_drill {
    fields: [
      prescription_id,
      prescription_date,
      beneficiary.name,
      provider.name,
      pharmacy.pharmacy_name,
      drug.drug_name_simple,
      length,
      distance_bene_provider
    ]
  }
}
