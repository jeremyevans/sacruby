!SLIDE center 
.notes Hi everybody.  Tonight I'll be discussing some of PostgreSQL advanced types and how to parse them in ruby

# Parsing Advanced PostgreSQL Types

## Jeremy Evans

### Sacramento Ruby Meetup
### July 2012

!SLIDE center
.notes PostgreSQL has a very expressive type system.  In addition to a large number of built in types, it also allows you to define your own custom types.

# Types

!SLIDE center
.notes PostgreSQL natively supports arrays for virtually all types.

# Arrays 

!SLIDE center
.notes For example, if you want to store an array of integers in a column, you would just add brackets at the end of the integer type.

# integer[]

!SLIDE center
.notes PostgreSQL ships with an extension called hstore which adds the hstore type, which allows for a key/value mapping table to be stored in a single column.

# Hstore

!SLIDE center
.notes PostgreSQL allows columns to have a composite type, allowing you to store row like objects in a single column.  Every table you create in PostgreSQL has its own row type, and another table can use that table's name as the type for one of its columns.

# Composite Types

!SLIDE center
.notes PostgreSQL 9.2 adds support for range types.  PostgreSQL range types are similar to ruby's range objects, though they are more flexible.  They allow exclusive beginning elements in addition to exclusive ending elements. They support unbounded and empty ranges as well.

# Ranges

!SLIDE center
.notes PostgreSQL 9.2 also adds support for the json type, allowing you to store a json object in a single row.

# JSON

!SLIDE center
.notes When you retrieve data from PostgreSQL, you usually get that data in the form of a string, with additional metadata letting you know the type id of the column.

# Retrieving Data

!SLIDE center
.notes So when you retrieve an integer from PostgreSQL, you get it in the form of a string, but the type id lets you know it is a integer.

# Type IDs

!SLIDE center
.notes For example, the boolean type on PostgreSQL always has type id 16, so if you retrieve a column from PostgreSQL and the type id is 16, you know you should cast the string to a ruby true or false value.

# boolean => 16

!SLIDE center
.notes The type ids for all of the types that PostgreSQL supports by default are fixed, in that all PostgreSQL installations use the same type id for that type.

# Fixed Type IDs

!SLIDE center
.notes However, custom types such as hstore and the tables you create yourselves do not have a fixed type, but are assigned one by the system.

# Floating Type IDs

!SLIDE center
.notes It's possible to map a type name to a given type id by looking at the pg\_type system table.

# pg\_type

!SLIDE center
.notes With the background out of the way, let's jump right into parsing these advanced PostgreSQL types.

# Parsing

!SLIDE center
.notes PostgreSQL arrays can be either single dimensional or multi-dimensional.  Each dimension in the array is surrounded by braces, and each element is separated by a comma.  If entries in the array contain commas or other characters, the whole member is quoted and, if necessary, escaped.

# Arrays

    {1,2,3,4}
    {{1,2},{3,4}}
    {"some,","\\\"text"}

!SLIDE center
.notes Hstore values look similar to ruby hashes with strings for keys and values, using the hash rocket to separate the key from the value, and the comma between key/value pairs.  Hstore values are always quoted and escaped on output.

# Hstore

    "a"=>"b"
    "a"=>"b", "c"=>"\"\\d"

!SLIDE center
.notes Composite types are similar to arrays, except they are only single dimensional, they use parantheses instead of braces, and embedded quotes inside quoted values are escaped by doubling them instead of via a backslash.

# Composite Types

     (1,a)
     (1,"a""\\")

!SLIDE center
.notes Range types are either empty, or they are surrounded by a bracket and/or paranthesis.  Similar to mathematical notation, bracket indicates inclusive beginning or end and parenthesis indicates exclusive beginning or end.  If there is no value for a beginning or end, the range is unbounded in that direction.

# Ranges

     [1,10)
     (,50]
     empty


!SLIDE center
.notes The JSON type unsurprisingly stores the type as JSON.

# JSON

    {a: "b"}
    [1, 2, 3]

!SLIDE center
.notes For arrays, composite types, and ranges, it's not enough to just be able to parse the general structure of the type.  For these elements, you need to parse each member of the type.

# Parsing Members

    {1,2,3} => ['1', '2', '3']

!SLIDE center
.notes For example, for an array of integers, by default an array parser would give you an array of strings.  You need to tell the parser what the type of the members is, so it while it parses each element from the array string, it casts it to the correct type. 

# integer[]

    {1,2,3} => [1, 2, 3]

