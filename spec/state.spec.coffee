rules = require '../lib/rules'
stat = require '../lib/state'

describe 'State', () ->

  it 'should have a target', () ->
    rule = new rules.Rule 'TARGET', []
    state = new stat.State rule, 0
    expect(state.getTarget()).toEqual('TARGET')

  it 'should have appropriate next category', () ->
    rule = new rules.Rule 'TARGET', [0,1,2,3,4]

    state0 = new stat.State rule, 0
    expect(state0.getNext()).toEqual(0)

    state0.incrementParse()
    state0.incrementParse()
    state0.incrementParse()
    expect(state0.getNext()).toEqual(3)

    state0.incrementParse()
    expect(state0.getNext()).toEqual(4)

