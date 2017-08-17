require 'rails_helper'
require './spec/support/autocompletable'
require './spec/support/localizable'

RSpec.describe Profession, type: :model do
  include_examples "acts like autocompletable"
  include_examples "acts like localizable"
end
