all: deps

.PHONY: deps
deps: shikanime-deps totalenergies-deps

.PHONY: shikanime-deps
shikanime-deps:
	@terraform -chdir=modules/shikanime init

.PHONY: totalenergies-deps
totalenergies-deps:
	@terraform -chdir=modules/totalenergies init