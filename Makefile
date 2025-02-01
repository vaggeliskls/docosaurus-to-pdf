# Get the current directory
CURRENT_DIR := $(CURDIR)

IMAGE_URL := ghcr.io/vaggeliskls/docusaurus-to-pdf:latest

log_console = (echo  "\n\033[1;36m--->\033[0m $(1)\n")

help: 
	@echo " Usage: make <task>"
	@echo "   task options:"	
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "	\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build : ## Build docker image
	@$(call log_console, "Build docker image")
	@docker build --platform linux/amd64 -t $(IMAGE_URL) .

test: ## Test pdf generation
	@$(call log_console, "Test pdf generation")
	@docker run --rm --platform linux/amd64 -v $(CURRENT_DIR):/pdf $(IMAGE_URL)

extract: ## Extract pdf from docs url
	@$(call log_console, "Extract pdf from docs url")
	@docker run --rm --name doc-to-pdf --platform linux/amd64 -v $(CURRENT_DIR):/pdf -e DOCS_URL="https://docusaurus.io/docs/" $(IMAGE_URL)