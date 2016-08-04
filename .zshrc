# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="theunraveler"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

plugins+=(zsh-completions)
autoload -U compinit && compinit

# Dotfile config
function list_commands {
  echo "install_oh_my_zsh"
  echo "symlink_dotfiles [DOTFILES_DIR]"
  echo "install_vim_plugins"
}

function symlink_dotfiles {
  echo "You may provide a path if the default of ~/Sites/dotfiles is not correct."
  echo $1
  if ! [ -z "$1" ]; then
    dotfile_path=$1
  else
    dotfile_path=~/Sites/dotfiles
  fi
  
  cd ~ 

  rm -f ~/.zshrc && rm -f ~/.tmux.conf && rm -f ~/.vimrc
  ln -s $dotfile_path/.zshrc
  ln -s $dotfile_path/.tmux.conf
  ln -s $dotfile_path/.vimrc
}

function install_oh_my_zsh {
  if ! [ -z "$(which zsh)" ]; then
    echo "You must install zsh first"
    exit
  fi

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function install_vim_plugins {
  mkdir -p ~/.vim && cd ~/.vim
  git clone https://github.com/ctrlpvim/ctrlp.vim.git bundle/ctrlp.vim
  git clone git://github.com/vim-ruby/vim-ruby.git ~/.vim/bundle/vim-ruby
}

function fuckin_push {
  branch=$( git rev-parse --abbrev-ref HEAD )
  if [ "$branch" = "master" ]; then
    echo "You're on master, you fool"
  else  
    git add app/ lib/ spec/
    git commit -c ORIG_HEAD
    git push -f origin $branch
  fi
}

function fuckin_pull {
  branch=$( git rev-parse --abbrev-ref HEAD )
  git fetch origin && git reset --hard origin/$branch
}

alias zopen="vi ~/.zshrc"
alias zsource="source ~/.zshrc"

# Rails-isms
alias b='bundle'
alias be='bundle exec'
alias bet='RAILS_ENV=test bundle exec'

# Directory traversing
alias mgmt='cd /srv/mgmt/current'
alias cms='cd /srv/rug/current'
alias landing='cd /srv/landing/current'

# Tailing logs
alias development='tail -f -n 100 log/development.log'
alias production='tail -f -n 100 log/production.log'

export PATH=$HOME/local/bin:$PATH
export PM_CHEF="/Users/michael.zemel/Sites/pm_chef"
export PATH=$HOME/.rbenv/shims:$PATH
export PATH="/opt/puppetlabs/bin:$PATH"
export PATH="/opt/chefdk/bin:$PATH"

