# Path to your oh-my-zsh installation.
export ZSH=/Users/michael.zemel/.oh-my-zsh

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
function symlink_dotfiles {
  echo "You may provide a path if the default of ~/Sites/dotfiles is not correct."
  echo $1
  if ! [ -z "$1" ]; then
    dotfile_path=$1
  else
    dotfile_path=~/Sites/dotfiles
  fi
  
  pushd ~

  # zsh
  rm ~/.zshrc
  ln -s $dotfile_path/.zshrc
  rm ~/.tmux.conf
  ln -s $dotfile_path/.tmux.conf
  rm ~/.vimrc
  ln -s $dotfile_path/.vimrc

  popd
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
