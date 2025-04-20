#!/bin/bash
# This script bootstraps a project directory, accepting a project name on the command line and creating directories

# Get project name from parameter or use default
project_name=${1:-new_project}

# Create project directory
mkdir -p "$project_name"
echo "Created project directory: $project_name"

# Change to project directory
cd "$project_name"
echo "Changed to directory: $project_name"

# Create subdirectories
mkdir -p _notes
echo "Created directory: _notes"

mkdir -p dev
echo "Created directory: dev"

mkdir -p img
echo "Created directory: img"

mkdir -p snd
echo "Created directory: snd"

echo "Project setup complete!"
