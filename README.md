# Dotfiles Public

This is my personal Linux and Android setup built from scratch. The core focus right now is a fast Neovim configuration based on LazyVim, inspired by Craftzdog's aesthetic with custom styling (like the Aether theme).

It currently supports Arch Linux and Android via Termux.

---

## Getting Started

If you just cloned this repo, here is the fastest way to get everything running.

### 1. Clone into your config directory

```bash
git clone https://github.com/Kevin-Illu/dotfiles-public.git ~/.config/dotfiles-public
cd ~/.config/dotfiles-public
```

### 2. Install base dependencies

Neovim needs a few build tools, search utilities, and language runtimes so Mason and Treesitter can compile parsers and run language servers.

**On Arch Linux:**
```bash
sudo pacman -S --needed neovim git curl base-devel ripgrep fd fzf nodejs npm python python-pip
```
*Note: A Nerd Font (such as `ttf-jetbrains-mono-nerd`) is recommended for terminal icons.*

**On Android (Termux):**
```bash
pkg update && pkg upgrade -y
pkg install -y git curl nvim fish tmux termux-api termux-exec nodejs-lts python ripgrep fd fzf clang build-essential python-pip
```

### 3. Run the installer

The repo includes an automated installer that detects whether you are on Arch or Termux, backs up any existing config, and creates the symlinks.

```bash
chmod +x install.sh
./install.sh
```

What it handles behind the scenes:
- Backs up your existing `~/.config/nvim` to `~/.config/nvim.bak`.
- Symlinks `~/.config/dotfiles-public/nvim` to `~/.config/nvim`.
- On Termux: prompts for storage access (`termux-setup-storage`), installs packages, and sets Fish as the default shell.

### 4. Launch Neovim

```bash
nvim
```

On first launch:
- Lazy.nvim bootstraps and downloads all plugins automatically.
- Mason installs language servers and formatters in the background. You can check the download queue anytime with `:Mason`.
- Run `:checkhealth` to verify clipboard, treesitter, and LSP providers.

---

## Daily Usage & Code Examples

### Neovim shortcuts

A few custom keymaps configured in `nvim/lua/config/keymaps.lua`:

```lua
-- Quick splits and navigation
ss              -- Horizontal split (:split)
sv              -- Vertical split (:vsplit)
sh, sj, sk, sl  -- Move focus between windows (Left, Down, Up, Right)

-- Window layout and resizing
<Leader>rh      -- Move current split to far left
<Leader><       -- Maximize current split
<Leader>>       -- Restore balanced splits (<C-w>=)
<A-h>, <A-l>    -- Resize split width
<A-j>, <A-k>    -- Resize split height

-- Fast buffer/tab navigation
te              -- Open new tab (:tabedit)
<Tab>           -- Next tab
<S-Tab>         -- Previous tab

-- Terminal toggle (toggleterm)
<C-\>           -- Toggle built-in terminal
```

### Syncing Obsidian notes

If you use Obsidian, `obsidian-sync.sh` keeps notes in sync between Arch and Android via Git:

```bash
chmod +x obsidian-sync.sh
./obsidian-sync.sh
```

It checks for local edits, commits and pushes to remote, pulls updates with rebase, and launches the Obsidian app. You can adjust the vault path in `obsidian-sync.sh`:

```bash
VAULT_DIR="$HOME/workspace/notes/Enginering/"
```

---

## Roadmap

- [x] Neovim config
  - [x] Stable LazyVim config
  - [x] Setup guide and documentation
- [x] Android dotfiles (Termux setup script)
- [x] Obsidian sync script
- [ ] Tmux config
- [ ] Fish shell dotfiles

## Completed / In Progress

- [x] Map dependencies for Arch and Android
- [x] `install.sh` script with auto-detection and backups
- [ ] Standalone Fish shell configuration
- [ ] Tmux status bar and keybindings
