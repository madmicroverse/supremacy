# Vim Cheatsheet

## Modes
- `i` - Insert mode (insert text)
- `Esc` - Return to normal mode
- `v` - Visual mode (select text)
- `V` - Visual line mode (select entire lines)
- `Ctrl+v` - Visual block mode (select columns)
- `:` - Command mode

## Basic Navigation
- `h` - Move cursor left
- `j` - Move cursor down
- `k` - Move cursor up
- `l` - Move cursor right
- `w` - Jump to start of next word
- `b` - Jump to start of previous word
- `e` - Jump to end of word
- `0` - Jump to start of line
- `$` - Jump to end of line
- `gg` - Go to first line of document
- `G` - Go to last line of document
- `{number}G` - Go to line {number}
- `Ctrl+f` - Page down
- `Ctrl+b` - Page up
- `Ctrl+d` - Half page down
- `Ctrl+u` - Half page up
- `%` - Jump to matching bracket

## Editing
- `i` - Insert before cursor
- `I` - Insert at beginning of line
- `a` - Insert after cursor
- `A` - Insert at end of line
- `o` - Insert new line below
- `O` - Insert new line above
- `r` - Replace single character
- `R` - Replace mode (overwrite text)
- `x` - Delete character under cursor
- `X` - Delete character before cursor
- `dd` - Delete line
- `dw` - Delete word
- `d$` or `D` - Delete to end of line
- `d0` - Delete to beginning of line
- `yy` - Copy line
- `yw` - Copy word
- `y$` - Copy to end of line
- `p` - Paste after cursor
- `P` - Paste before cursor
- `u` - Undo
- `Ctrl+r` - Redo
- `.` - Repeat last command

## Search and Replace
- `/pattern` - Search forward for pattern
- `?pattern` - Search backward for pattern
- `n` - Repeat search in same direction
- `N` - Repeat search in opposite direction
- `:%s/old/new/g` - Replace all occurrences of 'old' with 'new' in file
- `:%s/old/new/gc` - Replace all occurrences with confirmation
- `:s/old/new/g` - Replace all occurrences in current line

## Multiple Files
- `:e filename` - Edit a file
- `:w` - Save
- `:w filename` - Save as
- `:q` - Quit
- `:q!` - Quit without saving
- `:wq` or `:x` - Save and quit
- `:bn` - Next buffer
- `:bp` - Previous buffer
- `:ls` - List all buffers
- `:b{number}` - Go to buffer {number}
- `:sp filename` - Open file in horizontal split
- `:vsp filename` - Open file in vertical split
- `Ctrl+ws` - Split window horizontally
- `Ctrl+wv` - Split window vertically
- `Ctrl+ww` - Switch between windows
- `Ctrl+wq` - Quit current window
- `Ctrl+wh` - Move to left window
- `Ctrl+wj` - Move to window below
- `Ctrl+wk` - Move to window above
- `Ctrl+wl` - Move to right window

## Visual Mode
- `v` - Start visual mode
- `V` - Start linewise visual mode
- `Ctrl+v` - Start visual block mode
- `>` - Shift text right
- `<` - Shift text left
- `y` - Yank (copy) marked text
- `d` - Delete marked text
- `~` - Switch case

## Macros
- `q{letter}` - Record macro into register {letter}
- `q` - Stop recording macro
- `@{letter}` - Run macro in register {letter}
- `@@` - Rerun last run macro

## Folding
- `zf` - Create fold
- `zo` - Open fold
- `zc` - Close fold
- `za` - Toggle fold
- `zR` - Open all folds
- `zM` - Close all folds

## Marks
- `m{letter}` - Set mark at current position
- `'{letter}` - Jump to line of mark
- `` `{letter}`` - Jump to position of mark
- `:marks` - List all marks

## Text Objects
- `ciw` - Change inner word
- `ci"` - Change inside quotes
- `ci(` - Change inside parentheses
- `ci{` - Change inside braces
- `cit` - Change inside HTML tag
- `diw`, `di"`, etc. - Delete instead of change
- `viw`, `vi"`, etc. - Select instead of change

## Miscellaneous
- `:set number` - Show line numbers
- `:set nonumber` - Hide line numbers
- `:set paste` - Enable paste mode (prevents auto-indenting)
- `:set nopaste` - Disable paste mode
- `:help keyword` - Open help for keyword
- `Esc` - Exit insert mode or cancel command
