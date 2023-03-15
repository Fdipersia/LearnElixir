# EPISODE 1 // Intro
  
* Elixir runs on beam => Virtual Machine
* Relieable, concurrent, distributed
* Elixir is a functional programing language, it doesn't have Classes, Objects or Inheritance
* Elixir programs are "simple", are functions that take input and returns output
* Modular program design
* Zero downtime: No need to restart or disconnect clients after deploy
* Whatsapp uses BEAM

# EPISODE 2 // Data Types

2 Kinds of types: Base Types & High Level Types

## Base types

  ### Numbers
    - Integers
    - Floats

  ### Atoms
  * Similar to Ruby symbols
  * :name, :"name", :"my name"
  * true, false and nil are atoms
  * :nil == nil
  * :true == true
  * :false == false
  * ModuleNames are atoms

  ### Binaries:
  * Strings are just binaries in Elixir
  """
  This is a multiline
  string
  """

  ### Maps:
  * Are key value store
  %{key: value,  }
  episode = %{name: "juan"}

  ### Tuples:
  * Collection of values
  coll = {value1, value2, ...}
  elem(coll, 0) => value1
  put_elem(coll, 2, value3) => {value1, value2, value3}

  ### List
  * Similar to arrays
  list = [value, value2]
  Enum.at(list, 1) => value2
  * appending is fast
  * prepending is slow
  * inserting at can be slow
  * reading can be slow

  ### Character list
  [integer, integer2]
  * shorthand notation: 'hello' => [104, 101, 108, 108, 111]

  ### Functions 
  fn(args) -> ... end
  add = fn(a, b) -> 
          a + b
        end

  ## High Level Types

  ### Keyword lists:
  [{:atom, value}, ...]
  shorthand notation:
  attrs = [name: "francisco"]

  ### Structs
  %{__struct__: ModuleName, ...}

# EPISODE 3 // Operators

## Match operator "="

* Tries to equal the operandor on each side
* It binds the variable on the left to the variable on the right

{name, age} = {"Panchi", 32}
name => "Panchi"
age => 32

{:ok, content} = File.read("file_name.txt") => binds content to file content if success

{name, _ignore} = {"Panchi", 32} => 

{^name, age} = {"Panchi", 32} => caret "^" is used for compare not to re bound

## reminder operator "rem(val1, val2)"
rem(x, y) is % in ruby
rem(4, 2) => 0
rem(5, 2) => 1

## Equality/ Comparison operators
 1 == 1 => true
 1.0 == 1 => true
 1.0 === 1 => false
 ! => bang => inequality
 1 != 2 => true

## List operators

### in
* To check if element is present in list
"Daniel" in ["Daniel", "Juan"] => true

### ++ 
* To combine lists
["a"] ++ ["b", "c"] => ["a", "b", "c"]

### -- 
* To remove elements from lists
["a", "b", "c"] -- ["c"] => ["a", "b"]

### pipe operator "|"
* To prepend elements to a list

list = [1, 2, 3]
[0 | list] => [0, 1, 2, 3]

[head | tail] = list
head => 1
tail => [2, 3]

[a, b ,c | tail] = [1, 2, 3, 4]
a => 1
b => 2
c => 3
tail => [4]

## Binary operators

# concatenate binaries
"hello" <> " " <> "world" => "hello world"

# interpolate
"Age is #{30 + 2}"

# pipeline operator: |>
* Used to chain functions together into a pipeline

var = foo(var)
var = bar(var)

Becomes this:
var = var
      |> foo
      |> bar

Which translates to var = bar(foo(var))

# EPISODE 4 // Functions, Modules & Structs

## Anonymous Functions
* Anonymous because they derive they name from the variable they are bound to.

add = fn(a,b) -> a + b end

## Named Function: 

def add(a,b) do
  a + b
end

## Modules
* Named functions must be placed inside Modules.
* Modules are organizational tools.

defmoudle Math do
  def add(a,b) do
      a + b
  end
end

Calling anonymous functions => add.(10, 5)
Calling named functions => Math.add(10, 5)

## Nesting Moudles

defmodule Math do
  defmodule Division do
    def divide(a,b) do
      a / b
    end
  end

  def add(a,b) do
      a + b
  end
end

Math.Division.divide(6, 3)

or 

defmodule Math.Division do
  def divide(a, b) do
    a / b
  end
end

## Private Functions

defmodule Math do
  def add_two(a) do
      a
      |> add_one
      |> add_one
  end

  defp add_one(a) do
    a + 1
  end
