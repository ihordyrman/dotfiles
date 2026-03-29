Sync system configs to the dotfiles repo at /home/ihor/Projects/dotfiles.

Run ALL diff checks in parallel first, then apply all changes.

## Step 1 — check for differences (run all in parallel)

```bash
diff -rq ~/.config/nvim ~/Projects/dotfiles/nvim --exclude="lazy-lock.json"
diff -rq ~/.config/i3 ~/Projects/dotfiles/i3
diff ~/.config/zellij/config.kdl ~/Projects/dotfiles/shell/zellij.kdl
diff ~/.config/alacritty/shared.toml <(sed -n '/tee.*shared.toml/,/^EOF/p' ~/Projects/dotfiles/shell/alacritty.sh | sed '1d;$d')
diff ~/.config/alacritty/theme.toml  <(sed -n '/tee.*theme.toml/,/^EOF/p'  ~/Projects/dotfiles/shell/alacritty.sh | sed '1d;$d')
diff ~/.config/alacritty/font.toml   <(sed -n '/tee.*font.toml/,/^EOF/p'   ~/Projects/dotfiles/shell/alacritty.sh | sed '1d;$d')
```

## Step 2 — apply changes

**nvim**: for each file that differs or is only in `~/.config/nvim`, `cp` it to the matching path under `~/Projects/dotfiles/nvim/`. For files only in the repo (deleted from system), remove them from the repo.

**i3**: if `config` differs, `cp ~/.config/i3/config ~/Projects/dotfiles/i3/config`. Ignore files only in the repo (`i3.sh`, `i3status/`) — those are setup scripts, not live configs.

**zellij**: if different, `cp ~/.config/zellij/config.kdl ~/Projects/dotfiles/shell/zellij.kdl`.

**alacritty** — configs are embedded as heredocs inside `~/Projects/dotfiles/shell/alacritty.sh`. For each differing section, replace the heredoc content in the script with the current system file content. The heredoc for each file is bounded by `sudo tee ~/.config/alacritty/<name>.toml` and the next bare `EOF` line.

## Step 3 — report

List every file that was updated, added, or removed. If nothing changed, say "already in sync".
