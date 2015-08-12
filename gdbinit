handle SIGUSR1 nostop noprint
handle SIGUSR2 nostop noprint
handle SIGALRM nostop noprint
handle SIGVTALRM nostop noprint
add-auto-load-safe-path /opt/arm-toolchain/sysroot/lib
add-auto-load-safe-path /opt/arm-toolchain/arm-none-linux-gnueabi/lib

set solib-absolute-prefix /opt/arm-toolchain/sysroot
set solib-search-path .
set debug libthread-db 1
