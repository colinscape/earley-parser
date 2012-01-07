{exec} = require 'child_process'

task 'specs', 'run the jasmine specs', (options) ->
  console.log "Running specs"
  exec 'jasmine-node --coffee spec', (err, stdout, stderr) ->
    console.log stdout + stderr or "Successfully ran specs."

task 'Specs', 'run the verbose jasmine specs', (options) ->
  console.log "Running verbose specs"
  exec 'jasmine-node --verbose --coffee spec', (err, stdout, stderr) ->
    console.log stdout + stderr or "Successfully ran specs."

