!SLIDE center
.notes The rest of the presentation is going to be my general thoughts on Coffeescript and NodeJS.  Cavaet Audiens is Latin for "Let the listener beware".  I only have a few weeks of experience in using Coffeescript/NodeJS, so anything I say could be way off base.

# Cavaet Audiens

!SLIDE center
.notes I originally was going to give a single list of pros and cons, but I think that conflates two separate issues.  The first issue is comparing coffeescript to javascript.

# Coffeescript vs. Javascript

!SLIDE center
.notes Let's start off with the pros. Coffeescript has a much nicer syntax than javascript, borrowing from both ruby and python.  Unless you hate the idea of signficant indentation, you'll probably like Coffeescript syntax better.  I used python before ruby, so it doesn't bother me.

# Pros - Syntax

!SLIDE center
.notes Some nicities are using @ to refer to this.

# @

!SLIDE center
.notes The -> and => define functions.  The difference is that the => changes @ to bind to the current value of this.  This is sort of a con as it can get a little confusing, but it's needed in a lot of async code.

# ->, =>

!SLIDE center
.notes One of the biggest gains is not having to worry about using var for all variables and accidentally creating global variables.

# No var

!SLIDE center
.notes Another niceity is list comprehensions, which work similar to the ones in python and simplify array processing.

# List comprehensions

!SLIDE center
.notes Finally, another big gain is that everything is an expression, similar to ruby.

# Everything is an expression

!SLIDE center
.notes The main downside of Coffeescript is debugging code.

# Cons - Debugging

!SLIDE center
.notes Backtraces in coffeescript code have javascript line information, instead of coffeescript line information, making them mostly useless.

# Backtraces That Suck

!SLIDE center
.notes You will pretty much have to read the compiled javascript in many cases to figure out your error.  This is fairly easy if you are precompiling the coffeescript to serve to a browser (since Firebug/Chrome Inspector tools show the compiled output).  However, for debugging server code, it usually requires a separate compilation step.

# Hope You Like Reading Compiled Javascript

!SLIDE center
.notes I think the syntax improvements outweigh the debugging pain, so I'd definitely use Coffeescript over Javascript in the future.

# Verdict 
