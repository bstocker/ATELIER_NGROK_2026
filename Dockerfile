FROM python:3.13-slim

WORKDIR /app

ENV FLASK_APP=__init__.py
ENV PYTHONUNBUFFERED=1

# Install the application dependencies
RUN pip install --no-cache-dir Flask

# Copy in the source code
COPY . .
EXPOSE 5000


CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]