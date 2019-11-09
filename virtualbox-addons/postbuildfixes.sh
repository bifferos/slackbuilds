
# WTF is this doing there?
rm -Rf VBox.log
# Probably shouldn't uninstall using this script
rm -Rf usr/sbin/vbox-uninstall-guest-additions
# Going to run depmod to hopefully make these
rm -Rf lib/modules/*/modules.*
# Why does slacktrack not exclude dev/? 
rm -Rf dev/vboxuser
rm -Rf dev/vboxguest
# Clean up useradd, groupadd
rm -Rf etc/*group* etc/*shadow* etc/*passwd* 


cat >> install/doinst.sh <<- ENDENDENDEND
# Plagiarised straight from the virtualbox-kernel slackbuild, thanks Heinz.
chroot . /sbin/depmod -a @KERNEL@
# Pasted straight from the vbox install script, to make up for the etc/
# removals above.
groupadd -r -f vboxsf >/dev/null 2>&1
useradd -d /var/run/vboxadd -g 1 -r -s /bin/false vboxadd >/dev/null 2>&1 || true
useradd -d /var/run/vboxadd -g 1 -u 501 -o -s /bin/false vboxadd >/dev/null 2>&1 || true
ENDENDENDEND
