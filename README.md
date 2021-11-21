# Exit Statuses, Return Codes, String Test Conditionals, More Special variables

## Display the UID and username of the user executing this script

```bash
echo "Your UID is ${UID}"
```

<br/>

## Display if the UID does not match 1000

You can read more about exit statuses by using the man page
```bash
man useradd

## Then search for "EXIT VALUES"
```

<br/>

```bash
UID_TO_TEST_FOR='1000'

if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
  echo "Your UID does not match ${UID}."
  
  # Stop the execution of a script using the exit command
  exit 1
fi 

<br/>

## Display the username
USER_NAME=$(id -un)
```

<br/>

## Test if the command succeeded

```${?}``` checks the exit status of the most recently executed command

```bash
if [[ "${?}" -ne 0 ]]
then
 echo "The id command did not execute successfully"
 exit 1
fi

echo "Your username is $USER_NAME" 
```

<br/>

## Use a string test conditional
```bash
USER_NAME_TO_TEST_FOR='vagrant'

if [[ ${USER_NAME} = ${USER_NAME_TO_TEST_FOR} ]]
then
  echo "Your username matches ${USER_NAME_TO_TEST_FOR}"
fi
```

## Test for != (not equal) for the string
```bash
if [[ ${USERNAME} != ${USER_NAME_TO_TEST_FOR} ]]
then
  echo "Your username does not match $USER_NAME_TO_TEST_FOR"
  exit 1
fi

## Successful execution
exit 0
```











