view: risk_score_input {
  derived_table: {
    explore_source: risk_score {
      column: start_date {}
      column: humidity { field: daily_weather.humidity }
      column: temperature { field: daily_weather.temperature }
      column: trip_count {}
    }
  }
}

view: risk_score_regression {
  derived_table: {
    datagroup_trigger: sweet_datagroup
    sql_create:
      CREATE OR REPLACE MODEL ${SQL_TABLE_NAME}
      OPTIONS(model_type='linear_reg'
        , labels=['risk_score']
        , min_rel_progress = 0.05
        , max_iteration = 50
        ) AS
      SELECT
         * EXCEPT(start_date)
      FROM risk_score_inputs ;;
  }
}

######################## TRAINING INFORMATION #############################

view: risk_score_regression_evaluation {
  derived_table: {
    sql: SELECT * FROM ml.EVALUATE(
          MODEL risk_score_regression,
          (SELECT * FROM risk_score_input)) ;;
  }
  dimension: mean_absolute_error {type: number}
  dimension: mean_squared_error {type: number}
  dimension: mean_squared_log_error {type: number}
  dimension: median_absolute_error {type: number}
  dimension: r2_score {type: number}
  dimension: explained_variance {type: number}
}

view: risk_score_training {
  derived_table: {
    sql: SELECT  * FROM ml.TRAINING_INFO(MODEL risk_score_regression);;
  }
  dimension: training_run {type: number}
  dimension: iteration {type: number}
  dimension: loss {type: number}
  dimension: eval_loss {type: number}
  dimension: duration_ms {label:"Duration (ms)" type: number}
  dimension: learning_rate {type: number}
  measure: iterations {type:count}
  measure: total_loss {
    type: sum
    sql: ${loss} ;;
  }
  measure: total_training_time {
    type: sum
    label:"Total Training Time (sec)"
    sql: ${duration_ms}/1000 ;;
    value_format_name: decimal_1
  }
  measure: average_iteration_time {
    type: average
    label:"Average Iteration Time (sec)"
    sql: ${duration_ms}/1000 ;;
    value_format_name: decimal_1
  }
  set: detail {fields: [training_run,iteration,loss,eval_loss,duration_ms,learning_rate]}
}


################################ TRUE OUTPUTS ############################
view: risk_score_prediction {
  derived_table: {
    sql: SELECT * FROM ml.PREDICT(
          MODEL risk_score_regression,
          (SELECT * FROM risk_score_input));;
  }

  dimension: predicted_risk_score {
    type: number
  }

  dimension: residual {
    type:  number
    sql: ${expected_risk_score} - ${risk_score}  ;;
  }
  dimension: residual_percent {
    type:  number
    value_format_name: percent_1
    sql: 1.0 * ${residual}/NULLIF(${risk_score},0)  ;;
  }

  dimension: start_date {
    type: date
    primary_key: yes
  }

  dimension: number_comorbidites {
    type: number
  }

  dimension: number_conditions {
    type: number
  }
  dimension: risk_score {
    type: number
  }
  measure: expected_risk_score {
    type: max
    sql: ${predicted_risk_score} ;;
  }
  measure: overall_residual {
    type: max
    sql: ${residual} ;;
  }
  measure: overall_residual_percent {
    type: max
    value_format_name: percent_1
    sql: ${residual_percent} ;;
  }
}



