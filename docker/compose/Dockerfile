FROM marigold:release as gateway_server

CMD python3 -m gunicorn -w 1 -b localhost:8081 -k uvicorn.workers.UvicornWorker "marigold.backend.gateway.gateway_server:app()" & \
    PYTHONPATH=${HOME}/dev rye run discord_client

FROM marigold:release as training_server

CMD PYTHONPATH=${HOME}/dev python3 -m gunicorn -w 4 -b localhost:8082 -k uvicorn.workers.UvicornWorker "marigold.backend.training.training_server:app()"

FROM marigold:release as deployement_server

CMD PYTHONPATH=${HOME}/dev python3 -m gunicorn -w 1 -b localhost:8083 -k uvicorn.workers.UvicornWorker "marigold.backend.deployment.deployment_server:app()"

FROM marigold:release as registry_server

CMD rye run mlflow server --backend-store-uri ${HOME}/marigold/mlflow --port 8080
