require 'test_helper'

class Sanity; end

describe Sanity do
  subject { true }

  specify { subject.must_equal true }
end
