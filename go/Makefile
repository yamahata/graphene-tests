OUT_OF_TREE_COMMANDS = \
	bash

IN_TREE_COMMANDS =

manifests = $(addsuffix .manifest,$(OUT_OF_TREE_COMMANDS) $(IN_TREE_COMMANDS))
exec_target = $(IN_TREE_COMMANDS)
target = $(manifests)

level = ../../
include ../../Makefile
