#!/bin/bash
set -e
 
DOCKERHUB_REPO="sabula/codeaws"
IMAGE_TAG="latest"
CONTAINER_NAME="confident_volhard"
 
echo "Pulling latest Docker image..."
docker pull $DOCKERHUB_REPO:$IMAGE_TAG
 
echo "Stopping old container if running..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true
 
echo "Starting new container..."
docker run -d -p 8080:8080 --name $CONTAINER_NAME $DOCKERHUB_REPO:$IMAGE_TAG
 
echo "Deployment finished successfully!"