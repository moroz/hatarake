# frozen_string_literal: true

require 'rails_helper'
require './spec/support/autocompletable'
require './spec/support/localizable'

RSpec.describe Skill do
  include_examples 'acts like localizable'
  include_examples 'acts like autocompletable'
end
