# kernupdate
A simple shell script to check and run updates for your custom kernel build.
This script is the automation of my kernel update process, to make it work you need your kernel configuration stored in /proc/config.gz. Of course it will not work for building a custom kernel for the first time, also wont work if you didn't make your kernel build relocatable.
The script checks new version of the "stable" kernel via the kernel.org rss feed, and it asks you if you want to update. If you say y it will start building your new kernel version.
Tested on Artix Linux, should work on Arch and its derivatives, and probably on most distros.

Dependencies:
wget
zcat
