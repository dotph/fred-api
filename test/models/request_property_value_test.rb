require 'test_helper'

describe RequestPropertyValue do
  describe :associations do
    subject { create :request_property_value }

    specify { subject.request.wont_be_nil }
    specify { subject.request_property_name.wont_be_nil }
  end
end
