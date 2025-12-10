#!/bin/sh

# Start MinIO in the background
minio server /data --console-address :9001 &
MINIO_PID=$!

# Wait for MinIO to start
sleep 10

mc mb minio/mimir 2>/dev/null || true

# Wait for the background process
wait $MINIO_PID
