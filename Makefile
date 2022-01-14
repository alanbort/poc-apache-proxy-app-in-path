HELP_MAKE_TARGETS = @cat Makefile | \
                    grep -E -e '[a-z\-]*:\s*[a-z]*\-?[a-z]* \#.*$$' | \
                    grep -v '^ *\#' | \
                    sort | \
                    grep --color '^[a-z\-]*' 

.PHONY: help fullhelp stop docker-setup clean

default: docker-setup

#### Documentation and help

help: # show quick list of actions
	@echo Targets
	@echo =================
	$(HELP_MAKE_TARGETS)

fullhelp: # show full documentation and list of available actions
	$(README)
	@echo
	@echo
	@echo \# Targets
	@echo
	$(HELP_MAKE_TARGETS)

stop: # Stop test environment
	@docker-compose down

docker-setup:
	@docker-compose build
	@docker-compose up -d

clean: # remove docker images
	@docker-compose down --rmi all
	@docker system prune --all --volumes --force
