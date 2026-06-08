FROM python:3.12-slim

# slim keeps the runtime smaller while staying compatible with common Python wheels.
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN useradd -m -u 10001 appuser

COPY --chown=appuser:appuser . .

EXPOSE 5000

USER appuser

CMD ["python", "__init__.py"]