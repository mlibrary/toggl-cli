#!/bin/bash

# First figure out where we're being run from
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

PYTHON_DIR="$(dirname "$DIR")/python"

# This assumes that there's a structure like:
# .../bin/toggl.sh      <- This file goes here.
# .../python/pip        <- python/pip dependencies installed here.
# .../python/toggl-cli  <- https://github.com/mlibrary/toggl-cli
# ... may be anything.  Maybe /usr/local.  Maybe ~, maybe something else entirely.

PYTHONPATH="$PYTHON_DIR/pip" \
PYTHONIOENCODING="utf-8" \
  /usr/bin/python \
    "$PYTHON_DIR/toggl-cli/toggl.py" \
    "$@"

