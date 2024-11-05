# Winermux 
The script executing windows application in termux.

# Minimum Requirements:
・Andorid 10+  
・[Termux](https://f-droid.org/packages/com.termux/)  
・[Termux:X11](https://github.com/termux/termux-x11/releases)  
・1.8 - 2.0GB of free storage  

# How to install winermux:
Execute the command following.  
```
termux-setup-storage && pkg update -y && pkg upgrade -y && pkg install curl git -y
```
```
git clone https://github.com/haru87582719/winermux && cd ~/winermux && chmod +x winermux.sh && ./winermux.sh --install
```
# How to install wine-mono
・Execute the command following in cmd.exe.
```
wineboot -u
```
# How to fix garbled Japanese characters:

1. Edit "$PREFIX/glibc/etc/locale.gen".  
2. Remove the # from ja_JP.UTF-8 UTF-8.  
3. Execute the command following.  
```
cd ~/winermux/locale && chmod +x locale locale-gen && ./locale-gen
```   
4. Execute wine-japanese.reg in regedit.  

# How to Uninstall winermux
Execute the command following.  
```
./winermux.sh --remove
```
