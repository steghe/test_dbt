{% macro centsToDollar(amount, decimal=2) %}
round({{amount}} / 100, {{decimal}})
{% endmacro %}