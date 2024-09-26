lua << EOF
require("cscope_maps").setup(
  {
    -- maps related defaults
    disable_maps = false, -- "true" disables default keymaps
    skip_input_prompt = false, -- "true" doesn't ask for input
    prefix = "<leader>c", -- prefix to trigger maps

    -- cscope related defaults
    cscope = {
      -- location of cscope db file
      db_file = "./cscope.out", -- DB or table of DBs
                                -- NOTE:
                                --   when table of DBs is provided -
                                --   first DB is "primary" and others are "secondary"
                                --   primary DB is used for build and project_rooter
      -- cscope executable
      exec = "cscope", -- "cscope" or "gtags-cscope"
      -- choose your fav picker
      picker = "quickfix", -- "quickfix", "telescope", "fzf-lua" or "mini-pick"
      -- size of quickfix window
      qf_window_size = 5, -- any positive integer
      -- position of quickfix window
      qf_window_pos = "bottom", -- "bottom", "right", "left" or "top"
      -- "true" does not open picker for single result, just JUMP
      skip_picker_for_single_result = false, -- "false" or "true"
      -- these args are directly passed to "cscope -f <db_file> <args>"
      db_build_cmd_args = { "-bqkv" },
      -- statusline indicator, default is cscope executable
      statusline_indicator = nil,
      -- try to locate db_file in parent dir(s)
      project_rooter = {
        enable = false, -- "true" or "false"
        -- change cwd to where db_file is located
        change_cwd = false, -- "true" or "false"
      },
    }
  }
)

-- TODO: fix this build
-- local group = vim.api.nvim_create_augroup("CscopeBuild", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePost", {
  -- -- TODO: update this for more languages
  -- pattern = { "*.c", "*.h", "*.fs", "*.cs" },
  -- callback = function ()
    -- vim.cmd("Cscope db build")
  -- end,
  -- group = group,
-- })

EOF

nmap <leader>cps :CsPrompt s<cr>
nmap <leader>cs :Cs f s<cr>
nmap <leader>cpg :CsPrompt g<cr>
nmap <leader>cg :Cs f g<cr>
nmap <leader>cpc :CsPrompt c<cr>
nmap <leader>cc :Cs f c<cr>
nmap <leader>cpt :CsPrompt t<cr>
nmap <leader>ct :Cs f t<cr>
nmap <leader>cpe :CsPrompt e<cr>
nmap <leader>ce :Cs f e<cr>
nmap <leader>cpf :CsPrompt f<cr>
nmap <leader>cf :Cs f f<cr>
nmap <leader>cpi :CsPrompt i<cr>
nmap <leader>ci :Cs f i<cr>
nmap <leader>cpd :CsPrompt d<cr>
nmap <leader>cd :Cs f d<cr>
nmap <leader>cpa :CsPrompt a<cr>
nmap <leader>ca :Cs f a<cr>
nmap <leader>cpb :CsPrompt b<cr>
nmap <leader>cb :Cs f b<cr>
