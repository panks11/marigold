FROM marigold:release as backend

CMD rye run mlflow server --backend-store-uri ${HOME}/marigold/mlflow --port 8080 & \
    python3 -m gunicorn -w 1 -b localhost:8081 -k uvicorn.workers.UvicornWorker "marigold.backend.gateway.gateway_server:app()" & \
    PYTHONPATH=${HOME}/dev python3 -m gunicorn -w 4 -b localhost:8082 -k uvicorn.workers.UvicornWorker "marigold.backend.training.training_server:app()" & \
    PYTHONPATH=${HOME}/dev python3 -m gunicorn -w 1 -b localhost:8083 -k uvicorn.workers.UvicornWorker "marigold.backend.deployment.deployment_server:app()" & \
    PYTHONPATH=${HOME}/dev rye run discord_client
