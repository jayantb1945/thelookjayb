- dashboard: filter_suggestion_testing_1
  title: Filter Suggestion Testing 1
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: New Tile
    name: New Tile
    model: thelook
    explore: users
    type: looker_grid
    fields: [users.age, users.gender, users.full_name, users.countAverage]
    sorts: [users.countAverage desc]
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
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Age: users.age
      Gender: users.gender
    row:
    col:
    width:
    height:
  filters:
  - name: Age
    title: Age
    type: field_filter
    default_value: "[0,29]"
    allow_multiple_values: true
    required: false
    ui_config:
      type: range_slider
      display: inline
      options: []
    model: thelook
    explore: users
    listens_to_filters: []
    field: users.age
  - name: Gender
    title: Gender
    type: field_filter
    default_value: f
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options: []
    model: thelook
    explore: users
    listens_to_filters: []
    field: users.gender
