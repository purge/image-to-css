#!/usr/bin/env coffee
fs = require 'fs'
mime = require 'mime'
argv = require('optimist')
  .usage('$0 <source directory>')
  .demand(1)
  .argv

dir = argv._[0]

fs.readdir dir, (err, files) ->
  throw err if err
  files.forEach (file) ->
    srcPath = dir + '/' + file
    fs.readFile srcPath, (err, data) ->
      throw err if err
      #convert file to base64, warn if its too big for IE.
      payload = data.toString('base64')
      throw "payload too big for IE" if payload.length > 32768
      fname = cssSafeName(file)
      mimeType = mime.lookup(srcPath)
      process.stdout.write(".#{fname} { background: url(data:#{mimeType};base64,#{payload}) no-repeat; }\n")

cssSafeName = (src) ->
  return src.replace(/[!""#$%&'()\*\+,\./:;<=>\?@\[\\\]^`{\|}~ ]/, '-');
