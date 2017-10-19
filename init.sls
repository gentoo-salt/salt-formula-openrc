{% if grains['os'] == 'Gentoo' %}

{% set rc_file = '/etc/rc.conf' %}

include:
  - augeas

package-openrc:
  pkg.installed:
    - name: sys-apps/openrc 
    - version: latest

{% for item in [{'rc_parallel':'YES','rc_interactive':'YES','rc_depend_strict':'NO','rc_logger':'YES','rc_log_path':'/var/log/rc.log','unicode':'YES'}] %}
{% for option, value in item.iteritems() %}
uncomment-{{ option }}:
  file.uncomment:
    - name: {{ rc_file }}
    - regex: {{ option }}=

set-{{ option }}:
  augeas.change:
    - lens: Shellvars.lns 
    - uncomment: true
    - context: /files/{{ rc_file }}
    - changes:
      - set {{ option }} \"{{ value }}\"
{% endfor %}
{% endfor %}

{% endif %}
