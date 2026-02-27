The bleeding edge version of this dotfile has been moved to [codeberg](https://codeberg.org/badumbatish) due to propietary company projects.

You're still welcome to inherit the repo's ideas as well as the [blog](https://badumbatish.github.io/posts/jasmine_in_llvm_land_and_config) whenver you see fit :)

~~# Overview~~

~~Hi everyone, welcome to my collection of dotfiles. The dotfiles is geared towards neovim/tmux/MacOS and my job, which is compiler development.~~

~~Before blindly initializing and running the commands in this dotfile, do your due diligence first and read through every link here if you're not familiar with one. You can also dive into the configuration files themselves.~~
~~## Why?~~

~~A very, very smart CS person in my compiler class at uni once told me something along~~
~~the line of "use/build your tool very well" and I feel like~~
~~I want to share it in this blog. The use case of when he told me might be different~~
~~, but the principle still remains the same: regardless if it's about the compiler, terminal tool, or~~
~~your IDE, it really pays off to learn how to use your tool so good that it~~
~~completely boosts your productivity into a different dimension.~~

~~In my case, automating to shave seconds off each time I compile, test, debug or query my code really reinforces the~~
~~dev cycle, making me lose less mental capacity and gain more efficiency.~~

~~Alright, that's all the yapping. Let's get to it :)~~

~~## Initialization and Upkeep~~

~~I used [chezmoi](https://www.chezmoi.io/) to manage my dotfiles.~~

~~### Initialization~~
~~Fork this repository and then run the following command to initial the configuration.~~

~~```~~
~~chezmoi init git@github.com:<your_github_username>/dotfiles.git && chezmoi update~~
~~```~~

~~### Upkeep via custom commands~~

~~With a large number of files to keep up with and update, I've outgrown chezmoi's default commands: chezmoi add, git add, and git push... The demands to automate the upkeep of my files has led to a small number of commands that wraps chezmoi to make my maintainance easier:~~

~~- `cadd`: `chezmoi add` every files that is managed by chezmoi to git, commit them and show the difference. I still have to add the file once manually.~~
~~- `cpush`: Push all the changes to remote (Basically a wrapped chezmoi cd && git push)~~
~~- `cap`: A wrapper executable that executes `cadd` and `cpush`~~
~~- `cinstall`: On a new mac machine, I call this script to install (almost) all necessary packages for my development.~~


~~With these commands, I:~~
~~- Don't have to remember which files I've edited or changed.~~
~~- Don't have to remember which package/library I need to install on a new machine~~
~~- Cut downs from (at minimum) 20 keystrokes to (at most) 4 keystrokes to register my new modifications.~~
~~- Waste no time waiting for chezmoi to add, and push as there is a script guaranteeing that each time it's the same~~
~~result.~~


~~## Window Manager (WM)~~
~~On MacOS, I'm currently using [yabai](https://github.com/koekeishiya/yabai) together with [skhd](https://github.com/koekeishiya/skhd) to drive my window management setup. Have a quick read about them if you haven't got a chance.~~

~~Using a Window Manager alleviates my reliance on the built-in mousepad and relieves me from programming [wrist pain](https://www.reddit.com/r/learnprogramming/comments/1dx9qgr/wrist_hurts_from_too_much_programming/)~~

~~Let's talk about WM now :)~~

~~I provide an executable called `yabai_reload` to automate reloading and running yabai/skhd whenever you restart MacOS or edit your yabai/skhd config.~~


~~Firstly, run `yabai_reload` to get yabai and skhd running/reset.~~

~~Secondly, there's a philosophy that you probably need to know about the window manager keybind's prefix.~~

~~- Cmd + `key`: Switch the focus to ...~~
~~- Shift + Cmd + `key`: Move the actual window to ...~~

~~### WM keybinds~~
~~- Cmd + hjkl: (Switch) the focus to left down up right window in the current workspace.~~
~~- Cmd + 1234: (Switch) to focus to workspace 1 2 3 4~~
~~- Shift + Cmd + hjkl: (Move the current window) (in the current workspace) to left down up right.~~
~~- Shift + Cmd + 1234: (Move the current window) to workspace 1 2 3 4.~~
~~## Atuin~~

~~Atuin is an automatic fuzzy finding tool for your terminal commands. It has helped me so much with rerunning my building and testing commands and has saved me hours of work.~~

~~I recommend you check out their [website](https://atuin.sh/) and watch the demo for yourself.~~

~~In my opinion, it's a pretty essential tool for all CLI users.~~
~~## Kitty ~~
~~Kitty is my chosen terminal. I switched from iterm2 to Kitty for the following reason:~~

~~- GPU acceleration: Kitty is smoother and faster than iterm2, this is important on a big codebase like llvm due to its massive improvement on rendering speed (rendering text in a big codebase in neovim on iterm2 is a pain.)~~
~~- Configuration ease: configuration for Kitty is extremely easy: everything is in 1 single file, from themes to extra shortcuts.~~

~~When you're doing software dev on a big codebase, aesthetics is an afterthought instead of [performance/speed](https://sw.kovidgoyal.net/kitty/performance/).~~

~~I also configure a few sane commands in Kitty for faster project maneuver:~~

~~- Cmd + `M`: Run the executable `sesh` in the current terminal.~~
~~- Cmd + `D`: Run the command `ctrl + b + d` to exit the current tmux session.~~
~~- Cmd + `N`: Run the command `ctrl + b + n` to go to the next panel in the current tmux session.~~
~~## ccache ~~
~~I set my ccache to be ~~
~~```~~
~~file_clone = true~~
~~inode_cache = true~~
~~max_size = 70G~~
~~base_dir = /~~
~~absolute_paths_in_stderr = true~~
~~```~~

~~to allow ccache of multiple directories and more max size as well as more caching speed on my llvm builds, both release and debug version.~~

~~Read the ccache manual for option explanations.~~
~~## Neovim and programming~~

~~Let's talk about neovim btw. Neovim is my chosen hyperextensible text editor. ~~

~~Throughout my two years of using neovim, I've accummulated a few commands to help ease my development process.~~
~~As a result, here is a selected list of commands, ordered by functionality~~


~~### Scratchpad file and debugging.~~

~~- `<leader>ps`: (P)aste the content in register `+` to a newly created, name-inputted-by-user file under the~~
~~scratch/ directory, and copied the full path file name into your copy-and-paste register (+).~~
~~- `<leader>ys`: (Y)ank and paste the current selection to a newly created, name-inputted-by-user file under the~~
~~scratch/ directory and copied the full path file name into your copy-and-paste register (+).~~
~~- `<leader>yl`: (Y)ank the full path + current file name + current line of the cursor and put it in the~~
~~copy-and-paste register (+).~~
~~- `<leader>yf`: (Y)ank the (f)ull path + current file name and put it in the copy-and-paste register (+).~~
~~- `<leader>yr`: (Y)ank the (r)elative path + current file name and put it in the copy-and-paste register (+).~~
~~- `<leader>yg`: (Y)ank everything in the file and return cursor to the same location as before. This is helpful for copy pasting stuff to other people~~

~~To me, this really speaks me to the power of neovim as a hyperextensible: comprising multiple steps in a single keybinds to boost developer productivity to the max.~~

~~The functionality related to scratchpad-ing and debugging are helpful in regard to quickly recreating a file on your local machine from a github issue and execute/run them, as well as quickly input the file name + cursor location to [lldb](https://lldb.llvm.org/) for debugging.~~

~~### Fuzzy-finder & Grepping~~

~~Back before starting my employment @ Igalia, I relied on [telescope](https://github.com/nvim-telescope/telescope.nvim) for all of my fuzzy finding. It turns out telescope is [really really slow](https://www.reddit.com/r/neovim/comments/ura4vu/telescope_too_slow_for_large_directories/) on big repository, even with ripgrep in place of grep. ~~

~~With fzf-lua being soooo sooo so customizable, I then turned my focus to said library and hasn't looked back since.~~

~~The mapping group for the fuzzy finding functionality is `<leader>f*` and `<leader>g*`~~
~~- `<leader>fg`: live fuzzy find using ripgrep.~~
~~- `<leader>ff`: live fuzzy find using fd.~~
~~- `<leader>fr`: resume the last live fuzzy find session.~~
~~- `<leader>fd`: live fuzzy find vim diagnostics.~~
~~- `<leader>fm`: live fuzzy find marks.~~
~~- `<leader>fb`: live fuzzy find recently opened buffers (within current nvim-executed folder)~~
~~- `<leader>g`: fuzzy find using ripgrep the word under the cursor or the current selection. ~~

~~A cool thing about fzf-lua is I can add nvim-treesitter-context as a dependency, which gives me extra context for every match in a file. This makes it so that for example, if I'm searching for a string or a variable in C++, I can instantly know which function the variable is residing in, as well as jump to said function/codeblock with the keymap `[c`.~~
~~### Language server support ~~

~~Language server protocol is a much needed functionality in a code editor.~~

~~It is also supported via the mapping group `<leader>l*`~~
~~- `<leader>la`: Trigger code action on the cursor from the language server. This includes capitalize functions and variables to satisfy a standard, filling in the remaining case of a C++ switch construct.~~
~~- `<leader>lr`: Smart rename - renaming a variable/function scope-wise.~~
~~- `<leader>c`: For C++, switch from a header file to its corresponding source file and vice versa~~
~~- `<leader>n`: Go to next suggestion from the language server support.~~
~~- `<leader>p`: Go to previous suggestion from the language server support.~~
~~- `<leader>y`: Accept the current suggestion from the language server support.~~
~~- `gc`: Instruct the LSP to comment out the current selection ~~
~~- `gd`: Instruct the LSP to go to definition on the cursor.~~

~~- `[m` &  `]m`: Jump to previous and next function.~~

~~### Git support ~~
~~For a beginner in a codebase (even a seasoned programmer), the ability to obtain more information and context, extending further than the code sitting in front of them, is extremely helpful.~~
~~Furthermore, small quality-of-life ability such as staging the current selected change to git add (instead of git adding the whole file) is very much appreciated.~~

~~My neovim config also supports git through the mapping group `<leader>h*`. A few capabilities include:~~
~~- Automatic git signs: shows green in the column for addition, and red for deletion.~~
~~- Automatic git blame on current line: shows the author and the commit message for the last change to current line.~~
~~- `<leader>yh`: (Y)ank the git blame SHA on current line~~
~~- `<leader>hb`: Show the git (b)lame on the current file~~
~~- `<leader>hs`: (S)tage the current hunk to git add~~
~~- `<leader>hr`: (R)eset the current hunk from git add~~

~~### Autocmd~~

~~I also have some quality-of-life auto commands.~~

~~- When I've performed a yank, I automatically highlight the yanked content for half a second to cognitively confirm the content.~~

~~- When I opened a file again, I automatically go to the last position where it was edited.~~

~~- When I've searched for something and it's highlighted across the file, I automatically remove the highlighting when I enter insert mode.~~
