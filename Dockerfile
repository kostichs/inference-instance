FROM nvidia/cuda:11.8.0-runtime-ubuntu20.04

WORKDIR /app

COPY app /app/app
COPY requirements.txt /app/requirements.txt

RUN apt-get update && apt-get install -y python3 python3-pip curl && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    export PATH="$HOME/.cargo/bin:$PATH" && \
    pip3 install --no-cache-dir -r /app/requirements.txt

EXPOSE 5000

CMD ["uvicorn", "app.model:app", "--host", "0.0.0.0", "--port", "5000"]
