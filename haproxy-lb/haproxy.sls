service needs to start at boot time:
  service.running:
    - name: haproxy
    - enable: True
    - require:
      - pkg: install_haproxy
    - watch:
      - file: sync_custom_ha.conf

install_haproxy:
  pkg.installed:
    - name: haproxy

sync_custom_ha.conf:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://custom_ha.cfg
    - user: root
    - group: root
    - mode: 600


