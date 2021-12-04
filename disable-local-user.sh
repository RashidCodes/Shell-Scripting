# This script allows for a local linux account to be disabled, deleted, and optionally archived.


## the script should be executed with superuser privileges
if [[ $UID -ne 0 ]]
then
  echo 'Execute this script with superuser privileges.' >&2
  exit 1
fi


## Usage function
usage(){
  echo "Usage: ${0} [-dra] USER_NAME" >&2
  echo 'Disable, delete, and archive a user. Use -d to delete a user instead of disabling them. Use -r to remove the home directory of the deleted user. Lastly, use -a to archive the home directory of the deleted user.' >&2.
  exit 1
}

## Only one argument is accpeted
if [[ "${#}" -lt 1 ]]
then
  usage
fi



for NAME in "${@}"
do
  
  # Get the username
  USER_NAME="$NAME"

  # User ID
  USER_ID=$(id -u $USER_NAME)
  
  # Do not delete any user accounts that have a UID less than 1000
  if [[ $USER_ID -gt 1000 ]]
  then  
  
    ## Expire an account
    chage -E $USER_NAME

    ## Check the exit status of the chage command
   if [[ "${?}" -ne 0 ]]
   then
     echo "${USER_NAME} was not disabled" >&2
   else
     echo "${USER_NAME} was successfully disabled"
   fi
    
    
    ## Delete the account if the user specifies the following options
    while getopts dra OPTION
    do
      case "${OPTION}" in
        d)
          userdel $USER_NAME
          if [[ "${?}" -ne 0 ]]
          then
            echo "${USER_NAME} was not deleted"
          else
            echo "${USER_NAME} was successfully deleted"
          ;;
        r)
          # Remove the user's home directory
          userdel -r $USER_NAME
          if [[ "${?}" -ne 0 ]]
          then
            echo "${USER_NAME} was not deleted"
          else
            echo "${USER_NAME} was successfully deleted"
          ;;
        a)
          # check if the archives directory exists
          if [[ -d "archives" ]]
            tar -cvf "archives/${USER_NAME}.tar" "/home/$USER_NAME" 
    
            # Check the exit status of the tar command
            if [[ "${?}" -eq 0 ]]
            then
              echo "Successfully saved ${USER_NAME}'s home directory." 
            else
              echo "Could not save ${USER_NAME}'s home directory." >&2
    
          else
             # Create the archive folder 
             echo "The archives directory does not exist. Creating archive directory..."
             mkdir archive
             echo "Successfully created the archive directory"
             tar -cvf "archives/${USER_NAME}.tar" "/home/$USER_NAME"
             
             # Check the exit status of the tar command
             if [[ "${?}" -eq 0 ]]
             then
               echo "Successfully saved ${USER_NAME}'s home directory." 
             else
               echo "Could not save ${USER_NAME}'s home directory." >&2
           ;;
    
         ?)
           usage
        esac
    done
  fi
done


