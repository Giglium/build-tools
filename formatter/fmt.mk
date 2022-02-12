# ====================================================================================
# Setup Project

# ====================================================================================
# Actions

.PHONY: fmt.black
fmt.black: #! Run Black as Python standard formatter on the project folder.
	black $(ROOT)
