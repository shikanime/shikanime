{
  services.rke2 = {
    enable = true;
    role = "server";
    cisHardening = true;
    extraFlags = [
      "--cluster-cidr 10.42.0.0/16,2001:cafe:42::/56"
      "--service-cidr 10.43.0.0/16,2001:cafe:43::/112"
    ];
    autoDeployCharts = {
      cert-manager = {
        enable = true;
        createNamespace = true;
        hash = "sha256-9ypyexdJ3zUh56Za9fGFBfk7Vy11iEGJAnCxUDRLK0E=";
        name = "cert-manager";
        repo = "https://charts.jetstack.io";
        targetNamespace = "cert-manager-system";
        values = {
          clusterResourceNamespace = "cert-manager-trust";
          crds.enable = true;
        };
        version = "v1.19.1";
      };
      cluster-api-operator = {
        enable = true;
        createNamespace = true;
        hash = "sha256-ROo2PFA39z61PqTpgI2PlTtdIyCG3znHaPgrYPpdA7Q=";
        name = "cluster-api-operator";
        repo = "https://kubernetes-sigs.github.io/cluster-api-operator";
        targetNamespace = "capi-operator-system";
        values.cert-manager.enabled = true;
        version = "0.24.1";
      };
      longhorn = {
        enable = true;
        createNamespace = true;
        hash = "sha256-qHHTl+Gc8yQ5SavUH9KUhp9cLEkAFPKecYZqJDPsf7k=";
        name = "longhorn";
        repo = "https://charts.longhorn.io";
        targetNamespace = "longhorn-system";
        version = "1.10.1";
      };
      tailscale-operator = {
        enable = true;
        createNamespace = true;
        hash = "sha256-8pZyWgBTDtnUXnYzDCtbXtTzvUe35BnqHckI/bBuk7o=";
        name = "tailscale-operator";
        repo = "https://pkgs.tailscale.com/helmcharts";
        targetNamespace = "tailscale-system";
        values = {
          apiServerProxyConfig.mode = "true";
          operatorConfig.hostname = "nishir-k8s-operator";
        };
        version = "1.90.9";
      };
      vpa = {
        enable = true;
        createNamespace = true;
        hash = "sha256-d0om1BuSLM9CDIRdmsxeG/uhUfliFmzHe6+qwfXg/t0=";
        name = "vpa";
        repo = "https://charts.fairwinds.com/stable";
        targetNamespace = "kube-system";
        version = "4.10.0";
      };
    };
  };
}
