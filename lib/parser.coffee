lib.rules = require './lib/rules'
lib.state = require './lib/state'

parse = (words, grammar) ->
  chart = []
  _.times word.length, () -> chart.push []
  initialRule = new lib.rulesInitialRule grammar.getRoot()
  chart[0].enqueue initialRule, 0
  
  for word,i in words
    for state in chart[i]
      if state.isIncomplete()
        if state.nextCategoryIsNonTerminal()
          predict state, i, grammar, chart
        else scan state, i, word, grammar, chart
      else
        complete state, i, chart
  return chart

predict = (state, j, grammar, chart) ->
  b = state.getNext()
  rules = grammar.getRulesFor b
  for rule in rules
    chart[j].enqueue rule, j

scan = (state, j, word, grammar, chart) ->
  b = state.getNext()
  i = state.getIndex()
  if b in grammar.getPartsOfSpeechFor word
    rule = new lib.rules.Rule b, word
    chart[j+1].enqueue rule, i

complete = (state, k, chart) ->
  b = state.getTarget()
  j = state.getIndex() 
  for state in chart[j]
    i = state.getIndex()
    next = state.getNext()
    if next is b
      rule = state.clone().incrementParse()
      chart[k].enqueue rule,i 