end

## Aliasing
* You can use the innermost Module name by using alias keyword

defmodule MyModule do
  alias Math.Division

  def my_implement(a, b) do
    Division.divide(a, b) + 2
  end
end


# "as" in alias
* Rename the alias

defmodule MyModule do
  alias Math.Division, as: D

  def my_implement(a, b) do
    D.divide(a, b) + 2
  end
end

## import

* Importing a module allows you to use functions as if they were there

defmodule MyModuleImport do
  import Math.Division
  @moduledoc """
    Describes what this module does
  """


  def my_implement(a, b) do
    divide(a, b) + 2
  end
end

- import only certain definitions: `import Math.Division, only: [divide: 2]`
- import except certain definitions: `import Math.Division, except: [divide: 2]`
- you can also delegate functions to be executed by other functions in different modules

## Documentation

@moduledoc """
  Describes what this module does
"""

## Struct

defstruct attr1: val1, attr2: val2...

defmodule User do
  defstruct name: nil,
            age: nil
end

%User{name: "Daniel"}

# EPISODE 5 // Control Flow
  
## cond
* returns the first matching condition
* in Elixir is widly used
* use it instead of if - else

cond do
  1 + 1 == 1 -> "This will never happen"
  2 * 2 != 4 -> "Nor this"
  true -> "This will"
end

## case
* runs a block of code matching the condition

case expr do
  output -> code
  _other -> default
end

## if - else
* not as frequent as in Ruby

if 1 + 1 == 3 do
 "Not this"
else
  "The Else"
end

## unless
the code block will run unless it matches

unless 1 + 3 == 3 do
  "The laws of math still holds true"
end

## guard

def blank?(value) when value in [nil, "", false], do: true
def blank?(_other), do: false

# EPISODE 6 // Recursion

* Elixir does not have loops
* Loops require variable mutations
* Elixir uses recursion instead

## Recursion

* It is a function that calls it self

## Tail Call Optimization

* *Last thing* a function does is call it self
* There is only one function in the stack, avoiding stackoverflow (when too many functions are stacked and memory collapses)

# EPISODE 7 // Enum & Stream

## Enum
* Enumerable

### Enum.at
Enum.at([1,2,3], 1, :default) => 2

### Enum.filter

* Filter returns a list, even if tuple is given.

list = [1, 2, %{name: "Francisco", dob: "26-08-90"}, "String"]
user_list = [
  %{name: "Francisco", dob: "26-08-90"},
  %{name: "Tom", dob: "27-08-90"},
  %{name: "Ivan", dob: "28-08-90"},
  %{name: "Sam", dob: "29-08-90"},
]
Enum.filter list, fn(el) -> is_number(el) end => [1,2]
Enum.filter list, fn(el) -> is_binary(el) end => ["String"]
Enum.filter %{name: "Francisco", dob: "26-08-90"}, fn({_key, val}) -> val == "26-08-90" end => [dob: "26-08-90"]
Enum.filter user_list, fn(el) -> el[:dob] == "26-08-90" end => [%{dob: "26-08-90", name: "Francisco"}]

### Enum.reduce

list = [1,2,3,4]
Enum.reduce(list, starting_value, fn(elem, acc) -> elem + acc end) => 10
* Reduces a list to a single value
* Reduce is like a reduction in cooking, from many args to one final

### Enum.into

* Converts Enumerable into another type
* Target must implement Collectable protocol

Enum.into()

%{name: "Juan", yob: 1990}
  |> Enum.filter(fn({_k, value}) -> is_binary(value) end)
  |> Enum.into(%{})

### Enum.take

* Take a number of elementes out of an Enumerable

Enum.take(1..20, 5) => List of 5 first numbers from 1 to 20

### Capture operator "&"

* Captures or creates an anonymous fn

Enum.filter([1,2,3,"St"], &is_number/1) => [1,2,3]
            ==
Enum.filter([1,2,3,"St"], &is_number/(&1)) => [1,2,3]
* In the params the & is bound to the number of argument passed
Enum.reduce([1,2,3,4], &(&1 + &2))
            ==
Enum.reduce([1,2,3,4], &+/2)
Enum.map(["sam", "juan", "tom"], &String.upcase/1) => ["SAM", "JUAN", "TOM"]

### Enum.sum
Enum.reduce([1,2,3,4], &+/2) => 10
           ==
Enum.sum([1,2,3,4]) => 10

