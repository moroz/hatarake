require 'rails_helper'
require './spec/support/localizable'

RSpec.describe Province, type: :model do
  include_examples "acts like localizable"
end
