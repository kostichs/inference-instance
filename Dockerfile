FROM nvidia/cuda:11.8.0-runtime-ubuntu20.04

WORKDIR /app

RUN echo "WORKDIR set to /app"

COPY app /app
COPY requirements.txt /app/requirements.txt

RUN echo "Files in /app after COPY:" && ls -R /app

RUN apt-get update && apt-get install -y python3 python3-pip curl && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    export PATH="$HOME/.cargo/bin:$PATH" && \
    echo "Python version:" && python3 --version && \
    echo "Pip version:" && pip3 --version && \
    echo "Installing dependencies..." && \
    pip3 install --no-cache-dir -r /app/requirements.txt

RUN echo "Installed Python packages:" && pip3 list

RUN echo "Final file structure in /app:" && ls -R /app

EXPOSE 5000

CMD ["sh", "-c", "echo 'Starting Uvicorn...'; uvicorn --app-dir /app app.model:app --host 0.0.0.0 --port 5000"]
