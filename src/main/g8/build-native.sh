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
TEMP_PLUGIN_PATH="./$PLUGIN_FILENAME"
JAR_PATH="/tmp/$PLUGIN_NAME.jar"

# ----------- PUBLISHING ARTIFACT -------------------------
rm -rf ~/.ivy2/local/"$ORG"/"$PLUGIN_NAME"_"$SCALA_VERSION"/
sbt "publishLocal"
# ----------- PUBLISHING ARTIFACT END ---------------------

# ------------------ NATIVE -------------------------
rm -f "$JAR_PATH"
#Create fat JAR
coursier bootstrap -f -o "$JAR_PATH" --assembly "$ORG":"$PLUGIN_NAME"_"$SCALA_VERSION":"$PLUGIN_VERSION" --preamble=false
#Generate assistive data using agent
java -agentlib:native-image-agent=config-output-dir=./src/main/resources/META-INF/native-image/ -jar "$JAR_PATH"
#Make native image
rm -f "$TEMP_PLUGIN_PATH"
native-image --no-fallback -jar "$JAR_PATH" "$TEMP_PLUGIN_PATH"
chmod +x "$TEMP_PLUGIN_PATH"
mv "$TEMP_PLUGIN_PATH" "$PLUGIN_PATH"
# ---------------- NATIVE END ------------------------

# ----------- PUBLISHING METADATA -----------------------
xattr -w "com.ameba.SwiftBar" $(cat "$META_PATH" | base64) "$PLUGIN_PATH"
# ----------- PUBLISHING METADATA END -------------------