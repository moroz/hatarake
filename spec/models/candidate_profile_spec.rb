# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CandidateProfile, type: :model do
  let(:profile) { FactoryBot.build(:candidate_profile) }
  describe 'validations' do
    context 'with correct attributes' do
      it 'is valid' do
        expect(profile).to be_valid
      end
    end

    describe 'names' do
      context 'without first name' do
        it 'is invalid' do
          profile.first_name = nil
          expect(profile).not_to be_valid
        end
      end

      context 'without last name' do
        it 'is invalid' do
          profile.last_name = nil
          expect(profile).not_to be_valid
        end
      end

      context 'without sex' do
        it 'is valid on create' do
          profile.sex = nil
          expect(profile).to be_valid
        end
      end
    end
  end

  describe 'display name' do
    let(:profile) do
      FactoryBot.build(:candidate_profile,
                       first_name: 'Apache',
                       last_name: 'Helicopter')
    end

    it 'returns full name' do
      expect(profile.display_name).to eq('Apache Helicopter')
    end
  end
end
