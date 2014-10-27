# iTerm2 integration for ZSH
# From http://iterm2.com/misc/zsh_startup.in

ST_NAME=`hostname -f`

[ x"$TERM" = "xscreen" ] && exit

# iTerm2 Indicates start of command output. Runs just before command executes.
iterm2_before_cmd_executes() {
  printf "\033]133;C\007"
}

# iTerm2 report return code of command; runs after command finishes but before prompt
iterm2_after_cmd_executes() {
  printf "\033]133;D;$?\007"
  printf "\033]1337;RemoteHost=$USER@`hostname -f`\007\033]1337;CurrentDir=$PWD\007"
}

# iTerm2 mark start of prompt
iterm2_prompt_start() {
  printf "\033]133;A\007"
}

# iTerm2 mark end of prompt
iterm2_prompt_end() {
  printf "\033]133;B\007"
}

PS1="%{$(iterm2_prompt_start)%}$PS1%{$(iterm2_prompt_end)%}"

iterm2_precmd() {
  iterm2_after_cmd_executes
}

iterm2_preexec() {
  iterm2_before_cmd_executes
}

[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions iterm2_precmd)

[[ -z $preexec_functions ]] && preexec_functions=()
preexec_functions=($preexec_functions iterm2_preexec)

printf "\033]1337;RemoteHost=$USER@`hostname -f`\007"
printf "\033]1337;CurrentDir=$PWD\007"
printf "\033]1337;ShellIntegrationVersion=1\007"
