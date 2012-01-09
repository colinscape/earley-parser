class State
  constructor: (@rule, @start, @length, @parse) ->
    @start = 0 if not @start?
    @length = 0 if not @length?
    @parse = 0 if not @parse?
    @previous = []

  getTarget: () ->
    return @rule.getTarget()

  getNext: () ->
    return @rule.getCategory @parse

  clone: (length) ->
    rule = @rule.clone()
    return new State rule, @start, length, @parse

  incrementParse: () ->
    ++@parse

  isNextCategoryNonTerminal: (grammar) ->
    nextCategory = @getNext()
    rules = grammar.getRulesFor nextCategory
    return rules.length isnt 0

  getHash: () ->
    return @display()

  isIncomplete: () ->
    return @parse isnt @rule.getLength()
  
  isComplete: () ->
    return @parse is @rule.getLength()
    
  display: () ->
    previousDisplay = (p.display() for p in @previous)
    return "#{@rule.display @parse} (#{@start},#{@length})   [#{previousDisplay.join ']['}]"

  getStart: () ->
    return @start

  getLength: () ->
    return @length


  addPrevious: (previous) ->
    @previous.push previous

module.exports.State = State
