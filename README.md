## Troubleshooting
```bash
# Fix to get Discord working
sudo tee /etc/sysctl.d/99-userns.conf >/dev/null <<EOF
kernel.apparmor_restrict_unprivileged_userns=0
EOF

sudo sysctl --system

# Undoing it
sudo rm /etc/sysctl.d/99-userns.conf
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=1
sudo sysctl --system
cat /proc/sys/kernel/apparmor_restrict_unprivileged_userns # Expected: 1
```

Setup MarkdownPreview in Neovim:
```
:call mkdp#util#install()
```
