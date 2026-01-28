# NixOS Setup

![Nix Hyprland](nix.png)

A work in progress..., Not a "true declarative" config yet (skill issue).

### Nvidia PRIME Offload Wrapper Script

I. Create the script,
```
sudo mkdir -p /usr/local/bin
sudo nano /usr/local/bin/nvidia-offload
```
II. Then Paste,
```
export __NV_PRIME_RENDER_OFFLOAD=1
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only
exec "$@"
```
III. Make it executable,
```
sudo chmod +x /usr/local/bin/nvidia-offload
```
### Steam Launch Options
1. In Steam -> Game Properties -> Launch Options

2. Paste below in "Launch Options" box,
```
nvidia-offload gamemoderun gamescope -w 1920 -h 1080 -- %command%
```

### Install
```bash
curl https://raw.githubusercontent.com/unlucky-shen/nixos/main/nixify.sh > nixify.sh

chmod +x ./nixify.sh

./nixify.sh
```

### Todo List
- [ ] Migrate config to flakes, will take time tho (skill issue)
- [ ] Change neovim config to nixvim
- [x] Change DE to WM (Hyprland) 
