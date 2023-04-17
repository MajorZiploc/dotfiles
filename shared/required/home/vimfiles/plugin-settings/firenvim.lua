if vim.g.started_by_firenvim == true then
  vim.cmd('set guifont=monospace:h20')
  vim.cmd("let g:firenvim_config={'globalSettings':{},'localSettings':{'.*':{ 'takeover': 'never' }}}")

  -- text box
  vim.cmd("nmap <leader>tb <cmd>set lines=20<cr><cmd>set columns=100<cr>")

-- TODO: fix one of these attempts to resize the window on open of the window
--
--   vim.cmd([[
--   function! s:IsFirenvimActive(event) abort
--     if !exists('*nvim_get_chan_info')
--       return 0
--     endif
--     let l:ui = nvim_get_chan_info(a:event.chan)
--     return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
--         \ l:ui.client.name =~? 'Firenvim'
--   endfunction

--   function! OnUIEnter(event) abort
--     if s:IsFirenvimActive(a:event) && &lines < 10
--       set lines=10
--     endif
--   endfunction

--   augroup FirenvimUser
--     autocmd!
--     autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
--   augroup end
-- ]])

  -- vim.cmd('so ~/vimfiles/plugin-settings/firenvim.vim')

  -- vim.api.nvim_create_autocmd({'UIEnter'}, {
  --   callback = function(event)
  --     vim.cmd('set lines=10')
  --     vim.cmd('set columns=100')
  --   end
  -- })

end

