assert = require 'assert'
demo = require '../scripts/demo_module'

describe 'demo test', ->  
	it 'cs', ()-> 
		assert demo.demoFunc('cs') == 'CENTRAL SOFT'
	it 'other', ()-> 
		assert demo.demoFunc('other') == 'hello world!!'
	