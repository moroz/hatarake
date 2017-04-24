require 'rails_helper'
require './spec/support/autocompletable'

RSpec.describe Profession, type: :model do
  include_examples "acts like autocompletable"
end
