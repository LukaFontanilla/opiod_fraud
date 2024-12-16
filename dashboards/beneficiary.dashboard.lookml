- dashboard: 3__beneficiary
  title: 3 - Beneficiary
  layout: newspaper
  preferred_viewer: dashboards
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
    hidden_fields: []
    y_axes: []
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
    hidden_fields: []
    y_axes: []
    listen:
      Beneficiary: beneficiary.name
    row: 0
    col: 4
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
    hidden_fields: []
    y_axes: []
    listen:
      Beneficiary: beneficiary.name
    row: 4
    col: 0
    width: 8
    height: 10
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
    hidden_fields: []
    listen:
      Beneficiary: beneficiary.name
    row: 0
    col: 8
    width: 8
    height: 14
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
    hidden_fields: []
    y_axes: []
    listen:
      Beneficiary: beneficiary.name
    row: 0
    col: 16
    width: 8
    height: 14
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
    hidden_fields: []
    y_axes: []
    listen:
      Beneficiary: beneficiary.name
    row: 14
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
    hidden_fields: []
    y_axes: []
    listen:
      Beneficiary: beneficiary.name
    row: 14
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
    ui_config:
      type: advanced
      display: popover
    model: demo_datasets
    explore: bene_daily_summary
    listens_to_filters: []
    field: beneficiary.name
