#!/bin/sh

# Start MinIO in the background
minio server /data --console-address :9001 &
MINIO_PID=$!

# Wait for MinIO to start
sleep 10

# Create the mimir bucket (suppress error if it already exists)
until mc alias set minio http://localhost:9000 mimir supersecret; do
  echo "Waiting for MinIO to be ready..."
  sleep 2
done

mc mb minio/mimir 2>/dev/null || true

# Wait for the background process
wait $MINIO_PID
