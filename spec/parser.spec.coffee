lib = {}
lib.rules = require '../lib/rules'
lib.state = require '../lib/state'
lib.grammar = require '../lib/grammar'
lib.parser = require '../lib/parser'

describe 'Parser', () ->

  it 'should parse nothing', () ->
    rule = new lib.rules.Rule 's', ['vp']
    grammar = new lib.grammar.Grammar [rule]
    grammar.getRoot()
    result = lib.parser.parse [], grammar
    expect(result).toBeDefined()




