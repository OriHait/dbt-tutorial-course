{# {{config(severity : 'warn')}} #}

WITH order_details as (

SELECT
    order_id,
    count(*) as num_of_items_in_order

FROM {{ref('stg_ecommerce__order_items')}}
GROUP BY 1

) 

SELECT
    o.*,

FROM {{ref('stg_ecommerce_orders')}} as o
FULL OUTER JOIN order_details od USING(order_id)
WHERE 
    od.order_id IS NULL 
        OR o.order_id IS NULL 
        OR od.num_of_items_in_order != o.num_items_ordered





   