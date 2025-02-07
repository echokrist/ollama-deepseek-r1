# Use the latest Ubuntu image
FROM ollama/ollama:latest

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

ARG OLLAMA_MODEL
ENV OLLAMA_MODEL=$OLLAMA_MODEL

# Start Ollama server in background
RUN ollama serve & \
    # Now pull the model
    ollama pull "$OLLAMA_MODEL"; \
    ollama run "$OLLAMA_MODEL"
