# Parsing command line arguments with ```getopts```
Getopts is shell builtin and you can check that using the ```type -a getopts``` command. It's recommended that shell builtins be used more often because it makes scripts more portable.

<br/>

## Provide documentation about the script

```bash
usage(){
  echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
  echo 'Generate a random password.'
  echo '  -l LENGTH   Specify the password length.'
  echo '  -s          Append a special character to the password.'
  echo '  -v          'Increase verbosity.'

  # If they ended up there then it means they did something wrong
  exit 1

}
``` 

<br/>

### Checking the ```VERBOSE``` option
```bash
log(){
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

```

<br/>

## Creating a script that generates a password using ```getopts```.

Have a read about the getopts command: ```help getopts```.


### Parsing the options with ```getopts```
```bash
LENGTH=48

while getopts vl:s OPTION
do 
  case ${OPTION} in
    v)
      VERBOSE='true'
      log 'Verbose mode on.'
      ;;

    l)
      LENGTH="${OPTARG}"
      ;;
    s)
      USE_SPECIAL_CHARACTER='true'
      ;;
    ?)
      usage
      exit 1
  esac
done


log 'Generating password'

```

<br/>


### Generating the password
```bash
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

# Append a special character if requested to do so
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
  log 'Selecting a random special character'
  SPECIAL_CHARACTER=$(echo '!@#$%^&*()_+=' | fold -w1 | shuf | head -c1)
  PASSWORDa="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done!'
log 'Here is the password.'

# Display the password
# Display the password whether VERBOSE is true or not
echo "${PASSWORD}"

exit 0

```


