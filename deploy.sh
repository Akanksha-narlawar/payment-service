#!/bin/bash

JAR_FILE="$1"

echo "Deploying artifact: $JAR_FILE"

if [ ! -f "$JAR_FILE" ]; then
    echo "ERROR: Artifact not found: $JAR_FILE"
    exit 1
fi

echo "Stopping previous application..."

# Add your actual deployment command here
echo "Starting application with: $JAR_FILE"

echo "Deployment completed successfully"