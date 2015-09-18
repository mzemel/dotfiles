if [ -z "$CURRENT_AWS_ENV" ]
then
  CURRENT_AWS_ENV="sweetspotbeta"
fi
# Valid are: staging, sweetspotscience, sweetspotbeta, sweetspotbio, sweetspotcare

# Path to your oh-my-zsh installation.
export ZSH=/Users/mzemel/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="theunraveler"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/Users/mzemel/.rbenv/shims:/Users/mzemel/apache-maven-3.3.1/bin:/opt/chefdk/bin:/Users/mzemel/bin:/usr/local/bin:/Users/mzemel/.rbenv/bin:/Users/mzemel/.rbenv/shims:/Users/mzemel/apache-maven-3.3.1/bin:/opt/chefdk/bin:/Users/mzemel/bin:/usr/local/bin:/Users/mzemel/.rbenv/bin:/Users/mzemel/.rbenv/shims:/Users/mzemel/apache-maven-3.3.1/bin:/opt/chefdk/bin:/Users/mzemel/bin:/usr/local/bin:/Users/mzemel/.rbenv/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/MacGPG2/bin:/Users/mzemel/.ec2:/Users/mzemel/.ec2:/Users/mzemel/.ec2:/Users/mzemel/apache-jmeter-2.13/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
source /Users/mzemel/Sites/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# source ~/.git-prompt.sh
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=~/bin:$PATH
 export PATH=~/anaconda/bin:$PATH
export PATH="/opt/chefdk/bin:$PATH"
export PATH=~/apache-maven-3.3.1/bin:$PATH
export JAVA_HOME="$(/usr/libexec/java_home)"
export PATH="$PATH:$HOME/.ec2"

eval "$(rbenv init -)"
eval "$(aws_environment.sh -i)"
aws_environment $CURRENT_AWS_ENV
alias zopen="subl ~/.zshrc"
alias zsource="source ~/.zshrc"

# Rails-isms
alias b='bundle'
alias bp='bundle install --path vendor && bundle package --all'
alias be='bundle exec'
alias bet='RAILS_ENV=test bundle exec'
alias poonicorn="bin/unicorn_rails -c config/unicorn.rb -E development"

# Directory traversing
alias platform='cd ~/Sites/productdev/platform'
alias pdf='cd ~/Sites/productdev/svc_pdf_rendering'
alias rogue='cd ~/Sites/productdev/rogue'
alias camus='cd ~/Sites/productdev/auditing/camus'
alias sartre='cd ~/Sites/productdev/auditing/sartre'
alias kafka='cd ~/Sites/productdev/auditing/kafka'
alias ss="cd ~/Sites/stripstarter"
alias sc="cd ~/Projects/scala"
alias el='cd ~/Projects/elixir'
alias bork='cd ~/Sites/productdev/sweetspot-chef-repo'
alias dicker='cd ~/Sites/productdev/docker'
alias burp='boot2docker restart && boot2docker up'

# Server navigation
servers() {
  pushd ~/Sites/sweetspot-chef-repo
  echo "Current environment is: $CURRENT_AWS_ENV"
  scripts/servers
  popd
}
change_to() {
  export CURRENT_AWS_ENV="$1"
  zsource
}
ssh_rogue() {
  echo "SSHing into $CURRENT_AWS_ENV Rogue..."
  ssh $(servers | grep "role\[rogue\]" | awk '{print $1}')
}
ssh_platform() {
  echo "SSHing into $CURRENT_AWS_ENV Platform..."
  ssh $(servers | grep "role\[app\]" | awk '{print $1}')
}

# Git-fu
sco() {
  git checkout $(echo "mz/SWEET-$1")
}
scob() {
  git checkout -b $(echo "mz/SWEET-$1")
}
rco() {
  git checkout $(echo "mz/ROG-$1")
}
rcob() {
  git checkout -b $(echo "mz/ROG-$1")
}
cco() {
  git checkout $(echo "mz/RCP-$1")
}
ccob() {
  git checkout -b $(echo "mz/RCP-$1")
}
com() {
  git checkout master
  git pull upstream master
}
push() {
  branch=$( git rev-parse --abbrev-ref HEAD )
  git push upstream $branch
}

# Tailing logs
alias development='tail -f -n 100 log/development.log'
alias production='tail -f -n 100 log/production.log'



export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2376
export DOCKER_CERT_PATH=/Users/mzemel/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
export DOCKER_IP=$(boot2docker ip 2>/dev/null)
export MYSQL_HOST=$DOCKER_IP
export MONGO_HOST=$DOCKER_IP
export REDIS_HOST=$DOCKER_IP
export RIAK_HOST=$DOCKER_IP
export POSTGRES_HOST=$DOCKER_IP

export DATA_ACCESS_IP=http://$DOCKER_IP:9000
export DATA_ACCESS_HOST=$DOCKER_IP
export DATA_ACCESS_PORT=9000
export DATA_ACCESS_LOG_LEVEL=INFO

export PATTERNS_HOST=$DOCKER_IP
export PATTERNS_PORT=8080
export PATTERNS_LOG_LEVEL=INFO

export STATISTICS_HOST=$DOCKER_IP
export STATISTICS_PORT=9100
export STATISTICS_HOST_LOG_LEVEL=INFO

export DEXCOM_PULL_HOST=$DOCKER_IP
export DEXCOM_PULL_PORT=9050
export DEXCOM_PULL_LOG_LEVEL=INFO

# JRuby stuff
jiffy() { export PATH=/Users/mzemel/jruby-1.7.16/bin:$PATH; }
dejiffy() { export PATH=$PATH:/Users/mzemel/jruby-1.7.16/bin; }
alias j="jruby -S"
export JRUBY_OPTS='-X+O -J-Djruby.launch.inproc=false -Xcext.enabled=true'

power() {
  pushd ~/.pow
  rm platform
  ln -s ~/Sites/platform
  popd
  echo "Platform is now running on Pow!"
}

rpower() {
  pushd ~/.pow
  rm rogue
  ln -s ~/Sites/rogue
  popd
  echo "Rogue is now running on Pow!"
}

depower() {
  pushd ~/.pow
  rm platform
  echo '3000' > platform
  popd
  echo "Platform has been removed from Pow!"
}

rdepower() {
  pushd ~/.pow
  rm rogue
  echo '3000' > rogue
  popd
  echo "Rogue has been removed from Pow!"
}

docker_cleanup() {
  ~/cleanup_docker.sh
}
