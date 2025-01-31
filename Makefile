help: 
	@echo " Usage: make <task>"
	@echo "   task options:"	
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "	\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


build : ## Build docker image
	@$(call log_console, "Build docker image")
	@docker build -t ghcr.io/vaggeliskls/docusaurus-to-pdf:latest .

test: ## Test pdf generation
	@$(call log_console, "Test pdf generation")
	@docker run --rm -v ./pdf:/pdf ghcr.io/vaggeliskls/docusaurus-to-pdf:latest --initialDocURLs="https://docusaurus.io/docs/" --contentSelector="article" --paginationSelector="a.pagination-nav__link.pagination-nav__link--next" --excludeSelectors=".margin-vert--xl a,[class^='tocCollapsible'],.breadcrumbs,.theme-edit-this-page" --coverImage="https://docusaurus.io/img/docusaurus.png" --coverTitle="Docusaurus v2"