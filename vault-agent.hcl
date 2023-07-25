pid_file = "./vault-agent.pid"

vault {
    address = "https://vault-cluster-public-vault-12d7ae1f.0c07f521.z1.hashicorp.cloud:8200"
}

auto_auth {
    method "approle" {
        mount_path = "auth/approle"
        config = {
            role_id_file_path = "/home/ubuntu/role_id_var"
            secret_id_file_path = "/home/ubuntu/secret_id_var"
            remove_secret_id_file_after_reading = false
        }
    }
    
    
    sink "file" {
        config = {
            path = "./agent-token"
        }
    }
}

cache {
  use_auto_auth_token = true
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = true
}

template {  
    source = "/home/ubuntu/template.ctmpl"
    destination = "/var/www/html/index.html"
}

