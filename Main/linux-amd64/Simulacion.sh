#!/bin/sh

APPDIR=$(readlink -f "$0")
APPDIR=$(dirname "$APPDIR")
$APPDIR/java/bin/java -Djna.nosys=true -Djava.library.path="$APPDIR:$APPDIR/lib" -cp "$APPDIR:$APPDIR/lib/Main.jar:$APPDIR/lib/core.jar:$APPDIR/lib/gluegen-rt.jar:$APPDIR/lib/jogl-all.jar:$APPDIR/lib/controlP5.jar" Main "$@"
