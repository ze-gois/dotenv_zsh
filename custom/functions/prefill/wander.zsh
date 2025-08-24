# Widget to prefill the buffer with "wander ARG"
wander-prefill() {
  local arg="$1"
  BUFFER="wander $arg"
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N wander-prefill

# If WANDER_ARG is set in the environment, prefill buffer
if [[ -n "$WANDER_ARG" ]]; then
  zle -F 0 "wander-prefill $WANDER_ARG"
fi
