GO_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

OUT_OF_TREE_EXECUTABLES = \
	bash \
	uname

IN_TREE_EXECUTABLES =

GO_EXECUTABLES = \
	go/bin/go \
	go/bin/gofmt \
	go/doc/articles/wiki/test.bash \
	go/doc/codewalk/run \
	go/lib/time/update.bash \
	go/pkg/tool/linux_amd64/addr2line \
	go/pkg/tool/linux_amd64/api \
	go/pkg/tool/linux_amd64/asm \
	go/pkg/tool/linux_amd64/buildid \
	go/pkg/tool/linux_amd64/cgo \
	go/pkg/tool/linux_amd64/compile \
	go/pkg/tool/linux_amd64/cover \
	go/pkg/tool/linux_amd64/dist \
	go/pkg/tool/linux_amd64/doc \
	go/pkg/tool/linux_amd64/fix \
	go/pkg/tool/linux_amd64/link \
	go/pkg/tool/linux_amd64/nm \
	go/pkg/tool/linux_amd64/objdump \
	go/pkg/tool/linux_amd64/pack \
	go/pkg/tool/linux_amd64/pprof \
	go/pkg/tool/linux_amd64/test2json \
	go/pkg/tool/linux_amd64/trace \
	go/pkg/tool/linux_amd64/vet \
	go/src/all.bash \
	go/src/androidtest.bash \
	go/src/bootstrap.bash \
	go/src/buildall.bash \
	go/src/clean.bash \
	go/src/cmd/go/mkalldocs.sh \
	go/src/internal/trace/mkcanned.bash \
	go/src/iostest.bash \
	go/src/make.bash \
	go/src/naclmake.bash \
	go/src/nacltest.bash \
	go/src/race.bash \
	go/src/run.bash \
	go/src/syscall/mkall.sh \
	go/src/syscall/mkerrors.sh \
	go/src/syscall/mksysnum_plan9.sh \
	go/test/errchk

# convert_name = $(subst .,_,$(subst /,-,$(1)))
# convert_name = $(subst .,_,$(notdir $(1)))
convert_name = $(notdir $(1))
GO_EXECUTABLE_IDS = $(foreach executable,$(GO_EXECUTABLES),$(call convert_name,$(executable)))

manifests = $(addsuffix .manifest,$(OUT_OF_TREE_EXECUTABLES) $(IN_TREE_EXECUTABLES))
#$(info $(manifests))
exec_target = $(IN_TREE_EXECUTABLES)
target = $(manifests)
sig_files_extra = $(addsuffix .sig,$(OUT_OF_TREE_EXECUTABLES) $(GO_EXECUTABLE_IDS))
token_files_extra = $(addsuffix .token,$(OUT_OF_TREE_EXECUTABLES) $(GO_EXECUTABLE_IDS))
#extra_rules = -e 's:\$$(GOROOTDIR):$(GO_DIR):g'
extra_rules = -e 's:\$$(GOROOTDIR):.:g'

level = ../../
include ../../Makefile
include ../../../../../Makefile.rules

test:
	GOCACHE=off GOROOT=$(GO_DIR)/go ./pal-Linux-SGX ./bash.manifest.sgx	 ./go/src/run.bash --no-rebuild
	GOCACHE=off GOROOT=$(GO_DIR)/go ./pal-Linux-SGX ./go.manifest.sgx go/bin/go tool dist test --no-rebuild
	# GOCACHE=off GOROOT=/home/yamahata/graphene/devel/go/go PATH=$GOROOT/bin:$PATH	 ./pal-Linux-SGX ./go.manifest.sgx go/bin/go tool dist test --no-rebuild
	# GOCACHE=off GOROOT=/home/yamahata/graphene/devel/go/go PATH=$GOROOT/bin:$PATH	 ./pal-Linux-SGX ./bash.manifest.sgx ./go/src/run.bash --no-rebuild

define sgx_sign_template =
$(1).sig $(1).manifest.sgx: $(2) $$(LIBPAL) $$(SGX_SIGNER_KEY)
	$$(eval $(1)-manifest := $$(call find_manifest,$(1)))
	$$(MAKE) $$($(1)-manifest)
	$$(call prerequisite,$$($(1)-manifest),$(1).sig)
	@echo [ $$@ ]
	$$(SGX_SIGN) -output $(1).manifest.sgx -exec $(2) -manifest $$($(1)-manifest)
CLEAN_FILES += $(1).sig
CLEAN_FILES += $(1).manifest.sgx
endef

# define sgx_sign_template =
# $(GO_DIR)/$(1).sig $(GO_DIR)/$(1).manifest.sgx: $(2) $$(LIBPAL) $$(SGX_SIGNER_KEY)
# 	$$(eval $(1)-manifest := $$(call find_manifest,$(1)))
# 	$$(MAKE) $$($(1)-manifest)
# 	$$(call prerequisite,$$($(1)-manifest),$(1).sig)
# 	@echo [ $$@ ]
# 	$$(SGX_SIGN) -output $(1).manifest.sgx -exec $(2) -manifest $$($(1)-manifest)
# CLEAN_FILES += $(1).sig
# CLEAN_FILES += $(1).manifest.sgx
# endef

# $(foreach executable,$(GO_EXECUTABLES),$(info $(call sgx_sign_template,$(call convert_name,$(executable)),$(executable))))
$(foreach executable,$(GO_EXECUTABLES),$(eval $(call sgx_sign_template,$(call convert_name,$(executable)),$(executable))))

# clean:
# 	rm -rf $(CLEAN_FILES) *.token
