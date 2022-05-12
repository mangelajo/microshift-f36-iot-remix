#!/bin/sh

sudo rm -rf .tmp .build-repo .deploy-repo .cache
mkdir .cache .build-repo .deploy-repo .tmp -p
ostree --repo=".build-repo" init --mode=bare-user
ostree --repo=".deploy-repo" init --mode=archive
cp ./.fedora-iot-spec/* .tmp/
cp ./custom/* .tmp/
cat "./.fedora-iot-spec/treecompose-post.sh" "./custom/treecompose-post.sh" > ".tmp/treecompose-post.merged.sh"
chmod +x ".tmp/treecompose-post.merged.sh"
sudo rpm-ostree compose tree --unified-core --cachedir=".cache" --repo=".build-repo" --write-commitid-to="commit-file" ".tmp/treefile.json"
sudo sudo ostree --repo=".deploy-repo" pull-local ".build-repo" "microshift/stable/x86_64"

