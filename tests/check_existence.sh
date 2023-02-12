#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc 2>/dev/null || true;

function typea_check(){
  type -a "$1";
}

@test "check that all user defined bash functions exist" {
  IFS= ;
  l=(
  "find_files"
  "h"
  "show_env_notes"
  "tmuxcs"
  "tmuxps"
  "tmuxds"
  "show_machine_details"
  "col_n"
  "skip_n"
  "take_n"
  "show_file_content"
  "search_env_for"
  "search_env_for_fuzz"
  "show_block"
  "show_line_nums"
  "refresh_settings"
  "find_items_rename_preview"
  "find_items_rename"
  "find_items"
  "find_items_fuzz"
  "find_files_delete_preview"
  "find_files_delete"
  "find_files_rename_preview"
  "find_files_rename"
  "find_files"
  "find_files_fuzz"
  "find_in_files"
  "find_in_files_fuzz"
  "find_in_files_replace"
  "afind_items_rename_preview"
  "afind_items_rename"
  "afind_items"
  "afind_items_fuzz"
  "afind_files_delete_preview"
  "afind_files_delete"
  "afind_files_rename_preview"
  "afind_files_rename"
  "afind_files"
  "afind_files_fuzz"
  "afind_in_files"
  "afind_in_files_fuzz"
  "afind_in_files_replace"
  "gfind_items_rename_preview"
  "gfind_items_rename"
  "gfind_items"
  "gfind_items_fuzz"
  "gfind_files_delete_preview"
  "gfind_files_delete"
  "gfind_files_rename_preview"
  "gfind_files_rename"
  "gfind_files"
  "gfind_files_fuzz"
  "gfind_in_files"
  "gfind_in_files_fuzz"
  "gfind_in_files_replace"
  "git_checkout_branch_in_path"
  "git_rebase_i_head"
  "git_log_follow"
  "git_diff_range"
  "git_log_show_last_n_on_current_branch"
  "git_diff_of_commit"
  "git_diff_from_commit_to_current"
  "show_cmds_like"
  "show_cmds_like_fuzz"
  "snip_bash_for_loop"
  "snip_sql_search_column"
  "snip_sql_search_general"
  "snip_sql_function_info"
  "snip_sql_table_constraints"
  "snip_sql_table_and_view_info"
  "snip_pwsh_init_module"
  "snip_pwsh_init_script"
  "show_cheat_sheet"
  "parse_json_fields"
  "parse_csv_fields"
  "convert_csv_to_json"
  "csv_delimiter_check_single_line"
  "rest_get"
  "rest_post"
  "rest_patch"
  "rest_delete"
  "rest_generic"
  "cdfp"
  "ideh1"
  "idev1"
  "cdp"
  "vim_session"
  )
  for funct in ${l[@]}; do
    run typea_check "$funct"
    assert_success
    assert_output --partial "$funct"
  done;
  unset IFS;
}

@test "check that all user defined bash aliases exist" {
  IFS= ;
  l=(
  "tmuxas"
  "tmuxks"
  "tmuxksvr"
  "tmuxls"
  #"clip"
  #"clipp"
  "show_path"
  "rev_chars"
  "rev_lines"
  "toggle_case"
  "camel_to_snake"
  "snake_to_camel"
  "snake_to_space"
  "camel_to_space"
  "space_to_snake"
  "space_to_camel"
  "to_lower"
  "to_upper"
  "rtrim"
  "ltrim"
  "trim"
  "keep_last"
  "keep_first"
  "add_semicolons"
  "to_fuzz"
  "to_newlines"
  "bse"
  "bss"
  "blj"
  "bls"
  "ls"
  "grep"
  "fgrep"
  "egrep"
  "ll"
  "la"
  "ld"
  "l"
  "less_r"
  "less_f"
  "whence"
  "_grepn_files"
  "grepn_files_freq"
  "grepn_files_uniq"
  "find_items_hidden"
  "find_items_nonhidden"
  "reexe"
  "vimi"
  "vimc"
  "vimt"
  "vimnp"
  "show_fn_names"
  "show_fn_impls"
  "back"
  "time_js"
  "git_merge_keep_theirs"
  "git_deploy"
  "git_log_break_down"
  "git_graph"
  "git_log_diff"
  "to_winpath"
  "to_unixpath"
  "show_root_folder"
  "cdf"
  )
  for funct in ${l[@]}; do
    run typea_check "$funct"
    assert_success
    assert_output --partial "$funct"
  done;
  unset IFS;
}

