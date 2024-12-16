- dashboard: 6__data_science
  title: 6 - Data Science
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - title: Risk by % Opioid
    name: Risk by % Opioid
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_scatter
    fields: [provider.npi, provider_lifetime_value.risk_score, provider_lifetime_value.percent_opioid_prescriptions]
    sorts: [provider.npi]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    series_types: {}
    series_colors:
      provider_lifetime_value.percent_opioid_prescriptions: "#9174F0"
      provider_lifetime_value.risk_score: "#9174F0"
    reference_lines: []
    trend_lines: [{color: "#000000", label_position: right, period: 7, regression_type: linear,
        series_index: 1, show_label: true, label_type: r2}]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    hidden_fields: [provider.npi]
    y_axes: []
    listen: {}
    row: 2
    col: 4
    width: 5
    height: 6
  - title: Risk by Supply Length
    name: Risk by Supply Length
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_scatter
    fields: [provider.npi, provider_lifetime_value.risk_score, provider_lifetime_value.percent_dangerous_supply_lengths]
    sorts: [provider.npi]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    series_types: {}
    series_colors:
      provider_lifetime_value.percent_opioid_prescriptions: "#9174F0"
      provider_lifetime_value.risk_score: "#9174F0"
    reference_lines: []
    trend_lines: [{color: "#000000", label_position: right, period: 7, regression_type: linear,
        series_index: 1, show_label: true, label_type: r2}]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    hidden_fields: [provider.npi]
    y_axes: []
    listen: {}
    row: 2
    col: 9
    width: 5
    height: 6
  - title: 'Risk by # Overdoses'
    name: 'Risk by # Overdoses'
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_scatter
    fields: [provider.npi, provider_lifetime_value.risk_score, provider_lifetime_value.percent_dangerous_event]
    sorts: [provider.npi]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    series_types: {}
    series_colors:
      provider_lifetime_value.percent_opioid_prescriptions: "#9174F0"
      provider_lifetime_value.risk_score: "#9174F0"
    reference_lines: []
    trend_lines: [{color: "#000000", label_position: right, period: 7, regression_type: linear,
        series_index: 1, show_label: true, label_type: r2}]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    hidden_fields: [provider.npi]
    y_axes: []
    listen: {}
    row: 2
    col: 14
    width: 5
    height: 6
  - title: Risk by % Distance
    name: Risk by % Distance
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_scatter
    fields: [provider.npi, provider_lifetime_value.risk_score, provider_lifetime_value.percent_dangerous_distances]
    sorts: [provider.npi]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    series_types: {}
    series_colors:
      provider_lifetime_value.percent_opioid_prescriptions: "#9174F0"
      provider_lifetime_value.risk_score: "#9174F0"
    reference_lines: []
    trend_lines: [{color: "#000000", label_position: right, period: 7, regression_type: linear,
        series_index: 1, show_label: true, label_type: r2}]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    hidden_fields: [provider.npi]
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: |-
      x-axis is represented by the % of the patient cohort that meets dangerous distance criteria
      <br>
      <br>
      y-axis is represented by the % risk score of the provider based on all lifetime risk factors (opioid prescriptions, supply, overdoses, and distance)
    listen: {}
    row: 2
    col: 19
    width: 5
    height: 6
  - name: A - Generate Model Inputs
    type: text
    title_text: A - Generate Model Inputs
    row: 0
    col: 0
    width: 24
    height: 2
  - name: B - Train the Model
    type: text
    title_text: B - Train the Model
    row: 8
    col: 0
    width: 24
    height: 2
  - title: Training Loss
    name: Training Loss
    model: demo_datasets
    explore: machine_learning_raw
    type: looker_area
    fields: [machine_learning_raw.iteration, machine_learning_raw.total_loss]
    sorts: [machine_learning_raw.total_loss desc]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: machine_learning_raw.total_loss,
            id: machine_learning_raw.total_loss, name: Total Loss}], showLabels: true,
        showValues: true, unpinAxis: true, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    font_size: 16px
    series_types: {}
    label_color: [Black]
    defaults_version: 1
    hidden_fields: []
    listen: {}
    row: 10
    col: 13
    width: 11
    height: 6
  - title: Predictive Power
    name: Predictive Power
    model: demo_datasets
    explore: predictive_power_raw
    type: looker_single_record
    fields: [predictive_power_raw.mean_absolute_error, predictive_power_raw.mean_squared_error,
      predictive_power_raw.median_absolute_error, predictive_power_raw.median_squared_error,
      predictive_power_raw.r_squared]
    sorts: [predictive_power_raw.mean_absolute_error]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    series_types: {}
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 10
    col: 0
    width: 4
    height: 6
  - name: C - Apply Model
    type: text
    title_text: C - Apply Model
    row: 16
    col: 0
    width: 24
    height: 2
  - title: Training Detail
    name: Training Detail
    model: demo_datasets
    explore: machine_learning_raw
    type: looker_grid
    fields: [machine_learning_raw.iteration, machine_learning_raw.learning_rate, machine_learning_raw.loss]
    sorts: [machine_learning_raw.iteration]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      machine_learning_raw.loss:
        is_active: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axes: [{label: '', orientation: left, series: [{axisId: machine_learning_raw.total_loss,
            id: machine_learning_raw.total_loss, name: Total Loss}], showLabels: true,
        showValues: true, unpinAxis: true, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    font_size: 20px
    series_types: {}
    point_style: circle
    show_value_labels: true
    label_density: 25
    label_color: [Black]
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: []
    listen: {}
    row: 10
    col: 4
    width: 9
    height: 6
  - title: Historical Actual vs Predicted Risk for Providers
    name: Historical Actual vs Predicted Risk for Providers
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_scatter
    fields: [applied_model_results.actual_risk_score, applied_model_results.predicted_risk_score,
      provider.name]
    sorts: [applied_model_results.actual_risk_score desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    series_types: {}
    series_point_styles:
      applied_model_results.actual_risk_score: diamond
      applied_model_results.predicted_risk_score: triangle
    hidden_fields: []
    defaults_version: 1
    y_axes: []
    listen: {}
    row: 18
    col: 0
    width: 12
    height: 7
  - title: Predicted Risk Values for Providers by Location
    name: Predicted Risk Values for Providers by Location
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_map
    fields: [provider.location, applied_model_results.predicted_risk_score]
    filters:
      bene_daily_summary.weight_opioid_claims: '4'
      bene_daily_summary.weight_supply_length: '2'
      bene_daily_summary.weight_dangerous_events: '1'
      bene_daily_summary.weight_distance: '3'
      provider.specialty: ''
    sorts: [applied_model_results.predicted_risk_score desc]
    limit: 50
    column_limit: 50
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: icon
    map_marker_icon_name: ambulance
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: value
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axes: [{label: '', orientation: bottom, series: [{axisId: bene_daily_summary.risk_score,
            id: bene_daily_summary.risk_score, name: Risk Score}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    hide_legend: true
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: []
    listen: {}
    row: 18
    col: 12
    width: 12
    height: 7
  - name: ''
    type: text
    body_text: "<center> R-squared (R^2) is a statistical measure that represents\
      \ the proportion of the variance for a dependent variable that's explained by\
      \ an independent variable or variables in a regression model. \n<br>\n<br>\n\
      R-squared explains to what extent the variance of one variable explains the\
      \ variance of the second variable. So, if the R^2 of a model is 0.50, then approximately\
      \ half of the observed variation can be explained by the model's inputs."
    row: 2
    col: 0
    width: 4
    height: 6
