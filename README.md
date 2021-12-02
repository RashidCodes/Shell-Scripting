# Deleting and Disabling Linux accounts

The command to delete a user from our system is the ```userdel``` command. The ```userdel``` command may not be available in our path (after using the ```which``` command) so, we'll have to find it.

## Using the ```locate``` command
We'll be using the ```locate``` command to find the ```userdel``` command.
```bash
locate userdel
```

The db used by the ```locate``` command is not updated in real time so you may have to update the db to find a file you recently created using the code below.
```bash
# You need root privileges since updatedb searches the entire filesystem.
sudo updatedb 
```

Since we're looking for an executable, we can use the ```grep``` command to find executables in the ```bin``` or ```sbin``` directories.

```bash
locate userdel | grep 'bin'
```

<br/>

## Manually searching for the file
So let's say the ```locate``` command is not found; you can use your knowledge of the linux filesystem to find possible places where the ```userdel``` command might live. For example,
```userdel``` is a system admin command and similar commands can be found in the ```sbin``` directory. Moreover, since the command is an executable, you can narrow search to the ```bin``` and ```sbin``` directories.

<br/>


## Using the ```find``` command
```bash
find /usr/sbin/ -name userdel

## Another way to use the command
find / -name userdel 2> /dev/null # redirecting STDERR to the bitbucket
```

If the file is found in a location a user does not have access to, then the command has to be run using superuser privileges.
```bash
sudo find / -name userdel 2> /dev/null
```

Or you can simply switch to root ( not recommended) using ``` su - ```.'


