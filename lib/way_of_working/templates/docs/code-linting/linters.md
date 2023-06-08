---
layout: page
nav_order: 1
parent: Code Linting
---

# Linters

The following tables detail the linters that we are currently using:
<% @types.each do |type, linters| -%>

## <%= type %>

<%
max_language_length = linters.map(&:language).map(&:length).max
max_constant_name_length = linters.map(&:constant_name).map(&:length).max
max_details_length = linters.map(&:details).map(&:length).max
-%>
| <%= type.singularize.ljust(max_language_length) %> | <%= 'Linter'.ljust(max_constant_name_length) %> | <%= 'Details'.ljust(max_details_length) %> |
|<%= ':'.ljust(max_language_length + 2, '-') %>|<%= ':'.ljust(max_constant_name_length + 2, '-') %>|<%= ':'.ljust(max_details_length + 2, '-') %>|
<% linters.sort_by(&:sorter).each do |linter| -%>
| <%= linter.language.ljust(max_language_length) %> | <%= linter.constant_name.ljust(max_constant_name_length) %> | <%= linter.details.ljust(max_details_length) %> |
<% end -%>
<% end %>
