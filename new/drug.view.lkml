view: drug {
  sql_table_name: `lookerdata.opioid_fraud_new.drug_final`
    ;;

#############
### Original Dimensions
#############

  dimension: drug_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.DRUG_ID ;;
  }

  dimension: drug_name {
    hidden: yes
    type: string
    sql: ${TABLE}.DRUG_NAME ;;
  }

  dimension: drug_name_simple {
    label: "Drug Name"
    type: string
    sql: ${TABLE}.DRUG_NAME_SIMPLE ;;
    link: {
      label: "Drug Therapy Dashboard"
      url: "/dashboards/733"
      icon_url: "http://www.google.com/s2/favicons?domain=www.looker.com"
    }
    html:
    {% if opioid_drug._value == "Yes" %} <font color="red">{{ rendered_value }}</font>
    {% else %} {{ rendered_value }}
    {% endif %}
    ;;
  }

  dimension: med {
    type: number
    sql: ${TABLE}.MED ;;
  }

  dimension: opioid_drug {
    type: yesno
    sql: ${TABLE}.OPIOID_DRUG ;;
  }

#############
### Derived Dimensions
#############

#############
### Measures
#############

  measure: count {
    label: "Count Drugs"
    type: count
    drill_fields: [drug_name]
  }
}
