$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

ENV['TRACES_BACKEND'] ||= 'traces/backend/console'

require 'bundler/setup'
require 'covered/config'

def initialize(root, paths)
	super
	
	@covered = Covered::Config.load
	if @covered.record?
		@covered.enable
	end
end

def after_tests(assertions)
	super(assertions)
	
	if @covered.record?
		@covered.disable
		@covered.call(self.output.io)
	end
end
