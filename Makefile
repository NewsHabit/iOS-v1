RESET = \033[0m
GREEN = \033[1;32m
CYAN = \033[1;36m

all:
	@tuist clean > /dev/null 2>&1
	@echo "$(CYAN)╔════════════════════════════════════════╗$(RESET)"
	@echo "$(CYAN)║               tuist clean              ║$(RESET)"
	@echo "$(CYAN)╚════════════════════════════════════════╝$(RESET)"
	@tuist fetch > /dev/null 2>&1	
	@tuist generate > /dev/null 2>&1
	@echo "$(GREEN)╔════════════════════════════════════════╗$(RESET)"
	@echo "$(GREEN)║              tuist fetch               ║$(RESET)"
	@echo "$(GREEN)║              tuist generate            ║$(RESET)"
	@echo "$(GREEN)╚════════════════════════════════════════╝$(RESET)"
