if vim.g.started_by_firenvim == true then
  vim.cmd('set guifont=monospace:h20')
  vim.cmd("let g:firenvim_config={'globalSettings':{},'localSettings':{'.*':{ 'takeover': 'never' }}}")
end
