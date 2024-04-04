--[[
-- Plugins available across all instances of neovim
--]]
local plugins = {
    -- LUALINE - https://github.com/nvim-lualine/lualine.nvim
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    -- KANAGAWA THEME - https://github.com/rebelot/kanagawa.nvim
    {
        "rebelot/kanagawa.nvim",
        name = 'kanagawa',
        lazy = false,
        priority = 1000,
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
            vim.cmd([[colorscheme kanagawa-dragon]])
        end
    },

    -- NVIM-TREE - https://github.com/nvim-tree/nvim-tree.lua
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        -- REQUIRES A NERD FONT INSTALLED - https://www.nerdfonts.com/
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },

    -- TELESCOPE - https://github.com/nvim-telescope/telescope.nvim
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- UNDOTREE - https://github.com/mbbill/undotree
    { 'mbbill/undotree' },
    
    -- FUGITIVE - https://github.com/tpope/vim-fugitive
    { 'tpope/vim-fugitive' },

    -- WHICH-KEY - https://github.com/folke/which-key.nvim
    {
        'folke/which-key.nvim',
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- MASON - https://github.com/williamboman/mason.nvim
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- LSP-ZERO - https://github.com/VonHeikemen/lsp-zero.nvim
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
        }
    },
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {'L3MON4D3/LuaSnip'}
        },
    },
}

--[[
-- Plugins available within a Nix flake
--]]
local ok, flake_plugins = pcall(require, "flake.plugins")
if ok then
    print("Loading flake plugins")
    for _, plugin in ipairs(flake_plugins) do
        table.insert(plugins, plugin)
    end
end

return plugins

