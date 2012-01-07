_ = require 'underscore'

class Rule
  constructor: (@target, @body) ->

  getTarget: () ->
    return @target

  getCategory: (i) ->
    return @body[i]

  clone: () ->
    return new Rule @target, _.clone @body

  getLength: () ->
    return @body.length

  display: (parse) ->
    info = _.clone @body
    info.splice parse, 0, '@'
    return "#{@target} -> #{info.join ' '}"

class InitialRule extends Rule
  constructor: (grammar) ->
    super 'GAMMA', [grammar.getRoot()]

module.exports.Rule = Rule
module.exports.InitialRule = InitialRule
