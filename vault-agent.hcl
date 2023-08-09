pid_file = "./vault-agent.pid"

vault {
    address = "<replace_with_vault_cluster_addr>"
}

auto_auth {
    method "approle" {
        mount_path = "auth/approle"
        config = {
            role_id_file_path = "<replace_with_path_to_role_id_var>"
            secret_id_file_path = "<replace_with_path_to_secret_id_var>"
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
    source = "<replace_with_path_to_template.ctmpl>"
    destination = "<replace_with_path_to_index.html>"
}

