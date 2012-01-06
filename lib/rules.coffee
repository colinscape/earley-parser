_ = require 'underscore'

class Rule
  constructor: (@target, @body) ->

  getTarget: () ->
    return @target

  getCategory: (i) ->
    return @body[i]

  clone: () ->
    return new Rule @target, _.clone @body

class InitialRule extends Rule
  constructor: (@body) ->

  getTarget: () ->
    return '@'

module.exports.Rule = Rule
module.exports.InitialRule = InitialRule
