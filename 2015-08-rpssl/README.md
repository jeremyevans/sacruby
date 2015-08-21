# rpssl

SacRuby Quiz Night for August 20th, 2015.

It starts with the quiz inspire by Quiz 9, Rock Paper Scissors, from Best of Ruby Quiz,
published by Pragmatic Programmers. And then changes...

...because http://www.samkass.com/theories/RPSSL.html

## Prerequisites

1. This has been tested with Ruby 2.1 which has test/unit installed by
   default
2. If using Ruby 2.2 or newer, for now, run `gem install test-unit` to
   pick up the unit test framework used in this project.

## What to do

1. If you are a new Rubyist, play with creating one or more Player classes to submit to the tournament.
Use the samples here and the runner to test them out. Submit your versions as a Pull Request or a Gist.
Run by using `ruby rpssl players/file1.rb players/file2.rb` where file1.rb and file2.rb
are the names of the files in the players directory you want to test. You can also test
all by just supplying a directory: `ruby rpssl players/`

2. Create a Unit Test for the Player classes you create. See example in tests/ folder.
Put your class in the players/ folder and copy the sample test. Change the names
of file found in the require. Ruby tests by doing `ruby tests/tc_player.rb` or
what-ever your name of the file is.

3. Adv: Create a service using http://faye.jcoglan.com/ruby.html or similar that can protect the engine,
and provide a wrapper for players to connect to the server, and run the tournament remotely.
