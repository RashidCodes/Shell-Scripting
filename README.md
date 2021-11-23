# Positional Parameters, Arguments, for Loops, and Special Parameters

These scripts generate a random password for each user specified on the command line. I learned a lot about the ```PATH``` variable in this tutorial.


<br/>

## Display what the user typed on the command line
```bash
echo "You executed this command: ${0}"
```

<br/>

## A brief aside about the ```PATH``` variable
The path variable is an environment variable that contains an ordered list of paths that Linux will search for executables when running a command. Using these paths means that we do not have to specify an absolute path when running a command.
```bash
>>> echo ${PATH}
/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/sbin:/home/vagrant/bin
```

The path variable is not read-only so it can be modified. For example, we can redirect Linux to look for the ```head``` command in /usr/local/bin instead of the orignal /usr/bin as shown in the code below. You many need superuser privileges to execute some of the commands.

```bash
# the location of the original head command
>>> which head
/usr/bin/head

# redirect Linux: first we'll create a new executable called 'head'
echo "this is my head" >  /usr/local/bin/head

# the new head command
>>> which head
/usr/loca/bin/head

# remove the new head file
>>> rm /usr/local/bin/head

# Rehash all locations: Read about the hash command
hash -r

# the original head is restored
which head 
/usr/bin/head

```

## Adding a custom script to the path
Let's say I created some script called ```rashid.sh```.

```bash
# Copy the file to one of the folders in the path
sudo cp rashid.sh /usr/local/bin

```

Now we can execute ```rashid.sh``` without supplying a path to the script.
```bash
>>> which rashid.sh
/usr/local/bin/rashid.sh
```

Note that ```${0}``` will return the full path of rashid.sh.


<br/>

## The ```basename``` and ```dirname```  commands.
Read about the basename and dirname commands on the man page. 
```bash
echo "You used $(dirname ${0}) as the path to the $(basename ${0}) script."
```


<br/>

## Special Parameters
Go to the man page and search for "special parameters" to see the list of special parameters you can use in bash.

### Number of arguments passed in using a special parameter (```#```)
```bash
NUMBER_OF_PARAMETERS=${#}
echo "You supplied $NUMBER_OF_PARAMETERS argument(s) on the command line."
```

<br/>

## Make sure users supply at least one argument
```bash
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [USER_NAME]..."
  exit 1

fi
```

<br/>

## The ```for``` loop.
Read on the ```for``` command. It's a shell keyword so ```(help for)```. Also read about the @ and * special parameters.
```bash
for USER_NAME in "${@}"
do
 PASSWORD=$(date +%s%N | sha256sum | head -c48)
 echo "${USER_NAME}: ${PASSWORD}"
done
```


