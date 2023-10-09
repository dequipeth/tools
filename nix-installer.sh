#!/bin/bash
# This script installs Nix on Fedora Silverblue.
# It must be executed as root.
#
# https://github.com/dnkmmr69420/nix-installer-scripts/blob/main/installer-scripts/silverblue-nix-installer.sh
#
# Thomas DEQUIPE


mkdir /var/lib/nix


echo "Setting SELinux context for /nix and /var/lib/nix"
for path in "" "/var/lib"; do
	semanage fcontext -a -t etc_t $path'/nix/store/[^/]+/etc(/.*)?'
	semanage fcontext -a -t lib_t $path'/nix/store/[^/]+/lib(/.*)?'
	semanage fcontext -a -t systemd_unit_file_t $path'/nix/store/[^/]+/lib/systemd/system(/.*)?'
	semanage fcontext -a -t man_t $path'/nix/store/[^/]+/man(/.*)?'
	semanage fcontext -a -t bin_t $path'/nix/store/[^/]+/s?bin(/.*)?'
	semanage fcontext -a -t usr_t $path'/nix/store/[^/]+/share(/.*)?'
	semanage fcontext -a -t var_run_t $path'/nix/var/nix/daemon-socket(/.*)?'
	semanage fcontext -a -t usr_t $path'/nix/var/nix/profiles(/per-user/[^/]+)?/[^/]+'
done


echo "Creating SSL certificate configuration"
tee /etc/systemd/system/nix-daemon.service.d/override.conf << EOF
[Service]
Environment="NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt"
EOF


echo "Creating /nix mkdir service"
tee /etc/systemd/system/mkdir-rootfs@.service << EOF
[Unit]
Description=Enable mount points in / for ostree
ConditionPathExists=!%f
DefaultDependencies=no
Requires=local-fs-pre.target
After=local-fs-pre.target
[Service]
Type=oneshot
ExecStartPre=chattr -i /
ExecStart=mkdir -p '%f'
ExecStopPost=chattr +i /
EOF


echo "Creating nix.mount service"
tee /etc/systemd/system/nix.mount << EOF
[Unit]
Description=Nix Package Manager
DefaultDependencies=no
After=mkdir-rootfs@nix.service
Wants=mkdir-rootfs@nix.service
Before=sockets.target
After=ostree-remount.service
BindsTo=var.mount
[Mount]
What=/var/lib/nix
Where=/nix
Options=bind
Type=none
EOF


echo "Enabling mounting of /var/lib/nix to /nix and resetting SELinux context"
systemctl daemon-reload
systemctl enable nix.mount
systemctl start nix.mount
restorecon -RF /nix


echo "Temporarily setting SELinux to permissive"
setenforce Permissive


echo "Running the Nix install script"
sleep 5
sh <(curl -L https://nixos.org/nix/install) --daemon --yes
echo "Nix installer has finished running"


echo "Copying service files"
cp -f /nix/var/nix/profiles/default/lib/systemd/system/nix-daemon.{service,socket} /etc/systemd/system/
restorecon -RF /nix
systemctl daemon-reload
systemctl enable --now nix-daemon.socket


echo "Setting SELinux back to enforcing"
setenforce Enforcing


echo "Adding sudo path variables for Nix"
SUDOPATHVARIABLE5=$(printenv PATH)
sleep 1
tee /etc/sudoers.d/nix-sudo-env << EOF
Defaults  secure_path = /nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:$SUDOPATHVARIABLE5
EOF


echo "Modifying configurations"
tee /etc/nix/nix.conf << EOF
experimental-features = nix-command flakes
build-users-group = nixbld
EOF
tee /etc/profile.d/nix-app-icons.sh << EOF
export XDG_DATA_DIRS="\$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share:\$XDG_DATA_DIRS"
export KDEDIRS="\$HOME/.nix-profile:/nix/var/nix/profiles/default:\$KDEDIRS"
EOF


echo "Building Nix package manager"

curl -s https://raw.githubusercontent.com/dnkmmr69420/nix-installer-scripts/main/nix-out-of-default/setup.sh | bash -s /usr/local

echo "Cleaning up"
nix profile remove 0

echo "Linking"
ln -s /nix/var/nix/profiles/default /nix/nix-profile
ln -s /nix/var/nix/profiles/default /var/nix-profile

echo "Making a Nix backup"

sudo mkdir /opt/nb
sudo cp -R /nix /opt/nb

sudo tee /opt/nb/reset-nix <<EOF
#!/bin/bash
sudo echo "Resetting nix..."
sudo rm -rf /nix/*
sudo mkdir -p /nix
sudo cp -R /opt/nb/nix/* /nix/
sudo restorecon -RF /nix
sudo echo "Nix has been reset. Reboot for changes to apply."
EOF

sudo chmod a+x /opt/nb/reset-nix

echo "Reboot your system by typing"
echo "systemctl reboot"
