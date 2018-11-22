# File Database (fdb)
  A simple database system that uses a files in a file system for record
storage.

## Storage Format
  We create a binary image of zero's:

```
  dd if=/dev/zero of=$databases/$name.fdb bs=1024 count=1000
```

  Then we turn it into an ext4 filesystem:

```
  mkfs.ext4 $databases/$name.fdb
```

  Then we mount it so fdb can use it:

```
  sudo mount -o loop $databases/$name.fdb $databases/$name
```

### Points
* We could share the mount on the network.  Transactions would be an issue,
and probably data corruption.
* Using the file system in this way supplements the need for using a heavy
API.
* We could tune the parameters of the file system that we are using to make
it faster, and to favor many small files.  The inode metadata is probably
just as large as some records maybe?
* You could use a remote shell to run commands on this database.  We could
restrict what that remote user can do based on file permissions.
* Instead of using character block devices, could we use pipes or FIFOs
to give us transactions?

## CRUD Operations
### Inserting (insert.sh)
  We can implmenet SQL easy enough using shell scripts and arguments.

```
  ./insert.sh into <table> values <token1,token2,...,tokenN>
```
  
  The primary key isn't specified in values.  It's calculated by the insert
script.

### Points
* What if we created programs that relied more on pipes vs argument parsing?
```
echo -n "Ryan,Warren,36" | insert into persons
```
