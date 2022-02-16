
view: beneficiary {

  dimension: bene_id {
    type: number
    primary_key: yes
    hidden: yes
  }

  dimension: bene_id_code {
    label: "Bene ID"
    value_format_name: id
    type: number
    link: {
      label: "Bene Dashboard"
      url: "https://demoexpo.looker.com/dashboards/67?Bene%20ID={{value}}"
      icon_url: "https://looker.com/favicon.ico"
    }
    action: {
      label: "Launch New Investigation"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Need for new investigation on {{value}}"
      }
      form_param: {
        name: "To Mailing List"
        required: yes
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Investigator -

        Given the high amount of risk seen in {{value}}, we strongly recommend beginning a new investigation.

        Best,
        "
      }
    }
  }

  dimension: first_name {}

  dimension: last_name {}

  dimension: name {
    sql: concat(${first_name}, concat(' ', ${last_name})) ;;
    link: {
      label: "WebMd"
      url: "https://doctor.webmd.com/results?so=&ln={{ value }}"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.webmd.com"
    }
    link: {
      label: "Google"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
  }

  dimension: zip_code {
    type: number
    map_layer_name: us_zipcode_tabulation_areas
    value_format_name: id
    drill_fields: [bene_id_code]
  }

  dimension: lat {
    hidden: yes
    type: number
  }

  dimension: long {
    hidden: yes
    type: number
  }

  dimension: city {
    drill_fields: [bene_id_code]
  }

  dimension: state {
    map_layer_name: us_states
    drill_fields: [zip_code]
  }

  dimension: max_avg_rolling_MED_365 {
    hidden: yes
    type: number
  }

  dimension: average_distance_bene_doctor {
    type: number
    value_format_name: decimal_1
    hidden: yes
  }
  dimension: average_distance_bene_pharmacy {
    type: number
    value_format_name: decimal_1
    hidden: yes
  }
  dimension: count_distinct_opioid_pharmacies {
    type: number
    hidden: yes
  }
  dimension: count_distinct_opioid_providers {
    type: number
    hidden: yes
  }
  dimension: count_events {
    type: number
    hidden: yes
  }

  dimension: risk_points_distance {
    hidden: yes
    type: number
    sql:
      CASE
        WHEN ${average_distance_bene_doctor} > 20 AND ${average_distance_bene_pharmacy} > 20 then 1.0
        WHEN ${average_distance_bene_doctor} > 20 AND ${average_distance_bene_pharmacy} > 10 then 0.7
        WHEN ${average_distance_bene_doctor} > 10 AND ${average_distance_bene_pharmacy} > 20 then 0.7
        WHEN ${average_distance_bene_doctor} > 10 AND ${average_distance_bene_pharmacy} > 10 then 0.5
        WHEN ${average_distance_bene_doctor} > 10 AND ${average_distance_bene_pharmacy} > 5 then 0.3
        WHEN ${average_distance_bene_doctor} > 5 AND ${average_distance_bene_pharmacy} > 10 then 0.3
        WHEN ${average_distance_bene_doctor} > 5 AND ${average_distance_bene_pharmacy} > 5 then 0.1
        ELSE 0
      END
    ;;
  }

  dimension: risk_points_doctor_shopping {
    hidden: yes
    type: number
    sql:
      CASE
      WHEN ${count_distinct_opioid_providers} > 4 AND ${count_distinct_opioid_pharmacies} > 3 then 1.0
      WHEN ${count_distinct_opioid_providers} > 2 AND ${count_distinct_opioid_pharmacies} > 3 then 0.7
      WHEN ${count_distinct_opioid_providers} > 4 AND ${count_distinct_opioid_pharmacies} > 2 then 0.7
      WHEN ${count_distinct_opioid_providers} > 2 AND ${count_distinct_opioid_pharmacies} > 2 then 0.5
      WHEN ${count_distinct_opioid_providers} > 1 AND ${count_distinct_opioid_pharmacies} > 2 then 0.3
      WHEN ${count_distinct_opioid_providers} > 2 AND ${count_distinct_opioid_pharmacies} > 1 then 0.3
      WHEN ${count_distinct_opioid_providers} > 1 AND ${count_distinct_opioid_pharmacies} > 1 then 0.1
      ELSE 0
      END
    ;;
  }

  dimension: risk_points_overdose {
    hidden: yes
    type: number
    sql:
      CASE
        WHEN ${count_events} > 3 then 1.0
        WHEN ${count_events} > 2 then 0.8
        WHEN ${count_events} > 1 then 0.6
        WHEN ${count_events} > 0 then 0.4
        ELSE 0
      END ;;
  }

  dimension: risk_points_MED_usage {
    hidden: yes
    type: number
    sql:
      CASE
        WHEN ${max_avg_rolling_MED_365} > 600 then 1.0
        WHEN ${max_avg_rolling_MED_365} > 400 then 0.8
        WHEN ${max_avg_rolling_MED_365} > 200 then 0.5
        WHEN ${max_avg_rolling_MED_365} > 100 then 0.2
        ELSE 0
      END
    ;;
    value_format_name: decimal_1
  }

  dimension: total_risk_points {
    hidden: yes
    type: number
    sql: ${risk_points_distance} + ${risk_points_doctor_shopping} + ${risk_points_overdose} + ${risk_points_MED_usage} ;;
    value_format_name: decimal_1
  }

  measure: risk_distance {
    # group_label: "Risk"
    label: "5 - Distance Risk"
    type: average
    sql: ${risk_points_distance} ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }

  measure: risk_doctor_shopping {
    # group_label: "Risk"
    label: "3 - Doc Shop Risk"
    type: average
    sql: ${risk_points_doctor_shopping} ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }

  measure: risk_overdose {
    # group_label: "Risk"
    label: "4 - Overdose Risk"
    type: average
    sql: ${risk_points_overdose} ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }

  measure: risk_MED_usage {
    # group_label: "Risk"
    label: "2 - MED Risk"
    type: average
    sql: ${risk_points_MED_usage} ;;
    value_format_name: percent_1
    drill_fields: [drill*]
  }

  parameter: weight_distance {
    type:  unquoted
    default_value: "1"
  }

  parameter: weight_doctor_shopping {
    type:  unquoted
    default_value: "1"
  }

  parameter: weight_overdose {
    type:  unquoted
    default_value: "2"
  }

  parameter: weight_MED_usage {
    type:  unquoted
    default_value: "3"
  }

  dimension: weight_distance_value {
    type: number
    sql: {% parameter weight_distance %} ;;
    hidden:  yes
  }

  dimension: weight_doctor_shopping_value {
    type: number
    sql: {% parameter weight_doctor_shopping %} ;;
    hidden:  yes
  }

  dimension: weight_overdose_value {
    type: number
    sql: {% parameter weight_overdose %} ;;
    hidden:  yes
  }

  dimension: weight_MED_usage_value {
    type: number
    sql: {% parameter weight_MED_usage %} ;;
    hidden:  yes
  }

  dimension: sum_weights_dimension {
    type: number
    hidden: yes
    sql:    ${weight_distance_value} +
            ${weight_doctor_shopping_value} +
            ${weight_overdose_value} +
            ${weight_MED_usage_value}
            ;;
  }

  measure: sum_weights {
    hidden: yes
    type: number
    sql:    ${weight_distance_value} +
            ${weight_doctor_shopping_value} +
            ${weight_overdose_value} +
            ${weight_MED_usage_value}
    ;;
  }

  measure: risk_score_dimension {
    # group_label: "Risk"
    label: "1 - Risk Score"
    type: number
    value_format_name: percent_1
    sql:
          (
            ${risk_distance} * ${weight_distance_value}
        +   ${risk_doctor_shopping} * ${weight_doctor_shopping_value}
        +   ${risk_overdose} * ${weight_overdose_value}
        +  ${risk_MED_usage} * ${weight_MED_usage_value}
      ) /   nullif(${sum_weights},0)
    ;;
    drill_fields: [drill*]
  }

  measure: average_max_rolling_MED_365 {
    group_label: "Claims"
    label: "Max Rolling MED 365"
    type: average
    sql: ${max_avg_rolling_MED_365} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }

  measure: count_benes {
    label: "Count Beneficiaries"
    type: count
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      bene_id_code,
      name,
      zip_code,
      risk_score_dimension,
      average_max_rolling_MED_365
    ]
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:

    SELECT
      a.bene_id,
      concat('719496', right(concat('00003',cast(a.bene_id as varchar(10))),3)) as bene_id_code,
      a.first_name,
      a.last_name,
      b.zip_code,
      b.lat,
      b.long,
      b.city,
      b.state,
      c.max_avg_rolling_MED_365,
      d.average_distance_bene_doctor,
      d.average_distance_bene_pharmacy,
      d.count_distinct_opioid_pharmacies,
      d.count_distinct_opioid_providers,
      d.count_events
    FROM ${beneficiary_raw.SQL_TABLE_NAME} a
    LEFT JOIN ${zip_raw.SQL_TABLE_NAME} b
      ON a.zip_id = b.zip_id
    LEFT JOIN ${max_rolling_MED_by_bene.SQL_TABLE_NAME} c
      ON a.bene_id = c.bene_id
    LEFT JOIN ${summary_facts_by_bene.SQL_TABLE_NAME} d
      ON a.bene_id = d.bene_id

;;
  }
}

