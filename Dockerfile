FROM python:3.9-slim

WORKDIR /app

COPY __init__.py .
COPY templates/ templates/

RUN pip install --no-cache-dir flask

EXPOSE 5000

CMD ["python", "__init__.py"]