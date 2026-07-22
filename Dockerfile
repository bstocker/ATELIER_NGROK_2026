# JUSTIFICATION DU CHOIX : Utilisation de la version 'slim' (basée sur Debian).
# Elle est beaucoup plus légère que l'image standard et évite les problèmes de 
# compilation liés à 'musl' que l'on rencontre souvent avec Alpine en Python.
FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1
ENV FLASK_APP=app.py

WORKDIR /app

RUN useradd -m appuser

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=appuser:appuser . .

USER appuser

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]