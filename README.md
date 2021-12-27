# `trombik.vif`

An `ansible` role to create virtual interfaces on OpenBSD.

# Requirements

None

# Role Variables

| variable | description | default |
|----------|-------------|---------|
| `vif_config` | A list of virtual network interfaces (see  below) | `[]` |

## `vif_config`

This variable is a list of virtual interfaces to create. Its element is a
dict.

| Key | Description | Mandatory? |
|-----|-------------|------------|
| `name` | The name of interface. | Yes |
| `priority` | Priority in integer. Interfaces with a higher priority are created earlier. | Yes |
| `config` | The content of `hostname.if(5)` | Yes |

# Dependencies

None

# Example Playbook

```yaml
---
- hosts: localhost
  roles:
    - ansible-role-vif
  vars:
    vif_config:
      - name: trunk0
        priority: 20
        config: |
          trunkport vether0
          trunkport vether1
          10.1.1.100/24
      - name: vether0
        priority: 100
        config: |
          up
      - name: vether1
        priority: 100
        config: |
          up
      - name: carp0
        priority: 10
        config: |
          10.0.2.100/24 carpdev em0 vhid 1 pass password
```

# License

```
Copyright (c) 2021 Tomoyuki Sakurai <y@trombik.org>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <y@trombik.org>

This README was created by [qansible](https://github.com/trombik/qansible)
