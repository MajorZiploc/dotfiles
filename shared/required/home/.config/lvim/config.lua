-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":wa<cr>"

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- TODO: consider if we really need to install these upfront
-- usually they are installed as you go to files that match various filetypes
-- this list usually just causes errors of various OS'es
-- maybe trim it down to the bare minimum
-- Syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  -- "bash",
  -- "c",
  -- "cpp",
  -- "css",
  -- "diff",
  -- "dockerfile",
  -- "git_rebase",
  -- "gitignore",
  -- "html",
  -- "java",
  "javascript",
  "json",
  -- "jsonc",
  -- "kotlin",
  "lua",
  "python",
  -- "rust",
  -- "scss",
  -- "sql",
  -- "tsx",
  "typescript",
  "vim",
  -- "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- This should be the same as the above
-- TODO: consider if we really need to install these upfront
-- usually they are installed as you go to files that match various filetypes
-- this list usually just causes errors of various OS'es
-- maybe trim it down to the bare minimum
-- require("mason-lspconfig").setup {
--   ensure_installed = {
--     "rust_analyzer",
--     "jdtls",
--     "pyright",
--     "sqlls",
--     "tsserver",
--     "vimls",
--     "html",
--     "cssls",
--     "bashls",
--     "gopls",
--     "jsonls",
--     "grammarly",
--   },
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    --     ---@usage arguments to pass to the formatter
    --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    --     extra_args = { "--print-with", "100" },
    --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

lvim.transparent_window = true
-- disable auto pairing of paired chars in favor of manual keys
lvim.builtin.autopairs.active = false

-- tabline will go away when only 1 tab exists
vim.opt.showtabline = 1
-- dont use system clipboard by default
vim.opt.clipboard = nil
-- vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
-- remove top lunar tab bar
lvim.builtin.bufferline.active = false

lvim.builtin.which_key.mappings["n"] = {
  name = "+Navigation",
}
lvim.builtin.which_key.mappings["e"] = nil
lvim.builtin.which_key.mappings["q"] = nil
lvim.keys.normal_mode["<leader>ne"] = "<CMD>NvimTreeToggle<CR>"

lvim.keys.normal_mode['<bs>'] = "<CMD>noh<CR>"

lvim.builtin.which_key.mappings['w'] = nil

lvim.builtin.telescope.defaults = {
  file_ignore_patterns = { ".git/", "node_modules" },
  layout_config = {
    width = 0.9,
    height = 0.9,
    preview_width = 0.65,
    prompt_position = "top",
    preview_cutoff = 40,
  },
  layout_strategy = 'horizontal',
  path_display = { truncate = 1 },
  prompt_position = "top",
  prompt_prefix = " ",
  selection_caret = " ",
  sorting_strategy = "ascending",
  -- TODO: where to put these options?
  -- use_highlighter = false,
  -- minimum_grep_characters = 3,
  vimgrep_arguments = {
    'rg',
    '--color=never',
    '--no-heading',
    '--with-filename',
    '--line-number',
    '--column',
    '--smart-case',
  },
}

-- Example of writing fn and using in a key binding
-- local function blank_grep_string_search ()
--   require('telescope.builtin').grep_string({ search = '' })
-- end
-- lvim.keys.normal_mode['<leader>fa'] = blank_grep_string_search

lvim.builtin.telescope.pickers = {
  grep_string = {
    search = '',
    only_sort_text = true,
    additional_args = function(opts)
      return { "--hidden" }
    end
  },
  find_files = {
    prompt_prefix = " ",
    find_command = { "rg", "--files", "--hidden" },
  },
  live_grep = {
    only_sort_text = true,
    additional_args = function(opts)
      return { "--hidden" }
    end
  },
  buffers = {
    sort_mru = true,
    prompt_prefix = "﬘ ",
  },
  commands = {
    prompt_prefix = " ",
  },
  git_files = {
    prompt_prefix = " ",
    show_untracked = true,
  },
}

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

lvim.keys.normal_mode['<C-p>'] = require("lvim.core.telescope.custom-finders").find_project_files
lvim.builtin.which_key.mappings['f'] = nil
lvim.keys.normal_mode['<leader>fb'] = "<CMD>Telescope buffers<CR>"
lvim.keys.normal_mode['<leader>fda'] = "<CMD>Telescope live_grep<CR>"
lvim.keys.normal_mode['<leader>fi'] = "<CMD>Telescope current_buffer_fuzzy_find<CR>"
lvim.keys.normal_mode['<leader>fhc'] = "<CMD>Telescope command_history<CR>"
lvim.keys.normal_mode['<leader>fcs'] = "<CMD>Telescope commands<CR>"
lvim.keys.normal_mode['<leader>fa'] = "<CMD>Telescope grep_string<CR>"
lvim.keys.normal_mode['<leader>fca'] = "<CMD>Telescope git_commits<CR>"
lvim.keys.normal_mode['<leader>fci'] = "<CMD>Telescope git_bcommits<CR>"
lvim.keys.normal_mode['<leader>fm'] = "<CMD>Telescope marks<CR>"

lvim.builtin.which_key.mappings["w"] = {
  name = "+SecondaryLeader",
}
lvim.builtin.which_key.mappings["g"] = {
  name = "+GoTo/Do",
}
lvim.lsp.buffer_mappings.normal_mode['<leader>wi'] = { vim.lsp.buf.hover, "Show hover" }
lvim.lsp.buffer_mappings.normal_mode['<leader>gq'] = { vim.lsp.buf.hover, "Show hover" }
lvim.lsp.buffer_mappings.normal_mode['<leader>gd'] = lvim.lsp.buffer_mappings.normal_mode['gd']
lvim.lsp.buffer_mappings.normal_mode['<leader>gd'] = { "<CMD>Telescope lsp_definitions<CR>", "Go to definitions" }
-- basic single line quickfix list style view of references
-- lvim.lsp.buffer_mappings.normal_mode['<leader>gr'] = lvim.lsp.buffer_mappings.normal_mode['gr']
-- Uses telescope to show all references and the context/file they exist in
lvim.lsp.buffer_mappings.normal_mode['<leader>gr'] = { "<CMD>Telescope lsp_references<CR>", "Show references" }
lvim.builtin.which_key.mappings["r"] = {
  name = "+Refactor",
}
lvim.lsp.buffer_mappings.normal_mode['<leader>rn'] = { vim.lsp.buf.rename, "Rename" }
lvim.lsp.buffer_mappings.visual_mode['<leader>gf'] = { vim.lsp.buf.format, "Format" }
lvim.lsp.buffer_mappings.visual_mode['<leader>qf'] = { "<CMD>Telescope quickfix<CR>", "Quickfix" }
lvim.builtin.which_key.mappings["c"] = {
  name = "+Code",
}
lvim.lsp.buffer_mappings.visual_mode['<leader>ca'] = { vim.lsp.buf.code_action, "Code action" }
lvim.lsp.buffer_mappings.normal_mode['<leader>ca'] = { vim.lsp.buf.code_action, "Code action" }
lvim.lsp.buffer_mappings.normal_mode['<leader>e'] = { vim.diagnostic.goto_next, "Next Error" }
lvim.lsp.buffer_mappings.normal_mode['<leader>E'] = { vim.diagnostic.goto_prev, "Previous Error" }
lvim.lsp.buffer_mappings.normal_mode[']d'] = { vim.diagnostic.goto_next, "Next Error" }
lvim.lsp.buffer_mappings.normal_mode['[d'] = { vim.diagnostic.goto_prev, "Previous Error" }

-- disable inline virtual_text diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)

