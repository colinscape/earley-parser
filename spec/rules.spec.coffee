rules = require '../lib/rules'

describe 'Rules', () ->

  it 'should have a target', () ->
    rule = new rules.Rule 'TARGET', []
    expect(rule.getTarget()).toEqual('TARGET')

  it 'should have a valid category', () ->
    rule = new rules.Rule 'TARGET', ['first', 'second']
    expect(rule.getCategory 0).toEqual('first')

  it 'should be cloneable', () ->
    rule = new rules.Rule 'TARGET', ['first', 'second']
    clonedRule = rule.clone()
    expect(clonedRule.getTarget()).toEqual 'TARGET'
    expect(clonedRule.getCategory 0).toEqual 'first'
    expect(clonedRule.getCategory 1).toEqual 'second'

  it 'clones should be independent', () ->
    rule = new rules.Rule 'TARGET', ['first', 'second']
    clonedRule = rule.clone()
    rule.body[0] = 'SURPRISE'
    expect(rule.getCategory 0).toEqual 'SURPRISE'
    expect(clonedRule.getCategory 0).toEqual 'first'

  it 'should have a length', () ->
    rule = new rules.Rule 'TARGET', ['first', 'second']
    expect(rule.getLength()).toEqual 2
    


