# Handle Linuxbrew
if [[ -d "/home/linuxbrew/.linuxbrew/bin" ]]; then
  path-prepend "/home/linuxbrew/.linuxbrew/bin"
elif [[ -d "$HOME/.linuxbrew/bin" ]]
  path-prepend "$HOME/.linuxbrew/bin"
fi