!SLIDE center
.notes Range types are similar, with both the beginning and ending element needing to be parsed.

# Ranges

!SLIDE center
.notes Composite types are even more tricky, as each element in the composite type may need a separate converter.

# Composite Types

!SLIDE center
.notes It gets even better, you can have arrays of composite types.  For example, if I take the composite type examples I gave earlier and put them into an array, I get something like this.  Note all of the backslashes needed.

# Array of Composite Types 

    {"(1,a)","(1,\"a\"\"\\\\\")"}

!SLIDE center
.notes Likewise, you can have composite types containing arrays.  Note the doubled backslashes and the doubled quotes.

# Composite Types Containing Arrays

    ("{1,2,3}","{a,b,""\\\\c\\""""}")

!SLIDE center
.notes PostgreSQL types can be nested arbitrarily, allowing arrays of composite types containing arrays of ranges.

# Array of Composite Types Containing Arrays of Date Ranges

    {"(\"{\"\"[2012-07-31,2012-08-14)\"\"}\")"}

!SLIDE center
.notes How do you deal with parsing something like that?  Well, I think the best way is to use function composition.

# Parsing

!SLIDE center
.notes With function composition, you have the main function that parses the outer layer, and it also has a pointer to a function that know how to parse the next level.

# Function Composition

!SLIDE center
.notes So parsing using function composition is like an onion.  Each function parses a layer, and hands off the underlying data to the next function.

# Onion

!SLIDE center
.notes It's also like an onion in that if you deal with parsing to much, you are likely to have the urge to cry.

# Cry

!SLIDE center
.notes So lets parse this nasty array of composite types of arrays of date ranges.

# Let's get started!

    {"(\"{\"\"[2012-07-31,2012-08-14)\"\"}\")"}

!SLIDE center
.notes You actually build the parser from the outside in.  You start out with a simple date parser, which can parse the 2012-07-31 string to give you a ruby date.  Using that, you create a range parser, with a member parser that will parse dates.  Then you create an array parser, passing in the date range parser as the parser for the members of the array. You pass that parser to the composite type parser as the parser for the first member of the composite, and take the resulting parser and use that to create another array parser.

# First Step: Build Parser

!SLIDE center
.notes So the outer parser is an array parser, with a member parser that parses composites containing arrays of date ranges.  So let's apply that.  For simplicity, there's only a single element in this array, so after parsing the array, we are left with this string.

# Parsing Step 1

    ("{""[2012-07-31,2012-08-14)""}")

!SLIDE center
.notes We pass this string to our that composite parser, which has a parser for the first member of the composite that parses arrays of date ranges.  This composite only has a single member for simplicity.  After parsing the composite, we are left with this string:

# Parsing Step 2

    {"[2012-07-31,2012-08-14)"}

!SLIDE center
.notes We pass this string to the next parser, which parses arrays, with a member parser that parses date ranges.  Again, there is only a single element in this range for simplicity.

# Parsing Step 3

    [2012-07-31,2012-08-14)

!SLIDE center
.notes This is looking simpler.  We pass the string to the member parser, which parses date ranges.  This parses the range portion just leaving the beginning and ending of the range as strings.

# Parsing Step 4

    2012-07-31
    2012-08-14

!SLIDE center
.notes The last step is to just parse those date strings into ruby date values, using ruby's date parser.

# Parsing Step 5

!SLIDE center
.notes The result of all this is something like the ruby data structure below.  In ruby, this is an array containing a hash whose value is an array of a range of dates.

# Result

    [{:a=>[(Date.new(2012-07-31)...
            Date.new(2012-08-14))]}]

!SLIDE center
.notes This sounds complicated, right?  It probably is, if you don't use the right tool.

# Sounds Complicated?

!SLIDE center
.notes Sequel makes all of this pretty easy.  Sequel ships with extensions that parse all of the PostgreSQL types I've mentioned tonight.  For the most recent example, you would just create the database object, load three extensions, register your custom composite type, and then when you retrieve the value of the array of composite types, it does all the parsing I've just described, and leaves you with a result very similar to the one below.

# Sequel

    DB = Sequel.postgres(...)
    DB.extension(:pg_array, :pg_range, :pg_row)
    DB.register_row_type(:a)
    DB[:table].get(:a)
    # => [{:a=>[(Date.new(2012-07-31)...
                 Date.new(2012-08-14))]}]

!SLIDE center
.notes Anyway, that's some of what I've been working on over the past few months.  Any questions?

# Questions?
## Twitter: @jeremyevans0
## GitHub: jeremyevans
