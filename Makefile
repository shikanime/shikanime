.PHONY: devcontainer
devcontainer:
	docker load -i $(shell nix build .#nixosConfigurations.devcontainer.config.system.build.dockerImage --print-out-paths)
