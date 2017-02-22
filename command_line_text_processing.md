# Text Processing on the Command Line

## I/O Redirection

In the Linux command line files may be processed by a number of tools, called "commands" or "programs". In its simplest form, a command takes a file as input, does some stuff with the input, and then sends the results as output.

### Redirection to a file

The destination of the output by default is the command line itself. However, the output may also be "redirected" to somewhere else: to another file or to another command for further processing. For example the command `cat` takes a file as input and then simply sends the contents of the file to "standard output" (called STDOUT in technical speak) in this case, the command line terminal.

```
$ cat tl_p161v.txt
161v

http://gallica.bnf.fr/ark:/12148/btv1b10500001g/f328.item.r=

p161v_a1Crocum ferri

It can be made quickly if you put very filings that are very neat and have been washed in an iron drum that is only two fingers high, and cover it, and redden in a reverberation furnace, having washed it in good vinegar for a whole day.  And it will be very well burnt and clean, mixed and crushed on a marble slab. Having been well crushed and when well mixed, the vinegar will corrode it easily and will redden it quickly and bind it. Wet it with the strongest one you can find and burn it after. And after three or four wettings and burnings it will be ready. This one will be the color of columbine and is considered firmer for casting than the one that is redder and more beautiful in color, done with rusty filings and has more color in it. Some burn the filings many times on a shovel of red iron, watering each time with vinegar.

```

The output could also be redirected to another file. To do this the symbol `>` is used with the name of the target file after; e.g.:

```
$ cat tl_p161v.txt > /tmp/redirected_output.txt
thc4@permascowl:/data/Github/GR8975/folio_files$ cat /tmp/redirected_output.txt
161v

http://gallica.bnf.fr/ark:/12148/btv1b10500001g/f328.item.r=

p161v_a1Crocum ferri

It can be made quickly if you put very filings that are very neat and have been washed in an iron drum that is only two fingers high, and cover it, and redden in a reverberation furnace, having washed it in good vinegar for a whole day.  And it will be very well burnt and clean, mixed and crushed on a marble slab. Having been well crushed and when well mixed, the vinegar will corrode it easily and will redden it quickly and bind it. Wet it with the strongest one you can find and burn it after. And after three or four wettings and burnings it will be ready. This one will be the color of columbine and is considered firmer for casting than the one that is redder and more beautiful in color, done with rusty filings and has more color in it. Some burn the filings many times on a shovel of red iron, watering each time with vinegar.


```

Redirecting with `>` will create the target file if it does not exist, and will *overwrite* the file if it does. So be careful.

Output may be also *appended* (i.e., added to the very end) to a file using the symbol `>>`. Redirecting with `>>` will create the target file if it does not exist, but will *append* the output to the target file if it does.

```
$ cat tl_p022r.txt >> /tmp/redirected_output.txt
$ cat /tmp/redirected_output.txt
161v

http://gallica.bnf.fr/ark:/12148/btv1b10500001g/f328.item.r=

p161v_a1Crocum ferri

It can be made quickly if you put very filings that are very neat and have been washed in an iron drum that is only two fingers high, and cover it, and redden in a reverberation furnace, having washed it in good vinegar for a whole day.  And it will be very well burnt and clean, mixed and crushed on a marble slab. Having been well crushed and when well mixed, the vinegar will corrode it easily and will redden it quickly and bind it. Wet it with the strongest one you can find and burn it after. And after three or four wettings and burnings it will be ready. This one will be the color of columbine and is considered firmer for casting than the one that is redder and more beautiful in color, done with rusty filings and has more color in it. Some burn the filings many times on a shovel of red iron, watering each time with vinegar.

022r

http://gallica.bnf.fr/ark:/12148/btv1b10500001g/f49.image


fig_p022r_1

https://drive.google.com/open?id=0B9-oNrvWdlO5dWtBam9HWEpiaHc

The one depicted is a bit too big, see the following one.



Cannon ball, weighing 40 lb and being 12 lignes pied de roy long.

```

Note how the contents of tl_022r.txt have been appended to the file `/tmp/redirected_output.txt`

#### Exercise:

* create a single file with the contents of all your folios. Hint: to be safe do this first:

```
$ cd folio_files
$ touch [your name]_all_folios.txt
```
Then to create your "all_folios" file, by repeating this command for each of your folio files:

```
$ cat [folio file] >> [your name]_all_folios.txt
```

Then add your "all folio file" to your local git repository

```
$ git add [your name]_all_folios.txt
```

then commit it (with a message) to your local git repository

```
$ git commit -m 'created all folios file' [your name]_all_folios.txt
```

then push it to the remote repository on Github

```
$ git push origin master
```

#### Redirection to Another Command ("piping")

In addition to redirecting output to a file, you may also redirect to another command. This is called "piping". The string of connected pipes is called a "pipeline". The symbol "|" is used to redirect the output of one command to be the input to another. For example, in this pipeline a file is read by the `cat` command and its content is output to the pipe, which then sends it as input to the `wc` command, which counts the number of lines in the file and sends its output (a line count) to the terminal:

```
$ cat tl_p161v.txt | wc -l
8

```

To be complete, it should be noted that the contents of a file may be directed as input to a command using the `<` symbol. For example:

