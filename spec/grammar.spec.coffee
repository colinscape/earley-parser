rules = require '../lib/rules'
stat = require '../lib/state'

describe 'Grammar', () ->

  it 'should have a target', () ->
    rule = new rules.Rule 'TARGET', []
    state = new stat.State rule, 0
    expect(state.getTarget()).toEqual('TARGET')