view: applied_model_results {

  dimension: doctor_id {
    primary_key: yes
    type: number
  }

  dimension: actual_risk_score {
    value_format_name: percent_1
    type: number
    drill_fields: [doctor_id]
  }

  dimension: predicted_risk_score {
    value_format_name: percent_1
    type: number
    drill_fields: [doctor_id]
  }

  dimension: residual {
    value_format_name: percent_1
    type: number
    sql: ${actual_risk_score} - ${predicted_risk_score} ;;
    drill_fields: [doctor_id]
  }

  measure: average_actual_risk_score {
    value_format_name: percent_1
    type: average
    sql: ${actual_risk_score} ;;
    drill_fields: [drill*]
  }

  measure: average_predicted_risk_score {
    value_format_name: percent_1
    type: average
    sql: ${predicted_risk_score} ;;
    drill_fields: [drill*]
  }

  measure: average_residual {
    value_format_name: percent_1
    type: average
    sql: ${residual} ;;
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      doctor_id,
      actual_risk_score,
      predicted_risk_score
    ]
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:

  SELECT a.doctor_id, a.risk_score_dimension as actual_risk_score, a.risk_score_dimension + b.variance_from_risk_score as predicted_risk_score
  FROM ${unique_stats_by_doctor.SQL_TABLE_NAME} a
  LEFT JOIN ${applied_model_results_raw.SQL_TABLE_NAME} b
    ON a.doctor_id = b.doctor_id
    ;;
  }
}

