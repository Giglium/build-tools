# set the project folder if not defined
ifeq ($(origin REPOSITORY), undefined)
REPOSITORY := $(shell jq -r '.repository.url' package.json | sed 's/.git$$//g')
endif


.PHONY: userscript.init
userscript.init: ## Initialize a new userscript project
	@npm install --save-dev mini-css-extract-plugin css-loader sass-loader webpack webpack-monkey sass webpack-cli webpack-dev-server

.PHONY: userscript.build
userscript.build: ## build the user script
	@if [ -n $(REPOSITORY) ]; then \
		find . -name "meta.json" -exec sh -c ' \
			file_path=$$(echo $$1 | sed "s/^\.\//\//g" | sed "s/src/dist/g"); \
			script_name=$$(echo $$1 | sed "s|./src/\(.*\)/meta\.json|\1|"); \
			jq --arg version "$(VERSION)" \
				--arg repository "$(REPOSITORY)" \
				--arg filepath "$$file_path" \
				--arg script_name "$$script_name" \
				".updateURL = \$$repository + \"/raw/refs/tags/\" + \$$version + \$$filepath | \
				.downloadURL = \$$repository + \"/releases/download/\" + \$$version + \"/\" + \$$script_name + \".user.js\"" "$$1" > temp.json && mv temp.json "$$1" \
		' _ {} \; ; \
	fi
	
	@find . -name "meta.json" -exec sh -c ' \
		jq --arg version "$(VERSION)" \
		".version = \$$version" "$$1" > temp.json && mv temp.json "$$1" \
		' _ {} \;
	@./node_modules/.bin/webpack --mode production


.PHONY: userscript.dev
userscript.dev: ## build the development user script
	@webpack serve --mode development