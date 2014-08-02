require 'spec_helper'

describe JobTitle do
  it { should validate_presence_of(:name) }
end
