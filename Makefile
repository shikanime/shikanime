.PHONY: devcontainer
devcontainer:
	docker load -i $(nix build .#nixosConfigurations.devcontainer.config.system.build.dockerImage --print-out-paths)