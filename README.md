# dotfiles

This is a repository containing most of my configurations. They are
tangled with the CLI tool [md-tangle][1].

## Configurations

* [bash](configurations/bash.md)
    * [.git-completion](assets/.git-completion.bash)
    * [.git-prompt](assets/.git-prompt.sh)
* [bat](configurations/bat.md)
* [bin](configurations/bin.md)
* [conkeror](configurations/conkeror.md)
* [emacs](configurations/emacs.md)
* [i3](configurations/i3.md)
    * [wallpaper](assets/wallpaper.png)
    * [lock-screen](assets/lock-screen.png)
* [ideavimrc](configurations/ideavimrc.md)
* [git](configurations/git.md)
* [nano](configurations/nano.md)
* [nvim](configurations/nvim.md)
* [tmux](configurations/tmux.md)
* [WexTerm](configurations/wezterm.md)
* [Xmodmap](configurations/xmodmap.md)
* [Yazi](configurations/yazi.md)

### Tangle

Install [md-tangle][1]:
```bash
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install md-tangle
```
> Next time you only need to run `source .venv/bin/activate`

Now you can [tangle][1] the file want by e.g.:
```bash
md-tangle configurations/bin.md
```

Or update the [sources](dist) with:
```bash
./build.sh
```

To exit the virtual environment:
```bash
deactivate
```

## Source

The tangled source can be found [here](dist).


[1]: https://github.com/joakimmj/md-tangle
