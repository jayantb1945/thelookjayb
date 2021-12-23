view: user_DT {
  derived_table: {
    sql:
    SELECT
    CASE
        WHEN users.age  < 15 THEN '0'
        WHEN users.age  >= 15 AND users.age  < 30 THEN '1'
        WHEN users.age  >= 30 AND users.age  < 45 THEN '2'
        WHEN users.age  >= 45 AND users.age  < 60 THEN '3'
        WHEN users.age  >= 60 AND users.age  < 75 THEN '4'
        WHEN users.age  >= 75 THEN '5'
        ELSE '6'
        END AS `users.age_tier__sort_`,
            CASE
        WHEN users.age  < 15 THEN 'Below 15'
        WHEN users.age  >= 15 AND users.age  < 30 THEN '15 to 29'
        WHEN users.age  >= 30 AND users.age  < 45 THEN '30 to 44'
        WHEN users.age  >= 45 AND users.age  < 60 THEN '45 to 59'
        WHEN users.age  >= 60 AND users.age  < 75 THEN '60 to 74'
        WHEN users.age  >= 75 THEN '75 or Above'
        ELSE 'Undefined'
        END AS `users.age_tier`,
                (DATE(CONVERT_TZ(`created_at`,'UTC','America/Los_Angeles'))) AS `users.created_date`,
            CONCAT(users.first_name," ",users.last_name)  AS `users.full_name`,
            AVG(`id`) AS `users.countAverage`
        FROM
            `demo_db`.`users` AS `users`
        GROUP BY
            1,
            2,
            3,
            4
        ORDER BY
            (DATE(CONVERT_TZ(`created_at`,'UTC','America/Los_Angeles'))) DESC
        LIMIT 500;;
  }
  dimension: age_tier_list_DT {
    type: tier
    tiers: [15,30,45,60,75]
    style: integer
    sql: ${TABLE}.age ;;
  }

  measure: count_user_avg_DT {
    type: average
    sql:  ${TABLE}.id ;;
  }

}
# The name of this view in Looker is "Orders"
view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Status" in Explore.

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      billion_orders.count,
      fakeorders.count,
      hundred_million_orders.count,
      hundred_million_orders_wide.count,
      order_items.count,
      ten_million_orders.count
    ]
  }
}
