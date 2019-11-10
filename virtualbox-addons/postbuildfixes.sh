
# Lose the log
rm -Rf VBox.log
# Probably shouldn't uninstall using this script
rm -Rf usr/sbin/vbox-uninstall-guest-additions
# Going to run depmod to hopefully make these
rm -Rf lib/modules/*/modules.*
# Device files will be generated 
rm -Rf dev
# Clean up useradd, groupadd
rm -Rf etc/*group* etc/*shadow* etc/*passwd* 


mkdir -p install

cat >> install/doinst.sh <<- ENDENDENDEND

echo "running depmod"
chroot . /sbin/depmod -a
# Pasted straight from the vbox install script, to make up for the etc/
# removals above.
echo "Adding vboxsf group"
groupadd -r -f vboxsf >/dev/null 2>&1
echo "Adding vboxadd user"
useradd -d /var/run/vboxadd -g 1 -r -s /bin/false vboxadd >/dev/null 2>&1 || true
useradd -d /var/run/vboxadd -g 1 -u 501 -o -s /bin/false vboxadd >/dev/null 2>&1 || true
# Load the kernel modules
/etc/rc.d/init.d/vboxadd start
# Start the service
/etc/rc.d/init.d/vboxadd-service start
ENDENDENDEND

chmod 755 install/doinst.sh
