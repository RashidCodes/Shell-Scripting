# Reading standard input, Creating accounts, Username conventions, More Quoting

Bring up your virtual machine...

## Create an account on the local system

### Ask for the user's name
You can read about the ```$(read)``` command using: ```help read | less```

### A brief aside on inputs
There are different kinds of inputs namely:
- Standard Input: By **default**, standard input comes from the keyboard.
- Standard Output: Standard output is displayed on the screen.
- Standard Error: Standadr error is also displayed on the screen.

 
```bash
read -p 'Enter the username to create: ' USER_NAME

```

<br/>


### Ask for the real name
```bash
read -p 'Enter the name of the person who this account is for: ' COMMENT
```

<br/>


### Ask for the password
```bash
read -p 'Enter the password to use for the account: ' PASSWORD
```

<br/>



### Create the user
Read on the ```useradd``` command ```man useradd```. In order to add users to a system, you need superuser privileges. There's an option to the useradd command called ```-c --comment``` and its used to add a user. Generally, its a short description of a LOGIN and historically it's been used with the name of the LOGIN.

```-m, --create-home```: Creates the user's home directory if it does not exist. Use the man page to read more. Open the ```/etc/login.defs``` to see the default configuration.

```bash
useradd -c "${COMMENT}" -m ${USER_NAME} # The comment variable may contain spaces.

<br/>


### Set the password for the user
Read more the ```passwd``` command ```(man passwd)```. We'll be using the ```--stdin``` option to allow ```passwd``` to read the new password from standard input. We also want the user to change their password when they login. For this, we'll be using the ```-e, --expire``` option.

```bash
echo ${PASSWORD} | passwd --stdin ${USER_NAME} 
```

<br/>


### Force the user to change their password on first login
```bash
passwd -e ${USER_NAME}
```

<br/>

## Run this code using root priveleges because we are adding a user.

<br/>


## Switch users
```bash
sudo su - $USER_NAME
```

