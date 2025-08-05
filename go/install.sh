#!/bin/sh
#
# Go
#
# This installs some of the common dependencies needed (or at least desired)
# using Go.

# Check for Go
if (( $+commands[go] ))
then
  echo "  Installing Go packages for you."

  go telemetry off

  go install go.uber.org/mock/mockgen@latest
  go install github.com/newonton/duration@latest
fi

exit 0
