view: pharmacy {
  sql_table_name: `lookerdata.opioid_fraud_new.pharmacy_final`
    ;;

#############
### Original Dimensions
#############

  dimension: city {
    label: "Pharmacy City"
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: lat {
    hidden: yes
    type: number
    sql: ${TABLE}.LAT ;;
  }

  dimension: long {
    hidden: yes
    type: number
    sql: ${TABLE}.LONG ;;
  }

  dimension: pharmacy_company {
    type: string
    sql: ${TABLE}.PHARMACY_COMPANY ;;
    drill_fields: [pharmacy_name]
  }

  dimension: pharmacy_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.PHARMACY_ID ;;
  }

  dimension: pharmacy_name {
    label: "Pharmacy Store #"
    type: string
    sql: ${TABLE}.PHARMACY_NAME ;;
    drill_fields: [beneficiary.name]
    link: {
      label: "Pharmacy Deep Dive - {{ value }}"
      url: "/dashboards/10?Pharmacy={{ value }}"
      icon_url: "http://www.google.com/s2/favicons?domain=looker.com"
    }
    action: {
      label: "Investigate in More Detail"
      url: "https://hooks.zapier.com/hooks/catch/lkfjasdlkfxaoiu/"
      icon_url: "http://www.google.com/s2/favicons?domain=zapier.com"
      form_param: {
        name: "Reporter"
        type: string
        default: "{{ _user_attributes.email }}"
      }
      form_param: {
        name: "Person of Interest"
        type: string
        default: "{{ pharmacy_name._rendered_value }}"
      }
      form_param: {
        name: "State"
        type: string
        default: "{{ state._rendered_value }}"
      }
      form_param: {
        name: "Zip"
        type: string
        default: "{{ zip_code._rendered_value }}"
      }
      form_param: {
        name: "Comments"
        type: textarea
        default: "Please investigate in more detail"
      }
    }
  }

  dimension: state {
    label: "Pharmacy State"
    map_layer_name: us_states
    type: string
    sql: ${TABLE}.state ;;
    drill_fields: [zip_code]
  }

  dimension: zip_code {
    label: "Pharmacy Zip"
    map_layer_name: us_zipcode_tabulation_areas
    type: number
    sql: ${TABLE}.zip_code ;;
    drill_fields: [location]
  }

#############
### Derived Dimensions
#############

  dimension: location {
    label: "Pharmacy Location"
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${long} ;;
  }

#############
### Measures
#############

  measure: count {
    label: "Count Pharmacies"
    type: count
  }
}
