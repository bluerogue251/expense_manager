require 'spec_helper'

describe Department do
  it { should validate_presence_of(:name) }
end
