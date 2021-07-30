lvim.plugins = {
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.g.tokyonight_hide_inactive_statusline = true
      local _time = os.date "*t"
      if _time.hour < 9 then
        vim.g.tokyonight_style = "night"
      end
      vim.cmd [[
      colorscheme tokyonight
      ]]
    end,
    cond = function()
      local _time = os.date "*t"
      return (_time.hour >= 0 and _time.hour < 16)
    end,
  },
  {
    "NTBBloodbath/doom-one.nvim",
    config = function()
      vim.g.doom_one_italic_comments = true
      vim.cmd [[
      colorscheme doom-one
      ]]
      -- vim.g.doom_one_terminal_colors = true
    end,
    cond = function()
      local _time = os.date "*t"
      return (_time.hour >= 16 and _time.hour < 20)
    end,
  },
  {
    "glepnir/zephyr-nvim",
    config = function()
      vim.cmd [[
      colorscheme zephyr
      ]]
    end,
    cond = function()
      local _time = os.date "*t"
      return (_time.hour >= 20 and _time.hour <= 24)
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").on_attach()
    end,
    event = "InsertEnter",
  },
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "svn",
          "hgcommit",
        },
        lastplace_open_folds = true,
      }
    end,
    event = "BufWinEnter",
  },
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
    event = "BufRead",
  },
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
    cmd = "Trouble",
    -- event = "BufRead",
  },
  -- {
  --   "ggandor/lightspeed.nvim",
  --   event = "BufRead",
  -- },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    -- event = "BufRead",
  },
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    -- event = "BufRead",
  },
  {
    "nvim-telescope/telescope-project.nvim",
    event = "BufWinEnter",
    setup = function()
      vim.cmd [[packadd telescope.nvim]]
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = {
        "help",
        "terminal",
        "dashboard",
      }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = true
    end,
  },
  { "tzachar/compe-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-compe", event = "InsertEnter" },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.25, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
        },
        context = 15, -- amount of lines we will try to show around the current line
        -- treesitter is used to automatically expand the visible text,
        -- but you can further control the types of nodes that should always be fully expanded
        expand = {
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {}, -- exclude these filetypes
      }
    end,
    cmd = "ZenMode",
    -- event = "BufRead",
  },
  { "kevinhwang91/nvim-bqf", event = "BufRead" },
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()
    end,
    requires = { "mfussenegger/nvim-dap" },
    ft = "python",
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  },
  --   {
  --     "andweeb/presence.nvim",
  --     config = function()
  --       require("presence"):setup {
  --         -- General options
  --         auto_update = true,
  --         neovim_image_text = "LunarVim to the moon",
  --         main_image = "file",
  --         client_id = "793271441293967371",
  --         log_level = nil,
  --         debounce_timeout = 10,
  --         enable_line_number = true, -- Displays the current line number instead of the current project
  --
  --         -- Rich Presence text options
  --         editing_text = "Editing %s", -- string rendered when an editable file is loaded in the buffer
  --         file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer
  --         git_commit_text = "Committing changes", -- string rendered when commiting changes in git
  --         plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins
  --         reading_text = "Reading %s", -- string rendered when a read-only file is loaded in the buffer
  --         workspace_text = "Working on %s", -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string)
  --         line_number_text = "Line %s out of %s", -- Line number string (for when enable_line_number is set to true)
  --       }
  --     end,
  --   },
  -- {'pwntester/octo.nvim', config=function()
  --   require"octo".setup()
  -- end
  -- },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local opts = {
        tools = { -- rust-tools options
          -- automatically set inlay hints (type hints)
          -- There is an issue due to which the hints are not applied on the first
          -- opened file. For now, write to the file to trigger a reapplication of
          -- the hints or just run :RustSetInlayHints.
          -- default: true
          autoSetHints = true,

          -- whether to show hover actions inside the hover window
          -- this overrides the default hover handler
          -- default: true
          hover_with_actions = true,

          runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = true,

            -- rest of the opts are forwarded to telescope
          },

          inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<-",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix = "=>",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,
          },

          hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
          },
        },

        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
        server = {
          cmd = { DATA_PATH .. "/lspinstall/rust/rust-analyzer" },
          on_attach = require("lsp").common_on_attach,
        }, -- rust-analyser options
      }
      require("rust-tools").setup(opts)
    end,
    ft = { "rust", "rs" },
  },
  {
    "folke/zen-mode.nvim",
    -- cmd = "ZenMode",
    config = function()
      require("zen-mode").setup {
        window = {
          backdrop = 1,
          height = 0.9, -- height of the Zen window
          width = 0.85,
          options = {
            signcolumn = "no", -- disable signcolumn
            number = false, -- disable number column
            relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          gitsigns = { enabled = false }, -- disables git signs
          tmux = { enabled = false },
          twilight = { enabled = true },
        },
        on_open = function()
          vim.lsp.diagnostic.disable()
          vim.cmd [[
          set foldlevel=10
          IndentBlanklineDisable
          ]]
        end,
        on_close = function()
          vim.lsp.diagnostic.enable()
          vim.cmd [[
          set foldlevel=5
          IndentBlanklineEnable
          ]]
        end,
      }
    end,
  },
  -- {
  -- 	"folke/persistence.nvim",
  -- 	event = "VimEnter",
  -- 	module = "persistence",
  -- 	config = function()
  -- 		require("persistence").setup({
  -- 			dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
  -- 			options = { "buffers", "curdir", "tabpages", "winsize" },
  -- 		})
  -- 	end,
  -- },
}
