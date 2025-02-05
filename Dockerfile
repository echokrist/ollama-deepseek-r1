# Use the latest Ubuntu image
FROM ubuntu:latest

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
    # Start Ollama server in background, wait for it to be ready, then pull:
    (ollama serve &) && \
    # Wait for the server to listen on port 11411
    sh -c 'for i in 1 2 3 4 5; do \
    if nc -z 127.0.0.1 11434; then \
    echo "Ollama server is ready!"; \
    break; \
    fi; \
    echo "Waiting for Ollama server..."; \
    sleep 2; \
    done' && \
    # Now pull the model
    ollama pull "$OLLAMA_MODEL"; \
    else \
    echo "No OLLAMA_MODEL specified, skipping model pull."; \
    fi

# Expose the default Ollama server port
EXPOSE 11434

# Serve the model
CMD ["ollama", "serve"]
