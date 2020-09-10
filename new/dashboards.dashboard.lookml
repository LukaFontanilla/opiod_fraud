- dashboard: 1__overall
  title: 1 - Overall
  layout: newspaper
  elements:
  - title: Risk Score
    name: Risk Score
    model: demo_datasets
    explore: bene_daily_summary
    type: single_value
    fields: [bene_daily_summary.risk_score]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
    row: 0
    col: 0
    width: 3
    height: 7
  - title: Risk Factors
    name: Risk Factors
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_bar
    fields: [prescriptions.percent_opioid_prescriptions, bene_dangerous_events.percent_dangerous_event,
      prescriptions.percent_dangerous_supply_lengths, prescriptions.percent_dangerous_distances]
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
    y_axes: [{label: '', orientation: bottom, series: [{axisId: bene_daily_summary.risk_score,
            id: bene_daily_summary.risk_score, name: Risk Score}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    hide_legend: false
    series_types: {}
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
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
    row: 0
    col: 3
    width: 10
    height: 7
  - title: Risk by Zip
    name: Risk by Zip
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_map
    fields: [beneficiary.zip_code, bene_daily_summary.risk_score]
    limit: 500
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
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
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
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
    row: 7
    col: 0
    width: 7
    height: 8
  - title: Risk by Vector
    name: Risk by Vector
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_map
    fields: [bene_daily_summary.risk_score, beneficiary.location, provider.location]
    sorts: [bene_daily_summary.risk_score desc]
    limit: 50
    column_limit: 50
    map_plot_mode: lines
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
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
    row: 7
    col: 7
    width: 7
    height: 8
  - title: Dangerous Events over Time
    name: Dangerous Events over Time
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_line
    fields: [bene_daily_summary.count_overdoses, bene_daily_summary.count_deaths,
      bene_daily_summary.observation_quarter]
    fill_fields: [bene_daily_summary.observation_quarter]
    sorts: [bene_daily_summary.observation_quarter desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    series_types: {}
    defaults_version: 1
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
    row: 0
    col: 13
    width: 11
    height: 7
  - title: Risky Doctors
    name: Risky Doctors
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_grid
    fields: [provider.name, provider.specialty, prescriptions.percent_opioid_prescriptions,
      bene_daily_summary.risk_score]
    filters:
      provider.name: "-NULL"
      prescriptions.count: ">5"
    sorts: [bene_daily_summary.risk_score desc]
    limit: 500
    column_limit: 50
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
    series_labels:
      prescriptions.percent_opioid_prescriptions: "% Opioid Claims"
      bene_daily_summary.risk_score: Risk Score
    series_cell_visualizations:
      prescriptions.percent_opioid_prescriptions:
        is_active: true
      bene_daily_summary.risk_score:
        is_active: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    series_types: {}
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
    row: 7
    col: 14
    width: 10
    height: 8
  - name: Predictive Analytics
    type: text
    title_text: Predictive Analytics
    subtitle_text: Dive into predictive model evaluation <a href="https://ascension.cloud.looker.com/dashboards/11">here</a>
    row: 15
    col: 0
    width: 24
    height: 2
  - title: Predicted Risk
    name: Predicted Risk
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_map
    fields: [provider.location, applied_model_results.predicted_risk_score]
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
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
    row: 17
    col: 13
    width: 11
    height: 10
  - title: Predicted by Actual Risk
    name: Predicted by Actual Risk
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
    hidden_fields:
    defaults_version: 1
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
    row: 17
    col: 0
    width: 13
    height: 10
  filters:
  - name: City
    title: City
    type: string_filter
    default_value: ORLANDO
    allow_multiple_values: true
    required: false
  - name: Weight - % Opioid
    title: Weight - % Opioid
    type: field_filter
    default_value: '4'
    allow_multiple_values: true
    required: false
    model: demo_datasets
    explore: bene_daily_summary
    listens_to_filters: []
    field: bene_daily_summary.weight_opioid_claims
  - name: Weight - Supply Length
    title: Weight - Supply Length
    type: field_filter
    default_value: '2'
    allow_multiple_values: true
    required: false
    model: demo_datasets
    explore: bene_daily_summary
    listens_to_filters: []
    field: bene_daily_summary.weight_supply_length
  - name: Weight - Dangerous Events
    title: Weight - Dangerous Events
    type: field_filter
    default_value: '1'
    allow_multiple_values: true
    required: false
    model: demo_datasets
    explore: bene_daily_summary
    listens_to_filters: []
    field: bene_daily_summary.weight_dangerous_events
  - name: Weight - Distance
    title: Weight - Distance
    type: field_filter
    default_value: '3'
    allow_multiple_values: true
    required: false
    model: demo_datasets
    explore: bene_daily_summary
    listens_to_filters: []
    field: bene_daily_summary.weight_distance

- dashboard: 2__provider
  title: 2 - Provider
  layout: newspaper
  elements:
  - title: Provider Information
    name: Provider Information
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_single_record
    fields: [provider.name, provider.npi, provider.specialty, provider.city, provider.state,
      provider.zip_code]
    limit: 500
    show_view_names: false
    series_types: {}
    defaults_version: 1
    listen:
      Provider Name: provider.name
    row: 0
    col: 0
    width: 4
    height: 4
  - title: Risk Score
    name: Risk Score
    model: demo_datasets
    explore: bene_daily_summary
    type: single_value
    fields: [bene_daily_summary.risk_score, cohort_value.difference_risk_score]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Cohort
    show_view_names: false
    series_types: {}
    defaults_version: 1
    listen:
      Provider Name: provider.name
    row: 0
    col: 4
    width: 6
    height: 4
  - title: Risk Factors
    name: Risk Factors
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_bar
    fields: [prescriptions.percent_opioid_prescriptions, prescriptions.percent_dangerous_supply_lengths,
      bene_dangerous_events.percent_dangerous_event, prescriptions.percent_dangerous_distances]
    limit: 500
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
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs. Cohort
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Provider Name: provider.name
    row: 4
    col: 4
    width: 6
    height: 8
  - title: Opioid Drugs Prescribed
    name: Opioid Drugs Prescribed
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_pie
    fields: [drug.drug_name_simple, prescriptions.count]
    filters:
      drug.opioid_drug: 'Yes'
    sorts: [prescriptions.count desc]
    limit: 500
    value_labels: legend
    label_type: labPer
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: 471a8295-662d-46fc-bd2d-2d0acd370c1e
      options:
        steps: 5
        reverse: true
    series_colors: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs. Cohort
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_view_names: false
    series_types: {}
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    listen:
      Provider Name: provider.name
    row: 4
    col: 0
    width: 4
    height: 8
  - title: Beneficiaries Breakdown
    name: Beneficiaries Breakdown
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_grid
    fields: [beneficiary.name, beneficiary.zip_code, bene_lifetime_value.count_providers,
      bene_lifetime_value.count_pharmacy, bene_lifetime_value.risk_score]
    sorts: [bene_lifetime_value.risk_score desc]
    limit: 500
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
    series_labels:
      bene_lifetime_value.count_pharmacy: "# Pharmacies"
      bene_lifetime_value.count_providers: "# Providers"
      bene_lifetime_value.risk_score: Risk Score
    series_cell_visualizations:
      bene_lifetime_value.count_providers:
        is_active: true
      bene_lifetime_value.count_pharmacy:
        is_active: true
      bene_lifetime_value.risk_score:
        is_active: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs. Cohort
    series_types: {}
    defaults_version: 1
    listen:
      Provider Name: provider.name
    row: 0
    col: 10
    width: 14
    height: 6
  - title: Pharmacy Breakdown
    name: Pharmacy Breakdown
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_grid
    fields: [pharmacy.pharmacy_name, pharmacy.zip_code, pharmacy_lifetime_value.percent_opioid_prescriptions,
      pharmacy_lifetime_value.percent_dangerous_distances, pharmacy_lifetime_value.risk_score]
    sorts: [pharmacy_lifetime_value.risk_score desc]
    limit: 500
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
    series_labels:
      pharmacy_lifetime_value.percent_opioid_prescriptions: "% Opioid"
      pharmacy_lifetime_value.percent_dangerous_distances: "% Long Distance"
      pharmacy_lifetime_value.risk_score: Risk Score
    series_cell_visualizations:
      bene_lifetime_value.count_providers:
        is_active: true
      bene_lifetime_value.count_pharmacy:
        is_active: true
      bene_lifetime_value.risk_score:
        is_active: true
      pharmacy_lifetime_value.percent_opioid_prescriptions:
        is_active: true
      pharmacy_lifetime_value.percent_dangerous_event:
        is_active: true
      pharmacy_lifetime_value.percent_dangerous_distances:
        is_active: true
      pharmacy_lifetime_value.risk_score:
        is_active: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs. Cohort
    series_types: {}
    defaults_version: 1
    listen:
      Provider Name: provider.name
    row: 6
    col: 10
    width: 14
    height: 6
  - name: 1 - % Opioid Claims
    type: text
    title_text: 1 - % Opioid Claims
    row: 12
    col: 0
    width: 6
    height: 2
  - title: "% Opioid Claims"
    name: "% Opioid Claims"
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_donut_multiples
    fields: [prescriptions.count, drug.opioid_drug]
    pivots: [drug.opioid_drug]
    fill_fields: [drug.opioid_drug]
    sorts: [drug.opioid_drug]
    limit: 500
    show_value_labels: true
    font_size: 12
    series_labels:
      No - prescriptions.count: Not Opioid
      Yes - prescriptions.count: Opioid
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Cohort
    show_view_names: false
    series_types: {}
    defaults_version: 1
    listen:
      Provider Name: provider.name
    row: 14
    col: 0
    width: 6
    height: 7
  - name: 2 -  Supply Length
    type: text
    title_text: 2 -  Supply Length
    row: 12
    col: 6
    width: 6
    height: 2
  - name: 4 - Distance
    type: text
    title_text: 4 - Distance
    row: 12
    col: 18
    width: 6
    height: 2
  - name: 3 - Overdose / Death
    type: text
    title_text: 3 - Overdose / Death
    row: 12
    col: 12
    width: 6
    height: 2
  - title: Supply Length
    name: Supply Length
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_bar
    fields: [prescriptions.count, prescriptions.length_no_html]
    filters:
      prescriptions.length_no_html: NOT NULL
    sorts: [prescriptions.length_no_html]
    limit: 500
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
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    font_size: 12
    series_labels:
      No - prescriptions.count: Not Opioid
      Yes - prescriptions.count: Opioid
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Cohort
    series_types: {}
    defaults_version: 1
    listen:
      Provider Name: provider.name
    row: 14
    col: 6
    width: 6
    height: 7
  - title: Overdoses & Deaths
    name: Overdoses & Deaths
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_line
    fields: [bene_daily_summary.observation_quarter, bene_daily_summary.count_overdoses,
      bene_daily_summary.count_deaths]
    fill_fields: [bene_daily_summary.observation_quarter]
    sorts: [bene_daily_summary.observation_quarter desc]
    limit: 500
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
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    font_size: 12
    series_labels:
      No - prescriptions.count: Not Opioid
      Yes - prescriptions.count: Opioid
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Cohort
    series_types: {}
    defaults_version: 1
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 14
    col: 12
    width: 6
    height: 7
  - title: Distance Travelled
    name: Distance Travelled
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_map
    fields: [beneficiary.location, provider.location, bene_daily_summary.risk_score]
    limit: 500
    map_plot_mode: lines
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
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    show_value_labels: true
    font_size: 12
    series_labels:
      No - prescriptions.count: Not Opioid
      Yes - prescriptions.count: Opioid
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Cohort
    series_types: {}
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    point_style: none
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    listen:
      Provider Name: provider.name
    row: 14
    col: 18
    width: 6
    height: 7
  - title: "% Opioid vs Cohort"
    name: "% Opioid vs Cohort"
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_bar
    fields: [prescriptions.percent_opioid_prescriptions, cohort_value.percent_opioid_prescriptions]
    limit: 500
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
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    font_size: '12'
    series_types: {}
    series_labels:
      No - prescriptions.count: Not Opioid
      Yes - prescriptions.count: Opioid
      prescriptions.percent_opioid_prescriptions: Provider
      cohort_value.percent_opioid_prescriptions: Cohort
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Cohort
    defaults_version: 1
    listen:
      Provider Name: provider.name
    row: 21
    col: 0
    width: 6
    height: 6
  - title: Supply vs Cohort
    name: Supply vs Cohort
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_bar
    fields: [prescriptions.percent_dangerous_supply_lengths, cohort_value.percent_dangerous_supply_lengths]
    limit: 500
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
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    font_size: '12'
    series_types: {}
    series_labels:
      No - prescriptions.count: Not Opioid
      Yes - prescriptions.count: Opioid
      prescriptions.percent_opioid_prescriptions: Provider
      cohort_value.percent_opioid_prescriptions: Cohort
      prescriptions.percent_dangerous_supply_lengths: Provider
      cohort_value.percent_dangerous_supply_lengths: Cohort
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Cohort
    defaults_version: 1
    listen:
      Provider Name: provider.name
    row: 21
    col: 6
    width: 6
    height: 6
  - title: Dangerous Events vs Cohort
    name: Dangerous Events vs Cohort
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_bar
    fields: [bene_dangerous_events.percent_dangerous_event, cohort_value.percent_dangerous_event]
    limit: 500
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
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    font_size: '12'
    series_types: {}
    series_labels:
      No - prescriptions.count: Not Opioid
      Yes - prescriptions.count: Opioid
      prescriptions.percent_opioid_prescriptions: Provider
      cohort_value.percent_opioid_prescriptions: Cohort
      bene_dangerous_events.percent_dangerous_event: Provider
      cohort_value.percent_dangerous_event: Cohort
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Cohort
    defaults_version: 1
    listen:
      Provider Name: provider.name
    row: 21
    col: 12
    width: 6
    height: 6
  - title: Distance vs Cohort
    name: Distance vs Cohort
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_bar
    fields: [prescriptions.percent_dangerous_distances, cohort_value.percent_dangerous_distances]
    limit: 500
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
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    font_size: '12'
    series_types: {}
    series_labels:
      No - prescriptions.count: Not Opioid
      Yes - prescriptions.count: Opioid
      prescriptions.percent_opioid_prescriptions: Provider
      cohort_value.percent_opioid_prescriptions: Cohort
      prescriptions.percent_dangerous_distances: Provider
      cohort_value.percent_dangerous_distances: Cohort
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Cohort
    defaults_version: 1
    listen:
      Provider Name: provider.name
    row: 21
    col: 18
    width: 6
    height: 6
  filters:
  - name: Provider Name
    title: Provider Name
    type: field_filter
    default_value: Dot Poundford
    allow_multiple_values: true
    required: false
    model: demo_datasets
    explore: bene_daily_summary
    listens_to_filters: []
    field: provider.name


- dashboard: 3__beneficiary
  title: 3 - Beneficiary
  layout: newspaper
  elements:
  - title: Beneficiary Information
    name: Beneficiary Information
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_single_record
    fields: [beneficiary.name, beneficiary.zip_code, beneficiary.state, bene_lifetime_value.doctor_shopper,
      beneficiary.city]
    limit: 500
    column_limit: 50
    show_view_names: false
    series_types: {}
    defaults_version: 1
    listen:
      Beneficiary: beneficiary.name
    row: 0
    col: 0
    width: 4
    height: 4
  - title: Risk Score (vs Average)
    name: Risk Score (vs Average)
    model: demo_datasets
    explore: bene_daily_summary
    type: single_value
    fields: [bene_daily_summary.risk_score, cohort_value.difference_risk_score]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Average
    series_types: {}
    show_view_names: false
    defaults_version: 1
    listen:
      Beneficiary: beneficiary.name
    row: 4
    col: 0
    width: 4
    height: 4
  - title: Risk Breakdown
    name: Risk Breakdown
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_column
    fields: [prescriptions.percent_opioid_prescriptions, prescriptions.percent_dangerous_supply_lengths,
      bene_dangerous_events.percent_dangerous_event, prescriptions.percent_dangerous_distances]
    limit: 500
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
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs. Average
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Beneficiary: beneficiary.name
    row: 0
    col: 4
    width: 6
    height: 8
  - title: MED Overtime
    name: MED Overtime
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_line
    fields: [bene_daily_summary.observation_week, bene_daily_summary.count_dangerous_events,
      bene_daily_summary.average_med_365]
    fill_fields: [bene_daily_summary.observation_week]
    sorts: [bene_daily_summary.observation_week desc]
    limit: 500
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
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: bene_daily_summary.average_med,
            id: bene_daily_summary.average_med, name: Average Daily MED}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: !!null '', orientation: right, series: [{axisId: bene_daily_summary.count_dangerous_events,
            id: bene_daily_summary.count_dangerous_events, name: Count Dangerous Events}],
        showLabels: true, showValues: true, maxValue: 3, minValue: -1, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types:
      bene_daily_summary.count_dangerous_events: column
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs. Average
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Beneficiary: beneficiary.name
    row: 0
    col: 10
    width: 8
    height: 8
  - title: Activity Map
    name: Activity Map
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_map
    fields: [beneficiary.location, provider.location, bene_daily_summary.risk_score]
    limit: 500
    column_limit: 50
    map_plot_mode: lines
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
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
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
    listen:
      Beneficiary: beneficiary.name
    row: 0
    col: 18
    width: 6
    height: 8
  - title: Pharmacy Breakdown
    name: Pharmacy Breakdown
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_grid
    fields: [pharmacy.pharmacy_name, pharmacy.zip_code, pharmacy_lifetime_value.percent_opioid_prescriptions,
      pharmacy_lifetime_value.percent_dangerous_distances, pharmacy_lifetime_value.risk_score]
    sorts: [pharmacy_lifetime_value.risk_score desc]
    limit: 500
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
    series_labels:
      pharmacy_lifetime_value.percent_opioid_prescriptions: "% Opioid"
      pharmacy_lifetime_value.percent_dangerous_distances: "% Long Distance"
      pharmacy_lifetime_value.risk_score: Risk Score
    series_cell_visualizations:
      bene_lifetime_value.count_providers:
        is_active: true
      bene_lifetime_value.count_pharmacy:
        is_active: true
      bene_lifetime_value.risk_score:
        is_active: true
      pharmacy_lifetime_value.percent_opioid_prescriptions:
        is_active: true
      pharmacy_lifetime_value.percent_dangerous_event:
        is_active: true
      pharmacy_lifetime_value.percent_dangerous_distances:
        is_active: true
      pharmacy_lifetime_value.risk_score:
        is_active: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs. Cohort
    series_types: {}
    defaults_version: 1
    listen:
      Beneficiary: beneficiary.name
    row: 8
    col: 12
    width: 12
    height: 6
  - title: Provider Breakdown
    name: Provider Breakdown
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_grid
    fields: [provider.name, provider.specialty, provider_lifetime_value.percent_opioid_prescriptions,
      provider_lifetime_value.percent_dangerous_distances, provider_lifetime_value.risk_score]
    sorts: [provider_lifetime_value.percent_opioid_prescriptions desc]
    limit: 500
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
    series_labels:
      pharmacy_lifetime_value.percent_opioid_prescriptions: "% Opioid"
      pharmacy_lifetime_value.percent_dangerous_distances: "% Long Distance"
      pharmacy_lifetime_value.risk_score: Risk Score
      provider_lifetime_value.percent_dangerous_distances: "% Distance"
      provider_lifetime_value.risk_score: Risk Score
      provider_lifetime_value.percent_opioid_prescriptions: "% Opioid"
    series_cell_visualizations:
      bene_lifetime_value.count_providers:
        is_active: true
      bene_lifetime_value.count_pharmacy:
        is_active: true
      bene_lifetime_value.risk_score:
        is_active: true
      pharmacy_lifetime_value.percent_opioid_prescriptions:
        is_active: true
      pharmacy_lifetime_value.percent_dangerous_event:
        is_active: true
      pharmacy_lifetime_value.percent_dangerous_distances:
        is_active: true
      pharmacy_lifetime_value.risk_score:
        is_active: true
      provider_lifetime_value.percent_opioid_prescriptions:
        is_active: true
      provider_lifetime_value.percent_dangerous_distances:
        is_active: true
      provider_lifetime_value.risk_score:
        is_active: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs. Cohort
    series_types: {}
    defaults_version: 1
    listen:
      Beneficiary: beneficiary.name
    row: 8
    col: 0
    width: 12
    height: 6
  filters:
  - name: Beneficiary
    title: Beneficiary
    type: field_filter
    default_value: Miner Gregine
    allow_multiple_values: true
    required: false
    model: demo_datasets
    explore: bene_daily_summary
    listens_to_filters: []
    field: beneficiary.name


- dashboard: 4__pharmacy
  title: 4 - Pharmacy
  layout: newspaper
  elements:
  - title: Pharmacy Information
    name: Pharmacy Information
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_single_record
    fields: [pharmacy.pharmacy_company, pharmacy.pharmacy_name, pharmacy.state, pharmacy.city,
      pharmacy.zip_code]
    limit: 500
    show_view_names: false
    series_types: {}
    defaults_version: 1
    listen:
      Pharmacy: pharmacy.pharmacy_name
    row: 0
    col: 0
    width: 3
    height: 6
  - title: Risk Score
    name: Risk Score
    model: demo_datasets
    explore: bene_daily_summary
    type: single_value
    fields: [bene_daily_summary.risk_score, cohort_value.difference_risk_score]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Average
    series_types: {}
    show_view_names: false
    defaults_version: 1
    listen:
      Pharmacy: pharmacy.pharmacy_name
    row: 0
    col: 3
    width: 4
    height: 6
  - title: Risk Breakdown
    name: Risk Breakdown
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_column
    fields: [prescriptions.percent_opioid_prescriptions, prescriptions.percent_dangerous_supply_lengths,
      bene_dangerous_events.percent_dangerous_event, prescriptions.percent_dangerous_distances]
    limit: 500
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
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs. Average
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Pharmacy: pharmacy.pharmacy_name
    row: 0
    col: 7
    width: 8
    height: 6
  - title: Activity Map
    name: Activity Map
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_map
    fields: [pharmacy.location, provider.location, bene_daily_summary.risk_score]
    sorts: [bene_daily_summary.risk_score desc]
    limit: 500
    column_limit: 50
    map_plot_mode: lines
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
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
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
    listen:
      Pharmacy: pharmacy.pharmacy_name
    row: 0
    col: 15
    width: 9
    height: 6
  - title: Provider Breakdown
    name: Provider Breakdown
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_grid
    fields: [provider.name, provider.specialty, provider_lifetime_value.percent_opioid_prescriptions,
      provider_lifetime_value.percent_dangerous_distances, provider_lifetime_value.risk_score]
    sorts: [provider_lifetime_value.risk_score desc]
    limit: 500
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
    series_labels:
      pharmacy_lifetime_value.percent_opioid_prescriptions: "% Opioid"
      pharmacy_lifetime_value.percent_dangerous_distances: "% Long Distance"
      pharmacy_lifetime_value.risk_score: Risk Score
      provider_lifetime_value.percent_dangerous_distances: "% Distance"
      provider_lifetime_value.risk_score: Risk Score
      provider_lifetime_value.percent_opioid_prescriptions: "% Opioid"
    series_cell_visualizations:
      bene_lifetime_value.count_providers:
        is_active: true
      bene_lifetime_value.count_pharmacy:
        is_active: true
      bene_lifetime_value.risk_score:
        is_active: true
      pharmacy_lifetime_value.percent_opioid_prescriptions:
        is_active: true
      pharmacy_lifetime_value.percent_dangerous_event:
        is_active: true
      pharmacy_lifetime_value.percent_dangerous_distances:
        is_active: true
      pharmacy_lifetime_value.risk_score:
        is_active: true
      provider_lifetime_value.percent_opioid_prescriptions:
        is_active: true
      provider_lifetime_value.percent_dangerous_distances:
        is_active: true
      provider_lifetime_value.risk_score:
        is_active: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs. Cohort
    series_types: {}
    defaults_version: 1
    listen:
      Pharmacy: pharmacy.pharmacy_name
    row: 6
    col: 12
    width: 12
    height: 7
  - title: Beneficiary Breakdown
    name: Beneficiary Breakdown
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_grid
    fields: [beneficiary.name, beneficiary.zip_code, bene_lifetime_value.count_providers,
      bene_lifetime_value.count_pharmacy, bene_lifetime_value.risk_score]
    sorts: [bene_lifetime_value.risk_score desc]
    limit: 500
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
    series_labels:
      bene_lifetime_value.count_pharmacy: "# Pharmacies"
      bene_lifetime_value.count_providers: "# Providers"
      bene_lifetime_value.risk_score: Risk Score
    series_cell_visualizations:
      bene_lifetime_value.count_providers:
        is_active: true
      bene_lifetime_value.count_pharmacy:
        is_active: true
      bene_lifetime_value.risk_score:
        is_active: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs. Cohort
    series_types: {}
    defaults_version: 1
    listen:
      Pharmacy: pharmacy.pharmacy_name
    row: 6
    col: 0
    width: 12
    height: 7
  filters:
  - name: Pharmacy
    title: Pharmacy
    type: field_filter
    default_value: CVS - Store 1227
    allow_multiple_values: true
    required: false
    model: demo_datasets
    explore: bene_daily_summary
    listens_to_filters: []
    field: pharmacy.pharmacy_name


- dashboard: 5__data_science
  title: 5 - Data Science
  layout: newspaper
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
    listen: {}
    row: 2
    col: 0
    width: 6
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
    listen: {}
    row: 2
    col: 6
    width: 6
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
    listen: {}
    row: 2
    col: 12
    width: 6
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
    listen: {}
    row: 2
    col: 18
    width: 6
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
    listen: {}
    row: 10
    col: 13
    width: 11
    height: 6
  - title: "# Iterations"
    name: "# Iterations"
    model: demo_datasets
    explore: machine_learning_raw
    type: single_value
    fields: [machine_learning_raw.count_iterations]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    limit_displayed_rows: false
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
    row: 10
    col: 0
    width: 4
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
    row: 18
    col: 0
    width: 4
    height: 7
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
    listen: {}
    row: 10
    col: 4
    width: 9
    height: 6
  - title: Historical Actual vs Predicted
    name: Historical Actual vs Predicted
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
    hidden_fields:
    defaults_version: 1
    listen: {}
    row: 18
    col: 4
    width: 10
    height: 7
  - title: Residuals
    name: Residuals
    model: demo_datasets
    explore: bene_daily_summary
    type: looker_column
    fields: [provider.name, applied_model_results.residual]
    sorts: [provider.name desc]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_point_styles:
      applied_model_results.actual_risk_score: diamond
      applied_model_results.predicted_risk_score: triangle
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#000000",
        line_value: '0', label: Actual}]
    show_null_points: true
    hidden_fields:
    defaults_version: 1
    listen: {}
    row: 18
    col: 14
    width: 10
    height: 7
