# Use the latest Ubuntu image
FROM ubuntu:latest

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -L https://ollama.com/install.sh | bash

ARG OLLAMA_MODEL
ENV OLLAMA_MODEL=$OLLAMA_MODEL

# Only pull the model if OLLAMA_MODEL is not empty
RUN if [ -n "$OLLAMA_MODEL" ]; then \
    echo "Pulling Ollama model: $OLLAMA_MODEL" && \
    ollama pull "$OLLAMA_MODEL"; \
    else \
    echo "No OLLAMA_MODEL specified, skipping model pull."; \
    fi

# Expose the default Ollama server port
EXPOSE 11411

# Serve the model
CMD ["ollama", "serve"]
