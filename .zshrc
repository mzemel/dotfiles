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

function up {
  branch=$( git rev-parse --abbrev-ref HEAD )
  if [ "$branch" = "master" ]; then
    echo "You're on master, you fool"
  else  
    git push -f origin $branch
  fi
}


function fup {
  branch=$( git rev-parse --abbrev-ref HEAD )
  if [ "$branch" = "master" ]; then
    echo "You're on master, you fool"
  else  
    git add .
    git commit --amend
    git push -f origin $branch
  fi
}

function down {
  branch=$( git rev-parse --abbrev-ref HEAD )
  git fetch origin && git reset --hard origin/$branch
}

alias zopen="vi ~/.zshrc"
alias zsource="source ~/.zshrc"
alias sum="subl /Volumes/srv/mgmt/local"
alias sul="subl /Volumes/srv/landing/local"
alias suc="subl ~/Sites/cms"
alias dew="docker-compose exec web"
alias des="docker-compose exec sneakers"
alias del="docker-compose logs -f"

alias standup="open https://zoom.us/j/538555316"
alias coverage="open /Volumes/srv/mgmt/local/coverage/index.html"

# Rails-isms
alias b='bundle'
alias be='bundle exec'
alias bet='RAILS_ENV=test bundle exec'
alias ber='bundle exec rspec'
alias rber='docker-compose run -e "RAILS_ENV=test" web bundle exec rspec'

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


# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/michael.zemel/Downloads/google-cloud-sdk/path.zsh.inc ]; then
  source '/Users/michael.zemel/Downloads/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/michael.zemel/Downloads/google-cloud-sdk/completion.zsh.inc ]; then
  source '/Users/michael.zemel/Downloads/google-cloud-sdk/completion.zsh.inc'
fi

export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export EDITOR='vim'
source ~/.zshrc.phishme

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
