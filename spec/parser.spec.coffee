lib = {}
lib.rules = require '../lib/rules'
lib.state = require '../lib/state'
lib.grammar = require '../lib/grammar'
lib.parser = require '../lib/parser'

describe 'Parser', () ->

  xit 'should parse nothing', () ->
    rule = new lib.rules.Rule 's', ['vp']
    grammar = new lib.grammar.Grammar [rule]
    result = lib.parser.parse [], grammar
    expect(result).toBeDefined()

  xit 'should parse the Juraksky and Martin grammar', () ->
    rule1  = new lib.rules.Rule 'S', ['NP', 'VP']
    rule2  = new lib.rules.Rule 'S', ['Aux', 'NP', 'VP']
    rule3  = new lib.rules.Rule 'S', ['VP']
    rule4  = new lib.rules.Rule 'NP', ['Det', 'Nominal']
    rule5  = new lib.rules.Rule 'Nominal', ['Noun']
    rule6  = new lib.rules.Rule 'Nominal', ['Noun', 'Nominal']
    rule7  = new lib.rules.Rule 'NP', ['Proper-Noun']
    rule8  = new lib.rules.Rule 'VP', ['Verb']
    rule9  = new lib.rules.Rule 'VP', ['Verb', 'NP']
    rule10 = new lib.rules.Rule 'Nominal', ['Nominal', 'PP']
    lexicon = (word) ->
      pos = []
      if word in ['that', 'this', 'a'] then pos.push 'Det'
      if word in ['book', 'flight', 'meal', 'money'] then pos.push 'Noun'
      if word in ['book', 'include', 'prefer'] then pos.push 'Verb'
      if word in ['does'] then pos.push 'Aux'
      if word in ['from', 'to', 'on'] then pos.push 'Prep'
      if word in ['Houston', 'TWA'] then pos.push 'Proper-Noun'
      return pos

    grammar = new lib.grammar.Grammar [rule1, rule2, rule3, rule4, rule5, rule6, rule7, rule8, rule9, rule10], lexicon
    result = lib.parser.parse ['book', 'that', 'flight'], grammar  
    expect(result).toBeDefined()
    expect(result.wasSuccessful()).toEqual true
    expect(result.getNumberOfParses()).toEqual 1
    console.log result.display()

  it 'should parse Wikipedia grammar', () ->
    rule1 = new lib.rules.Rule 'P', ['S']
    rule2a = new lib.rules.Rule 'S', ['S', 'plus', 'M']
    rule2b = new lib.rules.Rule 'S', ['M']
    rule3a = new lib.rules.Rule 'M', ['M', 'times', 'number']
    rule3b = new lib.rules.Rule 'M', ['number']
    lexicon = (word) -> 
      switch word
        when '1', '2', '3', '4' then return ['number']
        when '+' then return ['plus']
        when '*' then return ['times']
    grammar = new lib.grammar.Grammar [rule1, rule2a, rule2b, rule3a, rule3b], lexicon
    result = lib.parser.parse ['2', '+', '3', '*', '4'], grammar
    expect(result).toBeDefined()
    expect(result.wasSuccessful()).toEqual true


  xit 'should parse simple grammar', () ->
    rule = new lib.rules.Rule 'A', ['noun']
    lexicon = (word) -> return ['noun']
    grammar = new lib.grammar.Grammar [rule], lexicon
    result = lib.parser.parse ['a'], grammar
    expect(result).toBeDefined()
    expect(result.wasSuccessful()).toEqual true
    expect(result.getNumberOfParses()).toEqual 1

  xit 'should parse ambiguous grammar', () ->
    rule1 = new lib.rules.Rule 'A', ['B']
    rule2 = new lib.rules.Rule 'A', ['C']
    rule3 = new lib.rules.Rule 'B', ['noun']
    rule4 = new lib.rules.Rule 'C', ['noun']
    lexicon = (word) -> return ['noun']
    grammar = new lib.grammar.Grammar [rule1, rule2, rule3, rule4], lexicon
    result = lib.parser.parse ['a'], grammar
    expect(result).toBeDefined()
    expect(result.wasSuccessful()).toEqual true
    expect(result.getNumberOfParses()).toEqual 2


