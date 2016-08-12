# rubyquiz-201607 Fun with words

Your challenge is to create a word that reads the entire Shakepeare set of texts
and processes the files to answer the following questions:

1. What is the distribution of words according to initial letter of the word?
2. What are the top ten words that appear in the entire body of texts?
3. What are the top three-letter combinations that appear in the text, ignoring all special characters, punctuation, and spaces?

Create three functions (and any other supporting programming you desire). The specification is as follows:

`$ ruby shakespeare.rb [alpha] [dir to data set]`

Should print out a histogram to standard output in the form of:

    A | 2003
    B | 1243
     ...
    Z | 45

The second program should be run with the command line:

`$ ruby shakespeare.rb [ten] [dir to data set]`

And should print out a list ten words in alphabetical order, comma separated:

    apple,boy,charlie,...,ten

The final program function should be run with the command line:

`$ ruby shakespeare.rb [three] [dir to data set]`

And should print out a comma separated list of three letter combinations in alphabetical order:

    abb,cat,egg,...,zip

All functions should be able to be run from the same program file.

The main program file should be called `shakespeare.rb`.

Submit your programs in a self contained directory as a pull request to this challenge. Use your team or user name as the subdirectory in the solutions folder.

## Testing

We'll compare solutions on the testing machine which has Ruby 2.3.1 installed
and using the Unix `time` tool.

Runs can be executed in any order.

It is ok to write temporary files for your processing, but they must be written
in the current workding directory, not the data directory.

## Credits

The data used for this exercise is from http://www.folgerdigitaltexts.org/. See the license in the data folder and on the web site.
