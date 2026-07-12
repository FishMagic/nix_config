let
  # 您的原有 RSA 密钥
  laevatein-rsa = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCvMW5WUJvqBrxB3/jBr4BYwY1n1sWJDGjKLVv1/6yLl17UrBgXBLlt0vG12eGEqUpc9N38v41OXeeCgM2xOhrF5dHh9wybgUxTEOIrelbzySVfMM21CBUfhU/i+urWWVuadEWj5nYwdh5cuDsCTs56zViWD6tslAMWuj/PFUzrUcdHqqIiq1vbWz9q59IgDQi8Bf7RfTYI8A9y2SR3oC6LKRh8mauIx4n3UbtA8CRtVNFhwtoWearX6JH1IkVODmfcY426tmby6MDSQtmFrhL1jHHrcYFhhgt3DMfiAYZ09YkfM42U5kpxwDsYKJ5Fdzctc6A58gDIibD23TyidaTuUvxmjpuxiUUe7YGUt/HEfl3Osotkj/GpIG6zbZKwPXGMHMyQEhF9MZyXaNmXkX+4ltC1udAmVBDsPzQieev5WpNKj3bQIwRpmo3SBVIFbZ8R1JDT9n/u2k0oUN0bIQuaK/Fb4QC1vGdNYJbyCo7QuiZ1qTqOTIEIbKOPTPzBwXB5Oj04C+6oOlW7B9RTih7EgUp6GZKYmRgcRhcYns+ZelX5IgeXr/ywt5hHjMBM1QRu7+7/aTVO35q7KxLaHbpRSGjVKgFn0iFZlJlPUEn0F8YQMTsLj9kndCJITCIsKhmKt749iD3yJD6ffkn2frJMP9wl4zELw2KaoK50Pyx/XQ== laevatein";
  
  # 新生成的 WSL Ed25519 密钥
  laevatein-wsl-ed25519 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHNMnG7xeBCaDNp1RRHfww0nrd44JwdLEUpAh0CjZwke laevatein@DESKTOP-AJRT68L";
  
  # 请在部署目标服务器后，将服务器的主机公钥（例如 /etc/ssh/ssh_host_ed25519_key.pub）添加到此处：
  # server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA...";
  
  allKeys = [ laevatein-rsa laevatein-wsl-ed25519 ];
in
{
  "xray-config.json.age".publicKeys = allKeys;
}
