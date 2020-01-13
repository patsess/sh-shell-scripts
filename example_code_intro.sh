
### EXAMPLE BASH CODE TAKEN FROM AN ONLINE COURSE ###

# How can I copy files?:
cp original.txt duplicate.txt  # copy single file
cp seasonal/autumn.csv seasonal/winter.csv backup  # copy multiple files to directory

# How can I move a file?:
mv autumn.csv winter.csv ..  # move multiple files to parent directory

# How can I rename files?:
mv course.txt old-course.txt

# How can I delete files?:
rm thesis.txt backup/thesis-2017-08.txt  # delete multiple files (and in different directories)

# How can I create and delete directories?:
# function to delete (empty) directory: rmdir

# How can I view a file's contents?:
cat agarwal.txt

# How can I view a file's contents piece by piece?:
less seasonal/spring.csv seasonal/summer.csv  # view multiple files (:n and :q then useful commands)

# How can I look at the start of a file?:
head seasonal/summer.csv

# How can I control what commands do?:
head -n 3 seasonal/summer.csv  # view first three lines of file

# How can I list everything below a directory?:
ls -R  # 'R' for "recursive"

# How can I get help for a command?:
man head  # see documentation (the "manual") of the 'head' function

# How can I select columns from a file?:
cut -f 2-5,8 -d , values.csv  # get 2nd, 3rd, 4th, 5th and 8th columns, using a comma as the delimiter, of a file
# note: the 'cut' function cannot handle the presence of the delimiter in strings, e.g. "Bloggs, Joe"

# How can I repeat commands?:
history
!55  # after viewing the history of commands (which includes their call index), calling (e.g.) '!55' will re-run the 55th command in your history
!head  # re-run the last call of the 'head' function

# How can I select lines containing specific values?:
grep bicuspid seasonal/winter.csv  # view lines containing "bicuspid" in a file
# note: common arguments for the 'grep' function include:
#   -c: print a count of matching lines rather than the lines themselves
#   -h: do not print the names of files when searching multiple files
#   -i: ignore case (e.g., treat "Regression" and "regression" as matches)
#   -l: print the names of files that contain matches, not the matches
#   -n: print line numbers for matching lines
#   -v: invert the match, i.e., only show lines that don't match

# How can I store a command's output in a file?:
head -n 5 seasonal/summer.csv > top.csv  # save output of call to a new file called 'top.csv'

# How can I use a command's output as an input?:
head -n 5 seasonal/winter.csv > top.csv  # this method (including command immediately below) uses a an extra (temporary) file, 'top.csv'
tail -n 3 top.csv

# What's a better way to combine commands?:
head -n 5 seasonal/summer.csv | tail -n 3  # uses a pipe

# How can I combine many commands?:
cut -d , -f 1 seasonal/spring.csv | grep -v Date | head -n 10

# How can I count the records in a file?:
wc  # (short for "word count") prints the number of characters
# note: to make it print only one of these using -c, -w, or -l respectively

# How can I specify many files at once?:
cut -d , -f 1 seasonal/winter.csv seasonal/spring.csv seasonal/summer.csv seasonal/autumn.csv
cut -d , -f 1 seasonal/*.csv

# What other wildcards can I use?:
# other (less commonly) wildcards:
#   ? matches a single character, so 201?.txt will match 2017.txt or 2018.txt, but not 2017-01.txt.
#   [...] matches any one of the characters inside the square brackets, so 201[78].txt matches 2017.txt or 2018.txt, but not 2016.txt.
#   {...} matches any of the comma-separated patterns inside the curly brackets, so {*.txt, *.csv} matches any file whose name ends with .txt or .csv, but not files whose names end with .pdf.

# How can I sort lines of text?:
# function to sort output: sort
# note: -n and -r can be used to sort numerically and reverse the order of its output, while -b tells it to ignore leading blanks and -f tells it to fold case (i.e., be case-insensitive)

# How can I remove duplicate lines?:
# function to remove **adjacent** duplicated lines: uniq
# note: the 'uniq' function is often used with the 'sort' function

# How can I save the output of a pipe?:
cut -d , -f 2 seasonal/*.csv | grep -v Tooth > teeth-only.txt
# note: the '>' should not appear in the middle of the pipeline

# How can I stop a running program?:
^C  # typing "Ctrl + C", note that the 'C' can be lower case

# How does the shell store information?:
# **environment variables** are one type of variable, they are available all the time (conventionally written in upper case)

# note: commonly-used environment variables include:
#   Variable	Purpose	Value
#   HOME	User's home directory	                /home/repl
#   PWD	Present working directory	                Same as pwd command
#   SHELL	Which shell program is being used	/bin/bash
#   USER	User's ID	                        repl
# To get a complete list (which is quite long), you can type 'set' in the shell.

# How can I print a variable's value?:
echo $USER

# How else does the shell store information?:
# **shell variable**, which is like a local variable in a programming language
training=seasonal/summer.csv
echo $training

# How can I repeat a command many times?:
for filetype in gif jpg png; do echo $filetype; done  # prints gif jpg png (on different lines)

# How can I repeat a command once for each file?:
for filename in seasonal/*.csv; do echo $filename; done

# How can I record the names of a set of files?:
datasets=seasonal/*.csv
for filename in $datasets; do echo $filename; done

files=seasonal/*.csv
for f in $files; do echo $f; done

# How can I run many commands in a single loop?:
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done

# How can I do many things in a single loop?:
for f in seasonal/*.csv; do echo $f; head -n 2 $f | tail -n 1; done

# How can I edit a file?:
# Unix has a bewildering variety of text editors. For this course, we will use a simple one called Nano.
nano names.txt
# note: useful commands for Nano editor:
#   Ctrl + K: delete a line.
#   Ctrl + U: un-delete a line.
#   Ctrl + O: save the file ('O' stands for 'output'). You will also need to press Enter to confirm the filename!
#   Ctrl + X: exit the editor.

# How can I save commands to re-run later?:
bash headers.sh  # where 'headers.sh' is a saved file containing the shell commands to execute

# How can I re-use pipes?:
cut -d , -f 1 seasonal/*.csv | grep -v Date | sort | uniq  # example contents of 'all-dates.sh' for command immediately below
bash all-dates.sh > dates.out  # save outout in a new file called 'dates.out'

# How can I pass filenames to scripts?:
sort $@ | uniq  # example contents of 'unique-lines.sh' for command immediately below
bash unique-lines.sh seasonal/summer.csv  # subs in 'seasonal/summer.csv' for '$@' in .sh file
bash unique-lines.sh seasonal/summer.csv seasonal/autumn.csv  # to process two files

# How can I process a single argument?:
# as well as $@, the shell lets you use $1, $2, and so on to refer to specific command-line parameters.
cut -d , -f $2 $1  # the numbers of '$1' and '$2' specify the order of arguments
bash column.sh seasonal/autumn.csv 1

# How can I write loops in a shell script?:
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done



