network:
  version: 2
  renderer: networkd
  ethernets:
    enp1s0:
      dhcp4: no
      addresses: [10.10.10.2/24]
      gateway4: 10.10.10.1
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]