# Use the latest Ubuntu image
FROM ollama/ollama:latest

ARG OLLAMA_MODEL
ENV OLLAMA_MODEL=$OLLAMA_MODEL

# Start Ollama server in background
RUN ollama serve & \
    sleep 10 && \
    ollama pull "$OLLAMA_MODEL" && \
    ollama run "$OLLAMA_MODEL"
