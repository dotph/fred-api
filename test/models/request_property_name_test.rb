require 'test_helper'

describe RequestPropertyName do
  describe :associations do
    subject { create :request_property_name }

    before do
      create :request_property_value, request_property_name: subject
      create :request_property_value, request_property_name: subject
    end

    specify { subject.request_property_values.wont_be_empty }
  end
end
