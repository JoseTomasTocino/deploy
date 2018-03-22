Fresh install of Kubuntu 17.10 on desktop environment.

# Slow startup 
Right after installing the Nvidia proprietary driver the boot got quite slow and the mobo beeped. Two problems were to blame:

## Weird problems with graphic mode

Checking `dmesg` showed the following halt point:

    [    3.572204] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready    
    [   28.060038] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [nvidia-smi:471]
    

[This post](https://askubuntu.com/questions/929817/nmi-watchdog-bug-soft-lockup-cpu2-stuck-for-23s-nvidia-smi566/934850#934850) suggested adding `nomodeset` or `modprobe.blacklist=nouveau` to existing kernel parameters in grub, so I edited the file `/etc/default/grub`, and changed the `GRUB_CMDLINE_LINUX_DEFAULT` line to this 

    GRUB_CMDLINE_LINUX_DEFAULT="nomodeset quiet splash"
    
## Networking services 

Using `systemd-analyze` I could see there were a couple of services related to networking that were taking too long to start. In particular, `systemd-resolved` was taking forever. It could be easily diagnosed by generating a plot of the services that were loading:

    systemd-analyze plot > plot.svg
    google-chrome plot.svg
    
Followed [this blog post](https://blobfolio.com/2017/05/fix-linux-dns-issues-caused-by-systemd-resolved/) to solve the issue. Esentially, it involves disabling systemd-resolved:

    sudo systemctl stop systemd-resolved
    sudo systemctl disable systemd-resolved
    
Then installing and configuring `unbound`:

    sudo apt-get install unbound
    sudo systemctl enable unbound-resolvconf
    sudo systemctl enable unbound
    
Also, NetworkManager's config file had to be modified, at `/etc/NetworkManager/NetworkManager.conf`, adding `dns=unbound` to the `[main]` section.

# Grub problem: no symbol table

After fixing the aforementioned problems, a new one appeared. Right after choosing the boot option in grub, an error message appeared saying "No symbol table". Apparently [it's a bug in Grub](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1633839) and was easily repaired by reinstalling it on the disk using:

    sudo grub-reinstall /dev/sda
    sudo update-grub
    sudo reboot
    
# Minor settings    

## Playback at headphones and speakers at the same time

Disable `auto-mute` on alsamixer:

    alsamixer -c 1

Then store the settings:

    sudo alsactl store
