# Winermux 
The script executing windows application in termux.

# Required environment
・Andorid verison: 10～

・CPU: aarch64

・Termux 

・Termux x11

・

# How to install winermux

Execute the command following.

```
pkg update -y && pkg upgrade -y && pkg install curl git -y
```

```
git clone https://github.com/haru87582719/winermux && cd winermux && chmod +x winermux.sh && ./winermux.sh --install
````

# How to fix garbled Japanese characters

1. Edit "$PREFIX/glibc/etc/locale.gen".
2. Remove the # from ja_JP.UTF-8 UTF-8.
3. Execute the command following.

```
cd winermux/locale && chmod +x locale locale-gen && ./locale-gen
```   
4. Execute wine-japanese.reg in regedit.
5. Restart.

# How to Uninstall winermux

Execute the command following.

```
./winermux.sh --remove
```
