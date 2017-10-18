{% if grains['os'] == 'Gentoo' %}

{% for pkg in 'app-admin/augeas','dev-python/python-augeas' %}
keyword-{{ pkg }}:
  file.replace:
    - name: /etc/portage/package.accept_keywords/all
    - pattern: .*{{ pkg }}.*
    - repl: {{ pkg }}
    - append_if_not_found: True
{% endfor %}

pkg-python-augeas:
  pkg.latest:
    - name: dev-python/python-augeas

pkg-openrc:
  pkg.latest:
    - name: sys-apps/openrc

{% endif %}
