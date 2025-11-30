{# this is a function to override the default schema creation strategy of dbt #}
{# by default dbt schema: target.schema given at time of project creation + '_' + schema in config of each model #}
{# we change it to use config's schema if available else use target.dev default #}


{% macro generate_schema_name(custom_schema_name, node) %}
    {% if custom_schema_name is not none %}
        {{ custom_schema_name | upper }}
    {% else %}
        {{ target.schema | upper }}
    {% endif %}
{% endmacro %}
