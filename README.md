# Simple Plan
All of this should be done in POSIX shell.
TODO file should be parsed so that top level directories are created for each "# <foo>" line in the todo.
lines below the "# <foo>" until the next "# <foo>" should be new files or directories. If there are spaces before the entry
then that entry becomes a sub file/directory to the one created for the line above.

1) take the example format, TODO.txt, and make it into a filesystem structure. 
2) generate a directory of symlinks to all of the files within that filesystem strucuture.
3) implement a way to present those symlinks in an orderable manner
4) present possible improvements. For example, does this need its own search or can it simply use grep

