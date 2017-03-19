.PHONY: db clean_files migrate dev js

all: help

help:
	@echo "  install	to install the app.  "
	@echo "  init		to create the virtual environment.  "

init:
	@if [ ! -d "./venv" ]; then \
		echo "  Creating the virtual environment."; \
		python3 -m venv ./venv ; \
	fi
	@echo "  Activating the virtual environment."
	source ./venv/bin/activate

	BIN=$(shell dirname `which python`
	@echo $(BIN)


# Start the virtual environment

