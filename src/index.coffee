path     = require("path")
settings = require("./settings")

# load settings
{options} = settings

if options.wait
  require("./run")
else
  spawn = require("child_process").spawn
  cmd = process.argv[0]
  runFile = (if cmd is "coffee" then "#{path.join __dirname, 'run.coffee'}" else "#{path.join __dirname, 'run.js'}")
  child_args = [runFile].concat process.argv[2..]
  child = spawn cmd, child_args,
    stdio: "inherit"
    detached: true
  child.unref()

  child.on "error", (err) ->
    console.error "#{err}"
    process.exit(1)
