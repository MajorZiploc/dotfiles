" NOTE: Meant to be used by ~/vimfiles/plugin-settings/firenvim.lua
" This solution still doesnt work tho

" Resize nvim
function! s:IsFirenvimActive(event) abort
  if !exists('*nvim_get_chan_info')
    return 0
  endif
  let l:ui = nvim_get_chan_info(a:event.chan)
  return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
      \ l:ui.client.name =~? 'Firenvim'
endfunction

function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    set lines=20
  endif
endfunction

autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

