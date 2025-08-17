#
# ~/.bash_profile
#!/bin/bash
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/dpinto/.lmstudio/bin"
