#!/bin/bash

base_dir="schema/@typespec/openapi3"

sorted_files=($(cd "$base_dir" && find . -maxdepth 1 -type f -name "*.yaml" 2>/dev/null | sort ))

if [ ${#sorted_files[@]} -eq 0 ]; then
  echo "No .yaml files found in ${base_dir}"
else
  top_file="${sorted_files[0]}"

  cd ${base_dir} && ln -sf "${top_file}" "openapi.yaml"
fi
