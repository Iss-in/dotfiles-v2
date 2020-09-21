#!/bin/bash
clear

install () {

 /usr/bin/yay -S zsh kitty vscodium-bin vlc conky-cairo brave-bin fontforge-git  \
        font-manager lxappearance gcalcli genius-spicetify-git indicator-kdeconnect-git \
         kunst-git libinput-gestures n30f-git picom-ibhagwan-git viewnior xorg-xrandr gvfs-gphoto2 gvfs-mtp \
        polybar siji-git skippy-xd-git spicetify-cli spotify themix-full-git android-tools firefox \
        xcolor yaru-icon-theme ncmpcpp mpd neofetch python-pip xpad python-nautilus xdo xdotool xcape\
        network-manager-applet redshift-gtk-git transmission-gtk glava numlockx gimp linux-headers imagemagick \
        polkit polkit-gnome jdk-openjdk virtualbox virtualbox-guest-iso virtualbox-host-modules-arch sshfs  bitwarden-bin gtk3-nocsd-git 

    sudo -u $SUDO_USER  pip install --user pywal spotdl 
    echo "setting polkit permissions......."
    echo '/* Allow members of the wheel group to execute any actions
    * without password authentication, similar to "sudo NOPASSWD:"
    */
    polkit.addRule(function(action, subject) {
        if (subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });' > /etc/polkit-1/rules.d/49-nopasswd_global.rules

    echo 'polkit.addRule(function(action, subject) {
    var YES = polkit.Result.YES;
    // NOTE: there must be a comma at the end of each line except for the last:
    var permission = {
        // required for udisks1:
        "org.freedesktop.udisks.filesystem-mount": YES,
        "org.freedesktop.udisks.luks-unlock": YES,
        "org.freedesktop.udisks.drive-eject": YES,
        "org.freedesktop.udisks.drive-detach": YES,
        // required for udisks2:
        "org.freedesktop.udisks2.filesystem-mount": YES,
        "org.freedesktop.udisks2.encrypted-unlock": YES,
        "org.freedesktop.udisks2.eject-media": YES,
        "org.freedesktop.udisks2.power-off-drive": YES,
        // required for udisks2 if using udiskie from another seat (e.g. systemd):
        "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
        "org.freedesktop.udisks2.filesystem-unmount-others": YES,
        "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
        "org.freedesktop.udisks2.eject-media-other-seat": YES,
        "org.freedesktop.udisks2.power-off-drive-other-seat": YES
    };
    if (subject.isInGroup("storage")) {
        return permission[action.id];
    }
    });' > /etc/polkit-1/rules.d/50-udiskie.rules

}

bluetooth () {
    cp /etc/pulse/default.pa /etc/pulse/default.pa.bak
    sudo -u $SUDO_USER yay -S alsa-utils alsa-firmware pulseaudio pulseaudio-bluetooth pulseaudio-alsa bluez bluez-utils pavolume-git
    echo -e "\nload-module module-switch-on-connect" >> /etc/pulse/default.pa 
    sed -i "s|#AutoEnable=false|AutoEnable=true|" "/etc/bluetooth/main.conf" 
    sed -i "s|#DiscoverableTimeout = 0|DiscoverableTimeout = 0|" "/etc/bluetooth/main.conf" 
    systemctl enable bluetooth.service
    systemctl start bluetooth.service
    sudo -u $SUDO_USER pulseaudio -k
    sudo -u $SUDO_USER pulseaudio -D

}
install_zsh () { 
    user=$(sudo -u $SUDO_USER whoami)
    rm -f /home/$user/.oh-my-zsh
    sudo -u $SUDO_USER  chsh -s /usr/bin/zsh
    sudo -u $SUDO_USER  gpasswd -a $user input
    sudo -u $SUDO_USER  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # sudo -u $SUDO_USER  sed -i "/^plugins=/s/)$/ zsh-syntax-highlighting zsh-autosuggestions history-substring-search )/" /home/$user/.zshrc
    sudo -u $SUDO_USER  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$user/.oh-my-zsh/plugins/zsh-syntax-highlighting
    sudo -u $SUDO_USER  git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/$user/.oh-my-zsh/plugins/zsh-autosuggestions
    ## download .zsh from your git 
    echo "unmuting devices"
    amixer sset Master unmute
    amixer sset Speaker unmute
    amixer sset Headphone unmute

}

autologin () {
    user=$(sudo -u $SUDO_USER whoami)
    mkdir -p "/etc/systemd/system/getty@tty1.service.d"
    echo '[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin' $user '--noclear %I $TERM' > "/etc/systemd/system/getty@tty1.service.d/override.conf"
}

silent_boot () {
    user=$(sudo -u $SUDO_USER whoami)
    sudo -u $SUDO_USER yay -S grub-silent
    touch ~/.hushlogin
    #edit getty override conf
    # sudo -u $SUDO_USER echo "[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null" > /home/$user/.zprofile
    echo "kernel.printk = 3 3 3 3" > /etc/sysctl.d/20-quiet-printk.conf
    sed -i /^HOOKS=/s/udev/systemd/ /etc/mkinitcpio.conf
    mkinitcpio -p
    # systemctl edit --full systemd-fsck-root.service
    # systemctl edit --full systemd-fsck@.service
    #add 
    # StandardOutput=null
    # StandardError=journal+console
    grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
}