## Stream

* A lazy version of Enum
* It doesn't do any work until it has to and only does what is has to

### Stream.run or ask for results

list = [1,2,3,"St"]

* Enum will loop through the list twice

list
  |> Enum.filter(&is_number/1)
  |> Enum.filter(&(&1 * 2 == 4))

* Stream will add up all the functions and then run only once when Enum.into asks for it

list
  |> Stream.filter(&is_number/1)
  |> Stream.filter(&(&1 * 2 == 4))
  |> Enum.into([])

### Stream.resource/3

Stream.resource(start_fun, next_fun, after_fun)

### Enum.cycle/1
* Creates an infinite stream of repeating elements
months = ~w(January February March April June July August September October November December)
Stream.cycle(months)
  |>  Enum.take(24)

# EPISODE 8 // Comprehensions

## for macro

* for combines features of map, filter and into

for name <- ["juan", "tom"] do
  String.upcase(name)
end

for name <- ["juan", "tom"], do: String.upcase(name)

for _ <- ["juan", "tom"] do
  &String.upcase/1
end

* for always returns a list
* can be used with multiple generators

deck = for suit <- [:hearts, :clubs, :diamonds, :spades],
    face <- List.flatten([Enum.to_list(1..10), :jack, :queen, :king, :ace]) do
  {suit, face}
end

spades = for {:spades, face} <- deck do
  {:spades, face}
end

## Filters

* Similar to filters but without the word when

for {:spades, face} <- deck, is_number(face) do
  {:spades, face}
end

* Can apply multiple filters at once

for {suit, face} <- deck,
    suit == :spades,
    is_number(face),
    face > 5 do
  {suit, face}
end

## Into
* Used to return a type different (as far as supports Collectable protocol) than a list
* Types that support Collectable protocol:
  - Map
  - List
  - IO.Stream
  - Bitstring (Binary)

for {key, val} <- %{name: "Juan", dob: 1990, age: 32},
    key in [:name, :age],
    into: %{} do
  {key, val}
end

## Variable scoping in for
* All variables used in *for* are local

name = "Juan"

upcased_names = for name <- ["tom", "sam"] do
  String.upcase(name)
end

name => "Juan"
upcased_names => ["TOM","SAM"]

-----------------------------------------
|            |  Enum   |  Stream | for   |
-----------------------------------------
| map        |   YES   |  YES    |  YES  |
-----------------------------------------
| filter     |   YES   |  YES    |  YES  |
-----------------------------------------
| Lazy       |   NO    |  YES    |  NO   |
-----------------------------------------
| Iterations | Depends |  ONE    |  YES  |
-----------------------------------------
| & Operator |   YES   |  YES    |  NO   |
----------------------------------------- 

## Tips

1. One operation: Enum || for
2. Multiple operations: for || Stream
3. Generating a list: for || Stream generator
4. Multiple lists: for

# EPISODE 9 // Sigils

* Sigils are a way to create a shorthand.

~W(hello there) => ["hello", "there"]

* Adding the option `a` return a list of atoms
~W(hello there)a => [:hello, :there]

* Avoiding usign scape characters
"\"Hello\""
~s("Hello") => "\"Hello\""

* Lowercse sigils allows interpolation
* Uppercase sigils do not

