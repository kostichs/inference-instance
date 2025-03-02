FROM nvidia/cuda:11.8.0-runtime-ubuntu20.04

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-dev python3-venv \
    git curl build-essential \
    rustc cargo && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта
COPY . /app

# Устанавливаем Python-зависимости
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir -r requirements.txt

# Открываем порт 5000
EXPOSE 5000

# Запускаем FastAPI через Uvicorn (проверь, что `model.py` существует!)
CMD ["uvicorn", "model:app", "--host", "0.0.0.0", "--port", "5000"]
