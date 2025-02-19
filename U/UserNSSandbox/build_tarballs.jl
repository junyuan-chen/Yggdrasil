using BinaryBuilder

name = "UserNSSandbox"
version = v"2022.10.03"

# Collection of sources required to complete build
sources = [
    GitSource("https://github.com/staticfloat/Sandbox.jl.git",
              "da1ccc1017fac4a2a42de98c30a29e337fb06e74"),
]

# Bash recipe for building across all platforms
script = raw"""
cd ${WORKSPACE}/srcdir/Sandbox.jl/deps
mkdir -p ${bindir}
$CC -std=c99 -O2 -static -static-libgcc -g -o ${bindir}/sandbox ./userns_sandbox.c
install_license /usr/share/licenses/MIT
"""

# We only build for Linux
platforms = filter(p -> Sys.islinux(p), supported_platforms())

# The products that we will ensure are always built
products = [
    ExecutableProduct("sandbox", :sandbox),
]

# Dependencies that must be installed before this package can be built
build_tarballs(ARGS, name, version, sources, script, platforms, products, Dependency[]; julia_compat="1.6")
