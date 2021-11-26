# Advanced Standard Input, Standard Output, and Standard error

There are three kinds of I/O namely:
- Standard Input
- Standard Output
- Standard Error

<br/>

## Redirect the standard output of a command into a file

```bash
FILE='/tmp/data'

# Redirecting the output away from the screen and into /tmp/data
head -n1 /etc/passwd > $FILE
```


File permissions are in play too. So, if you try to redirect output into a file you don't have read permissions for, you'll get an error. For example, the code below returns an error when the vagrant user is used.

```bash
echo $UID > /uid
```

<br/>

## Read the contents of a file to standard output
```bash
read SOMEDATA < $FILE

# print the data
echo $SOMEDATA
```

<br/>

## Appending to a file
```bash
echo 'This is new content' >> $FILE

# Check out the new content
cat $FILE | tail -n2
```

<br/>

## File descriptors
It's simply a number that represents an open file. There are three kinds of file descriptors namely:
- FD0 - STDIN
- FD1 - STDOUT
- FD2 - STDERR


You can **implicitly** read data into a variable like this:
```bash
read X < /etc/centos-release
```
However, if you wanted to be explicit (using file descriptors), you'll have to do this
```bash
read X 0< /etc/centos-release

# Look at the value of X
echo "${X}"

# Another example
echo "${UID}" 0> uid

```
If you don't supply a file descriptor then 0 is assumed for **STDIN**.


<br/>

## Redirecting errors
We are going to be analyzing the ```head``` command. We'll try to redirect its **STDOUT** and **STDERR**.

```bash
# This generates STDOUT
head -n1 /etc/passwd /etc/hosts

# This generates STDOUT and STDERR
head -n1 /etc/passwd  /etc/fakefile
```

We'd like to redirect **STDERR** to a file
```bash
head -n1 /etc/passwd /etc/fakefile 2> head.err
```

We can also redirect both **STDOUT** and **STDERR** on one line.
```bash
head -n1 /etc/passwd /etc/fakefile > head.out 2> head.err
```

The file descriptor ```2>``` always appends to a file.

We can also send **STDOUT** and **STDERR** to the same file. Well, here's the old way of doing it
```bash
head -n1 /etc/passwd /etc/hosts /fakefile > head.both 2>&1
```

Here, we redirect STDOUT to head.both. Then, STDERR is redirected to STDOUT which is then redirected to head.both. Basically, we're redirecting STDERR to STDIN. This is possible with ```&1```. There's another way though...

```bash
head -n1 /etc/passwd /etc/hosts /fakefile &> head.both
```
Using ```&>>``` appends to the file.


<br/>

## STDERR does not flow through the pipe.
```bash
# This produces 6 lines
head -n1 /etc/passwd /etc/hosts /fakefile

# Passing it through the pipe filters the STDERR
head -n1 /etc/passwd /etc/hosts /fakefile | cat -n
```

If you wanted to pass both STDOUT and STDERR through the pipe, then you can add STDERR to STDOUT
```bash
head -n1 /etc/passwd /etc/hosts /fakefile |& cat -n
```

## Redirecting to STDERR
Remember that you can redirect anything to STDERR or STDOUT. For example, let's redirect 'error' to STDERR

```bash
echo 'error' >&2
```
The ```&``` comes in when you specify a **file descriptor** instead of a file name.

<br/>

## Redirecting to the **Null Device**
We can redirect STDOUT or STDERR to the null device if we don't want to display it on our screen. For example, in the code sample below, we redirect STDERR to the null device and only display STDOUT
```bash
head -n1 /etc/passwd /etc/hosts /fakefile 2> /dev/null
```

You can also redirect all output to the null device
```bash
head -n1 /etc/passwd /etc/hosts /fakefile &> /dev/null
```

Redirect STDOUT to the null device
```bash
head -n1 /etc/passwd /etc/hosts /fakefile > /dev/null
```
<br/>

**USE CASE**: If you're executing a command in your script and you don't want the user to see the output of the command then just redirect it to the null device. If you wanted to know if a command succeeded or not, you can simply check the exit status.





