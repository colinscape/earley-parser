_ = require 'underscore'
lib =
  rules: require './rules'
  state: require './state'
  chart: require './chart'
  result: require './result'

parse = (words, grammar) ->

  if words.length is 0 then return new lib.chart.Chart []

  charts = []
  _.times (words.length+1), () -> charts.push (new lib.chart.Chart())
  initialRule = new lib.rules.InitialRule grammar
  initialState = new lib.state.State initialRule, 0
  charts[0].enqueue initialState
  
  for i in [0..words.length]
    word = words[i]
    iState = 0
    while charts[i].getStates()[iState]?
      state = charts[i].getStates()[iState]
      if state.isIncomplete()
        if state.isNextCategoryNonTerminal(grammar)
          predict state, i, grammar, charts
        else
          scan state, i, word, grammar, charts
      else
        complete state, i, charts
      ++iState
  return new lib.result.Result charts

predict = (state, j, grammar, charts) ->
  b = state.getNext()
  rules = grammar.getRulesFor b
  for rule in rules
    newState = new lib.state.State rule, j
    charts[j].enqueue newState

scan = (state, j, word, grammar, charts) ->
  b = state.getNext()
  i = state.getIndex()
  if b in grammar.getPartsOfSpeechFor word
    rule = new lib.rules.Rule b, [word]
    newState = new lib.state.State rule, i
    newState.incrementParse()
    charts[j+1].enqueue newState

complete = (state, k, charts) ->
  b = state.getTarget()
  j = state.getIndex() 
  for state in charts[j].getStates()
    i = state.getIndex()
    next = state.getNext()
    if next is b
      newState = state.clone(i)
      newState.incrementParse()
      charts[k].enqueue newState

module.exports.parse = parse
