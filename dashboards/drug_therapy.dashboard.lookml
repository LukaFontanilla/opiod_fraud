- dashboard: 5__drug_therapy
  title: 5 - Drug Therapy
  layout: newspaper
  elements:
  - title: Drug Use Over Time
    name: Drug Use Over Time
    model: opioid
    explore: claims
    type: looker_area
    fields: [claims.days_after_index_date, claims.rolling_total_count_opioid_claims,
      claims.rolling_total_count_non_opioid_claims]
    filters:
      drug_order_by_bene_typed.drug_is_included: 'Yes'
    sorts: [claims.days_after_index_date]
    limit: 500
    query_timezone: America/Los_Angeles
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: ccba75a3-58c7-4b9c-a931-4ffc59e79cba
      options:
        steps: 5
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
    stacking: normal
    limit_displayed_rows: false
    hidden_series: [events_MED.avg_total_MED, events_MED.max_avg_rolling_MED_365]
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      claims.rolling_total_count_opioid_claims: "#B32F37"
      claims.rolling_total_count_non_opioid_claims: "#72D16D"
    series_labels:
      claims.rolling_total_count_opioid_claims: Opioid Claims
      claims.rolling_total_count_non_opioid_claims: Non-Opioid Claims
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    y_axes: []
    listen:
      Drug Taken First: drug_order_by_bene_typed.drug_name_1
      Drug Ever Taken: drug_order_by_bene_typed.drug_included
    row: 9
    col: 0
    width: 13
    height: 10
  - title: Therapy Path
    name: Therapy Path
    model: opioid
    explore: claims
    type: marketplace_viz_sankey::sankey-marketplace
    fields: [drug_order_by_bene_typed.drug_name_1, drug_order_by_bene_typed.drug_name_2,
      drug_order_by_bene_typed.drug_name_3, drug_order_by_bene_typed.drug_name_4,
      beneficiary.count_benes]
    filters:
      drug_order_by_bene_typed.drug_is_included: 'Yes'
    sorts: [beneficiary.count_benes desc]
    limit: 50
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    color_range: ["#75E2E2", "#3EB0D5", "#4276BE", "#592EC2", "#9174F0", "#B1399E",
      "#B32F37", "#E57947", "#FBB555", "#FFD95F", "#C2DD67", "#72D16D"]
    label_type: name_value
    show_null_points: true
    series_types: {}
    y_axes: []
    defaults_version: 0
    listen:
      Drug Taken First: drug_order_by_bene_typed.drug_name_1
      Drug Ever Taken: drug_order_by_bene_typed.drug_included
    row: 0
    col: 13
    width: 11
    height: 19
  - title: Average Days to Each Stage
    name: Average Days to Each Stage
    model: opioid
    explore: claims
    type: looker_bar
    fields: [drug_order_by_bene_typed.average_incremental_days_after_index1, drug_order_by_bene_typed.average_incremental_days_after_index2,
      drug_order_by_bene_typed.average_incremental_days_after_index3, drug_order_by_bene_typed.average_incremental_days_after_index4]
    filters:
      drug_order_by_bene_typed.drug_is_included: 'Yes'
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: 7dcbb78d-d67d-4dda-b8f0-87380f6dd0df
      options:
        steps: 5
    y_axes: []
    series_types: {}
    series_colors: {}
    series_labels:
      drug_order_by_bene_typed.average_incremental_days_after_index1: Days to Drug
        1
      drug_order_by_bene_typed.average_incremental_days_after_index2: Days to Drug
        2
      drug_order_by_bene_typed.average_incremental_days_after_index3: Days to Drug
        3
      drug_order_by_bene_typed.average_incremental_days_after_index4: Days to Drug
        4
    hidden_fields: []
    defaults_version: 1
    listen:
      Drug Taken First: drug_order_by_bene_typed.drug_name_1
      Drug Ever Taken: drug_order_by_bene_typed.drug_included
    row: 0
    col: 0
    width: 13
    height: 9
  filters:
  - name: Drug Taken First
    title: Drug Taken First
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: opioid
    explore: claims
    listens_to_filters: []
    field: drug_order_by_bene_typed.drug_name_1
  - name: Drug Ever Taken
    title: Drug Ever Taken
    type: field_filter
    default_value: Any Drug
    allow_multiple_values: true
    required: false
    model: opioid
    explore: claims
    listens_to_filters: []
    field: drug_order_by_bene_typed.drug_included
