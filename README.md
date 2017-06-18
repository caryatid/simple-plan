# Simple Plan
All of this should be done in POSIX shell.
TODO file should be parsed so that nesting is indicated by indentation.
Create directories for every entry with sub entries. Create a file for each entry
without sub entries. 

## Example 
"import-plan.sh" is a simple implementation and shows a 
reasonable output. Run with the "TODO.txt" file as its argument.

# Tasks
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
8) Makefile
