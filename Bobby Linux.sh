#!/bin/sh
printf '\033c\033]0;%s\a' Bobby FG
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Bobby Linux.x86_64" "$@"
