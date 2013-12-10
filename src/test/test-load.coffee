assert = require 'assert'

describe 'hipchat-addon generator', ->
  it 'can be imported without blowing up', ->
    app = require '../app'
    assert(app?)
