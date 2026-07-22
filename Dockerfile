FROM python:3.12-slim

WORKDIR /app

# Base minimale et compatible pour une image Python légère.
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

RUN groupadd --system app && useradd --system --gid app --create-home --home-dir /home/appuser appuser

COPY --chown=appuser:appuser . .

USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