name = "Panchi"
~w(My name is #{name}) => ["My", "name", "is", "Panchi"]
~W(My name is #{name}) => ["My", "name", "is", "\#{name}"]

* make your own sigils

defmodule MyModule do
  def sigil_u(content, _opts) do
    content
      |> String.split
      |> Enum.map(&String.upcase/1)
  end
end

import MyModule, only:  [sigil_u: 2]
~u(some string to upcase) => ["SOME", "STRING", "TO", "UPCASE"]

# EPISODE 10 // Mix

* Mix is Elixir's build tool
* Combines many tools, such as tasks

* How to create a new Project: `mix new project_name`

* mix.exs file is similar to Gemfile

* lib directory => Where the majority of the project is stored

* .exs vs .ex 
.exs files are script files and are ignored by the mix compiler unless you explicitly run them

## module atrtibue @attr_name

defmodule MyModule do
  @prefix Application.get_env(:learn, :prefix)

  def encrypt(text) do
    @prefix <> String.reverse(text)
  end
end

Recompile the project with `recompile()`

# EPISODE 11 // Hex

* Hex is a package manager for the Erlang ecosystem.
* Similar to Ruby gems or npm packages

List of awesome Elixir packages: https://github.com/h4cc/awesome-elixir

* Specify packages in mix.exs file "The MIX file" => Add packages in the mix file
* `mix deps.get` => Install hex packages
* `mix compile` => Compile hex packages
* Remove packages from mix file and run `deps.clean PACKAGE_NAME`
* To update => Modify dependency version in mix file and run `deps.update PACKAGE_NAME`

* Configuring dependencies => in the `config/config.exs`
  config :package_name, setting_a: 'val1', setting_b: 'val2'

# EPISODE 12 // ExUnit

* ExUnit is Elixir test suite
* `ExUnit.start()` must be called from the test_helper file
* Test file requires `use ExUnit.Case` it imports case features

Syntax is pretty much the similar to rspec
test "Assert the truth" do
  assert(true)
end

* `assert` is smart enough to realise what it is asserting for.
* no need to use `assert_nil`, the argument in the right is expected

assert Math.add(nil, nil) == nil => this will assert for nil

if passed a string it will be returned as a message if fails

* `refute` is the opposite of `assert`

refute false == true


* for each module `async: true` allows tests from that module to be run in different beam processes
* Doctest => allows you to write example in docs and be run as tests, so it will force you to keep the docs updated
* `mix test` `mix test filename:line_number`

* Every public function should be tested
* Prefer docTest to keep docs updated

# EPISODE 13 // Processes

* To spawn a new process => to create a new process
* To spawn a new process usse the `spawn fn`

spawn fn ->
  IO.puts "This will run in a separate process"
end

* You can specify which function for a module to run in a separate process

spawn MyModule, :my_function, [arg1, arg2]

* Every bit of Elixir code runs in a BEAM process
* Processes don't share memory
* These are not Operating System processes
* It is really cheap to run processes

## Messaging

* Spawning a process returns a PID (process identifier)
* to get the PID use the self function

pid = spawn(fn -> ..end)
send pid, :message

Each process has a mailbox
Process input messages with the `receive` macro
receive accepts pattern matching, must have a default case to process every message and not to fill the process mailbox

## Process Death

* Process.exit(pid, :kill)

## Spawn_link

* Tie two processes together with `spawn_link` if one process die the other dies to.
* It can send a message with `Process.flag(:trap_exit, true)
It will process the flag and decide to die or not to die

# EPISODE 14 // GenServer

* OTP => Open Telecom Platform
* Earlang framework for building distributed systems (not only telecomunications)
* OTP is one important part of the Earlang standard library

* GenServer is an OTP module

{:ok, account} = GenServer.start(Learn.BankAccount, 0)

GenServer.cast(account, {:deposit, 50})
GenServer.cast(account, {:withdraw, 25})
balance = GenServer.call(account, :balance)

defmodule BankAccount do
  def handle_message({:deposit, amount}, _from, balance) do
    balance + amount
  end

  def handle_message({:withdraw, amount}, _from, balance) do
    balance - amount
  end

  def handle_message(:balance, from, balance) do
    send from, {:balance, balance}
    balance
  end
end

* GenServer processes are distributed across cores
* A GenServer process works on one message at a time
* GenServer processes can be supervised and restarted
* GenServer proces state can be upgraded in place

# EPISODE 15 // Supervisor

## Error Handling Philosophy

* Instead of preventing crashes, let it crash

## Supervisors
* Methods to restart the crashed processes
* Supervisors are processes that watch other processes and restart them if they fail

# EPISODE 16 // Applications

* OTP is a process oriented programming framework integral to Earlang and Elixir
* Every MIX project is an OTP app
* Buzzword compliant
* Acts like microservices
* Modules can be run from different machines, without communicating through jsons

* :observer.start 

# EPISODE 17 // Task & Agent

* These are two modules that help with processes

## Task
* Asynchronous Processing

```
  task = Task.async fn ->
    IO.puts "I'm in a different process"
  end

  task = Task.async(IO, :puts, ["I'm in a diferent process"])

  result = Task.await(task)
```

## Agent
* Storage

Acts like a GenServer

```
  {:ok, agent} = Agent.start_link(fn -> 0 end)
  Agent.update(agent, fn(state) -> state + 1 end)
  Agent.get(agent, fn(state) -> state end)
```

# EPISODE 18 // Nodes
* A node is an instance of the BEAM machine
* Start a node => `iex --sname node_name`
* You can send messages from a node to another
* `Node.self` => returns Node name
* First connect the two nodes `Node.connect(:other_node@computer)
* `Node.list`

* To connect nodes from different computers start them with the same cookie `iex --sname node_name --cokie secret`

# EPISODE 19 // Protocols
* Elixir does not allow monkey patching nor Inheritance
* Enter Protocols, Protocols allows a Library or Module to be more flexible when it comes to input.
* Protocols must be specified when developing the Library, do not forget to add docs so users can implement them.
* Data based

# EPISODE 20 // Behaviours
* Behaviour is Elixir's implementation of an Interface
* Models based

# EPISODE 21 // Exceptions
* Not for control flow
* Only when something really wrong happens
* You should return an error tuple rather than exception

`raise ArgumentError, "You provided bad arguments"`

## Catching exceptions
* You should not catch exceptions
* Exceptions should never occur

```
  try do
    something_that_might_fail
  rescue
    exception in [ArgumentError] ->
     IO.puts inspect(exception)
  end
```

```
  defmodule MyCustomException do
    defexception code: nil,
                 message: nil

    def exception(value) do
      msg = "A custom exception as raised because of: #{value}"
      %__MODULE__{message: msg}
    end
  end

  raise MyCustomException, value
```

# EPISODE 22 // Macros
* Macros allows you to write beautiful code that is good
* Macros transform code at compile time
* Prefer Data > Functions > Macros
* Solve problems with good data formats, modify it with functions if required, modify them with macros if needed.

* Define good data structures
* Write functional solutions
* If necessary pretty them up with Macros

Create the Opposite:
## Purely functional
```
  defmodule Math.Opposite do
    def opposite(:+, [a, b]) do
      a - b
    end
  end

  import Math.Opposite

  opossite(:+ [1 , 1])
```

## Defining a Macro

```
  defmodule Math.Opposite do
    defmacro opposite({:+, context, [a, b]}) do
      {:-, context, [a, b]}
    end
  end
```
## Macro with Quote helper
* Qoute helper returns an AST
```
  defmodule Math.Opposite do
    defmacro opposite({:+, _, [a, b]}) do
      quote do
        unquote(a) - unquote(b)
      end
    end
  end
```

* `unless` is a macro that expands to `if !condition do expretion end`
* `if` is a macro that expands to
```
  case condition do
    x when x in [false, nil] -> nil
    _ -> expr
  end
```

# EPISODE 23 // Binary
* Bit => 0 or 1
* Byte => 00000000 => 0
* Byte => 00000001 => 1

# EPISODE 24 // GenEvent
* GenEvent is a behaviour module for implementing event handling functionality

# EPISODE 25 // Dializer
* Static Typing: is when you specify the arguments with data types and would fail at compile type if wrong data type is passed
* Elixir doesn't have Static Typing
* Elixir has Dializer which will check types
* Pattern matching prevents errors at runtime
* Dializer gives warnings before runtime, doesn't prevent compilation
## Spec Annotations
* Are optionals
* In order to Dializer understand your code you must add `@sepc` to your functions.
```
  @spec my_function(map) :: integer
  @spec my_function(args) :: return_value
  def my_function(%{pattern: match}) -> hanlde end
```

`@spec` is a module Attribute

# EPISODE 26 // Deployment to self-managed hardware
* ExRM => Elixir release manager
* Hot Code Upgrading

# EPISODE 27 // Observer
* `:observer.start` inside `iex -S mix`

# EPISODE 28 // With Macro
* The `with` macro is kind of a more advanced pipeline operator

The following function would run as expected unless there is an error, for example if send api is down
```
  data
  |> encode
  |> send
  |> parse_response
```

* `with` allows us to patern match on the return values on each of the functions of the pipeline
* only if the pattern matches the next clause will be executed
* use `else` to handle errors

```
  with {:ok, data} <- encode(data),
       {:ok, resp} <- send(data),
       {:ok, decoded} <- parse_response(resp) do
    decoded
  else
    {:error, invalid_data} -> #recover from invalid data
  end
```

# EPISODE 29 // Registry
* It is a "local descentralized and scalable, key-value process storage"
* It is not distributed, it is not shared into multiple processes
```
  {:ok, _pid} = Registry.start_link(:unique, MyApp.Registry)
  # Registers the current Process ID with the registry, with key value pairs
  Registry.register(MyApp.Registry, "Hello", "World")
  # You can use the latter key to lookup the PID
  Registry.lookup(MyApp.Registry, "Hello") # => [{#Pid<>, "world"}]
