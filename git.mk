
.PHONY: git
git: ## Exec git command inside the project folder. You can specify any command to execute with the `c` flag. Ex. make git c=pull
	git -C $(PROJECT_FOLDER) $(c)

.PHONY: git.submodules
git.submodules: ## Update the submodules.
	git -C $(PROJECT_FOLDER) submodule sync
	git -C $(PROJECT_FOLDER) submodule update --recursive --remote