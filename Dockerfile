FROM python:3.13-slim

WORKDIR /app

RUN groupadd --system appgroup \
    && useradd --system --gid appgroup appuser

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=appuser:appgroup app.py .

USER appuser

EXPOSE 5000

CMD ["sh", "-c", "exec gunicorn --bind 0.0.0.0:${PORT:-5000} app:app"]