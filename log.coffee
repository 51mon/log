
tc = require 'tc'

inspect = require('util').inspect

options = writer: process.stdout

logger = (args...) ->
    _args = []
    _args = for arg in args
      switch typeof arg
        when 'string'
          if arg.match(/^[A-Z]/)?
            tc.green arg
          else if arg.match(/<[/]?\w+/)
            tc.magenta arg
          else if arg.match(/\w+=/)?
            tc.yellow arg
          else
            tc.dark arg
        when 'number', 'boolean' then tc.red arg
        when 'function' then tc.yellow arg
        when 'undefined' then tc.bold().dark 'undefined'
        else
          if arg?.exec? then tc.red inspect(arg)
          else if arg?.push? then tc.magenta inspect(arg)
          #else if !arg? then tc.bold().dark inspect arg
          else tc.cyan inspect(arg)
    options.writer.write _args.join ' '
    options.writer.write '\n'

module.exports = (_options) ->
  for k, v of _options
    options[k] = v
  logger

