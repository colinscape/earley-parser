class State
  constructor: (@rule, @index, @parse) ->
    @index = 0 if not @index?
    @parse = 0 if not @parse?

  getTarget: () ->
    return @rule.getTarget()

  getNext: () ->
    return @rule.getCategory @parse

  clone: (i) ->
    rule = @rule.clone()
    return new State rule, i, @parse

  incrementParse: () ->
    ++@parse

  isNextCategoryNonTerminal: (grammar) ->
    nextCategory = @getNext()
    rules = grammar.getRulesFor nextCategory
    return rules.length isnt 0

  getHash: () ->
    return "#{@rule.display @parse} (#{@index})"

  isIncomplete: () ->
    return @parse isnt @rule.getLength()
  
  isComplete: () ->
    return @parse is @rule.getLength()
    
  display: () ->
    return "#{@rule.display(@parse)} (#{@index})"

  getIndex: () ->
    return @index

module.exports.State = State
