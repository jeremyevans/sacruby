!SLIDE center
.notes Like Coffeescript vs. Javascript, the choice to use NodeJS and Express compared to Ruby and Sinatra or Rails has some pros and cons.

# NodeJS/Express vs. Ruby/Sinatra|Rails

!SLIDE center
.notes In general, NodeJS is faster than ruby, and will probably scale farther on the same hardware.

# Pro - Faster 

!SLIDE center
.notes However, that's the smaller of the two main benefits.  The primary benefit is you can share code on the client and the server.  This is a huge benefit, since otherwise you might have to write the same or similar code twice.  In Quinto, it was important that the client have all of the game logic, so you could get an immediate response when planning moves.

# Pro - Sharing Code

!SLIDE center
.notes - The biggest problem with NodeJS/Express is that you have to write everything in an async manner using nested callback functions, as NodeJS's synchronous IO functions block the entire process.  This is incredibly painful, and I'll later conclude it is unnecessary.  First, let me enumerate some problems.

# Con - Async

!SLIDE center
.notes With async code, you can't use throw for error handling.  In fact, if you throw an exception in an async function on Express, it kills the server immediately.

# Error Handling

!SLIDE center
.notes To work around this, you have to thread the Express error handling function all the way to the lowest levels of the stack.

# Thread Error Handling Function to the Lowest Levels

!SLIDE center
.notes Because all potentially blocking calls need to take a callback function, you can't really mix IO code freely with Non-IO code.

# Can't Mix IO Code and Non-IO Code

!SLIDE center
.notes One example of this is that you can't call IO functions in loops, you need to use recursion instead.

# Can't Use IO Functions within Loops

!SLIDE center
.notes The inability to mix IO and non-IO code is similar to haskell, but without the benefits that haskell gives you like an IO monad that lets you write synchronous-style code.

# The Pain of Haskell minus the Benefits of Haskell

!SLIDE center
.notes Your NodeJS async code ends up looking like stair steps, since each IO method takes a separate nested callback.

# Stair Stepping Code

!SLIDE center
.notes The fundemental problem with NodeJS's design is that it conflates async with nonblocking.  It would be much better if synchronous functions didn't block the whole process, instead just blocking the current coroutine/thread.

# Why Should Synchronous Functions Block the Entire Process?

!SLIDE center
.notes Basically, the synchronous functions should behave like the asynchronous functions, but instead of storing a callback function, it should store a continuation of the current state, so that when the IO completes, control returns to the caller of the function.

# Store a Continuation Instead of a Callback Function

!SLIDE center
.notes The reason most thread-based implementations are slow is mostly because they are preemptive instead of cooperative.  Preemative handles worse case scenarios better, but is not good for high-performance.  However, a cooperative thread approach can be as performant as an async approach, without the pain.

# OMG, I Just Described Cooperative Threading

!SLIDE center
.notes Computer science research done way back in the 70s by Lauer and Needham showed that threads and events are mathematically equivalent. 

# Truth: Threads and Events are Mathematically Equivalent

!SLIDE center
.notes At the Usenix Conference in 2003, Rob von Behren, Jeremy Condit, and Eric Brewer presented a paper called "Why Events are a Bad Idea".

# "Why Events are a Bad Idea"

!SLIDE 
.notes The paper describes the problems that event-based systems have, and how those problems can be basically fixed by using cooperative threading uses continuations.

     As a case in point, the cooperative task
     management technique described by [...]
     allows users of an event system to write
     thread-like code that gets transformed
     into continuations around blocking calls.
     In many cases, fixing the problems with
     events is tantamount to switching to
     threads.

!SLIDE center
.notes The real truth is that async code is only needed when you want something running in parallel.  Async code certainly requires nonblocking code, but nonblocking code should not require async code.

# Truth: Async is for Parallel Code

!SLIDE center
.notes I'm guessing that almost all NodeJS async use is for nested callbacks executed in serial, and not for true parallel code.

# Guess: Most NodeJS Async Uses are Serial, not Parallel

!SLIDE center
.notes The real object oriented way to handle parallel async code is to return a future.  A future is an object that does the async processing in the background or when accessed, and becomes the result of the async computation when the async code returns.

# OO Parallel Async Code -> Futures

!SLIDE center
.notes In ruby, you can do this with lazy.rb or the promise gem, but it probably doesn't perform that well as it is implemented with ruby threads.

# lazy.rb / Promise

!SLIDE center
.notes Using a language with built in futures would probably be better, and Clojure, IO, and Racket all have support built in.  

# Clojure/Io/Racket

!SLIDE center
.notes It's hard to say.  Even for a simple application like Quinto, the async stuff is a real pain, so I assume it's only worse in larger applications.  I probably would only use NodeJS in the future if I had a real need for sharing code between the client and server.

# Verdict 
