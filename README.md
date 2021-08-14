My configurations for several terminal applications. I only really test these
scripts when I get a new computer. It is doubtful that they will all always run
error free, but I'm getting there!

Run `setup.sh` at the root of the repository. Or, run any sub-script in the
setup_scripts directory individually:

```bash
bash setup_scripts/install_homebrew.sh
bash setup_scripts/git.sh
bash setup_scripts/pyenv.sh $PYTHON_VERSION
bash setup_scripts/nvm.sh $NODE_VERSION
bash setup_scripts/zsh_setup.sh
bash setup_scripts/vim.sh
bash setup_scripts/mutt.sh
bash setup_scripts/irssi.sh
bash setup_scripts/screen.sh
```

Always run these scripts with your working directory at the root of the
repository.
