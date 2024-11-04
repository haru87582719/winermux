# winermux
Wine execute in termux

```
git clone https://github.com/gesuto139/winermux && cd winermux && chmod +x winermux && ./winermux --install
````

# How to fix garbled Japanese characters

1. Edit "$PREFIX/glibc/etc/locale.gen".
2. Remove the # from ja_JP.UTF-8 UTF-8.
3. Execute the command following.

```
cd winermux/locale && chmod +x locale locale-gen
```   

