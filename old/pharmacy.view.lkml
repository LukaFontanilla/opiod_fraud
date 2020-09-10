view: pharmacy {

  dimension: pharmacy_id {
    hidden: yes
    type: number
    primary_key: yes
  }

  dimension: pharmacy_name {
    link: {
      label: "Pharmacy Dashboard"
      url: "https://demoexpo.looker.com/dashboards/68?Pharmacy={{value}}"
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

  dimension: pharmacy_company {
    drill_fields: [pharmacy_name]
  }

  dimension: zip_code {
    type: number
    map_layer_name: us_zipcode_tabulation_areas
    value_format_name: id
    drill_fields: [pharmacy_company]
  }

  dimension: lat {
    type: number
    hidden: yes
  }

  dimension: long {
    type: number
    hidden: yes
  }

  dimension: city {
    drill_fields: [pharmacy_company]
  }

  dimension: state {
    map_layer_name: us_states
    drill_fields: [pharmacy_company]
  }

  measure: count {
    label: "Count Pharmacies"
    type: count
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:

    SELECT
      a.pharmacy_id,
      CASE
        WHEN right(cast(pharmacy_id as varchar(5)),1) in ('1','3','5','7') then concat('CVS - Store 12', cast(pharmacy_id as varchar(5)))
        WHEN right(cast(pharmacy_id as varchar(5)),1) in ('2','4','6','8') then concat('Walgreens - Store 61', cast(pharmacy_id as varchar(5)))
        ELSE concat('Rite Aid - Store 34', cast(pharmacy_id as varchar(5)))
      END as pharmacy_name,
      CASE
        WHEN right(cast(pharmacy_id as varchar(5)),1) in ('1','3','5','7') then 'CVS'
        WHEN right(cast(pharmacy_id as varchar(5)),1) in ('2','4','6','8') then 'Walgreens'
        ELSE 'Rite Aid'
      END as pharmacy_company,
      b.zip_code,
      b.lat,
      b.long,
      b.city,
      b.state
    FROM ${pharmacy_raw.SQL_TABLE_NAME} a
    JOIN ${zip_raw.SQL_TABLE_NAME} b
      ON a.zip_id = b.zip_id
;;
  }

}

view: pharmacy_raw {

  derived_table: {
    datagroup_trigger: once_yearly
    sql:

SELECT 1 as pharmacy_id, 20 as zip_id, -0.003659 as lat_add, -0.017994 as long_add UNION ALL
SELECT 2 as pharmacy_id, 21 as zip_id, -0.000202 as lat_add, 0.0168 as long_add UNION ALL
SELECT 3 as pharmacy_id, 18 as zip_id, -0.003696 as lat_add, 0.012649 as long_add UNION ALL
SELECT 4 as pharmacy_id, 13 as zip_id, -0.007887 as lat_add, 0.022991 as long_add UNION ALL
SELECT 5 as pharmacy_id, 22 as zip_id, 0.003237 as lat_add, 0.019837 as long_add UNION ALL
SELECT 6 as pharmacy_id, 15 as zip_id, -0.001006 as lat_add, 0.010462 as long_add UNION ALL
SELECT 7 as pharmacy_id, 19 as zip_id, 0.012118 as lat_add, 0.019772 as long_add UNION ALL
SELECT 8 as pharmacy_id, 19 as zip_id, 0.004949 as lat_add, -0.022893 as long_add UNION ALL
SELECT 9 as pharmacy_id, 10 as zip_id, 0.015335 as lat_add, -0.003536 as long_add UNION ALL
SELECT 10 as pharmacy_id, 15 as zip_id, 0.014913 as lat_add, 0.024151 as long_add UNION ALL
SELECT 11 as pharmacy_id, 15 as zip_id, 0.024125 as lat_add, -0.002353 as long_add UNION ALL
SELECT 12 as pharmacy_id, 19 as zip_id, 0.021628 as lat_add, -0.017152 as long_add UNION ALL
SELECT 13 as pharmacy_id, 14 as zip_id, -0.016589 as lat_add, -0.009915 as long_add UNION ALL
SELECT 14 as pharmacy_id, 8 as zip_id, 0.020984 as lat_add, 0.009169 as long_add UNION ALL
SELECT 15 as pharmacy_id, 19 as zip_id, -0.004794 as lat_add, 0.013017 as long_add UNION ALL
SELECT 16 as pharmacy_id, 17 as zip_id, 0.00068 as lat_add, -0.008853 as long_add UNION ALL
SELECT 17 as pharmacy_id, 19 as zip_id, -0.024179 as lat_add, -0.014342 as long_add UNION ALL
SELECT 18 as pharmacy_id, 17 as zip_id, 0.014933 as lat_add, 0.005222 as long_add UNION ALL
SELECT 19 as pharmacy_id, 17 as zip_id, -0.004726 as lat_add, -0.01607 as long_add UNION ALL
SELECT 20 as pharmacy_id, 14 as zip_id, 0.007081 as lat_add, -0.005376 as long_add UNION ALL
SELECT 21 as pharmacy_id, 21 as zip_id, -0.003064 as lat_add, 0.024004 as long_add UNION ALL
SELECT 22 as pharmacy_id, 18 as zip_id, -0.019937 as lat_add, 0.000646 as long_add UNION ALL
SELECT 23 as pharmacy_id, 11 as zip_id, 0.006023 as lat_add, -0.019458 as long_add UNION ALL
SELECT 24 as pharmacy_id, 23 as zip_id, -0.008031 as lat_add, -0.017044 as long_add UNION ALL
SELECT 25 as pharmacy_id, 16 as zip_id, 0.020503 as lat_add, 0.024646 as long_add UNION ALL
SELECT 26 as pharmacy_id, 14 as zip_id, 0.014299 as lat_add, -0.014899 as long_add UNION ALL
SELECT 27 as pharmacy_id, 24 as zip_id, -0.014388 as lat_add, 0.01601 as long_add UNION ALL
SELECT 28 as pharmacy_id, 14 as zip_id, -0.01729 as lat_add, -0.007125 as long_add UNION ALL
SELECT 29 as pharmacy_id, 5 as zip_id, 0.018869 as lat_add, -0.008863 as long_add UNION ALL
SELECT 30 as pharmacy_id, 16 as zip_id, -0.006238 as lat_add, 0.011764 as long_add UNION ALL
SELECT 31 as pharmacy_id, 19 as zip_id, 0.024159 as lat_add, 0.004633 as long_add UNION ALL
SELECT 32 as pharmacy_id, 15 as zip_id, -0.02169 as lat_add, -0.021331 as long_add UNION ALL
SELECT 33 as pharmacy_id, 13 as zip_id, 0.024303 as lat_add, 0.012962 as long_add UNION ALL
SELECT 34 as pharmacy_id, 16 as zip_id, 0.019083 as lat_add, -0.004447 as long_add UNION ALL
SELECT 35 as pharmacy_id, 6 as zip_id, 0.019557 as lat_add, 0.023776 as long_add UNION ALL
SELECT 36 as pharmacy_id, 17 as zip_id, -0.008226 as lat_add, -0.023464 as long_add UNION ALL
SELECT 37 as pharmacy_id, 18 as zip_id, -0.014091 as lat_add, -0.023556 as long_add UNION ALL
SELECT 38 as pharmacy_id, 15 as zip_id, -0.02008 as lat_add, -0.019597 as long_add UNION ALL
SELECT 39 as pharmacy_id, 10 as zip_id, -0.003575 as lat_add, 0.020986 as long_add UNION ALL
SELECT 40 as pharmacy_id, 9 as zip_id, -0.013328 as lat_add, 0.018636 as long_add UNION ALL
SELECT 41 as pharmacy_id, 18 as zip_id, 0.003831 as lat_add, 0.017759 as long_add UNION ALL
SELECT 42 as pharmacy_id, 18 as zip_id, -0.017921 as lat_add, 0.011775 as long_add UNION ALL
SELECT 43 as pharmacy_id, 24 as zip_id, -0.00146 as lat_add, -0.021232 as long_add UNION ALL
SELECT 44 as pharmacy_id, 11 as zip_id, -0.011461 as lat_add, 0.015394 as long_add UNION ALL
SELECT 45 as pharmacy_id, 15 as zip_id, -0.013686 as lat_add, -0.006431 as long_add UNION ALL
SELECT 46 as pharmacy_id, 20 as zip_id, -0.021869 as lat_add, -0.00166 as long_add UNION ALL
SELECT 47 as pharmacy_id, 24 as zip_id, -0.005611 as lat_add, -0.014817 as long_add UNION ALL
SELECT 48 as pharmacy_id, 14 as zip_id, 0.00487 as lat_add, -0.007741 as long_add UNION ALL
SELECT 49 as pharmacy_id, 14 as zip_id, -0.008245 as lat_add, -0.005502 as long_add UNION ALL
SELECT 50 as pharmacy_id, 11 as zip_id, -0.02282 as lat_add, -0.01288 as long_add

    ;;
  }
}
