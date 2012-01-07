_ = require 'underscore'

class Result

  constructor: (@charts) ->

  wasSuccessful: () ->
    return @getNumberOfParses() isnt 0

  getNumberOfParses: () ->
    nParses = 0
    lastChart = _.last @charts
    if not lastChart? then return 1    
    for state in lastChart.getStates()
      if state.isComplete() and state.getIndex() is 0 and state.getTarget() is 'GAMMA'
        ++nParses
    return nParses

  display: () ->
    chart.display() for chart in @charts

module.exports.Result = Result