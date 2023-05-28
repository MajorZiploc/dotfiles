nmap <leader>cn :let vf_my_search_result_files_current_index = (vf_my_search_result_files_current_index + 1) % vf_my_search_result_files_length<CR>:execute 'find ' . vf_my_search_result_files[vf_my_search_result_files_current_index]["abs_file_name"]<CR>:call VipFiles_ShowMySearchResultFilesPosition()<CR>
nmap <leader>cp :let vf_my_search_result_files_current_index = ((vf_my_search_result_files_current_index <= 0 ? vf_my_search_result_files_length : vf_my_search_result_files_current_index) - 1) % vf_my_search_result_files_length<CR>:execute 'find ' . vf_my_search_result_files[vf_my_search_result_files_current_index]["abs_file_name"]<CR>:call VipFiles_ShowMySearchResultFilesPosition()<CR>
nmap <leader>cl :call VipFiles_ShowMySearchResultFiles("rel_file_name", "abs_file_name")<CR>
vmap <leader>cp "ty:call VipFiles_PopulateMySearchResultFiles(split(@t, '\n'))<CR>
