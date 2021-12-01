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

# Inspect OPTIND
echo "OPTIND: $OPTIND"

# Remove the options while leaving the remaining arguments
shift "$(( OPTIND - 1))"

# Now you can parse arguments using ${a}, ${#}, and so on
# Let's check to make sure users don't pass in any arguments from the command line
if [[ "{#}" -gt 0 ]]
then
  usage
fi

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


<br/>
<br/>

## Arithmetic Expansion
You can perform arithmetic operations using the code below
```bash
# Basic substraction
NUM=$((10 - 1))

# Post increment
NUM=$((NUM++))

# Post decrement
((NUM--)) # notice that we didn't need the '$' sign here

# Increment and reassignment
((NUM += 5))

# Modulo
NUM=$((NUM % 2)) # Checking for even numbers


# Using variables
a=10
b=20

NUM=$(( a + b )) # Notice how we did not use the '$' symbol


```

If you need to perform complex calculations then perhaps you can use an external program, for eg. bc which stands for external calculator. You can install it using ```sudo yum install -y bc```. Read about bc command. 
```bash
# Float operations using the basic calculator
echo '6/4' | bc -l

# You can also use the awk command
awk 'BEGIN {print 6/4 }'
```


<br/>

### The ```let``` bash builtin
Read about ```let```: ```help let```. It pretty much does the same thing as using double parenthesis.

```bash
let NUM++	
echo $NUM
```

<br/>

### The ```expr``` command
The ```expr``` command processes an expression and returns it output to STDOUT. Read about it using ```man expr```

```bash
expr 1 + 1

NUM=$(expr 2+3)
```