-- this will disable all visual indicators of diagnostics but will still allow next/prev diagnostic to work
-- vim.diagnostic.disable()

-- may be useful for disabling other virtual_text's
-- vim.diagnostic.config({virtual_text = false})

lvim.plugins = {
  { "tpope/vim-fugitive" },          -- git plugin
  { "MajorZiploc/code_runner.vim" },  -- run selected code chunks
  { "MajorZiploc/vip_files.vim" },  -- file ring
  { "mechatroner/rainbow_csv" },     -- csv highlighter and query engine
  { "tpope/vim-obsession" },         -- self managing n?vim sessions (Session.vim w/ :Obsession <file_name.vim>?/:Obsession! (start/discard current session respectively))
  { "eddyekofo94/gruvbox-flat.nvim" }, -- color theme
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true,        -- #RGB hex codes
        RRGGBB = true,     -- #RRGGBB hex codes
        RRGGBBAA = true,   -- #RRGGBBAA hex codes
        rgb_fn = true,     -- CSS rgb() and rgba() functions
        hsl_fn = true,     -- CSS hsl() and hsla() functions
        css = true,        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,     -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context" }, -- pin the function/class/interface/enum name to top line if inside that thing
  -- ui for vim cmd mode that moves the up and infront; can do other stuff too
  -- LazyVim uses this plugin, could be a good reference for setting it up
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader><Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "n", desc = "Redirect Cmdline" },
      -- { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      -- { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      -- { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      -- { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      -- { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      -- { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    }
  },
  -- { 'esensar/nvim-dev-container' } -- Use vscode devcontainers - the nvim integration on the containers doesnt seem to work well. Look into using this more
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-treesitter/nvim-treesitter"},
    }
  }
}

-- require("devcontainer").setup{} -- related to esensar/nvim-dev-container
require('refactoring').setup({})
lvim.keys.visual_mode["<leader>rr"] = ":lua require('refactoring').select_refactor()<CR>"

vim.cmd('let g:rbql_with_headers = 1')
vim.cmd('let g:rbql_backend_language = "python"')
vim.cmd('let g:rbql_use_system_python = 1')
vim.cmd('autocmd BufNewFile,BufRead *.csv set filetype=rfc_csv')

require 'colorizer'.setup()

lvim.colorscheme = "gruvbox-flat"
-- lvim.colorscheme = "tokyonight-night"

lvim.keys.visual_mode['<leader>vs'] = "<CMD>diffput<CR>"
lvim.keys.normal_mode['<leader>vs'] = "<CMD>Gitsigns stage_hunk<CR>"

lvim.builtin.which_key.mappings["v"] = {
  name = "+VersionControl",
  j = { "<CMD>diffget //3<CR>", "TakeRight" },
  f = { "<CMD>diffget //2<CR>", "TakeLeft" },
  i = { "<CMD>horizontal topleft Git<CR>", "GitStatus" },
  b = { "<CMD>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
}

lvim.keys.normal_mode[']g'] = "<CMD>Gitsigns next_hunk<CR>"
lvim.keys.normal_mode['[g'] = "<CMD>Gitsigns prev_hunk<CR>"

-- ################## DAP BEGIN ###########################

local dap = require('dap')

-- PYTHON DEBUG NOTES
-- NOTE: source your venv and make sure the env var VIRTUAL_ENV is set to your .venv/bin/python path
-- Troubleshooting
-- make sure you source your venv before opening lvim -- you should see (.venv) at the bottom of lvim
-- make sure lvim cache is fresh :LvimCacheReset
-- make sure debuggers and formats are installed in :Mason
-- make sure pip is upgrade in venv -- pip install --upgrade pip
-- make sure debugpy is installed in venv is upgrade in venv -- pip install debugpy
-- Permission denied to .venv issue:
--   1. Try reversing the way you source the venv and the bash file that has the VIRTUAL_ENV
--     if you source venv then bash file with env vars, then you will see (python) instead of (.venv) at the bottom and that can fix the permissions for some reason
--   2. try chmod 777 .venv
--     I havnt had success with this method
-- try rerunning the lvim installer
dap.adapters.python = {
  type = 'executable',
  -- May have to hardcode this to your python in your venv if it doesnt seem to work
  command = (os.getenv("VIRTUAL_ENV") or os.getenv('HOME') .. '/.pyenv/shims/python'),
  -- TODO: in your venv: pip install debugpy
  args = { '-m', 'debugpy.adapter' },
}

-- NOTE: delete this config if it looks like your debugger is looking at the wrong python to confirm its using this config
-- set filetype=python if your filetype in vim isnt python already. thats how it maps which config to use
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      -- May have to hardcode this to your python in your venv if it doesnt seem to work
      return (os.getenv("VIRTUAL_ENV") or os.getenv('HOME') .. '/.pyenv/shims/python')
    end,
  },
}

