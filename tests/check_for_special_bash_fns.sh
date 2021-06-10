#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

function typea_check(){
  type -a "$1";
}

@test "check that all user defined bash functions exist" {
  IFS= ;
  l=(
  "find_files"
  "h"
  "hf"
  "tmuxcs"
  "tmuxps"
  "tmuxds"
  "ide1"
  "ide2"
  "ide3"
  "show_find_full_paths"
  "show_machine_details"
  "show_folder_details"
  "set_elem"
  "set_eq"
  "set_cardinality"
  "set_subset"
  "set_union"
  "set_intersection"
  "set_complement"
  "set_symmetric_difference"
  "set_power_set_experimental"
  "set_cardesian_product_experimental"
  "set_disjoint_experimental"
  "set_minimum"
  "set_minimum_num"
  "set_maximum"
  "set_maximum_num"
  "prefix_file"
  "col_n"
  "skip_n"
  "take_n"
  "sample"
  "show_file_content"
  "sample_csv"
  "search_env_for"
  "search_env_for_fuzz"
  "show_block"
  "show_line_nums"
  "refresh_settings"
  "refresh_pwsh"
  "find_items_rename_experimental_helper"
  "find_items_rename_preview_experimental"
  "find_items_rename_experimental"
  "find_items"
  "find_items_fuzz"
  "find_files_delete_preview"
  "find_files_delete"
  "find_files_rename_helper"
  "find_files_rename_preview"
  "find_files_rename"
  "find_files"
  "find_files_fuzz"
  "find_in_files"
  "find_in_files_fuzz"
  "find_in_files_replace"
  "git_checkout_branch_in_path"
  "git_log_follow"
  "git_diff_range"
  "git_log_show_last_n"
  "show_cmds_like"
  "show_cmds_like_fuzz"
  "bash_snip_for_loop"
  "sql_snip_search_column"
  "sql_snip_general_search"
  "pwsh_snip_init_module"
  "pwsh_snip_init_script"
  )
  for funct in ${l[@]};
    do
      run typea_check "$funct"
      assert_success
      assert_output --partial "$funct"
    done;
  unset IFS;
}

