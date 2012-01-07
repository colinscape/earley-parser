lib = {}
lib.rules = require '../lib/rules'
lib.state = require '../lib/state'
lib.grammar = require '../lib/grammar'

describe 'Grammar', () ->

  it 'should have a root', () ->
    s = new lib.rules.Rule 's', ['v']
    v = new lib.rules.Rule 'v', ['e', 'r']
    grammar = new lib.grammar.Grammar [s,v]
    expect(grammar.getRoot()).toEqual('s')

  it 'should have rules for specific category', () ->
    s1 = new lib.rules.Rule 's', ['v']
    s2 = new lib.rules.Rule 's', ['v', 'e']
    v1 = new lib.rules.Rule 'v', ['r', 'y']
    v2 = new lib.rules.Rule 'v', ['y', 'j']
    grammar = new lib.grammar.Grammar [s1,s2,v1,v2]
    expect((grammar.getRulesFor 'v').length).toEqual(2)
    expect((grammar.getRulesFor 's').length).toEqual(2)
    expect((grammar.getRulesFor 'vss').length).toEqual(0)

  it 'should retrieve parts of speech', () ->
    lexicon = (word) ->
      return ['article', 'dull']
    grammar = new lib.grammar.Grammar [], lexicon
    expect(grammar.getPartsOfSpeechFor 'the').toEqual ['article', 'dull']

  it 'should retrieve correct parts of speech', () ->
    lexicon = (word) ->
      switch word
        when 'bob' then ['noun']
        when 'mike' then ['noun', 'verb']
        when 'a' then ['article']
    grammar = new lib.grammar.Grammar [], lexicon
    expect(grammar.getPartsOfSpeechFor 'bob').toEqual ['noun']
    expect(grammar.getPartsOfSpeechFor 'mike').toEqual ['noun', 'verb']
    expect(grammar.getPartsOfSpeechFor 'a').toEqual ['article']

