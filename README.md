# How to use the *run-everywhere.sh* script

Before we can test the script, we have to do some setup. We need to make sure we have ```/etc/host entries```. The ```/etc/hosts``` file contains the IP hostnames and addresses for the local host and other hosts in the internet network. This file is used to resolve a name into an address.

Run the following code on the ```admin01``` server

```bash
echo 10.9.8.11 server01 | sudo tee -a /etc/hosts
echo 10.9.8.12 server02 | sudo tee -a /etc/hosts
``` 

## Configure SSH configuration

Create a new SSH key on ```admin01```. The use ```ssh-copy-id``` to the servers.

To create an ssh key: ```ssh-keygen```

To copy the ssh key to the remote systems: ```ssh-copy-id```.


<br/>

## Run commands
Make sure you try out the different options to check if they work.

<br/>

### Verbose mode

```./run-everywhere.sh -v uptime```

<br/>

### Run as a superuser

```./run-everywhere.sh -ns id```

