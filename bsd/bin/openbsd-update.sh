# UPDATING OpenBSD
# The macppc platform does not get updates when the main 3 get updates.
# It never seems to get updates. It looks like a resource issue.

# Base system, like the kernel and ls
doas syspatch

# Manually installed binary packages
doas pkg_add -u

# Firmware
doas fw_update
