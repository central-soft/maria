assert = require 'assert'
hello = require '../scripts/20170120_hello'

describe 'TestHello', ->  
	it 'add', ()-> 
		assert hello.test() == "hello"