-- NOTE: chrome has to be started with a remote debugging port google-chrome-stable --remote-debugging-port=9222
-- chrome_debug_open
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  -- TODO: switch to mason managed dap
  args = { os.getenv("HOME") .. "/dev/microsoft/vscode-chrome-debug/out/src/chromeDebug.js", "--server=9222" }
}

dap.configurations.javascriptreact = {
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    -- urlFilter = "http://localhost:3000/*",
    -- url = "http://localhost:3000",
    webRoot = "${workspaceFolder}"
  }
}

dap.configurations.typescriptreact = {
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    -- urlFilter = "http://localhost:3000/*",
    -- url = "http://localhost:3000",
    webRoot = "${workspaceFolder}"
  }
}

dap.configurations.javascript = {
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    -- urlFilter = "http://localhost:3000/*",
    -- url = "http://localhost:3000",
    webRoot = "${workspaceFolder}"
  }
}

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  -- TODO: switch to mason managed dap
  args = { os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js' },
}
dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require 'dap.utils'.pick_process,
  },
}

dap.configurations.typescript = {
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    -- urlFilter = "http://localhost:3000/*",
    -- url = "http://localhost:3000",
    webRoot = "${workspaceFolder}"
  }
}

dap.adapters.bashdb = {
  type = 'executable',
  command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
  name = 'bashdb',
}

