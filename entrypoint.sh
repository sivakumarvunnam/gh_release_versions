#!/bin/bash
set -e
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
echo "Release Version: $RELEASE"
# Loop through the list of environments
for ENV in $ENVS; do
  # Perform actions on each environment
  echo "Processing environment: $ENV"
  printf "\n"
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

        # Print the values
        echo "Current Tag: $CURRENT_TAG"
        echo "Release Verison: $RELEASE"

        # Add an if condition to compare the values
        if [ "$CURRENT_TAG" != "$RELEASE" ]; then
          # Perform some action if the values are not equal
          echo "updating $SERVICE version from $CURRENT_TAG to $RELEASE."
          # Perform the sed command
          sed -i "s/$CURRENT_TAG/$RELEASE/g" "$dir/values.yaml"
        else
          # Perform some action if the values are equal
          echo "Values are equal. No action needed."
        fi

        # Add a blank line after the if condition
        printf "\n"
    done
  done
done