view: applied_model_results_raw {

  derived_table: {
    datagroup_trigger: once_yearly
    sql:
SELECT 1 as doctor_id, 0.01058 as variance_from_risk_score UNION ALL
SELECT 2 as doctor_id, 0.00127 as variance_from_risk_score UNION ALL
SELECT 3 as doctor_id, -0.03337 as variance_from_risk_score UNION ALL
SELECT 4 as doctor_id, 0.03889 as variance_from_risk_score UNION ALL
SELECT 5 as doctor_id, 0.02836 as variance_from_risk_score UNION ALL
SELECT 6 as doctor_id, -0.03693 as variance_from_risk_score UNION ALL
SELECT 7 as doctor_id, 0.04791 as variance_from_risk_score UNION ALL
SELECT 8 as doctor_id, 0.08416 as variance_from_risk_score UNION ALL
SELECT 9 as doctor_id, 0.00502 as variance_from_risk_score UNION ALL
SELECT 10 as doctor_id, -0.01077 as variance_from_risk_score UNION ALL
SELECT 11 as doctor_id, 0.00113 as variance_from_risk_score UNION ALL
SELECT 12 as doctor_id, 0.07346 as variance_from_risk_score UNION ALL
SELECT 13 as doctor_id, 0.14392 as variance_from_risk_score UNION ALL
SELECT 14 as doctor_id, -0.01817 as variance_from_risk_score UNION ALL
SELECT 15 as doctor_id, 0.03539 as variance_from_risk_score UNION ALL
SELECT 16 as doctor_id, 0.05169 as variance_from_risk_score UNION ALL
SELECT 17 as doctor_id, 0.02478 as variance_from_risk_score UNION ALL
SELECT 18 as doctor_id, 0.0755 as variance_from_risk_score UNION ALL
SELECT 19 as doctor_id, 0.02855 as variance_from_risk_score UNION ALL
SELECT 20 as doctor_id, 0.05811 as variance_from_risk_score UNION ALL
SELECT 21 as doctor_id, 0.06299 as variance_from_risk_score UNION ALL
SELECT 22 as doctor_id, 0.05099 as variance_from_risk_score UNION ALL
SELECT 23 as doctor_id, 0.09877 as variance_from_risk_score UNION ALL
SELECT 24 as doctor_id, -0.07046 as variance_from_risk_score UNION ALL
SELECT 25 as doctor_id, 0.06375 as variance_from_risk_score UNION ALL
SELECT 26 as doctor_id, 0.0321 as variance_from_risk_score UNION ALL
SELECT 27 as doctor_id, 0.06951 as variance_from_risk_score UNION ALL
SELECT 28 as doctor_id, 0.12908 as variance_from_risk_score UNION ALL
SELECT 29 as doctor_id, -0.03354 as variance_from_risk_score UNION ALL
SELECT 30 as doctor_id, 0.1039 as variance_from_risk_score UNION ALL
SELECT 31 as doctor_id, 0.10145 as variance_from_risk_score UNION ALL
SELECT 32 as doctor_id, -0.05121 as variance_from_risk_score UNION ALL
SELECT 33 as doctor_id, 0.10069 as variance_from_risk_score UNION ALL
SELECT 34 as doctor_id, -0.06539 as variance_from_risk_score UNION ALL
SELECT 35 as doctor_id, -0.01874 as variance_from_risk_score UNION ALL
SELECT 36 as doctor_id, 0.11565 as variance_from_risk_score UNION ALL
SELECT 37 as doctor_id, 0.08 as variance_from_risk_score UNION ALL
SELECT 38 as doctor_id, 0.13561 as variance_from_risk_score UNION ALL
SELECT 39 as doctor_id, 0.08901 as variance_from_risk_score UNION ALL
SELECT 40 as doctor_id, 0.00578 as variance_from_risk_score UNION ALL
SELECT 41 as doctor_id, 0.02375 as variance_from_risk_score UNION ALL
SELECT 42 as doctor_id, 0.10681 as variance_from_risk_score UNION ALL
SELECT 43 as doctor_id, 0.03616 as variance_from_risk_score UNION ALL
SELECT 44 as doctor_id, 0.05306 as variance_from_risk_score UNION ALL
SELECT 45 as doctor_id, 0.06095 as variance_from_risk_score UNION ALL
SELECT 46 as doctor_id, 0.11613 as variance_from_risk_score UNION ALL
SELECT 47 as doctor_id, 0.03517 as variance_from_risk_score UNION ALL
SELECT 48 as doctor_id, 0.10143 as variance_from_risk_score UNION ALL
SELECT 49 as doctor_id, 0.04819 as variance_from_risk_score UNION ALL
SELECT 50 as doctor_id, 0.17742 as variance_from_risk_score UNION ALL
SELECT 51 as doctor_id, -0.00317 as variance_from_risk_score UNION ALL
SELECT 52 as doctor_id, 0.0538 as variance_from_risk_score UNION ALL
SELECT 53 as doctor_id, 0.04985 as variance_from_risk_score UNION ALL
SELECT 54 as doctor_id, -0.03629 as variance_from_risk_score UNION ALL
SELECT 55 as doctor_id, -0.018 as variance_from_risk_score UNION ALL
SELECT 56 as doctor_id, 0.00768 as variance_from_risk_score UNION ALL
SELECT 57 as doctor_id, -0.06626 as variance_from_risk_score UNION ALL
SELECT 58 as doctor_id, 0.07857 as variance_from_risk_score UNION ALL
SELECT 59 as doctor_id, -0.01024 as variance_from_risk_score UNION ALL
SELECT 60 as doctor_id, 0.06896 as variance_from_risk_score UNION ALL
SELECT 61 as doctor_id, 0.10637 as variance_from_risk_score UNION ALL
SELECT 62 as doctor_id, 0.00386 as variance_from_risk_score UNION ALL
SELECT 63 as doctor_id, 0.02094 as variance_from_risk_score UNION ALL
SELECT 64 as doctor_id, 0.04701 as variance_from_risk_score UNION ALL
SELECT 65 as doctor_id, 0.01444 as variance_from_risk_score UNION ALL
SELECT 66 as doctor_id, 0.06401 as variance_from_risk_score UNION ALL
SELECT 67 as doctor_id, -0.04079 as variance_from_risk_score UNION ALL
SELECT 68 as doctor_id, 0.04538 as variance_from_risk_score UNION ALL
SELECT 69 as doctor_id, 0.02433 as variance_from_risk_score UNION ALL
SELECT 70 as doctor_id, 0.02167 as variance_from_risk_score UNION ALL
SELECT 71 as doctor_id, 0.01222 as variance_from_risk_score UNION ALL
SELECT 72 as doctor_id, -0.02653 as variance_from_risk_score UNION ALL
SELECT 73 as doctor_id, 0.07701 as variance_from_risk_score UNION ALL
SELECT 74 as doctor_id, 0.0648 as variance_from_risk_score UNION ALL
SELECT 75 as doctor_id, 0.01262 as variance_from_risk_score UNION ALL
SELECT 76 as doctor_id, -0.04472 as variance_from_risk_score UNION ALL
SELECT 77 as doctor_id, -0.01262 as variance_from_risk_score UNION ALL
SELECT 78 as doctor_id, 0.06158 as variance_from_risk_score UNION ALL
SELECT 79 as doctor_id, 0.03598 as variance_from_risk_score UNION ALL
SELECT 80 as doctor_id, -0.01072 as variance_from_risk_score UNION ALL
SELECT 81 as doctor_id, 0.1571 as variance_from_risk_score UNION ALL
SELECT 82 as doctor_id, 0.12098 as variance_from_risk_score UNION ALL
SELECT 83 as doctor_id, 0.1139 as variance_from_risk_score UNION ALL
SELECT 84 as doctor_id, 0.0876 as variance_from_risk_score UNION ALL
SELECT 85 as doctor_id, 0.01014 as variance_from_risk_score UNION ALL
SELECT 86 as doctor_id, 0.12141 as variance_from_risk_score UNION ALL
SELECT 87 as doctor_id, 0.06876 as variance_from_risk_score UNION ALL
SELECT 88 as doctor_id, -0.0078 as variance_from_risk_score UNION ALL
SELECT 89 as doctor_id, 0.1161 as variance_from_risk_score UNION ALL
SELECT 90 as doctor_id, 0.07904 as variance_from_risk_score UNION ALL
SELECT 91 as doctor_id, 0.05568 as variance_from_risk_score UNION ALL
SELECT 92 as doctor_id, 0.00577 as variance_from_risk_score UNION ALL
SELECT 93 as doctor_id, 0.03698 as variance_from_risk_score UNION ALL
SELECT 94 as doctor_id, -0.06227 as variance_from_risk_score UNION ALL
SELECT 95 as doctor_id, -0.02961 as variance_from_risk_score UNION ALL
SELECT 96 as doctor_id, 0.08311 as variance_from_risk_score UNION ALL
SELECT 97 as doctor_id, 0.02948 as variance_from_risk_score UNION ALL
SELECT 98 as doctor_id, -0.02202 as variance_from_risk_score UNION ALL
SELECT 99 as doctor_id, 0.08975 as variance_from_risk_score UNION ALL
SELECT 100 as doctor_id, 0.02371 as variance_from_risk_score
    ;;
  }
}

