set -e
set -u
set -x

source $SRC_DIR/env

printenv
conda info

pkg_names="$(conda list --canonical --no-pip)"
conda_pkgs_dir="$(conda info 2> /dev/null | grep "package cache" | cut -d: -f2 | tr -d '[[:space:]]')"

pushd $conda_pkgs_dir

conda list --canonical --no-pip --name _build | \
    xargs -t -I{} -n1 -P$CPU_COUNT \
        anaconda --token $TOKEN \
            upload --user aetrial --force --label $PKG_VERSION {}.tar.bz2 >/dev/null 2>&1
