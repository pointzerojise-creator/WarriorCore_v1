#!/bin/sh
# Build WarriorCore. Requires JDK 17+ and Maven.
set -e
mvn -q package
echo "Built: target/WarriorCore-1.0.0.jar"
