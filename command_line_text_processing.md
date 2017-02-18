# Text Processing on the Command Line

## I/O Redirection

In the Linux command line files may be processed by a number of tools, called "commands" or "programs". In its simplest form, a command takes a file as input, does some stuff with the input, and then sends the results as output.

### Redirection to a file

The destination of the output by default is the command line itself (this is called "standard output"). However, the output may also "redirect" the output to somewhere else: to another file or to another command for further processing. For example the command `cat`takes a file as input and then simply sends the contents of the file to "standard output" (called STDOUT in tecnical speak); i.e., the command line terminal.

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
#### Redirection to Another Command ("piping")

In addition to redirecting output to a file, you may also redirect to another command. This is called "piping" and the string of connected pipes is called a "pipeline". The symbol "|" is used to redirect the output of one command to be the input to another. For example, in this pipeline the contents of a file is read by the `cat` command, then sent as input to the `wc` command which counts the number of lines in the file and sends its output (a line count) to the terminal:

```
$ cat tl_p161v.txt | wc -l
8

```

Note: To be complete, it should be noted that the contentns of a file may be directed as input to a command using the `<` symbol. For example:

```
$ cat < tl_p161v.txt
161v

http://gallica.bnf.fr/ark:/12148/btv1b10500001g/f328.item.r=

p161v_a1Crocum ferri

It can be made quickly if you put very filings that are very neat and have been washed in an iron drum that is only two fingers high, and cover it, and redden in a reverberation furnace, having washed it in good vinegar for a whole day.  And it will be very well burnt and clean, mixed and crushed on a marble slab. Having been well crushed and when well mixed, the vinegar will corrode it easily and will redden it quickly and bind it. Wet it with the strongest one you can find and burn it after. And after three or four wettings and burnings it will be ready. This one will be the color of columbine and is considered firmer for casting than the one that is redder and more beautiful in color, done with rusty filings and has more color in it. Some burn the filings many times on a shovel of red iron, watering each time with vinegar.

```

Here the `cat` command receives it's input from a file through the `<` symbol. This is not necessary because `cat` takes the name of a file as input anyway. Some commands, notably `tr` (translate; a very important text processing command), do not take the name of a file to get its input, so the `<` operator is often needed.


The ability to pipe commands together is key feature of the linux command line, giving the user the ability to manipulate and manage data extensively and efficiently.


## Working with Tabular ("Structured") Data

* `cut` - cut fields from lines of structured data

Using https://github.com/cu-mkp/GR8975/blob/master/entry-metadata.csv as input get the values of the tools field


### Sorting

* `sort` - sort lines
* `uniq` - sort unique lines

Using https://github.com/cu-mkp/GR8975/blob/master/entry-metadata.csv as input

* get a list unique values
* sorted by frequency

## Working with Textual ("Unstructured") Data

### Counting words

* `tr` - translate
* `wc`- word count
* `head` - output lines from top of file

Using https://github.com/cu-mkp/GR8975/blob/master/entry-metadata.csv as input

* get a case insensitive list of values of the tools field
* get a list of values all lower-case with no punctuation

Using one of your folio files (or your compiled folio file):

*  get the 5 most frequently occurring words

### n-grams

* `tail` - read lines from end of file
* `paste` - merge lines of a file

### Regular Expressions

* `grep` - global regular expression print

### Filtering and Transforming Text

* `sed` - stream editor
