require 'minitest/spec'

World(MiniTest::Assertions)
MiniTest::Spec.new(nil)

World(FactoryGirl::Syntax::Methods)