dap.configurations.sh = {
  {
    type = 'bashdb',
    request = 'launch',
    name = "Launch file",
    showDebugOutput = true,
    pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
    pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
    trace = true,
    file = "${file}",
    program = "${file}",
    cwd = '${workspaceFolder}',
    pathCat = "cat",
    pathBash = "~/bin/bash",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    args = {},
    env = {},
    terminalKind = "integrated",
  }
}

-- ################## DAP END ###########################

-- PATCH: annoying error and warning notifications
local orig_notify = vim.notify
local filter_notify = function(text, level, opts)
  -- when opening python files, the notification comes up and pylyzer appears to never get installed
  if type(text) == "string" and string.find(text, "Installation in progress for [pylyzer]", 1, true) then
    return
  end
  -- vim.treesitter.query.get_query() is deprecated, use vim.treesitter.query.get() instead. :help deprecated
  --   This feature will be removed in Nvim version 0.10
  -- if type(text) == "string" and (string.find(text, "get_query", 1, true) or string.find(text, "get_node_text", 1, true)) then
  --   return
  -- end
  -- for all deprecated and stack trace warnings
  -- if type(text) == "string" and (string.find(text, ":help deprecated", 1, true) or string.find(text, "stack trace", 1, true)) then
  --   return
  -- end
  orig_notify(text, level, opts)
end
vim.notify = filter_notify

-- CAUTION: CAN BREAK OTHER LSPS SUCH AS PYTHON
-- local solargraph = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/solargraph")
-- if solargraph ~= "" then
--   -- solargraph is installed
--   -- required to make ruby lsp activate in ruby files
--   require('lvim.lsp.manager').setup('solargraph', {})
-- end

-- CAUTION: CAN BREAK OTHER LSPS SUCH AS PYTHON
-- local perlnavigator = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/perlnavigator")
-- if perlnavigator ~= "" then
--   -- perlnavigator is installed
--   -- required to make perl lsp activate in perl files
--   require('lvim.lsp.manager').setup('perlnavigator', {})
-- end

-- PATCH: for making Telescope transparent
vim.cmd('autocmd vimenter * highlight TelescopeTitle guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopeBorder guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopeNormal guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopeMatching guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopeMultiIcon guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopeSelection guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewDate guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewLine guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewLink guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewPipe guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewRead guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewSize guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewUser guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePromptTitle guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewBlock guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewGroup guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewMatch guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewTitle guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewWrite guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePromptBorder guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePromptNormal guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePromptPrefix guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewBorder guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewHyphen guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewNormal guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewSocket guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePreviewSticky guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopePromptCounter guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopeResultsBorder guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopeResultsLineNr guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopeResultsMethod guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopeResultsNormal guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopeResultsNumber guibg=NONE ctermbg=NONE')
vim.cmd('autocmd vimenter * highlight TelescopeResultsStruct guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsClass guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsField guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsTitle guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeMultiSelection guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopePreviewCharDev guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopePreviewExecute guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopePreviewMessage guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsComment guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsDiffAdd guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeSelectionCaret guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsConstant guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsFunction guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsOperator guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsVariable guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopePreviewDirectory guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsDiffChange guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsDiffDelete guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsIdentifier guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsDiffUntracked guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopeResultsSpecialComment guibg=NONE ctermbg=NONE')
-- vim.cmd('autocmd vimenter * highlight TelescopePreviewMessageFillchar guibg=NONE ctermbg=NONE')

lvim.builtin.lualine.sections.lualine_c = {
  {
    'filename',
    path = 1,
  }
}

vim.cmd('set wrap')
vim.cmd('source ~/.slim_vimrc')
vim.cmd('source ~/.vim/plugin-settings/vim_code_runner.vim')
vim.cmd('source ~/.vim/plugin-settings/vip_files.vim')
vim.cmd('source ~/.vimrc_ext')
