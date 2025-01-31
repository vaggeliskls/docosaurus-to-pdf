# Get the current directory
CURRENT_DIR := $(CURDIR)

IMAGE_URL := ghcr.io/vaggeliskls/docusaurus-to-pdf:latest

help: 
	@echo " Usage: make <task>"
	@echo "   task options:"	
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "	\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build : ## Build docker image
	@$(call log_console, "Build docker image")
	@docker build -t $(IMAGE_URL) .

test: ## Test pdf generation
	@$(call log_console, "Test pdf generation")
	@docker run --rm --platform linux/amd64 -v $(CURRENT_DIR):/pdf $(IMAGE_URL) --initialDocURLs="https://docusaurus.io/docs/" --contentSelector="article" --paginationSelector="a.pagination-nav__link.pagination-nav__link--next" 
