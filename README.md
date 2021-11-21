# Special Variables

## Display the UID and username of the user executing this script
You can use the man page to read the documentation on UID: $(man bash) and search for 'UID' (/UID). 
Note that on the man page, parameters enclosed in square brackets are **optional**.

```bash

# Display the UID
echo "Your UID is $UID"	

# Display the username: Use the id command ```$(man id)```
USER_NAME=$(id -un)
echo "Your username is $USER_NAME"
```


## Root user or not
When you're using variables like this, you want to enclose them in quotation marks. Use $(help if) for help on the if statement. You can use the test command ```$(man test)``` to learn about testing with the if statement

```bash

if [[ "${UID}" -eq 0 ]]
then
  echo "You are root."
else
  echo "You are not root."
fi
```

<br/>

## Execute as root
```bash
sudo ./this_file.sh
```

