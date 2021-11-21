# Box installation

## Download a box from the vagrant repo
```bash
vagrant box add jasonc/centos7
```

<br/>

## Create a folder and run the command below
```bash
mkdir shellclass && cd shellclass && vagrant init
```

<br/>

## Run the command below to start the virtual machine(s). You may have to read some documentation to configure your box 
```bash
vagrant up
```

<br/>

## Vagrant file config
```bash
Vagrant.configure("2") do |config|

  config.vm.box = "jasonc/centos7"
  config.vm.hostname = "testbox01"
  config.vm.network "private_network", ip: "10.9.8.7"
done
```

<br/>

## Destroy a VM
```bash
vagrant destroy
```

<br/>

## Creating multiple virtual machines
```bash
Vagrant.configure("2") do |config|
  config.vm.box = "jasonc/centos7"

  config.vm.define "test1" do |test1|
    test1.vm.hostname = "test1"
    test1.vm.network "private_network", ip: "10.9.8.5"
  end


  config.vm.define "test2" do |test2|
    test2.vm.hostname = "test2"
    test2.vm.network "private_network", ip: "10.9.8.6"
  end

done
```

<br/>

## Bringing up a virtual machine
```bash
vagrant up test1
```

<br/>

## Check the status of the virtual machines
```bash
vagrant status
```

<br/>

## SSH into the VM
```bash
vagrant ssh test1
```

<br/>

## Ping a VM
```bash
ping -c3 10.9.8.5
```











