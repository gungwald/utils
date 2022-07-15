#!/bin/bash
gdbus call \
  --session \
  --dest org.gnome.Shell \
  --object-path /org/gnome/Shell \
  --method org.gnome.Shell.Eval \
  "global.get_window_actors().filter(w=>w.meta_window.has_focus()===false).forEach(w=>w.meta_window.minimize())"
