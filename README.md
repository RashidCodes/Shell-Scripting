# Disabling Linux accounts

The best way to lock a user's account for security reasons is to use the ```chage``` command. Read about it on the bash man page (```man chage```). Take a look at the ```-E``` option, which is used to expire an account.

```bash
# Expire the nanie account
sudo chage -E 0 woz
```

You can also lock the password of a specified account using the ```-l``` flag. Check out the man page for the ```passwd``` command. Locking a user with a password command like this does not prevent a user from logging in with an SSH key. So if users can login via SSH then you're better off using the chage command.
```bash
# Lock nanie's account
sudo passwd -l nanie
```

<br/>

Another method is to set the shell to something that is not a shell or something that simply exits. Look at the available shells on a system, you can look at the ```/etc/shells``` file. Setting the shell of a user to ```/sbin/nologin``` or ```/usr/sbin/nologin``` prevents a user from logging in. You can do this using the ```usermod``` command.

```bash
# read the about the usermod command
sudo usermod -s /sbin/nologin nanie
```

You can still do somethings with SSH without an interactive login such as **Port Forwarding**. So use the ```chage``` command to actually disable the acocunt.


<br/>

## A script that deletes a user
```bash
# Run as root
if [[ $UID -ne 0 ]]
then
  echo 'Please run with sudo or as root.' >&2
  exit 1
fi


# Assume the first argument is the user to delete
USER="${1}"

# Delete the user
userdel $USER

# Make sure the user got deleted
if [[ "${?}' -ne 0 ]]
then
  echo "The account $USER was NOT deleted." >&2
  exit 1
fi


# Tell the user the account was deleted
echo "The account $USER was deleted."

exit 0
```











