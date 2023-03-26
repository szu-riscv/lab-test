
platform ?= labcore



update: 
	git pull
	git submodule update --init --recursive
include scripts/compile.mk
