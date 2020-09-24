APP_NAME := template-go-application
API_PORT := 8080
GO_VERSION := 1.15

define docker_run
	@docker run -it --rm \
	-v "$$(pwd):/app" \
	-p $(API_PORT):$(API_PORT) \
	-e VAR=foo \
	--name $(APP_NAME) \
	-w "/app" \
	golang:$(GO_VERSION) $1
endef

.PHONY: help enter-container run test format

help:	# This prints the available actions when you just type make, based on the comments. Keep it first target to be default.
ifeq ($(UNAME), Linux)
	@grep -P '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
else
	@# this is not tested, but prepared in advance for you, Mac drivers
	@awk -F ':.*###' '$$0 ~ FS {printf "%15s%s\n", $$1 ":", $$2}' \
		$(MAKEFILE_LIST) | grep -v '@awk' | sort
endif

enter-container: ### Grants sh access to the running container
	@echo "Entering $(APP_NAME)...\n\n"
	$(call docker_run)

run:	### Runs the application on top of the official golang docker image
	@echo "Executing $(APP_NAME)...\n\n"
	$(call docker_run, go run main.go)

test:	### Executes the application tests on top of the official golang docker image
	@echo "Testing $(APP_NAME)...\n\n"
	$(call docker_run, go test ./...)

format:	### Applies go fmt to all files of the project
	@echo "Formatting $(APP_NAME)...\n\n"
	$(call docker_run, go fmt ./...)