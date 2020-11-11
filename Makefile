version ?= v$(shell date +%s)
image ?= pierone.stups.zalan.do/teapot/turing:$(version)

build-docker:
