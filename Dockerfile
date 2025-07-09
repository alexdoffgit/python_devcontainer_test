# setup the syste,
FROM python:3.11-bullseye
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    vim \
    net-tools \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*
ENV VIRTUAL_ENV=/venv
RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# copy source to devcontainer
COPY . /app

# Install Python dependencies if requirements.txt exists
RUN if [ -f "requirements.txt" ]; then pip install --upgrade pip && pip install -r requirements.txt; fi

# Expose the default app port
EXPOSE 5000

# Default command for flask
# Set environment variables for Flask
ENV FLASK_APP=app.py
ENV FLASK_ENV=development
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000
CMD ["flask", "run"]