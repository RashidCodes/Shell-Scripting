# The case statement

Have a read about the case statement using ```help case```.

```bash
# The case command matches patterns

case "${1}" in
  start)
    echo 'Starting.'
    ;;
  stop)
    echo 'Stopping.'
    ;; 
  status|state|--state|--status)
    echo 'Status:'
    ;;
  *)
    # Catchall to match anthing that has not be accounted for
    echo 'Supply a valid option' >&2
    exit 1
    ;;
esac
```

