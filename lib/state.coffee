class State
  constructor: (@rule, @index, @parse) ->
    @parse = 0 if not @parse?

  getTarget: () ->
    return @rule.getTarget()

  getNext: () ->
    return @rule.getCategory @parse

  clone: () ->
    rule = @rule.clone()
    return new State rule, @index, @parse

  incrementParse: () ->
    ++@parse
    
module.exports.State = State
