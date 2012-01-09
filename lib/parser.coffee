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
  initialState = new lib.state.State initialRule
  charts[0].enqueue initialState
  
  for i in [0..words.length]
    word = words[i]
    iState = 0
    while charts[i].getStates()[iState]?
      state = charts[i].getStates()[iState]
      if state.isIncomplete()
        if state.isNextCategoryNonTerminal(grammar)
          predict state, grammar, charts
        else
          scan state, words, grammar, charts
      else
        complete state, charts
      ++iState
  return new lib.result.Result charts

predict = (state, grammar, charts) ->
  b = state.getNext()
  i = state.getStart()
  j = state.getLength()  
  rules = grammar.getRulesFor b
  for rule in rules
    newState = new lib.state.State rule, j, j, 0
    charts[j].enqueue newState

scan = (state, words, grammar, charts) ->
  b = state.getNext()
  i = state.getStart()
  j = state.getLength()
  word = words[j]
  if word and b in grammar.getPartsOfSpeechFor word
    rule = new lib.rules.Rule b, [word]
    newState = new lib.state.State rule, j, j+1, 1
    charts[j+1].enqueue newState

complete = (state, charts) ->
  b = state.getTarget()
  j = state.getStart() 
  k = state.getLength()
  for testState in charts[j].getStates()
    i = testState.getStart()
    j2 = testState.getLength()
    next = testState.getNext()
    if next is b and j is j2
      newState = testState.clone k
      newState.incrementParse()
      charts[k].enqueue newState, state

module.exports.parse = parse
