{% from "munin/map.jinja" import munin_node with context %}

include:
  - munin.node

# Enable common plugins
{% for plugin, linked_file in pillar.get('munin_node_common_plugins', {}).items() %}
{{ munin_node.plugin_dir }}/{{ plugin }}:
  file.symlink:
    - target: {{ munin_node.plugin_dir }}/{{ linked_file }}
    - user: root
    - group: 0
    - mode: 755
{% endfor %}

{{ munin_node.service }}:
  service.running:
    - watch:
      - file: {{ munin_node.plugin_dir }}/*
