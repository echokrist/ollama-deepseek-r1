# Use the latest Ubuntu image
FROM ollama/ollama:latest

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    netcat-traditional \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -L https://ollama.com/install.sh | bash

ARG OLLAMA_MODEL
ENV OLLAMA_MODEL=$OLLAMA_MODEL

# Only pull the model if OLLAMA_MODEL is not empty
RUN if [ -n "$OLLAMA_MODEL" ]; then \
    echo "Pulling Ollama model: $OLLAMA_MODEL" && \
    # Start Ollama server in background
    (ollama serve >/tmp/ollama.log 2>&1 & ) && \
    # Wait up to 10s for the server to listen
    for i in 1 2 3 4 5; do \
    if nc -z 127.0.0.1 11434; then \
    echo "Ollama server is ready!"; \
    break; \
    fi; \
    echo "Waiting for Ollama server..."; \
    sleep 2; \
    if [ "$i" = "5" ]; then \
    echo "ERROR: Ollama server did not become ready." >&2; \
    exit 1; \
    fi; \
    done && \
    # Now pull the model
    ollama pull "$OLLAMA_MODEL"; \
    else \
    echo "No OLLAMA_MODEL specified, skipping model pull."; \
    fi

# Expose the default Ollama server port
EXPOSE 11434

# Serve the model
CMD ["serve"]
