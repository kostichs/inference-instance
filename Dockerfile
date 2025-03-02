# Используем базовый образ с CUDA 11.8 и PyTorch
FROM nvidia/cuda:11.8.0-runtime-ubuntu20.04

WORKDIR /app

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-dev python3-venv \
    git curl build-essential && \
    rm -rf /var/lib/apt/lists/*

# Копируем файлы проекта
COPY . /app

# Устанавливаем Python-зависимости
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r /app/requirements.txt

# Открываем порт 5000
EXPOSE 5000

# Запускаем FastAPI через Uvicorn
CMD ["uvicorn", "app.model:app", "--host", "0.0.0.0", "--port", "5000"]
