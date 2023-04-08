all: deps

.PHONY: deps
deps: shikanime-deps totalenergies-deps

.PHONY: shikanime-deps
shikanime-deps:
	@terraform -chdir=modules/shikanime init -backend=false -get=false

.PHONY: totalenergies-deps
totalenergies-deps:
	@terraform -chdir=modules/totalenergies init -backend=false -get=false