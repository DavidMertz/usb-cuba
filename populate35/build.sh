printenv
conda info

TOKEN=ae-3f82bb6b-d33f-43d1-b8f1-a14e2ae1c1ed

pkg_names="$(conda list --canonical --no-pip)"
conda_pkgs_dir="$(conda info 2> /dev/null | grep "package cache" | cut -d: -f2 | tr -d '[[:space:]]')"

pushd $conda_pkgs_dir

conda list --canonical --no-pip --name _build | \
    xargs -t -I{} -n1 -P$CPU_COUNT \
        anaconda --token $TOKEN \
            upload --user aetrial --force --label $PKG_VERSION {}.tar.bz2
