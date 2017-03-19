.PHONY: db clean_files migrate dev js

STATIC_DIR=rollerapp/static
SCHEMA_DIR=rollerapp/schema
SCHEMAS=$(wildcard $(SCHEMA_DIR:=/*.sql))
BIN=venv/bin

all: help

help:
	@echo "  install	to install the app.  "
	@echo "  init		to create the virtual environment.  "

init:
	@if [ ! -d "./venv" ]; then \
		echo "  Creating the virtual environment."; \
		python3 -m venv ./venv ; \
	fi
	@echo "  Installing the requirements."
	@echo "    "
	@echo "    Python:"
	@$(BIN)/pip install -Ur requirements.txt
	@touch $(BIN)/activate
	@echo "    "
	@echo "    Node:"
	@$(BIN)/nodeenv --prebuilt -p
	@$(BIN)/npm install -g react-tools
	@touch $(BIN)/jsx

db:
	-psql -U tramee -c "drop database rollersdb"
	psql -U tramee -c "create database rollersdb"
	@for sch in $(SCHEMAS); do \
	  psql -d rollersdb -a -f $$sch ; \
	done

clean_files:
	-rm -rf $(STATIC_DIR)/jsx/.module-cache
	-rm $(STATIC_DIR)/jsx/*js
#	-rm -rf $(STATIC_DIR)/bower
#	-rm -rf $(STATIC_DIR)/js/compiled.js

clean:	db clean_files

install: init
	$(BIN)/python3 rollerapp/setup.py install

test: install
	$(BIN)/python3 rollerapp/test/runtests.py

