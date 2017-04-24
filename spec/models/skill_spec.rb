require 'rails_helper'
require './spec/support/autocompletable'

RSpec.describe Skill do
  include_examples "acts like autocompletable"
end
