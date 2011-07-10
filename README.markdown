settings-ohm
============

Simple Settings Model using Ohm/Redis for data storage. 

Description
___________

A simple way to directly set and retrieve settings for your Ohm based app.
You can store strings, integers, floats and boolean true/false values.
Every setting is set and accessed using a symbol, i.e. Settings[:port]

Usage
_____

In your application:

```ruby
require "ohm"
require "./settings-ohm"

Ohm.connect
```

Set settings:
```ruby
Setting[:name] = "simple settings using Ohm"
Setting[:port] = 3456
Setting[:open] = true
```

Retrieve settings:
```ruby
Setting[:name] # => "simple settings using Ohm"
Setting[:port] # => 3456
Setting[:open] # => true

# unset settings return nil
Setting[:adress] # => nil
```

Instead of raising an error, using anything other than a symbol as an identifier will return false
```ruby
Setting["string as an identifier"] # => false
```