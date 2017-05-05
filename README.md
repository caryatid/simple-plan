# Simple Plan
All of this should be done in POSIX shell.
TODO file should be parsed so that top level directories are created for each line in the todo without indentation
deeper indentation indicates a child of the highter indentation then that entry becomes a sub file/directory to the one created for the line above.

1) take the example format, TODO.txt, and make it into a filesystem structure.
2) generate a directory of symlinks to all of the files within that 
   filesystem strucuture.
3) implement a way to present those symlinks in an orderable manner
4) Is there an issue with how you handle changing existing files into a
   directory and a file?
5) can this take a directory and dump to a file?
6) Does this need its own search or can it simply use grep
7) perhaps implement some commands to add or remove entries.
   May just switch to plan proper
