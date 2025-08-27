# Vim Session Manager

Commands to simplify the organization of Vim sessions (`:h session`).

## Installation

Place this directory in a location on the following pattern:

```
~/.vim/pack/<ARBITRARY>/start/vim-session-manager
```

For example:

```console
git clone https://github.com/elijahgreenstein/vim-session-manager ~/.vim/pack/elijahgreenstein/start/vim-session-manager
```

## Usage

Vim Session Manager adds sessions to `~/.vim/vimsessions` and keeps track of session history in `~/.vim/vimsessions/sessionhist.txt`. Use the following commands to manage Vim sessions:

- `Mks <name>`: Make a new session, stored in `~/.vim/vimsessions/<name>`
- `Lds <name>`: Load session `<name>`
- `Vws`: View a list of sessions
- `Shs`: Show the history of loaded sessions
- `Rms <name>`: Remove session `<name>` (i.e. remove `~/.vim/vimsessions/<name>`)

