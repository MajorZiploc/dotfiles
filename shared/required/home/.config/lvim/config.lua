-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

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

-- Syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "git_rebase",
  "gitignore",
  "html",
  "java",
  "javascript",
  "json",
  "jsonc",
  "kotlin",
  "lua",
  "python",
  "rust",
  "scss",
  "sql",
  "tsx",
  "typescript",
  "vim",
  "yaml",
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
require("mason-lspconfig").setup {
    ensure_installed = {
    "rust_analyzer",
    "jdtls",
    "pyright",
    "sqlls",
    "tsserver",
    "vimls",
    "html",
    "cssls",
    "bashls",
    "gopls",
    "jsonls",
    "grammarly",
  },
}

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

lvim.keys.normal_mode['<C-p>'] = require("lvim.core.telescope.custom-finders").find_project_files
lvim.builtin.which_key.mappings['f'] = nil
lvim.keys.normal_mode['<leader>fb'] = "<CMD>Telescope buffers<CR>"
lvim.keys.normal_mode['<leader>fi'] = "<CMD>Telescope live_grep<CR>"
lvim.keys.normal_mode['<leader>fch'] = "<CMD>Telescope command_history<CR>"
lvim.keys.normal_mode['<leader>fa'] = "<CMD>Telescope grep_string<CR>"
lvim.keys.normal_mode['<leader>fca'] = "<CMD>Telescope git_commits<CR>"
lvim.keys.normal_mode['<leader>fci'] = "<CMD>Telescope git_bcommits<CR>"

lvim.builtin.which_key.mappings["w"] = {
  name = "+SecondaryLeader",
}
lvim.builtin.which_key.mappings["g"] = {
  name = "+GoTo/Do",
}
lvim.lsp.buffer_mappings.normal_mode['<leader>wi'] = { vim.lsp.buf.hover, "Show hover" }
lvim.lsp.buffer_mappings.normal_mode['<leader>gq'] = { vim.lsp.buf.hover, "Show hover" }
lvim.lsp.buffer_mappings.normal_mode['<leader>gd'] = lvim.lsp.buffer_mappings.normal_mode['gd']
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


lvim.plugins = {
  {"tpope/vim-fugitive"}, -- git plugin
  {"mechatroner/rainbow_csv"}, -- csv highlighter and query engine
  {"tpope/vim-obsession"}, -- self managing n?vim sessions (Session.vim w/ :Obsession <file_name.vim>?/:Obsession! (start/discard current session respectively))
  {"eddyekofo94/gruvbox-flat.nvim"}, -- color theme
  {
  "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          })
  end,
  },
  {"nvim-treesitter/nvim-treesitter-context"}, -- pin the function/class/interface/enum name to top line if inside that thing
}

require'colorizer'.setup()

lvim.colorscheme = "gruvbox-flat"
-- lvim.colorscheme = "tokyonight-night"

lvim.keys.visual_mode['<leader>vs'] = "<CMD>diffput<CR>"

lvim.builtin.which_key.mappings["v"] = {
  name = "+VersionControl",
  j = { "<CMD>diffget //3<CR>", "TakeRight" },
  f = { "<CMD>diffget //2<CR>", "TakeLeft" },
  i = { "<CMD>:horizontal topleft Git<CR>", "GitStatus" },
  b = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
}

lvim.builtin.telescope.defaults = {
  file_ignore_patterns = { ".git/", "node_modules" },
  layout_config = {
    preview_width = 0.6,
    prompt_position = "top",
  },
  path_display = { "smart" },
  prompt_position = "top",
  prompt_prefix = " ",
  selection_caret = " ",
  sorting_strategy = "ascending",
  vimgrep_arguments = {
    'rg',
    '--color=never',
    '--no-heading',
    '--with-filename',
    '--line-number',
    '--column',
    '--smart-case',
    '--hidden',
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
    additional_args = function(opts)
      return { "--hidden" }
    end
  },
  find_files = {
    prompt_prefix = " ",
    find_command = { "rg", "--files", "--hidden" },
  },
  live_grep = {
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

-- lvim.builtin.telescope.defaults.layout_strategy = "horizontal"

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
  type = 'executable';
  -- May have to hardcode this to your python in your venv if it doesnt seem to work
  command = (os.getenv("VIRTUAL_ENV") or os.getenv('HOME') .. '/.pyenv/shims/python'),
  -- TODO: in your venv: pip install debugpy
  args = { '-m', 'debugpy.adapter' };
}

-- NOTE: delete this config if it looks like your debugger is looking at the wrong python to confirm its using this config
-- set filetype=python if your filetype in vim isnt python already. thats how it maps which config to use
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      -- May have to hardcode this to your python in your venv if it doesnt seem to work
      return (os.getenv("VIRTUAL_ENV") or os.getenv('HOME') .. '/.pyenv/shims/python')
    end;
  },
}

-- NOTE: chrome has to be started with a remote debugging port google-chrome-stable --remote-debugging-port=9222
-- chrome_debug_open
dap.adapters.chrome = {
    type = "executable",
    command = "node",
    -- TODO: switch to mason managed dap
    args = {os.getenv("HOME") .. "/dev/microsoft/vscode-chrome-debug/out/src/chromeDebug.js",  "--server=9222"}
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
  args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
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
    processId = require'dap.utils'.pick_process,
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
  type = 'executable';
  command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter';
  name = 'bashdb';
}

dap.configurations.sh = {
  {
    type = 'bashdb';
    request = 'launch';
    name = "Launch file";
    showDebugOutput = true;
    pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb';
    pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir';
    trace = true;
    file = "${file}";
    program = "${file}";
    cwd = '${workspaceFolder}';
    pathCat = "cat";
    pathBash = "/usr/local/bin/bash";
    pathMkfifo = "mkfifo";
    pathPkill = "pkill";
    args = {};
    env = {};
    terminalKind = "integrated";
  }
}

-- ################## DAP END ###########################

vim.cmd('set wrap')
vim.cmd('source ~/vimfiles/plugin-settings/rainbow_csv.vim')
vim.cmd('source ~/vimfiles/rc-settings/terminal.vim')
vim.cmd('source ~/.vimrc_ext')
