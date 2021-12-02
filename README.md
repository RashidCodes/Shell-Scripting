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
```userdel``` is a system admin command and similar commands can be found in the ```sbin``` directory. Alternatively, since the command is an executable, you can narrow search to the ```bin``` and ```sbin``` directories.

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


<br/>

## Removing a user
```bash
userdel nanie
```

Using the ```userdel``` command like this deletes the user but keeps the user's files on the system. This might come in handly if you want access to a user's files after they have been removed.

<br/>

## Remove a user and their home directory
```bash
userdel -r nanie
```

<br/>

## A brief aside about UID's
The root user always has a ```UID``` of 0. System accounts have lower UID's. This is set in a file called ```/etc/login.defs```. Peruse it if you will.


<br/>

## Storing home directories with the ```tar``` command. Peruse the man page for this command (```man tar```).
```
# Create some random videos
mkdir catvideos
touch catvideos/admiral-catbar.mp4
touch catvideos/darthpaw.mp4
touch catvideos/luke-claw.mp4


# creat an archive of the cat videos
tar -cf catvideos.tar catvideos

# Look at its contents
tar -tf catvideos.tar 

# remove the old tar file
rm catvideos.tar

# Using the verbose option to see the files added to the archive
tar -cvf catvideos.tar catvideos

# extracting the contents of a tar file
mkdir restore
cd restore
tar -xf ../catvideos.tar 


# extracting with the verbose option
mkdir restore
cd restore
tar -xvf 
```


<br/>

## Compressing a tar file
```bash
gzip catvideos.tar
```

<br/>

## Uncompress a tar file
```bash
gunzip catvideos.tar.gz
```

<br/>

You can also perform the compression on the archive when you create it.
```bash
tar -zcvf catvideos.tar.gz catvideos/

# View the contents of a compressed archive
tar -ztvf catvideos.tar.gz 
```

<br/>

Some people like to give a compressed archive a file extension of ```tgz```. for example
```bash
tar -zcvf catvideos.tgz catvideos/
``
`


The tar command will happily overwrite any existing files. Keep that in mind.
```bash
# Let's put some data in darthpaw
echo 'hello' > catvideos/darthpaw.mp4

# Extract the archive again
tar -zxvf ../catvideos.tgz

# View the contents of darthpaw
cat catvideos/darthpaw.mp4 # Nothing is found because tar overwrote the file
```

<br/>

```tar``` relies on file permissions like any other command does. So you can't use tar on files you don't have permissions to.









