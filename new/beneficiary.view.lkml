include: "analytics_pdt.view.lkml"

view: beneficiary {
  sql_table_name: `lookerdata.opioid_fraud_new.bene_final` ;;

#############
### Original Dimensions
#############

  dimension: bene_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.bene_id ;;
  }

  dimension: city {
    label: "Beneficiary City"
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

  dimension: state {
    label: "Beneficiary State"
    map_layer_name: us_states
    type: string
    sql: ${TABLE}.state ;;
    drill_fields: [zip_code]
  }

  dimension: zip_code {
    label: "Beneficiary Zip"
    map_layer_name: us_zipcode_tabulation_areas
    type: number
    sql: ${TABLE}.zip_code ;;
    drill_fields: [location]
  }


#############
### Derived Dimensions
#############

  dimension: name {
    required_access_grants: [only_regular_advanced_users]
    label: "Beneficiary Name"
    type: string
    sql: concat(${first_name},' ',${last_name}) ;;
    drill_fields: [provider.name]
    link: {
      label: "Beneficiary Deep Dive - {{ value }}"
      url: "/dashboards/730?Beneficiary={{ value }}"
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

  dimension: bene_name_hashed {
    required_access_grants: [only_regular_advanced_users]
    label: "Beneficiary Name (Hashed)"
    type: string
    description: "Only users with sufficient permissions will see this data"
    sql:
        CASE
          WHEN '{{_user_attributes["can_see_sensitive_data"]}}' = 'yes'
                THEN ${name}
                ELSE TO_BASE64(SHA1(${name}))
          END ;;
  }

  dimension: location {
    required_access_grants: [only_regular_advanced_users]
    label: "Beneficiary Location"
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${long} ;;
  }

#############
### Measures
#############

  measure: count {
    required_access_grants: [only_regular_advanced_users]
    label: "Count Beneficiaries"
    type: count
    drill_fields: [last_name, first_name]
  }
}
