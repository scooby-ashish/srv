make sure service runs at boot time:
  service.running:
{% if grains['os_family'] == 'Debian' %}
    - name: nginx
{% elif grains['os_family'] == 'RedHat'%}
    - name: httpd
{% endif %}
    - enable: True
    - require:
      - pkg: install_nginx
    - watch:
{% if grains['os_family'] == 'Debian' %}
      - file: sync webserver_configuration
{% elif grains['os_family'] == 'RedHat' %}
      - file: sync httpd.conf
{% endif %}
      - file: sync index_file

install_nginx:
  pkg.installed:
{% if grains['os_family'] == 'Debian'%}
    - name: nginx
{% elif grains['os_family'] == 'RedHat'%}
    - name: httpd
{% endif %}

sync webserver_configuration:
  file.managed:
    - name: /etc/nginx/sites-enabled/webserver
    - source: salt://webserver
    - user: root
    - group: root
    - mode: 600

sync index_file:
  file.managed:
    - name: /var/www/html/index.html
    - source: salt://index.html
    - user: root
    - group: root
    - mode: 755

sync httpd.conf:
  file.managed:
    - name: /etc/httpd/conf.d/httpd.conf
    - source: salt://httpd.conf
    - user: root
    - group: root
    - mode: 600
