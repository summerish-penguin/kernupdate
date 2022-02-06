# kernupdate.sh
A simple shell script to check and run updates for your custom kernel build.\
This script is the automation of my kernel update process, to make it work you need your kernel configuration stored in `/proc/config.gz`. Of course it will not work for building a custom kernel for the first time, also wont work if you didn't make your kernel build relocatable.\
The kernell tarballs will be downloaded into `$HOME/kernel/`. If you don't have such a directory, the scrpit will create it.\
The script checks new version of the "stable" kernel via the kernel.org rss feed, and it asks you if you want to update. If you say y it will start building your new kernel version.\
At line 19, the command is `make -j4`, change accordingly to the number of your threads. I build a kernel with modules and initramfs; if you don't, then you could also remove line 20 and modify line 22.\
Tested on Artix Linux, should work on Arch and its derivatives, and probably on most distros.


Also there is a variant (commented inside the promptme function) for having a dmenu prompt ask you if you want to update.

**Dependencies:**\
wget\
zcat
