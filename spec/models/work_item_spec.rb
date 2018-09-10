# frozen_string_literal: true

require 'rails_helper'
require './spec/support/cv_item'

RSpec.describe WorkItem do
  include_examples 'cv item'
end
