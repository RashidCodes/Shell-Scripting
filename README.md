# The ```sort``` command
The ```sort``` command is used to sort the lines of text files. Peruse the man page for the ```sort``` command for more information.

```sort /etc/passwd```. 

Use the ```-r``` option to reverse the result.

```sort -r /etc/passwd```

Sort can also except *STDIN* for example,

cut -d ':' -f 3 /etc/passwd | sort 

Use the ```-n``` option to sort numerically
cut -d ':' -f 3 /etc/passwd | sort -n


## The ```du``` command

The ```du``` command is used to estimate file space usage. Let's find out which directory in ```/var``` uses the most space.

sudo du /var | sort -n

Let's usage the ```-h``` option of du to print the sizes in a human-readable form

sudo du -h /var | sort -n


Sort has a human-readable sort. Implement this using the ```-h``` option.


## Using ```netstat``` with sort
The ```netstat``` command is used to print network connections, routing tables, etc. Read about ```netstat``` on its man page.

Let's list all open ports using tcp and udp protocols

```netstat -nutl```

Let's look for the open ports using the ```grep``` command

```netstat -nutl | grep ':'```

The ip and port can extracted using ```awk``` as follows.

```netstat -nutl | grep ':' | awk '{print $4}'```

It's now easy to extract the port

```netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}'```

We can now sort the ports
```netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -nu```

The ```-u``` option in ```sort``` takes into account, unique values.

<br/>


## Sorting with a key
Use the ```-t``` option to specify a delimiter for the file, and then use the ```-k``` option to sort by key.

```cat /etc/passwd | sort -t ':' -k 3 -n```



## The ```uniq``` command
The ```uniq``` command reports or omits repeated lines. Checkout the man page about the command.

```netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq```

This may look like an extra step but the ```uniq``` command has other useful features. For example, you can count the number of repettions of a line.

```netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq -c```

Let's say you want to count the number of *syslog* messages a program is generating. The folder of interest is ```/var/log/messages```. 

```sudo cat /var/log/messages | awk '{print $5}' | sort | uniq -c | sort -n```


<br/>

## The ```wc``` command
The ```wc``` command is used to print the newline, word, and byte counts for each file. Peruse the man page for more information. Let's use the ```wc``` command to get some information about users on a linux system.

```wc /etc/passwd```

The first number is the number of lines, the second is the number of words, and the last is the number of bytes.


### How many accounts are using the ```bash``` shell

```grep bash /etc/passwd | wc -l```

You can also use the ```-c``` option for ```grep``` to count the number of lines.


<br/>


## Parsing a web log file
We'll end this session by parsing a sample log file (access_log) to find the number of times the different end-points have been hit.

```cut -d  '"' -f 2 access_log | awk '{print $1}' | grep 'http*' | uniq -c```










