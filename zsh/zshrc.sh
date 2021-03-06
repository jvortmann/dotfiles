# Include OS config
os="$(uname)"
[[ -f "$ZSH_HOME/os/${os}.sh" ]] && source "$ZSH_HOME/os/${os}.sh"

START="$(gdate "+%s%3N")"
#PS4='+$(gdate "+%s:%N") %N:%i> '
#exec 3>&2 2>/tmp/startlog
#setopt xtrace prompt_subst

export TERM=xterm-256color

# Include host config
hostname="$(hostname -s)"
[[ -f "$ZSH_HOME/hosts/$hostname.sh" ]] && source "$ZSH_HOME/hosts/$hostname.sh"

# set editor
export EDITOR=vim

# Enable emacs keys
bindkey -e

# Disable flow control
stty -ixon

# Bash profile integration
if [ "$ZSH_PROFILE_INTEGRATION" = true ]; then
  for file (/etc/profile.d/*) source $file
fi

# Configure PATH
source "$ZSH_HOME/path.sh"

# Include all files in lib dir
for file ($ZSH_HOME/lib/*) source $file

# Include plugins
for file ($ZSH_HOME/plugins/*.sh) source $file

# More PATH
export PATH="bin:$PATH"

# Set default theme if no theme selected
if [ -z "$ZSH_THEME" ]; then
  ZSH_THEME=default
fi

# Apply theme
source "$ZSH_HOME/themes/$ZSH_THEME.sh"

#unsetopt xtrace
#exec 2>&3 3>&-
LAST_COMMAND_TIME=$(($(gdate "+%s%3N")-$START))
