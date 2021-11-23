# Random Data, Cryptographic Hash Functions, Text and String Manipulation


## Generate a list of random passwords
Read on the ```RANDOM``` variable on the man page.
```bash
PASSWORD=${RANDOM}

# Three random numbers together
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
```

<br/>

## Using the date and time to create a password
Read about the ```date``` command on the man page. The ```head``` and ```sha256sum``` commands are also worth checking out.
```bash
PASSWORD=$(date +%s%N)
```

<br/>

## Creating a better password
```bash
PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "$PASSWORD"
```

<br/>

## An even better password
Adding a few random numbers and increasing the password length
```bash
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
```

<br/>

## Adding a special character
```bash
LIST_OF_SPECIAL_CHARACTERS='!@#$%^&*()_+='

## We need to select one character at random
SPECIAL_CHARACTER=$(LIST_OF_SPECIAL_CHARACTERS | fold -w1 | shuf | head -c1)

## Append the special character to the password
PASSWORD=${PASSWORD}{SPECIAL_CHARACTER}"
``


