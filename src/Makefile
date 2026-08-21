# Jekyll Blog Docker Makefile
# Variables
IMAGE_NAME := jekyll-blog
CONTAINER_NAME := jekyll-dev
PORT := 4000
UID := $(shell id -u)
GID := $(shell id -g)

# Default target
.PHONY: help
help: ## Show this help message
	@echo "Jekyll Blog Development Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

# Docker management
.PHONY: docker-image
docker-image: ## Build Docker image for Jekyll development
	@echo "Building Docker image: $(IMAGE_NAME)"
	docker build -t $(IMAGE_NAME) .

.PHONY: dev
dev: ## Start development server with live reload and trace
	@echo "Starting Jekyll development server..."
	docker run --rm -it \
		--name $(CONTAINER_NAME) \
		-p $(PORT):4000 \
		-v "$(PWD)":/srv/jekyll \
		--user $(UID):$(GID) \
		$(IMAGE_NAME) \
		bundle exec jekyll serve --host 0.0.0.0 --port $(PORT) --watch --livereload --trace

.PHONY: build
build: ## Build site for production
	@echo "Building Jekyll site for production..."
	docker run --rm -it \
		-v "$(PWD)":/srv/jekyll \
		--user $(UID):$(GID) \
		$(IMAGE_NAME) \
		bundle exec jekyll build --profile --trace

.PHONY: stop
stop: ## Stop development server
	@echo "Stopping Jekyll development server..."
	docker stop $(CONTAINER_NAME) 2>/dev/null || echo "Container $(CONTAINER_NAME) is not running"
	docker rm $(CONTAINER_NAME) 2>/dev/null || echo "Container $(CONTAINER_NAME) does not exist"

.PHONY: shell
shell: ## Open interactive shell in container
	@echo "Opening interactive shell..."
	docker run --rm -it \
		-v "$(PWD)":/srv/jekyll \
		--user $(UID):$(GID) \
		$(IMAGE_NAME) \
		/bin/bash

.PHONY: doctor
doctor: ## Run Jekyll doctor to check for issues
	@echo "Running Jekyll doctor..."
	docker run --rm -it \
		-v "$(PWD)":/srv/jekyll \
		--user $(UID):$(GID) \
		$(IMAGE_NAME) \
		bundle exec jekyll doctor --trace

.PHONY: clean
clean: ## Clean generated files and caches
	@echo "Cleaning Jekyll generated files..."
	docker run --rm -it \
		-v "$(PWD)":/srv/jekyll \
		--user $(UID):$(GID) \
		$(IMAGE_NAME) \
		bundle exec jekyll clean --trace
	@echo "Cleaning _site..."
	rm -rf _site

.PHONY: logs
logs: ## Show development server logs
	@echo "Showing logs for $(CONTAINER_NAME)..."
	docker logs -f $(CONTAINER_NAME) 2>/dev/null || echo "Container $(CONTAINER_NAME) is not running"

.PHONY: status
status: ## Show container status
	@echo "Checking container status..."
	docker ps -a | grep $(CONTAINER_NAME) || echo "No containers found matching $(CONTAINER_NAME)"
	@echo ""
	@echo "Image status:"
	docker images | grep $(IMAGE_NAME) || echo "No image found matching $(IMAGE_NAME)"

# Utility targets
.PHONY: clean-all
clean-all: clean ## Clean everything including Docker image
	@echo "Removing Docker image..."
	docker rmi $(IMAGE_NAME) 2>/dev/null || echo "Image $(IMAGE_NAME) does not exist"

.PHONY: update-deps
update-deps: ## Update Ruby gems
	@echo "Updating Ruby gems..."
	docker run --rm -it \
		-v "$(PWD)":/srv/jekyll \
		--user $(UID):$(GID) \
		$(IMAGE_NAME) \
		bundle update
