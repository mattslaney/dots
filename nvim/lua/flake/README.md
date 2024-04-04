# Flake
This is an empty folder used by nix flake for flake specific neovim config
flakes can sym link in an init.lua and plugins.lua for flake specific config

```shell
ln -sf /path/to/flake/init.lua /path/to/nvim/lua/flake/init.lua
ln -sf /path/to/flake/plugins.lua /path/to/nvim/lua/flake/plugins.lua
```

Flakes should ideally remove these links when exiting so they do not persist after the user has left back to the ordinary shell

