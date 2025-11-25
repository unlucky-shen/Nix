# Communix

### Nvidia Optimus PRIME Wrapper Script

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