delete_swap () {
    swapoff /swapfile
    rm -f /swapfile
    sed -i '/swapfile/d' /etc/fstab
    echo "swapfile deleted"
}
create_swap () {
    FILE="/swapfile"
    if [ -f "$FILE" ]; then
        echo "swap file already exist , deleting the current swapfile..."
        delete_swap
    fi
    echo "creating a new swapfile..."
    dd if=/dev/zero of=/swapfile bs=1M count=8192 status=progress
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile none swap defaults 0 0" >>  /etc/fstab
    echo "swapfile created"
}

hibernate () {
    partition="\/dev\/$(lsblk | awk '/part [/]$/{print $1}'  | sed 's/^.\{2\}//')"
    grub="/etc/default/grub"
    resume_offset="$(filefrag -v /swapfile | awk 'NR == 4 {print $4}' | sed 's/.\{2\}$//')"
    echo $resume_offset > /sys/power/resume_offset
    sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/s/ resume=[\/][a-z]*[\/][a-z]*[0-9]*//" "$grub"
    sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/s/\"$/ resume=${partition}\"/" "$grub"
    echo "added boot partition address"

    sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/s/ resume_offset=[[:digit:]]*//" "$grub"
    sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/s/\"$/ resume_offset=${resume_offset}\"/" "$grub"
    echo "added boot partition location"

    if ! grep -q "resume"  /etc/mkinitcpio.conf
    then 
        sed -i "/^HOOKS/s/)$/ resume)/" "mkinitcpio.conf" "/etc/mkinitcpio.conf"
        echo "adding resume HOOK"
        mkinitcpio -P
    fi
    update-grub
    echo "blacklist nouveau" > /etc/modprobe.d/modprobe.conf 

}


echo "making  a full update before proceding"
sudo -u $SUDO_USER yay -Syuu
# read -p "$(echo -e '\nCreate swap file? y/N (default:N)') " choice
# if [[ $choice == "y" ]];then
#     create_swap
# else
#     echo "skipping swap creation, moving onto next....."
# fi

# read -p "$(echo -e '\nEnable Hibernate? y/N (default:N)') " choice
# if [[ $choice == "y" ]];then
#     hibernate
# else
#     echo "skipping hibernate, moving onto next....."
# fi


# read -p "$(echo -e '\nInstall User applications? y/N (default:N)') " choice
# if [[ $choice == "y" ]];then
#     install
# else
#     echo "skipping installation of user apps, moving onto next....."
# fi

# read -p "$(echo -e '\nInstall Oh-My-Zsh? y/N (default:N)') " choice
# if [[ $choice == "y" ]];then
#     install_zsh
# else
#     echo "skipping installation of user apps, moving onto next....."
# fi


# read -p "$(echo -e '\nEnable Bluetooth? y/N (default:N)') " choice
# if [[ $choice == "y" ]];then
#     bluetooth
# else
#     echo "skipping bluetooth installation , moving onto next....."
# fi


# read -p "$(echo -e '\nEnable autologin? y/N (default:N)') " choice
# if [[ $choice == "y" ]];then
#     autologin
# else
#     echo "skipping bluetooth installation , moving onto next....."
# fi


# read -p "$(echo -e '\nEnable silent boot? y/N (default:N)') " choice
# if [[ $choice == "y" ]];then
#     silent_boot
# else
#     echo "skipping bluetooth installation , moving onto next....."
# fi




 
# read -p "$(echo -e '\nEnable Touchpad tap? y/N (default:N)') " choice
# if [[ $choice == "y" ]];then
#     sudo -u $SUDO_USER yay -S xf86-input-libinput
#     echo "enabling touchpad tap..."
#     echo 'Section "InputClass"
#         Identifier "touchpad"
#         Driver "libinput"
#         MatchIsTouchpad "on"
#         Option "Tapping" "on"
#         Option "TappingButtonMap" "lmr"
#     EndSection' > /etc/X11/xorg.conf.d/30-touchpad.conf 
# fi

#### setting defaulr browser  #########
# sudo -u $SUDO_USER xdg-mime default firefox.desktop x-scheme-handler/http
# sudo -u $SUDO_USER xdg-mime default firefox.desktop x-scheme-handler/https  

main () {
    read -p "$(echo -e '\n press 
    1) to Enable Swap file and Hibernate 
    2) to Enable bluetooth services 
    3) to Enable silent boot and plymouth 
    4) to install oh-my-zsh 
    5) to Enable Touchpad tap 
    6) to Install default user apps 
    0) to exit
    ')" choice
    case $choice in
        0)  echo "exiting.... "
            exit 1 ;;
        1)  delete_swap 
            create_swap
            hibernate
            main ;;
        2) echo 2
        ;;
        3) echo 3
        ;;
        4) echo 4
        ;;
        5) echo 5
        ;;
        6) echo 6
        ;;
        *) main ;;
        default) echo -n "unknown"
        ;;
    esac

}
main

