FROM python:3.13-slim

# Install pipx
RUN apt-get update && apt-get install -y pipx
RUN pipx ensurepath

# Install poetry
RUN pipx install poetry

# Set working directory
WORKDIR /app

# Install dependencies
COPY pyproject.toml ./
RUN pipx run poetry install --no-root

# Copy application
COPY todo todo

# Adding a delay to our application startup 
CMD ["bash", "-c", "sleep 20 && pipx run poetry run flask --app todo run --host 0.0.0.0 --port 6400"]