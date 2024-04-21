BROWSER ?= chromium
llama3.run: llama3.installed
	$(BROWSER) http://localhost:3000/
llama3.installed:
	docker run --detach \
	 --publish 3000:8080 \
	 --add-host=host.docker.internal:host-gateway \
	 --volume open-webui:/app/backend/data \
	 --name open-webui \
	 --restart always \
	 ghcr.io/open-webui/open-webui:main | tee $@
