# The while loop, Infinite loop, Shifting, Sleeping

## Demonstrates the use of shift and while loop
Read about the ```while``` command using ```help while```.

```bash
# Display the first three parameters
echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"
```

<br/>

## Creating an infinite while loop
Read about the ```true``` command. It's job is return an exit status of 0 (successful result). Additionally, read about the ```sleep``` command. It's an executable on the Linux system so you can use the man page to look it up (```man sleep```).

```bash
while [[ true ]]
do
  echo "${RANDOM}"

  # Sleep for 1 second
  sleep 1
done
```

<br/>

## The ```shell``` keyword
It's a shell builtin so you can use the ```help``` keyword. The code below shows how you can loop through positional parameters.

```bash
while [[ "${#}" -gt 0 ]]
do
  echo "Number of parameters: ${#}"
  echo "Parameter 1: ${1}"
  echo "Parameter 2: ${2}"
  echo "Parameter 3: ${3}"
  echo 
  shift
done
```
<br/>

