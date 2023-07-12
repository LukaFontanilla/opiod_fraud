- dashboard: 1__overall
  title: 1 - Overall
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
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
    hidden_fields: []
    y_axes: []
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
      Provider Specialty: provider.specialty
    row: 3
    col: 0
    width: 4
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
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
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
    hidden_fields: []
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
      Provider Specialty: provider.specialty
    row: 3
    col: 4
    width: 8
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
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: Based on beneficiary zip code
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
      Provider Specialty: provider.specialty
    row: 10
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
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: This map shows the beneficiary location versus the provider location,
      along with risk.
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
      Provider Specialty: provider.specialty
    row: 10
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
    hidden_fields: []
    y_axes: []
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
      Provider Specialty: provider.specialty
    row: 3
    col: 12
    width: 12
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
    hidden_fields: []
    y_axes: []
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
      Provider Specialty: provider.specialty
    row: 10
    col: 14
    width: 10
    height: 8
  - name: Predictive Analytics
    type: text
    title_text: Predictive Analytics
    subtitle_text: Dive into predictive model evaluation <a href="https://demoexpo.looker.com/dashboards/732">here</a>
    row: 18
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
    hidden_fields: []
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
      Provider Specialty: provider.specialty
    row: 20
    col: 12
    width: 12
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
    hidden_fields: []
    defaults_version: 1
    y_axes: []
    listen:
      Weight - % Opioid: bene_daily_summary.weight_opioid_claims
      Weight - Supply Length: bene_daily_summary.weight_supply_length
      Weight - Dangerous Events: bene_daily_summary.weight_dangerous_events
      Weight - Distance: bene_daily_summary.weight_distance
      Provider Specialty: provider.specialty
    row: 20
    col: 0
    width: 12
    height: 10
  - name: ''
    type: text
    body_text: |-
      <font color="black" size="5px"><b><center>Opioid Fraud Analysis

      <h1><center>Recommended Actions: Select a chart to  <span class="badge alert-danger">drill-down or take actions
    row: 0
    col: 0
    width: 24
    height: 3
  filters:
  - name: City
    title: City
    type: string_filter
    default_value: ORLANDO
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
  - name: Weight - % Opioid
    title: Weight - % Opioid
    type: field_filter
    default_value: '4'
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
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
    ui_config:
      type: advanced
      display: popover
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
    ui_config:
      type: advanced
      display: popover
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
    ui_config:
      type: advanced
      display: popover
    model: demo_datasets
    explore: bene_daily_summary
    listens_to_filters: []
    field: bene_daily_summary.weight_distance
  - name: Provider Specialty
    title: Provider Specialty
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: inline
    model: demo_datasets
    explore: bene_daily_summary
    listens_to_filters: []
    field: provider.specialty
