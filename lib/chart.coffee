_ = require 'underscore'

class Chart
  constructor: () ->
    @states = []
    @present = {}

  enqueue: (state, previous) ->
    if previous?
      state.addPrevious previous 
    hash = state.getHash()
    if not @present[hash]
      @states.push state
      @present[hash] = true

  getStates: () ->
    return @states

  display: () ->
    state.display() for state in @states

module.exports.Chart = Chart