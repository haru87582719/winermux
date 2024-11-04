#!/data/data/com.termux/files/usr/bin/bash
RED="\033[0;31m"
GRAY="\033[0;37m"
GREEN="\033[0;32m"
NC="\033[0m"
TIME=$(date +%T)

usage() {
  echo "Usage: $0 [options]"
  echo
  echo "Options:"
  echo "  -h, --help       Show this help message"
  echo "  -s, --start      Start Wine"
  echo "  -i, --install    Install Wine (wow64)"
  echo "  -r, --remove     Remove Wine"
  echo "  -v  --version    Show version"
  echo
  exit 1
}

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)
      usage
      ;;
    -s|--start)
winedesktop() {
	export XDG_RUNTIME_DIR=${TMPDIR}
	export DISPLAY=:0
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Starting Termux-x11 ..."
	termux-x11 :0 &
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Starting Pulseaudio ..."
	pulseaudio --verbose --start --exit-idle-time=-1 --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1"
	am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity
	unset LD_PRELOAD
	export GLIBC_PREFIX=/data/data/com.termux/files/usr/glibc
	export PATH=$GLIBC_PREFIX/bin:$PATH
	export BOX64_PATH=$PREFIX/glibc/opt/wine/bin/
	export BOX64_LD_LIBRARY_PATH=$GLIBC_PREFIX/opt/wine/lib/i386-unix/:$GLIBC_PREFIX/glibc/opt/wine/lib/wine/x86_64-unix/:/lib/i386-linux-gnu/:/lib/x86_64-linux-gnu:/lib/aarch64-linux-gnu/:/lib/arm-linux-gnueabihf/:$PREFIX/glibc/lib/
	export PULSE_SERVER=127.0.0.1
	export WINEPREFIX=$GLIBC_PREFIX/opt/.wine
	DISPLAY=:0 LC_ALL=ja_JP.utf8 taskset -c 2-3 box64 $GLIBC_PREFIX/opt/wine/bin/wine explorer /desktop=shell,1280x800 cmd > /sdcard/wine_log.txt 2>&1
	pkill -f pulseaudio
	pkill -f app_process
	exit 0
}
	export GLIBC_PREFIX=/data/data/com.termux/files/usr/glibc
	if [ -d "$GLIBC_PREFIX/opt/wine" ]; then
	if [ -d "$GLIBC_PREFIX/opt/.wine" ]; then
	winedesktop

	else
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Setting up wine prefix ..."
	unset LD_PRELOAD
	export GLIBC_PREFIX=/data/data/com.termux/files/usr/glibc
	export PATH=$GLIBC_PREFIX/bin:$PATH
	export WINEPREFIX=$GLIBC_PREFIX/opt/.wine
	box64 $GLIBC_PREFIX/opt/wine/bin/wine wineboot > /dev/null 2>&1
	winedesktop
	exit
	fi
	else
	echo -e  "${GRAY}[$TIME]${RED}[Error]${GRAY}: Wine is not installed."
	exit 0
	fi
     ;;
    -i|--install)
	export GLIBC_PREFIX=/data/data/com.termux/files/usr/glibc
	if [ -d "$GLIBC_PREFIX/opt/wine" ]; then
        echo -e "${GRAY}[$TIME]${RED}[Error]${GRAY}: Wine is already installed."
        exit 0
	else
	export GLIBC_PREFIX=/data/data/com.termux/files/usr/glibc
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Installing package ..."
	pkg install pulseaudio glibc-repo x11-repo tur-repo wget curl nano -y > /dev/null 2>&1
	pkg install termux-x11-nightly termux-am -y > /dev/null 2>&1
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Installing glibc packages ..."
	pkg install freetype-glibc fontconfig-glibc libxext-glibc libxinerama-glibc libxxf86vm-glibc libxrender-glibc libxcomposite-glibc libxrandr-glibc libxi-glibc libxcursor-glibc vulkan-tools-glibc box64-glibc pulseaudio-glibc libgnutls-glibc -y > /dev/null 2>&1
        pkg clean
install_wine(){
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Downloading wine.tar.xz ..."
	wget -q --show-progress https://github.com/Ilya114/Box64Droid/releases/download/alpha/wine-9.13-glibc-amd64-wow64.tar.xz -O $GLIBC_PREFIX/opt/wine.tar.xz
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Extracting wine.tar.xz ..."
	tar -xf $GLIBC_PREFIX/opt/wine.tar.xz -C $GLIBC_PREFIX/opt/
        EXTRACTED_FOLDER=$(tar -tf "$GLIBC_PREFIX/opt/wine.tar.xz" | head -1 | cut -d "/" -f 1)
	if [ -d $GLIBC_PREFIX/opt/$EXTRACTED_FOLDER ]; then
	mv $GLIBC_PREFIX/opt/$EXTRACTED_FOLDER $GLIBC_PREFIX/opt/wine
	fi
}
	if [ -d $GLIBC_PREFIX/opt ]; then
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: $GLIBC_PREFIX/opt is already created."
	install_wine
	else
	mkdir $GLIBC_PREFIX/opt
	install_wine
	fi
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Deleting wine.tar.xz"
	rm $GLIBC_PREFIX/opt/wine.tar.xz
	fi
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Install successful."
        exit 0

      ;;
    -r|--remove)
	export GLIBC_PREFIX=/data/data/com.termux/files/usr/glibc
	echo -e -n "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Do you remove wine? [Y/n]: "
	read ANS

	case $ANS in
	  "" | [Yy]* )
	if [ -d $GLIBC_PREFIX/opt/wine ]; then
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Removing wine prefix ..."
	rm -rf $GLIBC_PREFIX/opt/.wine
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Removing wine directory ..."
	rm -rf $GLIBC_PREFIX/opt/wine
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Removing glibc directory ..."
	pkg uninstall freetype-glibc fontconfig-glibc libxext-glibc libxinerama-glibc libxxf86vm-glibc libxrender-glibc libxcomposite-glibc libxrandr-glibc libxi-glibc libxcursor-glibc vulkan-tools-glibc box64-glibc pulseaudio-glibc libgnutls-glibc -y > /dev/null 2>&1
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Remove successful."
	else
	echo -e "${GRAY}[$TIME]${RED}[Error]${GRAY}: Wine is not installed."
	fi
	exit 0
	    ;;
	  * )
	    
	exit 0
	    ;;
	esac
      ;;
   -v|--version)
	echo -e "${GRAY}[$TIME]${GREEN}[Information]${GRAY}: Version: 1.0.0"
	exit 0
	;;

    *)
      echo -e "${GRAY}[$TIME]${RED}[Error]${GRAY}: Unknown option: $1"
      usage
      ;;
  esac
done
usage
