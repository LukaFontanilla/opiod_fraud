view: provider {
  sql_table_name: `lookerdata.opioid_fraud_new.provider_final`
    ;;

#############
### Original Dimensions
#############

  dimension: city {
    label: "Provider City"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: first_name {
    hidden: yes
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    hidden: yes
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: lat {
    hidden: yes
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: long {
    hidden: yes
    type: number
    sql: ${TABLE}.long ;;
  }

  dimension: npi {
    label: "Provider NPI"
    type: number
    sql: ${TABLE}.npi ;;
    value_format_name: id
  }

  dimension: provider_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.provider_id ;;
  }

  dimension: specialty {
    label: "Provider Specialty"
    type: string
    sql: ${TABLE}.specialty ;;
    drill_fields: [name, zip_code]
  }

  dimension: state {
    label: "Provider State"
    map_layer_name: us_states
    type: string
    sql: ${TABLE}.state ;;
    drill_fields: [zip_code]
  }

  dimension: zip_code {
    label: "Provider Zip"
    map_layer_name: us_zipcode_tabulation_areas
    type: number
    sql: ${TABLE}.zip_code ;;
    drill_fields: [location]
  }

#############
### Derived Dimensions
#############

  dimension: name {
    label: "Provider Name"
    type: string
    sql: concat(${first_name},' ',${last_name}) ;;
    drill_fields: [beneficiary.name]
    link: {
      label: "Provider Deep Dive - {{ value }}"
      url: "/dashboards/729?Provider%20Name={{ value }}"
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
        default: "{{ name._rendered_value }}"
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

  dimension: location {
    label: "Provider Location"
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${long} ;;
  }

#############
### Measures
#############

  measure: count {
    label: "Count Providers"
    type: count
    drill_fields: [last_name, first_name]
  }
}
