RESET = \033[0m
GREEN = \033[1;32m
CYAN = \033[1;36m
RED = \033[1;31m

TUIST = tuist
CLEAN = $(TUIST) clean
FETCH = $(TUIST) fetch
GENERATE = $(TUIST) generate

define run_step
	@echo "$(CYAN)$1..$(RESET)"
	@if ! $2 > /dev/null 2>&1; then \
		echo "$(RED)\nfailed 🚨$(RESET)"; \
		exit 1; \
	fi
endef

all:
	@$(call run_step,🧹 Cleaning,$(CLEAN))
	@$(call run_step,🚚 Fetching,$(FETCH))
	@$(call run_step,⚙️ Generating,$(GENERATE))
	@echo "$(GREEN)\nsuccess 😙$(RESET)"
