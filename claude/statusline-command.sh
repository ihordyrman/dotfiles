#!/bin/bash

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
output_style=$(echo "$input" | jq -r '.output_style.name // empty')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

dir_display="[${cwd/#$HOME/\~}]"

git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        if git -C "$cwd" diff-index --quiet HEAD -- 2>/dev/null; then
            git_color=$(printf '\033[32m')
        else
            git_color=$(printf '\033[31m')
        fi
        git_info=$(printf '\033[36m[\033[32m%s%s\033[36m]' "$git_color" "$branch")
    fi
fi

context_info=""
if [ -n "$remaining" ]; then
    context_info=$(printf '\033[36m[\033[33m%s%% ctx\033[36m]' "$remaining")
fi

style_info=""
if [ -n "$output_style" ] && [ "$output_style" != "default" ]; then
    style_info=$(printf '\033[36m[\033[35m%s\033[36m]' "$output_style")
fi

printf '\033[36m%s' "$dir_display"
[ -n "$git_info" ] && printf '%s' "$git_info"
[ -n "$context_info" ] && printf '%s' "$context_info"
[ -n "$style_info" ] && printf '%s' "$style_info"
printf '\033[0m\n'
