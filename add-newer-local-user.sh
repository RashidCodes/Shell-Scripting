#!/bin/bash

# Make sure the script is executed using root privileges
# You can also use $UID
if [[ $(id -u) -ne 0 ]]
then
  echo "Please run with sudo or root" >&2 # redirecting to standard error
  exit 1
fi


# Get the parameters
if [[ "${#}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [COMMENTS]..." >&2
  echo 'Create an account on the local system with the name of USER_NAME and a comments field of COMMENT' >&2
  exit 1
fi


# Using the first argument as the username
USER_NAME=${1}

# Chop off the first argument
shift

# Get the comments
COMMENT="${@}"

# Create a password for the user
PASSWORD=$(date +%s%N"${USER_NAME}" | sha256sum | head -c48)

# Add a special character to the password
ALL_SPECIAL_CHARACTERS='!@#$%^&*()_='
SPECIAL_CHARACTER=$(echo "${ALL_SPECIAL_CHARACTERS}" | fold -w1 | shuf | head -c1)
echo "Special character: $SPECIAL_CHARACTER"


# Create the user
useradd -c "$COMMENT" -m "$USER_NAME" &> /dev/null


# Check for the return status just in case the useradd command failed
if [[ ${?} -ne 0 ]]
then
  echo 'The account for $USER_NAME could not be created' >&2
  exit 1
fi


# Give the user a password
echo $PASSWORD | passwd --stdin $USER_NAME &> /dev/null

# Check to see if the passwd command succeeded
if [[ ${?} -ne 0 ]]
then
  echo 'The password for the account could not be set' >&2
  exit 1
fi


# Force the login to change their password
passwd -e ${USER_NAME} &> /dev/null


# Display the user credentials
echo
echo '=============='
echo " USER DETAILS"
echo '=============='
echo "Username: $USER_NAME"
echo "Password: $PASSWORD"
echo "Host: ${HOSTNAME}"
echo

# End the script successfully
exit 0





