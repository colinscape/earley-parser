{exec} = require 'child_process'

task 'specs', 'run the jasmine specs', (options) ->
  console.log "Running specs"
  exec './node_modules/jasmine-node/specs.sh spec', (err, stdout, stderr) ->
    console.log stdout + stderr or "Successfully ran specs."
