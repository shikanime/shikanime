.PHONY: generate
generate:
	@nixos-anywhere \
		--generate-hardware-config nixos-facter \
		--flake .#flandre shika@flandre.local \
		./modules/nixos/hosts/flandre/facter.json
	@nixos-anywhere \
		--generate-hardware-config nixos-facter \
		--flake .#remilia shika@remilia.local \
		./modules/nixos/hosts/remilia/facter.json
