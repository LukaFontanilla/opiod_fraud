view: sms_alerts {
  derived_table: {
    sql:
          SELECT
              '{{ _user_attributes['first_name'] }}' as first_name,
              '{{ _user_attributes['last_name'] }}' as last_name,
              cast({{ _user_attributes['phone_number'] }} as float) as phone_number,
              'ORLANDO' as territory
             ;;
  }

  dimension: first_name {}
  dimension: last_name {}
  dimension: name {
    sql: concat(${first_name},' ',${last_name}) ;;
  }
  dimension: phone_number {
    type: number
    value_format_name: id
  }
  dimension: territory {}
}
