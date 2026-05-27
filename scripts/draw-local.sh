#!/usr/bin/env bash
set -euo pipefail

keymap_file="${1:-config/roBa.keymap}"
output_dir="${2:-keymap-drawer}"
keyboard="$(basename "$keymap_file" .keymap)"

config_args=()
if [[ -f keymap_drawer.config.yaml ]]; then
  config_args=(-c keymap_drawer.config.yaml)
fi

draw_args=()
if [[ -f "config/${keyboard}.json" ]]; then
  draw_args=(-j "config/${keyboard}.json")
fi

mkdir -p "$output_dir"

keymap "${config_args[@]}" parse -z "$keymap_file" >"${output_dir}/${keyboard}.yaml"
keymap "${config_args[@]}" draw "${output_dir}/${keyboard}.yaml" "${draw_args[@]}" >"${output_dir}/${keyboard}.svg"

echo "Wrote ${output_dir}/${keyboard}.yaml"
echo "Wrote ${output_dir}/${keyboard}.svg"
