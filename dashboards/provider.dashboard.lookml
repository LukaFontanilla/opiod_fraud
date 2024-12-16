- dashboard: 2__provider
  title: 2 - Provider
  layout: newspaper
  preferred_viewer: dashboards
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
    hidden_fields: []
    y_axes: []
    listen:
      Provider Name: provider.name
    row: 0
    col: 0
    width: 6
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
    hidden_fields: []
    y_axes: []
    listen:
      Provider Name: provider.name
    row: 0
    col: 6
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
    hidden_fields: []
    y_axes: []
    listen:
      Provider Name: provider.name
    row: 4
    col: 6
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
    inner_radius: 50
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
    hidden_fields: []
    y_axes: []
    listen:
      Provider Name: provider.name
    row: 4
    col: 0
    width: 6
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
    hidden_fields: []
    y_axes: []
    listen:
      Provider Name: provider.name
    row: 0
    col: 12
    width: 12
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
    hidden_fields: []
    y_axes: []
    listen:
      Provider Name: provider.name
    row: 6
    col: 12
    width: 12
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
    hidden_fields: []
    y_axes: []
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
    hidden_fields: []
    y_axes: []
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
    hidden_fields: []
    y_axes: []
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
    hidden_fields: []
    y_axes: []
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
    hidden_fields: []
    y_axes: []
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
    hidden_fields: []
    y_axes: []
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
    hidden_fields: []
    y_axes: []
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
    hidden_fields: []
    y_axes: []
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
    ui_config:
      type: advanced
      display: popover
    model: demo_datasets
    explore: bene_daily_summary
    listens_to_filters: []
    field: provider.name
