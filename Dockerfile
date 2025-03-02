FROM nvidia/cuda:11.8.0-runtime-ubuntu20.04

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y python3 python3-pip && \
    pip3 install --no-cache-dir -r /app/requirements.txt

EXPOSE 5000

CMD ["uvicorn", "app.model:app", "--host", "0.0.0.0", "--port", "5000"]
