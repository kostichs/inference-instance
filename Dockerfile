# Используем базовый образ с CUDA 11.8 и PyTorch
FROM nvidia/cuda:11.8.0-runtime-ubuntu20.04

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта
COPY . .

# Устанавливаем Python, Rust и зависимости
RUN apt-get update && apt-get install -y python3 python3-pip curl && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    export PATH="$HOME/.cargo/bin:$PATH" && \
    pip3 install --no-cache-dir -r requirements.txt

# Открываем порт 5000
EXPOSE 5000

# Устанавливаем PYTHONPATH, чтобы Docker находил `app`
ENV PYTHONPATH=/app

# Запускаем FastAPI через Uvicorn
CMD ["uvicorn", "app.model:app", "--host", "0.0.0.0", "--port", "5000"]
