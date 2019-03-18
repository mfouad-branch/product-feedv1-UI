{spawn}     = require "child_process"
{platform}  = require "os"
{chmodSync} = require "fs"
path = require "path"
{remote} = require "electron"

class Converter
  constructor: ({@source, @template, @target, @baseURL, @log}) ->
    @target = @source
    @target = @target.replace(/\.([^.]+)$/, '_'+@template+'.$1')
    { isPackaged, getAppPath } = remote.app
    @pathToBin = path.resolve(path.join(path.dirname(getAppPath()), '..', './Resources', './bin', './main'))
    chmodSync @pathToBin, 0o755

  process: ->
    @log "Starting converting process.."
    @child = spawn @pathToBin, [@baseURL, @source, @target, @template , ","]

    @child.stdout.on "data", (data) =>
      @log "#{data.toString().replace(/\n/g, '<br>')}"

    @child.stderr.on "data", (data) =>
      @log "ERROR: #{data.toString().replace(/\n/g, '<br>')}", 'error'

    @child.on "exit", (code) =>
      style = if code == 0 then 'good' else 'error'
      @log "Converted Successfully", style
