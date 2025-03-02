# Используем базовый образ с CUDA 11.8 и PyTorch
FROM nvidia/cuda:11.8.0-runtime-ubuntu20.04

WORKDIR /app

# Копируем файлы проекта
COPY app /app
COPY requirements.txt /app/requirements.txt

# Устанавливаем Python и зависимости
RUN apt-get update && apt-get install -y python3 python3-pip && \
    pip3 install --no-cache-dir -r /app/requirements.txt

# Открываем порт 5000
EXPOSE 5000

# Запускаем FastAPI через Uvicorn
CMD ["uvicorn", "app.model:app", "--host", "0.0.0.0", "--port", "5000"]