```
$ cat < tl_p161v.txt
161v

http://gallica.bnf.fr/ark:/12148/btv1b10500001g/f328.item.r=

p161v_a1Crocum ferri

It can be made quickly if you put very filings that are very neat and have been washed in an iron drum that is only two fingers high, and cover it, and redden in a reverberation furnace, having washed it in good vinegar for a whole day.  And it will be very well burnt and clean, mixed and crushed on a marble slab. Having been well crushed and when well mixed, the vinegar will corrode it easily and will redden it quickly and bind it. Wet it with the strongest one you can find and burn it after. And after three or four wettings and burnings it will be ready. This one will be the color of columbine and is considered firmer for casting than the one that is redder and more beautiful in color, done with rusty filings and has more color in it. Some burn the filings many times on a shovel of red iron, watering each time with vinegar.

```

Here the `cat` command receives its input from a file through the `<` symbol. This is not necessary because `cat` takes the name of a file as input anyway. Some commands, notably `tr` (translate; a very important text processing command), do not take the name of a file to get its input, so the `<` operator is often needed.


The ability to pipe commands together is key feature of the linux command line, giving the user the ability to manipulate and manage data extensively and efficiently.


## Working with Tabular ("Structured") Data

* `cut` - cut fields from lines of structured data

Using https://github.com/cu-mkp/GR8975/blob/master/entry-metadata.csv as input get the values of the tools field


### Sorting

* `sort` - sort lines
* `uniq` - sort unique lines
* `tr` - translate

Using https://github.com/cu-mkp/GR8975/blob/master/entry-metadata.csv as input

* list of *all* values of tools field (i.e., including each item in semi-colon delimited list of values)
 *  get the 8th field from each line
 *  translate semicolons to new lines to separate out each value

```
$ cut -d',' -f8 entry-metadata.csv | tr ';' '\n'
```

* sorted list of unique values of tools field
 * get the 8th field from each line
 * translate semicolons to new lines to separate out each value
 * sort unique values in list

```
$ cut -d',' -f8 entry-metadata.csv | tr ';' '\n' | sort -u
```

## Working with Textual ("Unstructured") Data

### Counting words

* `tr` - translate
* `wc`- word count
* `head` - output lines from top of file

Using one of your folio files (or your compiled folio file):

* translate to newline ('\n') characters
 *  the 'complement' (-c) of alphabetic characters (i.e., anything not an alphabetic character)
 * while "squeezing" (-s) repeated "complement" characters

```
$ tr -sc 'A-Za-z' '\n' < folio_files/tl_p102v.txt | sort
```
*  get the 5 most frequently occurring words

* do above, then
 * sort the list of lines
 * count unique lines in the sorted list
 * sort the counts of unique lines numerically (-n) in reverse order (-r)
 * print only first 5 lines

```
$ tr -sc 'A-Za-z' '\n' < [folio file].txt | sort | uniq -c | sort -nr | head -5
```

get sorted list of word frequencies normalized for case
 *  translate to newline ('\n') characters
  * the 'complement' (-c) of alphabetic characters (i.e., anything not an alphabetic character)
  *  while "squeezing" (-s) repeated "complement" characters
* translate upper case characters to lower case
* sort the list of lines
* count unique lines in the sorted list
* sort the counts of unique lines numerically (-n) in reverse order (-r)

```
$ tr -sc 'A-Za-z' '\n' < folio_files/tl_p161v.txt | tr [:upper:] [:lower:] | sort | uniq -c | sort -nr
```

### n-grams

* `tail` - read lines from end of file
* `paste` - merge lines of a file

get a list of all word pairs in a folio file
* get a list of all words in the file
* write to a file (e.g., "tl_p161v.txt.words")
* get a list of all words in the file starting with the second word
* write to file (e.g., "tl_p161v.txt.nextwords")
* for each line in all words file "paste" matching line in "next words" file


```
$ tr -sc 'A-Za-z' '\n' < folio_files/tl_p103v.txt > /tmp/tl_p161v.txt.words
$ tail -n +2 /tmp/tl_p161v.txt.words > /tmp/tl_p161v.txt.nextwords
$ paste /tmp/tl_p161v.txt.words /tmp/tl_p161v.txt.nextwords > /tmp/tl_p161v.txt.bigrams

```

### Regular Expressions

Rather than matching and manipulating exact strings (i.e., sequences of characters) in files, you can also find *patterns* of characters. The patterns can be defined using "regular expression" syntax.


* `grep` - global regular expression print


 * find lines in a file with the pattern 'chicken'

```
$ grep 'chicken' folio_files/tl_p103v.txt

```
 * find lines in any files with the pattern 'chicken'

```
$ grep 'chicken' folio_files/*.txt

```
 * find all words in a file ending in ''-ing'
  * use `$` to "anchor" expression to end of line

```
$ tr -sc 'A-Za-z' '\n' < folio_files/tl_p103v.txt | grep 'ing$'
```

* find all lines in folio files with the words in a list contained in a file
 * use `-f` to indicate file containing patterns
 * use `-E` "extended regular expression" option and provide a pipe delimited list of alternatives

```
$ grep -E -f birds.txt folio_files/*.txt

```
* get a list of all words in a file, removing common words ("stop words")

```

```

### Filtering and Transforming Text

* `sed` - stream editor
