#!/bin/sh

PRODUCT="mb"
MB_NODE="mb-node"

MB_PORT="3002"
CARGO_PORT="8282"
CARGO_HOST="10.25.31.4"

MISYSBOARD_NODE_REPO="misysboard-node"
MB_COMPONENTS_REPO="misysboard_components"
MB_REPO="misysboard_node"
MB_DEPLOY_REPO="misysboard_deployment"
MB_MODELS_REPO="misysboard_models"

DEPLOY_PATH="deploy"
DEPLOY_DIR="$DEPLOY_PATH/$MISYSBOARD_NODE_REPO/$PRODUCT"
MB_NODE_TEMP_DIR="build/"


SWAG_DIR="misysboard-swag"
COMPONENTS_DIR="components"
LIBS_DIR="libs"
SETTINGS_DIR="settings"
MODEL_DIR="model"
USERS_DIR="data/users"
ADDONS_DIR="addons"
SERVICES_DIR="services"
DIST_DIR="dist"

MB_NODE_DIR="$DEPLOY_DIR/$MISYSBOARD_NODE_REPO"
MB_NODE_USERS_DIR="$MB_NODE_DIR/$USERS_DIR"

DEFAULT_FOLDER_NAME="_default"
DEFAULT_CONF_NAME="conf.json"
DEFAULT_PACKAGE_NAME="mb-package.json"
MB_NODE_ZIP="$MISYSBOARD_NODE_REPO.zip"
ROOT_MB_PACKAGE="root-mb-package.json"

STASH_MAFUI="https://lleblay@scm-git-eur.misys.global.ad/scm/mafui"
STASH_MB_COMPONENTS="$STASH_MAFUI/$MB_COMPONENTS_REPO.git"
STASH_MB_DEPLOY="$STASH_MAFUI/$MB_DEPLOY_REPO.git"
STASH_MB="$STASH_MAFUI/$MB_REPO.git"

VAR_CARGO_PORT="CARGO_PORT"
VAR_CARGO_HOST="CARGO_HOST"
VAR_VIRTUAL_PREFIX="VIRTUAL_PREFIX"

JAVA_BS="src/resources"

GIT_ARGS=" --depth 1"
GIT_BRANCH="1.0.0-M6"

step() {
    echo ""
    echo "------------------------------------------------------------------------------"
    echo ""
    echo $1
}

echo&Launch () {
    echo ""
    printf "$ $1"
    $1
}


step "REMOVE EXISTING TEMP FILES"
echo&Launch "rm -rf ${MB_NODE_TEMP_DIR}"
echo&Launch "mkdir ${MB_NODE_TEMP_DIR}"

step "TRANSFER MISYSBOARD NODE"
echo&Launch "cd $MB_NODE_TEMP_DIR"
echo&Launch "wget http://bm-artifacts.misys.global.ad/maven/content/groups/public/com/trmsys/misysboard/misysboard-node/1.0.0-M6/misysboard-node-1.0.0-M6.zip -O misysboard-node-1.0.0-M6.zip"
echo&Launch "unzip -qq misysboard-node-1.0.0-M6.zip -d $MISYSBOARD_NODE_REPO"

step "CLONE DEPS"
git config --global http.sslverify false
echo&Launch "git clone $STASH_MB_COMPONENTS $GIT_ARGS"
echo&Launch "git clone $STASH_MODELS $GIT_ARGS;"
echo&Launch "cd $MB_COMPONENTS_REPO"
echo&Launch "git checkout $GIT_BRANCH"
echo&Launch "npm install"
echo&Launch "grunt half-build"
echo&Launch "cd .."
echo&Launch "cp -r $MB_COMPONENTS_REPO/$DIST_DIR/* $MISYSBOARD_NODE_REPO/$ADDONS_DIR/"
echo&Launch "cd $MB_MODELS_REPO"
echo&Launch "git checkout $GIT_BRANCH"

exit 0