view: predictive_power_raw {

  dimension: r_squared {
    type: number
  }

  dimension: mean_absolute_error {
    type: number
  }

  dimension: median_absolute_error {
    type: number
  }

  dimension: mean_squared_error {
    type: number
  }

  dimension: median_squared_error {
    type: number
  }


  derived_table: {
    datagroup_trigger: once_yearly
    sql:
    SELECT
      0.767 as r_squared,
      123.639 as mean_absolute_error,
      0.00972 as median_absolute_error,
      27.921 as mean_squared_error,
      0.022840 as median_squared_error
        ;;
    }

}

view: machine_learning_raw {

  dimension: iteration {
    type: number
  }

  dimension: learning_rate {
    type: number
  }

  dimension: loss {
    type: number
  }

  measure: total_loss {
    type: sum
    sql: ${loss} ;;
  }

  measure: count_iterations {
    type: count
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:
SELECT 1 as iteration, 0.2 as learning_rate, 29.731 as loss UNION ALL
SELECT 2 as iteration, 0.2 as learning_rate, 24.431 as loss UNION ALL
SELECT 3 as iteration, 0.4 as learning_rate, 19.976 as loss UNION ALL
SELECT 4 as iteration, 0.4 as learning_rate, 16.926 as loss UNION ALL
SELECT 5 as iteration, 0.4 as learning_rate, 15.103 as loss UNION ALL
SELECT 6 as iteration, 0.4 as learning_rate, 14.913 as loss
    ;;
  }
}
