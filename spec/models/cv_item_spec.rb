require 'rails_helper'
require './spec/support/cv_item'

RSpec.describe EducationItem do
  include_examples "cv item"
end

RSpec.describe WorkItem do
  include_examples "cv item"
end
