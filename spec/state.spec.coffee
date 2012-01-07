lib = {}
lib.rules = require '../lib/rules'
lib.state = require '../lib/state'
lib.grammar = require '../lib/grammar'

describe 'State', () ->

  it 'should have a target', () ->
    rule = new lib.rules.Rule 'TARGET', []
    state = new lib.state.State rule, 0
    expect(state.getTarget()).toEqual('TARGET')

  it 'should have same hash for equivalent states', () ->
    rule1 = new lib.rules.Rule 'TARGET', []
    state1 = new lib.state.State rule1, 0

    rule2 = new lib.rules.Rule 'TARGET', []
    state2 = new lib.state.State rule2, 0
    expect(state1.getHash()).toEqual(state2.getHash())

  it 'should have different hash for different parse positions', () ->
    rule1 = new lib.rules.Rule 'TARGET', ['first', 'second']
    state1 = new lib.state.State rule1, 0, 0

    rule2 = new lib.rules.Rule 'TARGET', ['first', 'second']
    state2 = new lib.state.State rule2, 0, 1
    expect(state1.getHash()).toNotEqual(state2.getHash())

  it 'should have different hash for different indices', () ->
    rule1 = new lib.rules.Rule 'TARGET', ['first', 'second']
    state1 = new lib.state.State rule1, 0, 0

    rule2 = new lib.rules.Rule 'TARGET', ['first', 'second']
    state2 = new lib.state.State rule2, 1, 0
    expect(state1.getHash()).toNotEqual(state2.getHash())

  it 'should have different hash for different rules', () ->
    rule1 = new lib.rules.Rule 'TARGET', ['first', 'second']
    state1 = new lib.state.State rule1, 0, 0

    rule2 = new lib.rules.Rule 'TARGET2', ['first', 'second']
    state2 = new lib.state.State rule2, 1, 0
    expect(state1.getHash()).toNotEqual(state2.getHash())    

  it 'should have appropriate next category', () ->
    rule = new lib.rules.Rule 'TARGET', [0,1,2,3,4]

    state = new lib.state.State rule, 0
    expect(state.getNext()).toEqual(0)

    state.incrementParse()
    state.incrementParse()
    state.incrementParse()
    expect(state.getNext()).toEqual(3)

    state.incrementParse()
    expect(state.getNext()).toEqual(4)

  it 'should know if next category is non terminal', () ->
    rule1 = new lib.rules.Rule 's', ['v', 'p', 'n']
    rule2 = new lib.rules.Rule 'v', ['s', 't']
    rule3 = new lib.rules.Rule 'n', ['s', 't']
    grammar = new lib.grammar.Grammar [rule1, rule2, rule3]

    state = new lib.state.State rule1, 0
    expect(state.getNext()).toEqual('v')
    expect((grammar.getRulesFor 'v').length).toEqual 1
    expect(state.isNextCategoryNonTerminal(grammar)).toEqual true

    state.incrementParse()
    expect(state.getNext()).toEqual('p')
    expect((grammar.getRulesFor 'p').length).toEqual 0
    expect(state.isNextCategoryNonTerminal(grammar)).toEqual false

    state.incrementParse()
    expect(state.getNext()).toEqual('n')
    expect((grammar.getRulesFor 'n').length).toEqual 1
    expect(state.isNextCategoryNonTerminal(grammar)).toEqual true

  it 'should be incomplete when not parsed fully', () ->
    rule = new lib.rules.Rule 'TARGET', [0,1,2,3,4]

    state1 = new lib.state.State rule, 0, 0
    expect(state1.isIncomplete()).toEqual true

    state2 = new lib.state.State rule, 0, 3
    expect(state2.isIncomplete()).toEqual true

    state3 = new lib.state.State rule, 0, 5
    expect(state3.isIncomplete()).toEqual false
