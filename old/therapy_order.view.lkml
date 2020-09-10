# explore: drug_order_by_bene_typed {}

view: drug_order_by_bene_typed {
  derived_table: {
    datagroup_trigger: once_yearly
    sql:
      SELECT
        a1.bene_id,
        a1.drug_name as drug_name_1,
        a1.days_after_index_date as days_after_index_date1,
        a2.drug_name as drug_name_2,
        a2.days_after_index_date as days_after_index_date2,
        a3.drug_name as drug_name_3,
        a3.days_after_index_date as days_after_index_date3,
        a4.drug_name as drug_name_4,
        a4.days_after_index_date as days_after_index_date4,
        a5.drug_name as drug_name_5,
        a5.days_after_index_date as days_after_index_date5,
        a6.drug_name as drug_name_6,
        a6.days_after_index_date as days_after_index_date6,
        a7.drug_name as drug_name_7,
        a7.days_after_index_date as days_after_index_date7,
        a8.drug_name as drug_name_8,
        a8.days_after_index_date as days_after_index_date8
      FROM (SELECT * FROM ${drug_order_by_bene_raw2.SQL_TABLE_NAME} WHERE drug_order = 1) a1
      LEFT JOIN (SELECT * FROM ${drug_order_by_bene_raw2.SQL_TABLE_NAME} WHERE drug_order = 2) a2
        ON a1.bene_id = a2.bene_id
      LEFT JOIN (SELECT * FROM ${drug_order_by_bene_raw2.SQL_TABLE_NAME} WHERE drug_order = 3) a3
        ON a1.bene_id = a3.bene_id
      LEFT JOIN (SELECT * FROM ${drug_order_by_bene_raw2.SQL_TABLE_NAME} WHERE drug_order = 4) a4
        ON a1.bene_id = a4.bene_id
      LEFT JOIN (SELECT * FROM ${drug_order_by_bene_raw2.SQL_TABLE_NAME} WHERE drug_order = 5) a5
        ON a1.bene_id = a5.bene_id
      LEFT JOIN (SELECT * FROM ${drug_order_by_bene_raw2.SQL_TABLE_NAME} WHERE drug_order = 6) a6
        ON a1.bene_id = a6.bene_id
      LEFT JOIN (SELECT * FROM ${drug_order_by_bene_raw2.SQL_TABLE_NAME} WHERE drug_order = 7) a7
        ON a1.bene_id = a7.bene_id
      LEFT JOIN (SELECT * FROM ${drug_order_by_bene_raw2.SQL_TABLE_NAME} WHERE drug_order = 8) a8
        ON a1.bene_id = a8.bene_id
    ;;
  }
  dimension: bene_id {
    primary_key: yes
    hidden: yes
  }
  parameter: drug_included {
    type: string
    default_value: "Any Drug"
    allowed_value: {
      label: "Any Drug"
      value: "Any Drug"
    }
    allowed_value: {
      label: "OXYCONTIN"
      value: "OXYCONTIN"
    }
    allowed_value: {
      label: "LISINOPRIL"
      value: "LISINOPRIL"
    }
    allowed_value: {
      label: "OMEPRAZOLE"
      value: "OMEPRAZOLE"
    }
    allowed_value: {
      label: "FENTANYL"
      value: "FENTANYL"
    }
    allowed_value: {
      label: "LISINOPRIL"
      value: "LISINOPRIL"
    }
    allowed_value: {
      label: "HYDROCODONE-ACETAMINOPHEN"
      value: "HYDROCODONE-ACETAMINOPHEN"
    }
    allowed_value: {
      label: "ATORVASTATIN CALCIUM"
      value: "ATORVASTATIN CALCIUM"
    }
    allowed_value: {
      label: "ACETAMINOPHEN-CODEINE"
      value: "ACETAMINOPHEN-CODEINE"
    }
  }
  dimension: drug_is_included {
    type: yesno
    sql:
      ${drug_name_1} = {% parameter drug_included %} OR
      ${drug_name_2} = {% parameter drug_included %} OR
      ${drug_name_3} = {% parameter drug_included %} OR
      ${drug_name_4} = {% parameter drug_included %} OR
      {% parameter drug_included %} = 'Any Drug'
    ;;
  }
  dimension: drug_name_1 {
    group_label: "Drug Name"
  }
  dimension: drug_name_2 {
    group_label: "Drug Name"
  }
  dimension: drug_name_3 {
    group_label: "Drug Name"
  }
  dimension: drug_name_4 {
    group_label: "Drug Name"
  }
  dimension: drug_name_5 {
    group_label: "Drug Name"
  }
  dimension: drug_name_6 {
    group_label: "Drug Name"
  }
  dimension: drug_name_7 {
    group_label: "Drug Name"
  }
  dimension: drug_name_8 {
    group_label: "Drug Name"
  }
  dimension: days_after_index_date1 {
    group_label: "Days After Index"
    type: number
  }
  dimension: days_after_index_date2 {
    group_label: "Days After Index"
    type: number
  }
  dimension: days_after_index_date3 {
    group_label: "Days After Index"
    type: number
  }
  dimension: days_after_index_date4 {
    group_label: "Days After Index"
    type: number
  }
  dimension: days_after_index_date5 {
    group_label: "Days After Index"
    type: number
  }
  dimension: days_after_index_date6 {
    group_label: "Days After Index"
    type: number
  }
  dimension: days_after_index_date7 {
    group_label: "Days After Index"
    type: number
  }
  dimension: days_after_index_date8 {
    group_label: "Days After Index"
    type: number
  }
  dimension: incremental_days_after_index_date1 {
    group_label: "Incremental Days Since Last Therapy"
    type: number
    sql: ${days_after_index_date1} ;;
  }
  dimension: incremental_days_after_index_date2 {
    group_label: "Incremental Days Since Last Therapy"
    type: number
    sql: ${days_after_index_date2} - ${days_after_index_date1} ;;
  }
  dimension: incremental_days_after_index_date3 {
    group_label: "Incremental Days Since Last Therapy"
    type: number
    sql: ${days_after_index_date3} - ${days_after_index_date2} ;;
  }
  dimension: incremental_days_after_index_date4 {
    group_label: "Incremental Days Since Last Therapy"
    type: number
    sql: ${days_after_index_date4} - ${days_after_index_date3} ;;
  }
  dimension: incremental_days_after_index_date5 {
    group_label: "Incremental Days Since Last Therapy"
    type: number
    sql: ${days_after_index_date5} - ${days_after_index_date4} ;;
  }
  dimension: incremental_days_after_index_date6 {
    group_label: "Incremental Days Since Last Therapy"
    type: number
    sql: ${days_after_index_date6} - ${days_after_index_date5} ;;
  }
  dimension: incremental_days_after_index_date7 {
    group_label: "Incremental Days Since Last Therapy"
    type: number
    sql: ${days_after_index_date7} - ${days_after_index_date6} ;;
  }
  dimension: incremental_days_after_index_date8 {
    group_label: "Incremental Days Since Last Therapy"
    type: number
    sql: ${days_after_index_date8} - ${days_after_index_date7} ;;
  }
  measure: average_days_after_index1 {
    group_label: "Average Days After Index"
    type: average
    value_format_name: decimal_1
    sql: ${days_after_index_date1} ;;
  }
  measure: average_days_after_index2 {
    group_label: "Average Days After Index"
    type: average
    value_format_name: decimal_1
    sql: ${days_after_index_date2} ;;
  }
  measure: average_days_after_index3 {
    group_label: "Average Days After Index"
    type: average
    value_format_name: decimal_1
    sql: ${days_after_index_date3} ;;
  }
  measure: average_days_after_index4 {
    group_label: "Average Days After Index"
    type: average
    value_format_name: decimal_1
    sql: ${days_after_index_date4} ;;
  }
  measure: average_days_after_index5 {
    group_label: "Average Days After Index"
    type: average
    value_format_name: decimal_1
    sql: ${days_after_index_date5} ;;
  }
  measure: average_days_after_index6 {
    group_label: "Average Days After Index"
    type: average
    value_format_name: decimal_1
    sql: ${days_after_index_date6} ;;
  }
  measure: average_days_after_index7 {
    group_label: "Average Days After Index"
    type: average
    value_format_name: decimal_1
    sql: ${days_after_index_date7} ;;
  }
  measure: average_days_after_index8 {
    group_label: "Average Days After Index"
    type: average
    value_format_name: decimal_1
    sql: ${days_after_index_date8} ;;
  }
  measure: average_incremental_days_after_index1 {
    group_label: "Average Incremental Days Since Last Therapy"
    type: average
    value_format_name: decimal_1
    sql: ${incremental_days_after_index_date1} ;;
  }
  measure: average_incremental_days_after_index2 {
    group_label: "Average Incremental Days Since Last Therapy"
    type: average
    value_format_name: decimal_1
    sql: ${incremental_days_after_index_date2} ;;
  }
  measure: average_incremental_days_after_index3 {
    group_label: "Average Incremental Days Since Last Therapy"
    type: average
    value_format_name: decimal_1
    sql: ${incremental_days_after_index_date3} ;;
  }
  measure: average_incremental_days_after_index4 {
    group_label: "Average Incremental Days Since Last Therapy"
    type: average
    value_format_name: decimal_1
    sql: ${incremental_days_after_index_date4} ;;
  }
  measure: average_incremental_days_after_index5 {
    group_label: "Average Incremental Days Since Last Therapy"
    type: average
    value_format_name: decimal_1
    sql: ${incremental_days_after_index_date5} ;;
  }
  measure: average_incremental_days_after_index6 {
    group_label: "Average Incremental Days Since Last Therapy"
    type: average
    value_format_name: decimal_1
    sql: ${incremental_days_after_index_date6} ;;
  }
  measure: average_incremental_days_after_index7 {
    group_label: "Average Incremental Days Since Last Therapy"
    type: average
    value_format_name: decimal_1
    sql: ${incremental_days_after_index_date7} ;;
  }
  measure: average_incremental_days_after_index8 {
    group_label: "Average Incremental Days Since Last Therapy"
    type: average
    value_format_name: decimal_1
    sql: ${incremental_days_after_index_date8} ;;
  }
  measure: count_benes {
    type: count_distinct
    sql: ${bene_id} ;;
  }

}

# explore: drug_order_by_bene_raw2 {}

view: drug_order_by_bene_raw2 {
  derived_table: {
    # datagroup_trigger: once_yearly
    sql:
      SELECT  d.bene_id,
              a.drug_id,
              b.drug_name_simple as drug_name,
              a.date,
              c.index_date,
              datediff(day, c.index_date, a.date) as days_after_index_date,
              coalesce(a.drug_order,1) as drug_order
      FROM ${beneficiary.SQL_TABLE_NAME} d
      LEFT JOIN ${drug_order_by_bene_raw.SQL_TABLE_NAME} a
        ON d.bene_id = a.bene_id
      LEFT JOIN ${index_date_by_bene.SQL_TABLE_NAME} c
        ON d.bene_id = c.bene_id
      LEFT JOIN ${drug.SQL_TABLE_NAME} b
        ON a.drug_id = b.drug_id
    ;;
  }
  dimension: bene_id {}
}

view: drug_order_by_bene_raw {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: claims_raw {
      column: bene_id {}
      column: drug_id {}
      column: date {}
      derived_column: drug_order {
        sql: row_number() over (partition by bene_id order by date) ;;
      }
    }
  }
  dimension: bene_id {}
}
