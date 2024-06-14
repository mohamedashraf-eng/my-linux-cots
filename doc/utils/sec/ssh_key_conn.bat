@echo off
setlocal enabledelayedexpansion

REM Get input from the user
set /p server_name="Enter the remote server name: "
set /p server_ip="Enter the remote server IP: "

REM Generate SSH key pair with a secure passphrase
set "key_name=!server_name!_!date:~-4,4!!date:~-10,2!!date:~-7,2!_ed25519"
set "key_path=%USERPROFILE%\.ssh\!key_name!"
ssh-keygen -t ed25519 -f "!key_path!" -N "" -E sha256

REM Add the private key to the SSH agent
ssh-add "!key_path!"

REM Exchange the public key with the remote server
scp -o PubkeyAuthentication=no "!key_path!.pub" %server_name%@%server_ip%:~/tmp_!key_name!.pub
ssh -o PubkeyAuthentication=no %server_name%@%server_ip% "cat ~/tmp_!key_name!.pub >> ~/.ssh/authorized_keys && rm ~/tmp_!key_name!.pub && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"

echo "Key exchange completed successfully."

endlocal
