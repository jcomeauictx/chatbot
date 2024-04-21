SHELL := /bin/bash
BROWSER ?= chromium
all: llama2.run
llama.run: llama.installed
	$(BROWSER) http://localhost:3000/
llama.installed:
	docker run --detach \
	 --publish 3000:8080 \
	 --add-host=host.docker.internal:host-gateway \
	 --volume open-webui:/app/backend/data \
	 --name open-webui \
	 --restart always \
	 ghcr.io/open-webui/open-webui:main | tee $@
llama.clean:
	-docker stop $$(<llama.installed)
	-docker rm $$(<llama.installed)
	rm -f llama.installed
llama2.run: llama2.installed
	$(BROWSER) http://localhost:8080/
llama2.installed:
	docker run --detach \
	 --network=host \
	 --volume open-webui:/app/backend/data \
	 --env OLLAMA_BASE_URL=http://127.0.0.1:11434 \
	 --name open-webui \
	 --restart always \
	 ghcr.io/open-webui/open-webui:main | tee $@
llam2.clean:
	-docker stop $$(<llama2.installed)
	-docker rm $$(<llama2.installed)
	rm -f llama2.installed
