function generate_and_exchange_keys() {
  # Detect the operating system
  case "$(uname -s)" in
    Linux*)   ssh_command="ssh" ;;
    Darwin*)  ssh_command="ssh" ;;
    CYGWIN*)  ssh_command="ssh.exe" ;;
    MINGW*)   ssh_command="ssh.exe" ;;
    *)        echo "Unsupported operating system"; exit 1 ;;
  esac

  # Prompt user for server name and IP
  read -p "Enter the remote server name: " remote_server_name
  read -p "Enter the remote server IP address: " remote_server_ip

  # Generate key pair with passphrase
  key_name="${remote_server_name}_$(date +%Y%m%d%H%M%S)_ed25519"
  ssh-keygen -t ed25519 -f "$HOME/.ssh/$key_name" -N "" -E sha256

  # "$(openssl rand -base64 48)" 
  
  REM Add the private key to the SSH agent
  ssh-add "!key_path!"

  # Exchange keys
  scp_command="scp"
  if [ "$ssh_command" == "ssh.exe" ]; then
    scp_command="scp.exe"
  fi

  "$scp_command" "$HOME/.ssh/$key_name.pub" "$remote_server_name@$remote_server_ip:~/tmp_$key_name.pub"
  "$ssh_command" "$remote_server_name@$remote_server_ip" "cat ~/tmp_$key_name.pub >> ~/.ssh/authorized_keys && rm ~/tmp_$key_name.pub && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"

  echo "Key exchange completed successfully!"
}
