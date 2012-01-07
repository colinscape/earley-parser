lib = {}
lib.rules = require '../lib/rules'
lib.state = require '../lib/state'
lib.grammar = require '../lib/grammar'
lib.parser = require '../lib/parser'
lib.chart = require '../lib/chart'

describe 'Chart', () ->
  
  it 'new chart should have no states', () ->
    chart = new lib.chart.Chart()
    expect(chart.getStates().length).toEqual 0

  it 'adding a state should increment state count', () ->
    chart = new lib.chart.Chart()
    expect(chart.getStates().length).toEqual 0
    rule = new lib.rules.Rule 'a', []
    state = new lib.state.State rule, 0
    chart.enqueue state
    expect(chart.getStates().length).toEqual 1

  it 'adding a state again should not increment state count', () ->
    chart = new lib.chart.Chart()
    expect(chart.getStates().length).toEqual 0

    rule = new lib.rules.Rule 'a', []
    state = new lib.state.State rule, 0
    chart.enqueue state
    expect(chart.getStates().length).toEqual 1
    
    duplicateState = new lib.state.State rule, 0    
    chart.enqueue duplicateState
    expect(chart.getStates().length).toEqual 1     
