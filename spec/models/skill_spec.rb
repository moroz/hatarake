require 'rails_helper'

RSpec.describe Skill, type: :model do
  let(:skill) { FactoryGirl.build(:skill_item) }
  describe 'validations' do
    describe 'level' do
      describe 'inclusion in defined values' do
        context 'with valid level' do
          it 'is valid' do
            skill.level = 'intermediate'
            expect(skill).to be_valid
          end
        end
      end
    end
  end
end