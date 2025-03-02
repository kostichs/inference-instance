# Используем базовый образ с CUDA 11.8 и PyTorch
FROM nvidia/cuda:11.8.0-runtime-ubuntu20.04

# Устанавливаем системные зависимости, включая Rust
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-dev python3-venv \
    git curl build-essential \
    rustc cargo && \
    rm -rf /var/lib/apt/lists/*

# Задаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта
COPY requirements.txt requirements.txt
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt

COPY . .

# Открываем порт 5000
EXPOSE 5000

# Запускаем FastAPI через Uvicorn без "app."
CMD ["python3", "-m", "uvicorn", "model:app", "--host", "0.0.0.0", "--port", "5000"]
