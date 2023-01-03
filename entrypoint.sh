#!/bin/bash

# Get the current working directory
CWD=$(pwd)

# Print the current working directory
echo "Current working directory: $CWD"

# Set the path to the YAML file
YAML_FILE=$CWD/release_services.yaml

# Extract the release value
RELEASE=$(yq -r .release $YAML_FILE)

# Extract the envs list
ENVS=$(yq -j .envs $YAML_FILE | jq -r '.[]')

# Extract the services list
SERVICES=$(yq -j .services $YAML_FILE | jq -r '.[]')

# Print the values
echo "Release: $RELEASE"
echo "Environments: $ENVS"
# Loop through the list of environments
for ENV in $ENVS; do
  # Perform actions on each environment
  echo "Processing environment: $ENV"
  # Loop through the list of services
  for SERVICE in $SERVICES; do
    # Perform actions on each service
    echo "Processing service: $SERVICE"
    # Set the directory to start the search from
    start_dir="$CWD/avetta/configs/$(echo $ENV | tr -d '"')/$(echo $SERVICE | tr -d '"')"
    # Use the find command to loop through all subdirectories
    find "$start_dir" -type d -print0 | while IFS= read -r -d '' dir; do
        # Perform some action on the current directory
        # For example, you can update a YAML file or run a command
        # Extract the tag value
        CURRENT_TAG=$(yq -r .image.tag $dir/values.yaml)
        # Print the value
        echo "Current Tag: $CURRENT_TAG"
        echo "Release Verison: $RELEASE"
        sed -i "s/$CURRENT_TAG/$RELEASE/g" "$dir/values.yaml"
    done
  done
done
