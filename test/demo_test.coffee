assert = require 'assert'
demo = require '../scripts/demo_module'

describe 'demo test', ->  
	it 'test', ()-> 
		assert demo.demoFunc('test') == 'test'
	it 'test2', ()-> 
		assert demo.demoFunc('test2') == 'test2'
	it 'none', ()-> 
		assert demo.demoFunc('') == 'aa'
	



