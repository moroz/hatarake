require 'rails_helper'

RSpec.describe SkillItem, type: :model do
  let(:skill_item) { FactoryGirl.build(:skill_item) }

  describe 'validations' do
    describe 'level' do
      describe 'inclusion in defined values' do

        context 'with valid level' do
          it 'is valid' do
            skill_item.level = '3_good'
            expect(skill_item).to be_valid
          end
        end

        context "with invalid leve" do
          it "is invalid" do
            skill_item.level = "foobar"
            expect(skill_item).not_to be_valid
          end
        end

      end
    end
  end

  describe "auto-creating Skill" do
    let(:skill) { FactoryGirl.create(:skill, name: "Bazz") }

    context "when Skill doesn't exist" do
      it "creates a new Skill" do
        skill_item.skill_name = "Foobar"
        expect { skill_item.save }.to change { Skill.count }
      end
    end

    context "when Skill exists" do
      it "reuses existing Skill" do
        skill_item.skill_name = skill.name
        expect { skill_item.save }.not_to change { Skill.count }
      end
    end

  end
end
