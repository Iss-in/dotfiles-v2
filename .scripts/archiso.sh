#!/bin/bash
cp -r /usr/share/archiso/configs/releng/ archlive
cd archlive

## add aur
aur_repo=${PWD}/var/lib/pacman/aur
cat << EOF >> pacman.conf
[AUR]
SigLevel = Optional TrustAll
Server = file://${aur_repo}
EOF


## add pacman packages
cat << EOF >> packages.x86_64
terminus-font
htop
zsh-autosuggestions
zsh-history-substring-search
zsh-syntax-highlighting
kitty
EOF


# build and add AUR packages
mkdir -p ${aur_repo}
echo "copy all packages to aur_repo "
echo "add all package name to packages.x86_64"
read -p "$(echo -e '\nProceed? y/N (default:N)') " choice
if [[ $choice == "y" ]];then
    install
repo-add ${aur_repo}/AUR.db.tar.gz ${aur_repo}/*.pkg.*

# enable pacman colors
sed -i 's|^#Color|Color|' pacman.conf

# set timezone
sed -i 's|zoneinfo/UTC|zoneinfo/Asia/Kolkata|' airootfs/root/customize_airootfs.sh

cat << EOF >  airootfs/etc/vconsole.conf
FONT=ter-116n
EOF

# add dotfiles
curl -Ls https://github.com/nicoulaj/dotfiles/archive/master.tar.gz | tar xvz -C airootfs/root/ --strip-components=1
