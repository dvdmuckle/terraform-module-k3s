// Resolve the latest published non-prerelease version when requested
data "http" "k3s_version" {
  count = var.k3s_version == "latest" ? 1 : 0

  url = "https://api.github.com/repos/k3s-io/k3s/releases/latest"
}

data "http" "k3s_installer" {
  url = "https://raw.githubusercontent.com/k3s-io/k3s/${urlencode(local.k3s_version)}/install.sh"
}

locals {
  k3s_version = var.k3s_version == "latest" ? jsondecode(data.http.k3s_version[0].response_body).tag_name : var.k3s_version
}
