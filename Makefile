.PHONY: devcontainer
devcontainer:
 No newline at end of file
	docker load -i $(shell nix build .#nixosConfigurations.devcontainer.config.system.build.dockerImage --print-out-paths)
 No newline at end of file
