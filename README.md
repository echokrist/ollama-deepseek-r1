# ollama-docker
A docker setup for running Ollama.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/template/ZFH0bl?referralCode=AqDjJs)

## How to build and up container
```
docker compose build &&
docker compose up -d
```

You need to pull or run a model in order to have access to any models. 
You can do so by the docker exec lines below, and you can replace the deepseek-r1:8b model
with any model you want from: https://ollama.com/search



### From terminal for prompts
Replace deepseek-r1:8b with any model of choice.
Please note: The docker restart ollama-server is added to reset the server and model running. 
```
docker exec -it ollama-server ollama run deepseek-r1:8b && docker restart ollama-server 
```

## How to pull more models into the container
Replace deepseek-r1:8b with any model of choice.
```
docker exec -it ollama-server ollama pull deepseek-r1:8b
```


## How to Communicate with container once up

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
*within the same Docker network*


```
curl -X POST ollama-server:11434/api/generate \
     -H "Content-Type: application/json" \
     -d '{
           "model": "deepseek-r1:8b",
           "prompt": "Say hi",
           "stream": false
         }'
```


