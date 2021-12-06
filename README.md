# The ```Cut``` and ```Awk``` commands

Read about the ```cut``` command on the man page because it's not a shell builtin. It's a standalone utility.

## Display the characters of each line
```bash
# first character
cut -c 1 /etc/passwd

# third, fifth, and sixth characters
cut -c 3,5,6 /etc/passwd # cut spits out a set of characters thus no order is guaranteed
```

<br/>

## Display a range of character on each line
```bash
# fourth character to the seventh
cut -c 4-7 /etc/passwd

# fourth character to the end
cut -c 4- /etc/passwd

# first character to the fourth
cut -c -4 /etc/passwd
```

<br/>

You can also use ```-b``` to cut by byte.

<blockquote>Note that some characters that are made up of multiple bytes, for eg. UTF-8 characters.</blockquote>

## Using STDIN with cut
```bash
echo "nu" | cut -c 1
```

<br/>

## Cut by field
```bash
# print first field
echo -e 'one\ttwo\tthree' | cut -f 1

# print second field
echo -e 'one\ttwo\tthree' | cut -f 2
```

<br/>

## Specifying a delimiter with the ```cut```command
We use the ```-d``` option. 
```bash
echo 'one,two,three' | cut -d ',' -f 3
```

<blockquote> You may also not see people put space around the delimiter but this is not recommended. </blockquote>

For example cut won't work in the code below, because of the line-continuation character.
```bash
echo 'one\two\three' | cut -d \ -f 3
```


<br/>

## Change the output delimiter of the ```cut``` command using ```--output-delimiter```
```bash
# Notice that the output is delimited by the original delimiter
cut -d ':' -f 1,3 /etc/passwd

# Change it using the --output-delimiter option
cut -d ':' -f 1,3 --output-delimiter=',' /etc/passwd
```


<br/>

## The ```grep``` command
The grep command is used to print lines matching a pattern. Checkout the man page to learn more about the command.

Let's create some csv file
```bash
echo 'first,last' > people.csv
echo 'John,Smitt' >> people.csv
echo 'firstly,mclastly' >> people.csv
echo 'Mr. firstly,mclasty' >> people.csv
```

Let's say you want to print lines that contain the word 'first' in the csv file
```grep first people.csv```

### Using regular expressions with ```grep```
Let's match lines that start with the string, "first" using the caret symbol (```^```).

```grep '^first' people.csv```

You can also match the end of a string with the ```$``` symbol. For example, let's match lines that start with 'first' and end with 'last'.
```grep '^first,last$' people.csv```.

You can invert matching with the ```-v``` option.
```grep -v '^first,last$' people.csv```

Now we can remove the header using the following.
```grep -v '^first,last$' people.csv | cut -d ',' -f 1

You can also reverse the process by cutting first before 'grepping'.


### Splitting on multiple characters
Splitting on multiple characters can't be done using the cut command but you can leverage the power of the ```awk``` command. A demo is provided below.
```bash
cp people.csv people.dat

# edit people.dat as follows
DATA:firstDATA:last
DATA:JohnDATA:Smitt
DATA:firstlyDATA:mclasty
DATA:Mr. firstlyDATA:mclasty

```

You may want to split by 'DATA:' but this will not work
```cut -d 'DATA:' -f 2 people.dat```


## The ```awk``` command
This is where ```awk``` shines. 
```awk -F 'DATA:' '{print $2}' people.dat```

The ```-F``` option specifies a delimiter. The statement in ```{}``` represent some action.

You can print multiple fields as follows
```awk -F 'DATA:' '{print $2, $3}' people.dat```

You can see that ```awk``` separates the fields with a space. This is because the comma (```,```) represents the output field separator (OFS). ```awk``` has a special builtin variable called **OFS**. You can change this variable to whatever you'd like. To change a variable in ```awk```, use the ```-v``` to reassign that variable. So to change OFS to a space (```" "```), you can do this.
```awk -F ':' -v OFS=',' '{print $1, $3}' people.csv```

Instead of setting the OFS variable, you can specify a string
```awk -F ':'  '{print $1, "," $3}' /etc/passwd```.

You can also add strings to your print statements
```awk -F ':' '{print "COL1: " $1 "COL2: " $2}' /etc/passwd```


Unlike the ```cut``` command, the ```awk``` command allows you to specify an order for your fields. For example,
```awk -F ':' '{print $3, $1}' /etc/passwd``` prints the third fields before the first field.


In addition to $1, $2, and so on, ```awk``` gives us ```$NF``` which represents the *number of fields* found.
```awk -F ':' '{print $NF}' /etc/passwd```












