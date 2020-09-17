#### Ansible scripts for building Kubernetes cluster from scratch.

`It's not production ready! For test purposes only!`

## How to:

* Setup 2 or more VMs
    * Be sure that your VMs are:
        * able to connect to internet
        * connected in one network e.g. `10.10.10.0/24`
        * have static IP
            * P.S: bridge over `<eth0>` interface works fine
        * master node must have at least 2 cpus
    * patch `/etc/sudoers`
        * add line in the bottom `<user>   ALL=(ALL:ALL) NOPASSWD:ALL` to be able to perform `sudo` commands without password prompt
    * run `sudo apt-get update` just in case
    * copy ssh keys if needed
* Patch `inv/hosts`
    * set master IP and nodes IP
    * set unique `hostname` for each node
* `ansible-playbook -i inv -u <user> all.yml` to setup both master and nodes at once.
    * or:
        * `ansible-playbook -i inv -u <user> master.yml` for setup master node
        * `ansible-playbook -i inv -u <user> node.yml` for setup other nodes
* connect all nodes into cluster:
    * on the master node run command `kubeadm token create --print-join-command`
        * copy output and execute on rest nodes
    * on the master node run command `kubectl get nodes` to check that everything ok
    * P.S: it can take a while
    * if something went wrong and node `NotReady` please check kubernetes documentation for troubleshooting, like:
        * `kubectl get nodes -o wide`
        * `kubectl describe ...`
        * `kubectl logs ...`
* `scp <user>@<master>:.kube/config ~./kube/` to be able to interact with k8s cluster from host.
    * check `kubectl get nodes`
 