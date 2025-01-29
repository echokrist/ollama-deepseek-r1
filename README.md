# ollama-deepseek-r1
A docker setup for running Ollama with deepseek-r1



## How to build and run as server
```
docker compose build &&
docker compose up -d
```

## How to Communicate with container

### Curl from outside the container

```
curl -X POST http://localhost:11434/api/generate \
     -H "Content-Type: application/json" \
     -d '{
           "model": "deepseek-r1:8b",
           "prompt": "Say hi",
           "stream": false
         }'
```

### Curl from inside a docker container

```
curl -X POST ollama-server:11434/api/generate \
     -H "Content-Type: application/json" \
     -d '{
           "model": "deepseek-r1:8b",
           "prompt": "Say hi",
           "stream": false
         }'
```

### From terminal for prompts
Replace deepseek-r1:8b with any model of choice.
New models can be found here: https://ollama.com/search
```
docker exec -it ollama-server ollama run deepseek-r1:8b
```

## How to pull more models into the container
Replace deepseek-r1:8b with any model of choice.
New models can be found here: https://ollama.com/search
```
docker exec -it ollama-server ollama pull deepseek-r1:8b
```