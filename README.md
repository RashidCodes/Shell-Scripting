# How to create functions using bash

Read about functions using the function builtin command. Use ```help function``` to read about functions. Functions are like littel scripts within a script.

```bash
#!/bin/bash

# Creating the function
# Functions have to be defined before they're used.
log(){
  echo 'You called the log function'
}

# You can also create a function using the function keyword
function log(){
  echo 'You called the log function'
}

# calling the function: You don't need to use the openeing parenthesis
log
```

<br/>

## The ```local``` keyword and passing arguments
Local makes a variable **local** in-scope to the function. The value of that variable is only accessible within the function. The local function can only be used within a function. It's best practice to use local variables inside your functions that way you won't accidentally reuse variable names.

```bash
log(){
  local MESSAGE="${@}"
  echo "${MESSAGE}"
}

log 'Hello!'
log 'This is fun!'
```

<br/>

## A look at global variables
```bash
log(){
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

log 'Hello!'

## Setting the global VERBOSE variable to true
VERBOSE='true'

log 'This is fun!'

```

<br/>

## The ```readonly``` command
The readonly command makes a variable unchangeable or unmodifiable. Think of it as a ```const``` from Javascript. The variable cannot be changed for the duration of the script. Thus, it cannot be changed inside or outside of a function.

```bash
log(){
  local message="${@}"
  if [[ "${verbose}" = 'true' ]]
  then
    echo "${message}"
  fi
}

log 'hello!'

## setting the global verbose variable to true
verbose='true'
readonly verbose

## you can also do this
readonly verbose='true'

log 'this is fun!'

```

<br/>


## Sending messages to the system's log
Read about the logger command using ```man logger```. The logger command writes messages to the ```/var/log/messages```. You need root permissions to read that file so you'll have to read it's data using something like ```sudo tail /var/log/messages```.

An example of how the ```logger``` command is used.
```bash
# The -t command tags the name of the service or program using the logger
logger -t my-script 'Tagging on.'
```

### Adding the logging functionality to our script
```bash
log(){
  local message="${@}"
  if [[ "${verbose}" = 'true' ]]
  then
    echo "${message}"
  fi
  
  # Sent the message to the log file
  logger -t "${0}" "${message}"
}

log 'hello!'

## setting the global verbose variable to true
verbose='true'
readonly verbose

## you can also do this
readonly verbose='true'

log 'this is fun!'

```

<br/>


## Backing up files
Here we use a function to backup a few files. 


### A brief aside about the ```/tmp``` directory

The files in ```/var/tmp/``` survive a reboot whereas the files in ```/tmp/``` are not guaranteed to survive a reboot. Typically the files in ```/tmp/``` are cleared on boot and are also cleared more often than on a running system.

<br/>

### A brief aside about the ```cp``` command. The ```-p``` option copies a file in preserve mode. This keeps the timestamps the way they were instead of using today's timestamp. A use case for this could be when the need arises to replace a lost file. The file can then be replaced using the original copy. 

```bash
backup_file(){
  # This funciton creates a backup of a file. Returns non-zero status on error.

  local FILE="${1}"

  # Make sure the file exists
  if [[ -f "${FILE}" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log "Backing up ${FILE} to ${BACKUP_FILE}."

    # The exit status of the function will be the exit status of the cp command
    cp -p ${FILE} ${BACKUP_FILE}
  else
    # The file does not exist, so return a non-zero exit status
    return 1

  fi
}

```

Each function, like every command, returns an exit status. By default, a function returns the exit status of the last command in that function. Remember that the ```exit``` keyword exits the entire script whereas the ```return``` keyword exists a function.


<br/>

### Backing up the ```/etc/passwd``` file
```bash
backup_file '/etc/passwd'


## Check the status of the function
if [[ "${?}" -eq '0' ]]
then
  log 'File backup succeeded!'
else
  log 'File backup failed!'
  exit 1
fi
```

<br/>

### Check to see if the messages made it to the log file
```bash
sudo tail /var/log/messages
```

<br/>

### Check if the file was copied to ```/var/tmp```
```bash
ls -l /var/tmp
```

<br/>

Lastly, you can use the ```type -a ${function-name}``` command to read the code that makes up a function called ***function_name***