view: summary_facts_by_bene {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: claims_pre {
      column: bene_id {}
      column: average_distance_bene_doctor {}
      column: average_distance_bene_pharmacy {}
      column: count_distinct_opioid_pharmacies {}
      column: count_distinct_opioid_providers {}
      column: count_events { field: events.count_events }
    }
  }
  dimension: bene_id {
    primary_key: yes
    type: number
  }
  dimension: average_distance_bene_doctor {
    type: number
    value_format_name: decimal_1
  }
  dimension: average_distance_bene_pharmacy {
    type: number
    value_format_name: decimal_1
  }
  dimension: count_distinct_opioid_pharmacies {
    type: number
  }
  dimension: count_distinct_opioid_providers {
    type: number
  }
  dimension: count_events {
    type: number
  }
}

view: max_rolling_MED_by_bene {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: med_usage_by_date_by_bene_365_rolling {
      column: bene_id {}
      column: max_avg_rolling_MED_365 {}
    }
  }
  dimension: bene_id {
    primary_key: yes
    type: number
  }
  dimension: max_avg_rolling_MED_365 {
    type: number
  }
  measure: average_max_rolling_MED_365 {
    type: average
    sql: ${max_avg_rolling_MED_365} ;;
  }
}

view: beneficiary_raw {

  dimension: bene_id {
    type: number
    primary_key: yes
  }

  dimension: first_name {}

  dimension: last_name {}

  dimension: zip_id {
    type: number
  }

  dimension: lat_add {
    type: number
  }

  dimension: long_add {
    type: number
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:

SELECT 1 as bene_id, 'Karine' as first_name, 'Sawrey' as last_name, 15 as zip_id, -0.004108 as lat_add, -0.00014 as long_add UNION ALL
SELECT 2 as bene_id, 'Beverlie' as first_name, 'Mintoff' as last_name, 22 as zip_id, -0.021462 as lat_add, -0.005598 as long_add UNION ALL
SELECT 3 as bene_id, 'Gladys' as first_name, 'Breckell' as last_name, 14 as zip_id, 0.004862 as lat_add, 0.004399 as long_add UNION ALL
SELECT 4 as bene_id, 'Delcine' as first_name, 'Float' as last_name, 22 as zip_id, 0.001201 as lat_add, -0.01628 as long_add UNION ALL
SELECT 5 as bene_id, 'Coleen' as first_name, 'Hammarberg' as last_name, 21 as zip_id, 0.014637 as lat_add, -0.016 as long_add UNION ALL
SELECT 6 as bene_id, 'Ewen' as first_name, 'Glencros' as last_name, 13 as zip_id, 0.004708 as lat_add, 0.000331 as long_add UNION ALL
SELECT 7 as bene_id, 'Merwin' as first_name, 'Points' as last_name, 9 as zip_id, 0.024714 as lat_add, 0.009226 as long_add UNION ALL
SELECT 8 as bene_id, 'Lonna' as first_name, 'Toon' as last_name, 9 as zip_id, -0.001495 as lat_add, 0.012467 as long_add UNION ALL
SELECT 9 as bene_id, 'Alix' as first_name, 'Chester' as last_name, 19 as zip_id, 0.002815 as lat_add, 0.016645 as long_add UNION ALL
SELECT 10 as bene_id, 'Conway' as first_name, 'Stovell' as last_name, 22 as zip_id, -0.015785 as lat_add, -0.021718 as long_add UNION ALL
SELECT 11 as bene_id, 'Billy' as first_name, 'Yabsley' as last_name, 12 as zip_id, 0.00571 as lat_add, 0.006129 as long_add UNION ALL
SELECT 12 as bene_id, 'Clarence' as first_name, 'Scarce' as last_name, 22 as zip_id, -0.011386 as lat_add, 0.017974 as long_add UNION ALL
SELECT 13 as bene_id, 'Jacquelynn' as first_name, 'Stockall' as last_name, 18 as zip_id, 0.002782 as lat_add, -0.011391 as long_add UNION ALL
SELECT 14 as bene_id, 'Derrick' as first_name, 'Sarjent' as last_name, 19 as zip_id, -0.001241 as lat_add, -0.022217 as long_add UNION ALL
SELECT 15 as bene_id, 'Fionna' as first_name, 'Milliere' as last_name, 12 as zip_id, -0.004871 as lat_add, -0.01205 as long_add UNION ALL
SELECT 16 as bene_id, 'Gracia' as first_name, 'Blackhurst' as last_name, 15 as zip_id, -0.022997 as lat_add, -0.004223 as long_add UNION ALL
SELECT 17 as bene_id, 'Zonda' as first_name, 'Altham' as last_name, 11 as zip_id, 0.022225 as lat_add, -0.018761 as long_add UNION ALL
SELECT 18 as bene_id, 'Ginnie' as first_name, 'Bagley' as last_name, 9 as zip_id, -0.019066 as lat_add, 0.010664 as long_add UNION ALL
SELECT 19 as bene_id, 'Noak' as first_name, 'Kirkwood' as last_name, 13 as zip_id, -0.001015 as lat_add, -0.022664 as long_add UNION ALL
SELECT 20 as bene_id, 'Ophelie' as first_name, 'Tallent' as last_name, 16 as zip_id, -0.019561 as lat_add, 0.002667 as long_add UNION ALL
SELECT 21 as bene_id, 'Gale' as first_name, 'Conrard' as last_name, 19 as zip_id, 0.010508 as lat_add, 0.023444 as long_add UNION ALL
SELECT 22 as bene_id, 'Roddie' as first_name, 'Loyley' as last_name, 8 as zip_id, -0.011499 as lat_add, 0.01228 as long_add UNION ALL
SELECT 23 as bene_id, 'Orren' as first_name, 'Wharrier' as last_name, 15 as zip_id, -0.024682 as lat_add, 0.007979 as long_add UNION ALL
SELECT 24 as bene_id, 'Vassily' as first_name, 'Puzey' as last_name, 20 as zip_id, 0.014184 as lat_add, 0.000874 as long_add UNION ALL
SELECT 25 as bene_id, 'Reagen' as first_name, 'Elman' as last_name, 11 as zip_id, 0.018798 as lat_add, 0.020633 as long_add UNION ALL
SELECT 26 as bene_id, 'Henderson' as first_name, 'Broader' as last_name, 17 as zip_id, -0.024112 as lat_add, -0.004187 as long_add UNION ALL
SELECT 27 as bene_id, 'Kore' as first_name, 'Mantha' as last_name, 15 as zip_id, 0.005606 as lat_add, -0.006074 as long_add UNION ALL
SELECT 28 as bene_id, 'Emlyn' as first_name, 'Boggis' as last_name, 12 as zip_id, -0.012607 as lat_add, -0.017325 as long_add UNION ALL
SELECT 29 as bene_id, 'Willyt' as first_name, 'Drane' as last_name, 20 as zip_id, -0.023402 as lat_add, -0.022341 as long_add UNION ALL
SELECT 30 as bene_id, 'Bailey' as first_name, 'Canlin' as last_name, 14 as zip_id, -0.016487 as lat_add, -0.001686 as long_add UNION ALL
SELECT 31 as bene_id, 'Araldo' as first_name, 'Hutcheon' as last_name, 16 as zip_id, 0.014325 as lat_add, -0.019425 as long_add UNION ALL
SELECT 32 as bene_id, 'Glenn' as first_name, 'Lantiff' as last_name, 22 as zip_id, -0.024338 as lat_add, -0.002505 as long_add UNION ALL
SELECT 33 as bene_id, 'Anabella' as first_name, 'Measen' as last_name, 15 as zip_id, -0.022607 as lat_add, 0.012792 as long_add UNION ALL
SELECT 34 as bene_id, 'Winfred' as first_name, 'Eginton' as last_name, 25 as zip_id, 0.006466 as lat_add, -0.022376 as long_add UNION ALL
SELECT 35 as bene_id, 'Findlay' as first_name, 'Kubecka' as last_name, 13 as zip_id, -0.019108 as lat_add, 0.01964 as long_add UNION ALL
SELECT 36 as bene_id, 'Holden' as first_name, 'Tumioto' as last_name, 16 as zip_id, -0.01606 as lat_add, -0.016418 as long_add UNION ALL
SELECT 37 as bene_id, 'Emerson' as first_name, 'Chippin' as last_name, 9 as zip_id, 0.022037 as lat_add, 0.01498 as long_add UNION ALL
SELECT 38 as bene_id, 'Lara' as first_name, 'Sidney' as last_name, 20 as zip_id, 0.024223 as lat_add, -0.01747 as long_add UNION ALL
SELECT 39 as bene_id, 'Dionis' as first_name, 'Dondon' as last_name, 18 as zip_id, -0.00082 as lat_add, 0.012806 as long_add UNION ALL
SELECT 40 as bene_id, 'Selig' as first_name, 'Hawkridge' as last_name, 8 as zip_id, -0.006859 as lat_add, 0.013258 as long_add UNION ALL
SELECT 41 as bene_id, 'George' as first_name, 'Tunesi' as last_name, 16 as zip_id, -0.007976 as lat_add, -0.016098 as long_add UNION ALL
SELECT 42 as bene_id, 'Merlina' as first_name, 'Martynikhin' as last_name, 15 as zip_id, 0.009106 as lat_add, -0.00702 as long_add UNION ALL
SELECT 43 as bene_id, 'Kalila' as first_name, 'Beggan' as last_name, 26 as zip_id, -0.020239 as lat_add, -0.006682 as long_add UNION ALL
SELECT 44 as bene_id, 'Sarena' as first_name, 'Tildesley' as last_name, 12 as zip_id, 0.011321 as lat_add, 0.012427 as long_add UNION ALL
SELECT 45 as bene_id, 'Virge' as first_name, 'Maeer' as last_name, 17 as zip_id, -0.004988 as lat_add, 0.013453 as long_add UNION ALL
SELECT 46 as bene_id, 'Patrizia' as first_name, 'Cakebread' as last_name, 13 as zip_id, 0.001587 as lat_add, 0.023361 as long_add UNION ALL
SELECT 47 as bene_id, 'Kelbee' as first_name, 'Smart' as last_name, 11 as zip_id, -0.007844 as lat_add, -0.019612 as long_add UNION ALL
SELECT 48 as bene_id, 'Eal' as first_name, 'Tzarkov' as last_name, 25 as zip_id, -0.020353 as lat_add, 0.00232 as long_add UNION ALL
SELECT 49 as bene_id, 'Berk' as first_name, 'Colbran' as last_name, 29 as zip_id, -0.007713 as lat_add, 0.017757 as long_add UNION ALL
SELECT 50 as bene_id, 'Rockie' as first_name, 'John' as last_name, 23 as zip_id, -0.002706 as lat_add, -0.002795 as long_add UNION ALL
SELECT 51 as bene_id, 'Corinna' as first_name, 'Falck' as last_name, 6 as zip_id, 0.01243 as lat_add, -0.000899 as long_add UNION ALL
SELECT 52 as bene_id, 'Pail' as first_name, 'McIlvenny' as last_name, 10 as zip_id, -0.022762 as lat_add, -0.024821 as long_add UNION ALL
SELECT 53 as bene_id, 'Demott' as first_name, 'Danielot' as last_name, 13 as zip_id, 0.003137 as lat_add, -0.013065 as long_add UNION ALL
SELECT 54 as bene_id, 'Adrian' as first_name, 'Labram' as last_name, 11 as zip_id, -0.007496 as lat_add, 0.008409 as long_add UNION ALL
SELECT 55 as bene_id, 'Skippie' as first_name, 'Febvre' as last_name, 28 as zip_id, 0.021703 as lat_add, 0.017619 as long_add UNION ALL
SELECT 56 as bene_id, 'Kari' as first_name, 'Stebles' as last_name, 24 as zip_id, -0.021125 as lat_add, -0.007556 as long_add UNION ALL
SELECT 57 as bene_id, 'Estevan' as first_name, 'Shreenan' as last_name, 16 as zip_id, 0.006941 as lat_add, -0.023219 as long_add UNION ALL
SELECT 58 as bene_id, 'Consolata' as first_name, 'Bolger' as last_name, 7 as zip_id, -0.00224 as lat_add, 0.009111 as long_add UNION ALL
SELECT 59 as bene_id, 'Onfre' as first_name, 'Sciusscietto' as last_name, 21 as zip_id, -0.000113 as lat_add, -0.005399 as long_add UNION ALL
SELECT 60 as bene_id, 'Maurits' as first_name, 'Baudi' as last_name, 18 as zip_id, -0.009361 as lat_add, 0.0131 as long_add UNION ALL
SELECT 61 as bene_id, 'Maximilian' as first_name, 'Pigeram' as last_name, 11 as zip_id, -0.010655 as lat_add, -0.024358 as long_add UNION ALL
SELECT 62 as bene_id, 'Sandie' as first_name, 'Ridgwell' as last_name, 18 as zip_id, 0.004146 as lat_add, 0.012519 as long_add UNION ALL
SELECT 63 as bene_id, 'Zachary' as first_name, 'Ovise' as last_name, 20 as zip_id, -0.013501 as lat_add, 0.00532 as long_add UNION ALL
SELECT 64 as bene_id, 'Ferdinand' as first_name, 'Slipper' as last_name, 19 as zip_id, 0.016621 as lat_add, 0.01331 as long_add UNION ALL
SELECT 65 as bene_id, 'Olivette' as first_name, 'Stroband' as last_name, 4 as zip_id, 0.000896 as lat_add, 0.012931 as long_add UNION ALL
SELECT 66 as bene_id, 'Linea' as first_name, 'Leggatt' as last_name, 18 as zip_id, 0.005871 as lat_add, 0.009023 as long_add UNION ALL
SELECT 67 as bene_id, 'Clemens' as first_name, 'Domek' as last_name, 20 as zip_id, 0.0173 as lat_add, 0.004534 as long_add UNION ALL
SELECT 68 as bene_id, 'Ailey' as first_name, 'Fitkin' as last_name, 27 as zip_id, 0.01581 as lat_add, 0.015167 as long_add UNION ALL
SELECT 69 as bene_id, 'Elmo' as first_name, 'Parres' as last_name, 14 as zip_id, -0.02015 as lat_add, 0.016582 as long_add UNION ALL
SELECT 70 as bene_id, 'Bette-ann' as first_name, 'Anthon' as last_name, 21 as zip_id, 0.007721 as lat_add, -0.020537 as long_add UNION ALL
SELECT 71 as bene_id, 'Dahlia' as first_name, 'Saphin' as last_name, 26 as zip_id, -0.012304 as lat_add, -0.00506 as long_add UNION ALL
SELECT 72 as bene_id, 'Juliana' as first_name, 'McCaskill' as last_name, 6 as zip_id, 0.005621 as lat_add, -0.001703 as long_add UNION ALL
SELECT 73 as bene_id, 'Gabriell' as first_name, 'Urch' as last_name, 13 as zip_id, -0.00041 as lat_add, 0.022345 as long_add UNION ALL
SELECT 74 as bene_id, 'Goddart' as first_name, 'Sunnucks' as last_name, 22 as zip_id, 0.00949 as lat_add, -0.010381 as long_add UNION ALL
SELECT 75 as bene_id, 'Kennith' as first_name, 'Malling' as last_name, 23 as zip_id, -0.018928 as lat_add, 0.005772 as long_add UNION ALL
SELECT 76 as bene_id, 'Emlyn' as first_name, 'Edson' as last_name, 15 as zip_id, 0.024332 as lat_add, -0.016243 as long_add UNION ALL
SELECT 77 as bene_id, 'Stacy' as first_name, 'Boord' as last_name, 14 as zip_id, -0.004398 as lat_add, 0.01187 as long_add UNION ALL
SELECT 78 as bene_id, 'Reta' as first_name, 'Lowbridge' as last_name, 13 as zip_id, 0.022373 as lat_add, -0.019135 as long_add UNION ALL
SELECT 79 as bene_id, 'Corri' as first_name, 'Meader' as last_name, 19 as zip_id, -0.013952 as lat_add, -0.022042 as long_add UNION ALL
SELECT 80 as bene_id, 'Pepita' as first_name, 'Domico' as last_name, 18 as zip_id, -0.002068 as lat_add, -0.004259 as long_add UNION ALL
SELECT 81 as bene_id, 'Fanni' as first_name, 'Echalier' as last_name, 23 as zip_id, 0.010319 as lat_add, -0.013278 as long_add UNION ALL
SELECT 82 as bene_id, 'Odo' as first_name, 'Jerche' as last_name, 15 as zip_id, -0.004627 as lat_add, -0.010728 as long_add UNION ALL
SELECT 83 as bene_id, 'Annadiana' as first_name, 'Mycock' as last_name, 32 as zip_id, -0.021433 as lat_add, -0.016904 as long_add UNION ALL
SELECT 84 as bene_id, 'Heidi' as first_name, 'Feldstein' as last_name, 14 as zip_id, 0.024236 as lat_add, -0.004529 as long_add UNION ALL
SELECT 85 as bene_id, 'Petra' as first_name, 'Treslove' as last_name, 23 as zip_id, 0.018564 as lat_add, -0.019199 as long_add UNION ALL
SELECT 86 as bene_id, 'Chloe' as first_name, 'Dible' as last_name, 23 as zip_id, 0.007759 as lat_add, 0.017557 as long_add UNION ALL
SELECT 87 as bene_id, 'Bernadine' as first_name, 'Tolomelli' as last_name, 23 as zip_id, -0.013356 as lat_add, 0.008264 as long_add UNION ALL
SELECT 88 as bene_id, 'Arvie' as first_name, 'Issacov' as last_name, 11 as zip_id, -0.012171 as lat_add, 0.021172 as long_add UNION ALL
SELECT 89 as bene_id, 'Maurice' as first_name, 'Levensky' as last_name, 12 as zip_id, -0.001975 as lat_add, 0.009538 as long_add UNION ALL
SELECT 90 as bene_id, 'Tonnie' as first_name, 'Cantillon' as last_name, 17 as zip_id, -0.006561 as lat_add, -0.001972 as long_add UNION ALL
SELECT 91 as bene_id, 'Helena' as first_name, 'Jenyns' as last_name, 10 as zip_id, -0.019696 as lat_add, 0.002073 as long_add UNION ALL
SELECT 92 as bene_id, 'Seward' as first_name, 'Hempshall' as last_name, 16 as zip_id, 0.018587 as lat_add, -0.000057 as long_add UNION ALL
SELECT 93 as bene_id, 'Charles' as first_name, 'Gingles' as last_name, 10 as zip_id, 0.021515 as lat_add, -0.009455 as long_add UNION ALL
SELECT 94 as bene_id, 'Livvyy' as first_name, 'Cordon' as last_name, 19 as zip_id, -0.016705 as lat_add, 0.019818 as long_add UNION ALL
SELECT 95 as bene_id, 'Cecil' as first_name, 'Hanalan' as last_name, 18 as zip_id, 0.010687 as lat_add, -0.017383 as long_add UNION ALL
SELECT 96 as bene_id, 'Giacomo' as first_name, 'Lamke' as last_name, 15 as zip_id, 0.01583 as lat_add, 0.020641 as long_add UNION ALL
SELECT 97 as bene_id, 'Luciana' as first_name, 'Trout' as last_name, 4 as zip_id, 0.014037 as lat_add, 0.011891 as long_add UNION ALL
SELECT 98 as bene_id, 'Bellanca' as first_name, 'MacCafferty' as last_name, 11 as zip_id, -0.014355 as lat_add, 0.018451 as long_add UNION ALL
SELECT 99 as bene_id, 'Serena' as first_name, 'Huller' as last_name, 19 as zip_id, 0.021212 as lat_add, -0.00411 as long_add UNION ALL
SELECT 100 as bene_id, 'Dun' as first_name, 'Trighton' as last_name, 11 as zip_id, -0.014808 as lat_add, -0.020933 as long_add UNION ALL
SELECT 101 as bene_id, 'Guntar' as first_name, 'Trevenu' as last_name, 22 as zip_id, -0.000369 as lat_add, -0.015684 as long_add UNION ALL
SELECT 102 as bene_id, 'Nonna' as first_name, 'Pioch' as last_name, 15 as zip_id, -0.010513 as lat_add, 0.013636 as long_add UNION ALL
SELECT 103 as bene_id, 'Zuzana' as first_name, 'Dewick' as last_name, 11 as zip_id, 0.01066 as lat_add, 0.010374 as long_add UNION ALL
SELECT 104 as bene_id, 'Cristiano' as first_name, 'Giorgietto' as last_name, 12 as zip_id, -0.003818 as lat_add, 0.013735 as long_add UNION ALL
SELECT 105 as bene_id, 'Sullivan' as first_name, 'Meakes' as last_name, 20 as zip_id, 0.014527 as lat_add, 0.005843 as long_add UNION ALL
SELECT 106 as bene_id, 'Ignacio' as first_name, 'Lenney' as last_name, 16 as zip_id, -0.006338 as lat_add, 0.012625 as long_add UNION ALL
SELECT 107 as bene_id, 'Morley' as first_name, 'Curness' as last_name, 25 as zip_id, 0.017279 as lat_add, 0.016721 as long_add UNION ALL
SELECT 108 as bene_id, 'Cletis' as first_name, 'Battell' as last_name, 16 as zip_id, 0.015365 as lat_add, 0.020374 as long_add UNION ALL
SELECT 109 as bene_id, 'Dody' as first_name, 'Sutterby' as last_name, 20 as zip_id, -0.02185 as lat_add, -0.007003 as long_add UNION ALL
SELECT 110 as bene_id, 'Miner' as first_name, 'Gregine' as last_name, 13 as zip_id, -0.015613 as lat_add, 0.015316 as long_add UNION ALL
SELECT 111 as bene_id, 'Noelani' as first_name, 'Cleaton' as last_name, 18 as zip_id, -0.010618 as lat_add, -0.007106 as long_add UNION ALL
SELECT 112 as bene_id, 'Maggi' as first_name, 'Scruton' as last_name, 8 as zip_id, 0.004626 as lat_add, 0.024897 as long_add UNION ALL
SELECT 113 as bene_id, 'Gloria' as first_name, 'Hillam' as last_name, 13 as zip_id, -0.002043 as lat_add, 0.016293 as long_add UNION ALL
SELECT 114 as bene_id, 'Sloane' as first_name, 'Southern' as last_name, 16 as zip_id, 0.00232 as lat_add, 0.011591 as long_add UNION ALL
SELECT 115 as bene_id, 'Valeda' as first_name, 'Etock' as last_name, 8 as zip_id, 0.014879 as lat_add, -0.018289 as long_add UNION ALL
SELECT 116 as bene_id, 'Silvester' as first_name, 'Brettoner' as last_name, 16 as zip_id, 0.022902 as lat_add, 0.006561 as long_add UNION ALL
SELECT 117 as bene_id, 'Bartram' as first_name, 'Sine' as last_name, 17 as zip_id, 0.01937 as lat_add, -0.004673 as long_add UNION ALL
SELECT 118 as bene_id, 'Pip' as first_name, 'Jopp' as last_name, 7 as zip_id, -0.016661 as lat_add, -0.008217 as long_add UNION ALL
SELECT 119 as bene_id, 'Blythe' as first_name, 'Pulteneye' as last_name, 18 as zip_id, 0.001435 as lat_add, -0.004945 as long_add UNION ALL
SELECT 120 as bene_id, 'Maribelle' as first_name, 'Gillicuddy' as last_name, 21 as zip_id, -0.006497 as lat_add, -0.016978 as long_add UNION ALL
SELECT 121 as bene_id, 'Godfrey' as first_name, 'Sydenham' as last_name, 14 as zip_id, -0.021433 as lat_add, 0.016488 as long_add UNION ALL
SELECT 122 as bene_id, 'Jefferey' as first_name, 'Madre' as last_name, 9 as zip_id, 0.012356 as lat_add, 0.00496 as long_add UNION ALL
SELECT 123 as bene_id, 'Carney' as first_name, 'Elliker' as last_name, 10 as zip_id, -0.014205 as lat_add, -0.013803 as long_add UNION ALL
SELECT 124 as bene_id, 'Gideon' as first_name, 'Inchan' as last_name, 22 as zip_id, 0.007671 as lat_add, -0.004137 as long_add UNION ALL
SELECT 125 as bene_id, 'Mose' as first_name, 'Vogl' as last_name, 14 as zip_id, -0.021258 as lat_add, 0.013029 as long_add UNION ALL
SELECT 126 as bene_id, 'Faydra' as first_name, 'Blabey' as last_name, 15 as zip_id, -0.005808 as lat_add, -0.01248 as long_add UNION ALL
SELECT 127 as bene_id, 'Terrijo' as first_name, 'Bumford' as last_name, 19 as zip_id, 0.00988 as lat_add, -0.002981 as long_add UNION ALL
SELECT 128 as bene_id, 'Judd' as first_name, 'Reford' as last_name, 13 as zip_id, 0.021373 as lat_add, 0.009764 as long_add UNION ALL
SELECT 129 as bene_id, 'Esmaria' as first_name, 'MacMillan' as last_name, 14 as zip_id, -0.021622 as lat_add, 0.016281 as long_add UNION ALL
SELECT 130 as bene_id, 'Ellen' as first_name, 'Stannett' as last_name, 12 as zip_id, 0.011595 as lat_add, -0.018777 as long_add UNION ALL
SELECT 131 as bene_id, 'Jodie' as first_name, 'Braiden' as last_name, 30 as zip_id, 0.019883 as lat_add, -0.024459 as long_add UNION ALL
SELECT 132 as bene_id, 'Morgan' as first_name, 'Davers' as last_name, 23 as zip_id, 0.012039 as lat_add, 0.012818 as long_add UNION ALL
SELECT 133 as bene_id, 'Alfi' as first_name, 'Minette' as last_name, 20 as zip_id, 0.014126 as lat_add, -0.001094 as long_add UNION ALL
SELECT 134 as bene_id, 'Jereme' as first_name, 'Dietzler' as last_name, 14 as zip_id, -0.018222 as lat_add, -0.015171 as long_add UNION ALL
SELECT 135 as bene_id, 'Lem' as first_name, 'Haspineall' as last_name, 19 as zip_id, -0.022057 as lat_add, -0.023193 as long_add UNION ALL
SELECT 136 as bene_id, 'Crissie' as first_name, 'Younglove' as last_name, 14 as zip_id, 0.009774 as lat_add, 0.017319 as long_add UNION ALL
SELECT 137 as bene_id, 'Kathie' as first_name, 'Bowller' as last_name, 16 as zip_id, 0.012606 as lat_add, -0.017138 as long_add UNION ALL
SELECT 138 as bene_id, 'Jazmin' as first_name, 'Stanner' as last_name, 12 as zip_id, -0.022618 as lat_add, 0.015596 as long_add UNION ALL
SELECT 139 as bene_id, 'Hallsy' as first_name, 'Bysaker' as last_name, 15 as zip_id, -0.009629 as lat_add, 0.018941 as long_add UNION ALL
SELECT 140 as bene_id, 'Samuele' as first_name, 'Gidney' as last_name, 13 as zip_id, 0.00353 as lat_add, 0.012138 as long_add UNION ALL
SELECT 141 as bene_id, 'Carolina' as first_name, 'Lucus' as last_name, 22 as zip_id, 0.010011 as lat_add, 0.02414 as long_add UNION ALL
SELECT 142 as bene_id, 'Standford' as first_name, 'Wasteney' as last_name, 12 as zip_id, -0.003744 as lat_add, -0.00017 as long_add UNION ALL
SELECT 143 as bene_id, 'Alyosha' as first_name, 'Bukowski' as last_name, 10 as zip_id, -0.010223 as lat_add, 0.00423 as long_add UNION ALL
SELECT 144 as bene_id, 'Doralynn' as first_name, 'Shalders' as last_name, 19 as zip_id, 0.0005 as lat_add, -0.023698 as long_add UNION ALL
SELECT 145 as bene_id, 'Art' as first_name, 'McCreadie' as last_name, 10 as zip_id, 0.006302 as lat_add, 0.022174 as long_add UNION ALL
SELECT 146 as bene_id, 'Kelbee' as first_name, 'Dunton' as last_name, 14 as zip_id, -0.011437 as lat_add, 0.016226 as long_add UNION ALL
SELECT 147 as bene_id, 'Bobbye' as first_name, 'Mohan' as last_name, 24 as zip_id, 0.013884 as lat_add, 0.001554 as long_add UNION ALL
SELECT 148 as bene_id, 'Trudi' as first_name, 'Studde' as last_name, 14 as zip_id, 0.020068 as lat_add, -0.001346 as long_add UNION ALL
SELECT 149 as bene_id, 'Giacopo' as first_name, 'Benes' as last_name, 18 as zip_id, 0.019077 as lat_add, 0.016188 as long_add UNION ALL
SELECT 150 as bene_id, 'Petey' as first_name, 'Fraschetti' as last_name, 21 as zip_id, 0.019207 as lat_add, 0.004564 as long_add UNION ALL
SELECT 151 as bene_id, 'Jeanette' as first_name, 'Wilsher' as last_name, 10 as zip_id, 0.003233 as lat_add, 0.018827 as long_add UNION ALL
SELECT 152 as bene_id, 'Debby' as first_name, 'Rogger' as last_name, 20 as zip_id, -0.000598 as lat_add, 0.009941 as long_add UNION ALL
SELECT 153 as bene_id, 'Gaspard' as first_name, 'Grinnell' as last_name, 8 as zip_id, -0.008323 as lat_add, 0.00522 as long_add UNION ALL
SELECT 154 as bene_id, 'Vernon' as first_name, 'Prewer' as last_name, 15 as zip_id, 0.017315 as lat_add, -0.014585 as long_add UNION ALL
SELECT 155 as bene_id, 'Mona' as first_name, 'Baseke' as last_name, 8 as zip_id, 0.02129 as lat_add, -0.02435 as long_add UNION ALL
SELECT 156 as bene_id, 'Dulce' as first_name, 'Lamey' as last_name, 11 as zip_id, 0.016773 as lat_add, -0.013164 as long_add UNION ALL
SELECT 157 as bene_id, 'Dorolice' as first_name, 'Cust' as last_name, 16 as zip_id, -0.024914 as lat_add, -0.020974 as long_add UNION ALL
SELECT 158 as bene_id, 'Curry' as first_name, 'Lardner' as last_name, 23 as zip_id, -0.023533 as lat_add, 0.014005 as long_add UNION ALL
SELECT 159 as bene_id, 'Ricca' as first_name, 'Rudall' as last_name, 12 as zip_id, -0.002338 as lat_add, -0.011277 as long_add UNION ALL
SELECT 160 as bene_id, 'Ingelbert' as first_name, 'Dreghorn' as last_name, 13 as zip_id, 0.012874 as lat_add, -0.013857 as long_add UNION ALL
SELECT 161 as bene_id, 'Kristal' as first_name, 'Dibdin' as last_name, 24 as zip_id, 0.007432 as lat_add, -0.021923 as long_add UNION ALL
SELECT 162 as bene_id, 'Serge' as first_name, 'Bras' as last_name, 15 as zip_id, 0.017968 as lat_add, 0.016591 as long_add UNION ALL
SELECT 163 as bene_id, 'Franciskus' as first_name, 'Kunkler' as last_name, 20 as zip_id, -0.011348 as lat_add, 0.021776 as long_add UNION ALL
SELECT 164 as bene_id, 'Petr' as first_name, 'Browning' as last_name, 13 as zip_id, 0.018699 as lat_add, 0.015567 as long_add UNION ALL
SELECT 165 as bene_id, 'Bobbette' as first_name, 'Ivanin' as last_name, 2 as zip_id, -0.008848 as lat_add, -0.016107 as long_add UNION ALL
SELECT 166 as bene_id, 'Olenka' as first_name, 'Greenier' as last_name, 14 as zip_id, -0.004437 as lat_add, 0.002371 as long_add UNION ALL
SELECT 167 as bene_id, 'Mart' as first_name, 'Bellamy' as last_name, 20 as zip_id, 0.024838 as lat_add, -0.005806 as long_add UNION ALL
SELECT 168 as bene_id, 'Korney' as first_name, 'Attle' as last_name, 22 as zip_id, -0.02121 as lat_add, -0.014683 as long_add UNION ALL
SELECT 169 as bene_id, 'Josey' as first_name, 'Clinkard' as last_name, 22 as zip_id, 0.019308 as lat_add, 0.024983 as long_add UNION ALL
SELECT 170 as bene_id, 'Sandro' as first_name, 'Crowthe' as last_name, 12 as zip_id, 0.021335 as lat_add, 0.009962 as long_add UNION ALL
SELECT 171 as bene_id, 'Cassy' as first_name, 'Tripe' as last_name, 27 as zip_id, -0.005875 as lat_add, 0.008225 as long_add UNION ALL
SELECT 172 as bene_id, 'Adora' as first_name, 'Teodori' as last_name, 17 as zip_id, -0.002313 as lat_add, 0.002188 as long_add UNION ALL
SELECT 173 as bene_id, 'Clayborn' as first_name, 'Doers' as last_name, 14 as zip_id, -0.018937 as lat_add, -0.011805 as long_add UNION ALL
SELECT 174 as bene_id, 'Lyssa' as first_name, 'Mandal' as last_name, 9 as zip_id, -0.011443 as lat_add, 0.01655 as long_add UNION ALL
SELECT 175 as bene_id, 'Cathleen' as first_name, 'Lionel' as last_name, 9 as zip_id, 0.008672 as lat_add, -0.016759 as long_add UNION ALL
SELECT 176 as bene_id, 'Spike' as first_name, 'Ucceli' as last_name, 13 as zip_id, 0.021036 as lat_add, -0.011098 as long_add UNION ALL
SELECT 177 as bene_id, 'Constantin' as first_name, 'Peterffy' as last_name, 13 as zip_id, -0.019135 as lat_add, 0.024864 as long_add UNION ALL
SELECT 178 as bene_id, 'Neille' as first_name, 'Bardey' as last_name, 11 as zip_id, 0.012135 as lat_add, -0.021281 as long_add UNION ALL
SELECT 179 as bene_id, 'Rozalie' as first_name, 'Dennington' as last_name, 14 as zip_id, 0.000464 as lat_add, -0.007148 as long_add UNION ALL
SELECT 180 as bene_id, 'Farlee' as first_name, 'Myderscough' as last_name, 19 as zip_id, -0.020976 as lat_add, 0.007229 as long_add UNION ALL
SELECT 181 as bene_id, 'Vick' as first_name, 'Georgel' as last_name, 19 as zip_id, -0.001629 as lat_add, -0.015498 as long_add UNION ALL
SELECT 182 as bene_id, 'Shayna' as first_name, 'Iorio' as last_name, 13 as zip_id, -0.014583 as lat_add, 0.000002 as long_add UNION ALL
SELECT 183 as bene_id, 'Kippy' as first_name, 'Leele' as last_name, 18 as zip_id, 0.023626 as lat_add, 0.017376 as long_add UNION ALL
SELECT 184 as bene_id, 'Stan' as first_name, 'Dickenson' as last_name, 8 as zip_id, -0.017728 as lat_add, -0.011943 as long_add UNION ALL
SELECT 185 as bene_id, 'Druci' as first_name, 'Chateau' as last_name, 13 as zip_id, -0.014773 as lat_add, -0.023001 as long_add UNION ALL
SELECT 186 as bene_id, 'Kelley' as first_name, 'Truscott' as last_name, 16 as zip_id, 0.004443 as lat_add, -0.000509 as long_add UNION ALL
SELECT 187 as bene_id, 'Adan' as first_name, 'Pascoe' as last_name, 8 as zip_id, 0.000572 as lat_add, 0.011169 as long_add UNION ALL
SELECT 188 as bene_id, 'Raynell' as first_name, 'Preedy' as last_name, 16 as zip_id, -0.02396 as lat_add, -0.001388 as long_add UNION ALL
SELECT 189 as bene_id, 'Shirl' as first_name, 'Faircloth' as last_name, 17 as zip_id, -0.016315 as lat_add, 0.018275 as long_add UNION ALL
SELECT 190 as bene_id, 'Ole' as first_name, 'Harken' as last_name, 7 as zip_id, 0.01725 as lat_add, -0.013717 as long_add UNION ALL
SELECT 191 as bene_id, 'Staford' as first_name, 'Lyptratt' as last_name, 18 as zip_id, -0.017042 as lat_add, -0.024569 as long_add UNION ALL
SELECT 192 as bene_id, 'Wernher' as first_name, 'Gimert' as last_name, 21 as zip_id, 0.021439 as lat_add, -0.000995 as long_add UNION ALL
SELECT 193 as bene_id, 'Allene' as first_name, 'L Estrange' as last_name, 14 as zip_id, -0.023322 as lat_add, 0.004956 as long_add UNION ALL
SELECT 194 as bene_id, 'Danna' as first_name, 'McManamon' as last_name, 9 as zip_id, -0.00665 as lat_add, 0.001432 as long_add UNION ALL
SELECT 195 as bene_id, 'Abba' as first_name, 'Farbrace' as last_name, 10 as zip_id, -0.007029 as lat_add, -0.017508 as long_add UNION ALL
SELECT 196 as bene_id, 'Courtenay' as first_name, 'Gillooly' as last_name, 22 as zip_id, 0.00798 as lat_add, -0.018485 as long_add UNION ALL
SELECT 197 as bene_id, 'Torrin' as first_name, 'Claeskens' as last_name, 14 as zip_id, -0.018544 as lat_add, -0.020394 as long_add UNION ALL
SELECT 198 as bene_id, 'Barde' as first_name, 'Curado' as last_name, 15 as zip_id, -0.004892 as lat_add, 0.009384 as long_add UNION ALL
SELECT 199 as bene_id, 'Sonia' as first_name, 'Marikhin' as last_name, 19 as zip_id, -0.020502 as lat_add, 0.006124 as long_add UNION ALL
SELECT 200 as bene_id, 'Drake' as first_name, 'Waszczyk' as last_name, 13 as zip_id, -0.01331 as lat_add, -0.018107 as long_add
;;
  }
}
