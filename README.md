#  Naming Permissions

## Create a new file
```bash
vi luser-demo01.sh
```

<br/>

Note: File extensions don't matter on Linux

<br/>

```bash
#!/bin/bash

# Displaying information to the screen

echo 'Hello'
```

## Permissions on a file

```bash
-rw-r--r-- 1 vagrant vagrant
```

r - read
w - write
x - executable

- The first three characters ```(rw-)``` represents the permissions of the owners of the file, 
- the next three characters ```(r--)``` represent the permissions of the group of the file,
- and the last three characters ```(r--)``` represent the permissions that everyone else has to this file.


<br/>

## Grant executable permissions
We need to give users the ability to execute this file. This is done with ```chmod``` like the code below

```bash
chmod 755 luser-demo01.sh
```

This changes the permission to 
```bash
-rwxr-xr-x
```

<br/>

## Why 755?
- r = 4
- w = 2
- x = 1

## Executing the script
```bash
./luser-demo01.sh
```

<br/>


# Shell builtins

## The echo command

Check if a command is a shell builtin using the command below

```bash
type -a echo
```

## Get help on a shell builtin
```bash
help echo | less
```


<br/>

## Get help on commands that are not shell builtins
You can use the ```man ${command}``` command to read the manual of a command

```bash
man uptime
```


<br/>

## Assigning variables
It's very important that there are no spaces around the equal signs.
```bash
WORD='script'
```

<br/>

## Referencing a variable
```bash
# Single quotes prevent the expansion of variables
echo "${WORD}"

# Or

echo "This is a $WORD"

# Appending text to a variable: You need to use the ${} syntax
echo "Bash ${WORD}ing is fun"
```






