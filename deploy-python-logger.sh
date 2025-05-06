#!/bin/bash

# === CONFIG ===
PROJECT_NAME="logging-demo"
APP_NAME="python-logger"
GIT_REPO_URL="https://github.com/atreyvus/python-logger.git"  # Replace with your repo
PYTHON_IMAGE="registry.access.redhat.com/ubi8/python-39"

# === 1. Create project ===
oc new-project $PROJECT_NAME || oc project $PROJECT_NAME

# === 2. Deploy app using S2I (source-to-image) ===
oc new-app $PYTHON_IMAGE~$GIT_REPO_URL --name=$APP_NAME

# === 3. Expose service ===
oc expose svc/$APP_NAME

# === 4. Wait for pod to be ready ===
echo "⏳ Waiting for pod to be ready..."
oc wait --for=condition=ready pod -l app=$APP_NAME --timeout=120s

# === 5. Show route ===
echo "✅ App route:"
oc get route $APP_NAME -o jsonpath='{.spec.host}{"\n"}'

# === 6. Tail logs (optional) ===
echo "📜 Tailing logs:"
oc logs -f dc/$APP_NAME
