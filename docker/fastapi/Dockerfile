# syntax=docker/dockerfile:1.6
FROM python:3.11-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY ../../src/ ./src/
COPY gunicorn_conf.py .
EXPOSE 8000
CMD ["gunicorn", "-c", "gunicorn_conf.py", "app.main:create_app()"]
