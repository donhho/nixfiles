# `donhho/nixfiles`

## Troubleshooting
Discord
```bash
# Fix
sudo tee /etc/sysctl.d/99-userns.conf >/dev/null <<EOF
kernel.apparmor_restrict_unprivileged_userns=0
EOF

sudo sysctl --system

# Undo
sudo rm /etc/sysctl.d/99-userns.conf
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=1
sudo sysctl --system
cat /proc/sys/kernel/apparmor_restrict_unprivileged_userns # Expected: 1
```

MarkdownPreview
```
:call mkdp#util#install()
```
