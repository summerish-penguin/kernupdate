#!/bin/sh

# looking for a new stable release via the kernel.org rss feed
NewVer=$(wget -q -O- "https://www.kernel.org/feeds/kdist.xml" | grep "stable" | head -1 | grep -o -P '.{0}title.{0,8}' | head -1 | cut -d ">" -f 2 | cut -d ":" -f 1)
CurVer=$(uname -r)

SumNewVer=$(echo "$NewVer" | tr -d ".")
SumCurVer=$(echo "$CurVer" | tr -d ".")

# actual kernel installing
dothejob () {
[[ -d $HOME/kernel ]] || mkdir $HOME/kernel
cd $HOME/kernel/
wget "https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$NewVer.tar.xz" 
tar -xvJf linux-$NewVer.tar.xz
cd linux-$NewVer/
make mrproper 
zcat /proc/config.gz > .config
make -j$(nproc)
sudo make modules_install 
sudo cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-linux$SumNewVer 
sudo mkinitcpio -k $NewVer -g /boot/initramfs-linux$SumNewVer.img 
sudo cp System.map /boot/System.map-linux$SumNewVer 
sudo grub-mkconfig -o /boot/grub/grub.cfg 
cd
printf "Kernel updated to $NewVer\!"
}

# Question prompt
promptme () {
# Here commented a variant with a dmenu prompt
#Prompt=$(echo -e "yes\nno" | dmenu -c -l 2 -p "New kernel available, install it?")
#case $Prompt in 
	#yes) dothejob;;
	#no) exit;;
#esac
printf "New kernel available ($NewVer), do you want to update? [Y/n] "
read Answer
case $Answer in 
	n) exit;;
	*) dothejob;;
esac
}

# if a new version is available, prompt me
if [[ "$SumNewVer" -gt "$SumCurVer" ]]; then
	promptme
else
	printf "You are currently at the newest version!\n"
fi


