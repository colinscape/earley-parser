class Grammar
  constructor: (@rules, @lexicon) ->

  getRoot: () ->
    return @rules[0].getTarget()

  getRulesFor: (category) ->
    result = []
    for rule in @rules
      if rule.getTarget() is category
        result.push rule
    return result

  getPartsOfSpeechFor: (word) ->
    return @lexicon word
    
module.exports.Grammar = Grammar
