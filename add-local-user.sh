#!/bin/bash

# This script adds users to the same Linux system that the script is executed on.

## Check if the user is a root user
if [[ $(id -u) -ne 0 ]]
then
  echo "You must execute this script with root privileges".
  exit 1
fi


## Go on to add the user if the script is executed with superuser privileges.

if [[ $? -eq 0 ]]
then
  # Get the username
  read -p 'Enter the username of the new user: ' USER_NAME

  # Get the user's full name
  read -p 'Enter the full name of the new user: ' COMMENT

  # Get the password of the user
  read -p 'Please enter a password for the new user: ' PASSWORD

  # Display details
  echo "========================"
  echo "      USER DETAILS"
  echo "========================"
  echo "Username: ${USER_NAME}"
  echo "Full name: ${COMMENT}"


  # Creating user
  echo "Creating user ${USER_NAME}..."
  useradd -c "${COMMENT}" -m "${USER_NAME}"
  
  # Create the password for the user
  echo "${PASSWORD}" | passwd --stdin ${USER_NAME}

  # Make sure the LOGIN resets the password
  passwd --expire ${USER_NAME}

  echo "User creation complete"

fi

## Alert the user 
if [[ $? != 0 ]]
then
  echo "An error occured in the creation of the user: ${USER_NAME}. Consult your system administrator for assistance".
  exit 1
fi

exit 0
