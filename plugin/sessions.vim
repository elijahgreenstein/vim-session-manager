" Description: Shortcuts for creating, loading, and removing sessions.
"
" Designates a directory for Vim sessions and sets up a file to record the
" names and history of sessions loaded.
"
" - Create a new session with `:Mks <NAME>`
" - View sessions with `:Vws`
" - View the session history with `:Shs`
" - Load a session with `:Lds <NAME>`
" - Remove a session with `:Rms <NAME>`


" ============================================================
" Section: Setup

let s:sessiondir = $HOME . "/.vim/vimsessions/"
let s:sessionhist = $HOME . "/.vim/vimsessions/sessionhist.txt"


" ============================================================
" Section: Functions

function ShowSessionHistory()
  let sessionsList = readfile(s:sessionhist, '', 10)
  for line in sessionsList
    echo line
  endfor
endfunction

function UpdateSessionHistory(path)
  " Create session history if one does not exist
  if filereadable(s:sessionhist) == 0
    execute "silent !touch" s:sessionhist
  endif
  " Update session history
  let sessionsList = readfile(s:sessionhist, '', 10)
  execute "silent !echo \"" . a:path . "\" >" s:sessionhist
  for line in sessionsList
    if line != a:path
      execute "silent !echo \"" . line . "\" >>" s:sessionhist
    endif
  endfor
endfunction

function MakeSession(name)
  if (filewritable(s:sessiondir) != 2)
    exe "silent !mkdir -p " s:sessiondir
  endif
  let filename = s:sessiondir . a:name . ".vim"
  execute "mksession! " . filename
  call UpdateSessionHistory(filename)
  redraw!
  echo "Session saved: " filename
endfunction

function LoadSession(name)
  let sessionfile = s:sessiondir . a:name . ".vim"
  if (filereadable(sessionfile))
    execute "source " sessionfile
    call UpdateSessionHistory(sessionfile)
  else
    echo "No session named " a:name . ".vim"
  endif
endfunction

function RemoveSession(name)
  let sessionfile = s:sessiondir . a:name . ".vim"
  if (filereadable(sessionfile))
    execute "silent !rm " sessionfile
    redraw!
    echo "Session '" . a:name . "' removed"
  else
    echo "No session named " a:name . ".vim"
  endif
endfunction


" ============================================================
" Section: Commands

command -nargs=1 LoadSession call LoadSession("<args>")
command -nargs=1 Lds call LoadSession("<args>")
command -nargs=1 MakeSession call MakeSession("<args>")
command -nargs=1 Mks call MakeSession("<args>")
command -nargs=1 RemoveSession call RemoveSession("<args>")
command -nargs=1 Rms call RemoveSession("<args>")
command ShowSessions call ShowSessionHistory()
command Shs call ShowSessionHistory()
command ViewSessions execute "echo expand('" . s:sessiondir . "*.vim')"
command Vws execute "ViewSessions"


