#!/bin/bash -xe

#SBT
ORG="$org$"
PLUGIN_NAME="$name;format="camel"$"
SCALA_VERSION="$scalaVersion$"
PLUGIN_VERSION="$version$"

#PLUGIN
REFRESH="$refreshInterval$"
PLUGIN_FILENAME="\$PLUGIN_NAME.\$REFRESH"
PLUGINS_DIR="."
PLUGIN_PATH="\$PLUGINS_DIR"/"\$PLUGIN_FILENAME"
META_PATH="./src/main/resources/meta.txt"

# ----------- PUBLISHING PLUGIN -------------------------
rm -rf ~/.ivy2/local/"\$ORG"/"\$PLUGIN_NAME"_"\$SCALA_VERSION"/
sbt "publishLocal"
cs bootstrap -f -o "\$PLUGIN_PATH" --standalone "\$ORG":"\$PLUGIN_NAME"_"\$SCALA_VERSION":"\$PLUGIN_VERSION"
chmod +x "\$PLUGIN_PATH"
# ----------- PUBLISHING PLUGIN END ---------------------


# ----------- PUBLISHING METADATA -----------------------
xattr -w "com.ameba.SwiftBar" \$(cat "\$META_PATH" | base64) "\$PLUGIN_PATH"
# ----------- PUBLISHING METADATA END -------------------
