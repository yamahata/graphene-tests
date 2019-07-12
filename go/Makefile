CUR_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

OUT_OF_TREE_EXECUTABLES = \
	bash \
	go
IN_TREE_EXECUTABLES =

GO_EXECUTABLES = \
	go/bin/go \
	go/bin/gofmt \
	go/doc/articles/wiki/test.bash \
	go/doc/codewalk/run \
	go/lib/time/update.bash \
	go/pkg/bootstrap/bin/asm \
	go/pkg/bootstrap/bin/cgo \
	go/pkg/bootstrap/bin/compile \
	go/pkg/bootstrap/bin/link \
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
	go/src/cmd/go/testdata/failssh/ssh \
	go/src/cmd/internal/buildid/testdata/a.elf \
	go/src/cmd/internal/buildid/testdata/a.macho \
	go/src/cmd/internal/buildid/testdata/a.pe \
	go/src/debug/dwarf/testdata/ranges.elf \
	go/src/debug/dwarf/testdata/typedef.elf \
	go/src/internal/trace/mkcanned.bash \
	go/src/iostest.bash \
	go/src/make.bash \
	go/src/naclmake.bash \
	go/src/nacltest.bash \
	go/src/net/http/cgi/testdata/test.cgi \
	go/src/race.bash \
	go/src/run.bash \
	go/src/runtime/pprof/testdata/test32 \
	go/src/runtime/pprof/testdata/test32be \
	go/src/runtime/pprof/testdata/test64 \
	go/src/runtime/pprof/testdata/test64be \
	go/src/syscall/mkall.sh \
	go/src/syscall/mkerrors.sh \
	go/src/syscall/mksysnum_plan9.sh \
	go/test/errchk
#GO_EXECUTABLE_IDS = $(subst .,_,$(subst /,-,$(GO_EXECUTABLES)))

# we have go directory. workaroud a rule to %.manifest:%.
go.manifest: _go.manifest
	$(call cmd,ln_sf)
go.manifest.sgx: _go.manifest.sgx
	$(call cmd,ln_sf)
go.sig: _go.sig
	$(call cmd,ln_sf)
all: go.manifest.sgx

manifests = $(addsuffix .manifest,$(OUT_OF_TREE_EXECUTABLES) $(IN_TREE_EXECUTABLES))
exec_target = $(IN_TREE_EXECUTABLES)
target = $(manifests)
sig_files_extra = $(addsuffix .sig,$(OUT_OF_TREE_EXECUTABLES) $(GO_EXECUTABLE_IDS))
token_files_extra = $(addsuffix .token,$(OUT_OF_TREE_EXECUTABLES) $(GO_EXECUTABLE_IDS)) _go.token

# $(addsuffix .manifest.template,$(GO_EXECUTABLE_IDS)): manifest.template
#	ln -sf $< $@

# extra_rules = -e 's:\$$(EXEC_PATH):$<:g' -e 's:-:/:g' -e 's:_:.:g'

level = ../../
include ../../Makefile
include ../../../../../Makefile.rules

test:
	GOCACHE=off GOROOT=$(CUR_DIR)/go ./pal-Linux-SGX ./bash.manifest.sgx  ./go/src/run.bash --no-rebuild
