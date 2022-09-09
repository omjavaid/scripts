#release_arch=armv7a-linux-gnueabihf

if [ -d "$1" ]; then
  release_path=$1
else
  exit 1
fi

release_path=$1/bin
cc=$release_path/clang
cxx=$release_path/clang++

$cc --version | grep version
$cxx --version | grep version

read -r -p "Are you sure? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        echo "Installing clang as system compiler..."
        ;;
    *)
        exit 1
        ;;
esac

mkdir -p /usr/local/etc/ld.so.conf.d
echo "$release_path/lib" > /usr/local/etc/ld.so.conf.d/clang.conf

cat > /usr/local/bin/cc <<EOF
#!/bin/sh
exec ccache $cc "\$@"
EOF

chmod +x /usr/local/bin/cc

cat > /usr/local/bin/c++ <<EOF
#!/bin/sh
exec ccache $cxx "\$@"
EOF

chmod +x /usr/local/bin/c++
