#!/bin/bash -xe

#SBT
ORG="$org$"
PLUGIN_NAME="$name;format="camel"$"
SCALA_VERSION="$scalaVersion$"
PLUGIN_VERSION="0.1.0-SNAPSHOT"

#PLUGIN
REFRESH="5s"
OUTPUT_DIR="."

#OTHERS
PLUGIN_FILENAME="\$PLUGIN_NAME.\$REFRESH"

COURSIER_REPOSITORIES="ivy2Local|central|sonatype:releases|jitpack|sonatype:snapshots"

rm -rf ~/.ivy2/local/"\$ORG"/"\$PLUGIN_NAME"_"\$SCALA_VERSION"/
PUBLISH_PLUGIN="true" sbt ";clean ;publishLocal"
coursier bootstrap -f -o "\$OUTPUT_DIR"/"\$PLUGIN_FILENAME" --standalone "\$ORG":"\$PLUGIN_NAME"_"\$SCALA_VERSION":"\$PLUGIN_VERSION"
chmod +x "\$OUTPUT_DIR"/"\$PLUGIN_FILENAME"
