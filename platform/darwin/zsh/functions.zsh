# Change working directory to the top-most Finder window location
cdf() { # short for `cdfinder`
  cd "$(finder-path)"
}

# flash log tail function
fl() {

  ERRORREPORT="ErrorReportingEnable=1"
  TRACEOUTPUT="TraceOutputFileEnable=1"
  NODIALOGS="SuppressDebuggerExceptionDialogs=1"
  CONFIGDIR="/Library/Application Support/Macromedia"
  CONFIGFILE="$CONFIGDIR/mm.cfg"
  CONFIGWARNING="Some Flash debug configuration is missing. Please enter your password to have it automatically configured:"

  if [[ ! -d "$CONFIGDIR" ]]; then
    sudo -p "$CONFIGWARNING" mkdir -p "$CONFIGDIR"
  fi

  # Enable Error Reporting
  if ! grep -Fxq "$ERRORREPORT" "$CONFIGFILE"; then
    echo "$ERRORREPORT" | sudo -p "$CONFIGWARNING" tee -a "$CONFIGFILE" >/dev/null
  fi

  # Enable Trace Output
  if ! grep -Fxq "$TRACEOUTPUT" "$CONFIGFILE"; then
    echo "$TRACEOUTPUT" | sudo -p "$CONFIGWARNING" tee -a "$CONFIGFILE" >/dev/null
  fi

  # Do not show dialogs
  if ! grep -Fxq "$NODIALOGS" "$CONFIGFILE"; then
    echo "$NODIALOGS" | sudo -p "$CONFIGWARNING" tee -a "$CONFIGFILE" >/dev/null
  fi

  clear
  tail -f -n 200 ~/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt

}
