{% for user in pillar['users'] %}
add_{{ user }}:
  user.present:
    - name: {{ user }}
{% endfor %}

{% if 'my_ssh_key' in pillar %}
manage_my_ssh_key:
  file.managed:
{% if grains['fqdn'] == 'sm2.infra.svc.dev-lab.bgl.prajaas'%}
    - name: //home/prajaas/.ssh/{{ pillar['my_ssh_key_name'] }}
{% else %}
    - name: /home/noc/.ssh/{{ pillar['my_ssh_key_name'] }}
{% endif %}
    - mode: 600
    - contents_pillar: my_ssh_key
    - show_diff: False
{% endif %}
