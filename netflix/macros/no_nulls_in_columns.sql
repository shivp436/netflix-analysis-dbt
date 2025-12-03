{% macro no_nulls_in_columns(model) %}
  {% set columns = adapter.get_columns_in_relation(model) %}
  
  select *
  from {{ model }}
  where
    {% for col in columns %}
      {{ col.column }} is null
      {% if not loop.last %} or {% endif %}
    {% endfor %}
{% endmacro %}
