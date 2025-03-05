#!/usr/bin/env sh

# Retrieves the current AeroSpace workspace
CURRENT_WORKSPACE=$(aerospace focused-workspace)

# Ensure the workspace name is not empty before updating Sketchybar
if [ -n "$CURRENT_WORKSPACE" ]; then
  echo "$CURRENT_WORKSPACE"
else
  echo "No Workspace"
fi
