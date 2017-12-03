require 'rails_helper'

RSpec.describe 'Candidate edits CV items' do
  let(:candidate) { FactoryBot.create(:candidate) }
  
  before(:each) do
    login_as(candidate, scope: :candidate)
  end

  describe 'work items' do
    
    context 'when user clicks edit link' do

      it 'goes to work_items_path' do
        visit profile_path
        within '#candidate_work_experience' do
          click_link_or_button I18n.t('actions.edit')
          expect(current_path).to eq(work_items_path)
        end
      end

    end

    describe 'adding new items' do
      before do
        visit work_items_path
      end

      it 'shows new item form' do
        expect(page).to have_selector 'form#new_work_item'
      end

      it 'shows no work items' do
        expect(page).to have_no_selector '.work_item'
      end
      
      context "when submitted with valid attributes" do

        def fill_in_with_valid_attributes
          find('#work_item_organization').set('Biedronka')
          find('#work_item_position').set('merchandiser')
          find('#work_item_category').find(:xpath, 'option[2]').select_option
          find('#work_item_start_date_1i').find("option[value='#{Time.now.year-2}']").select_option
          find('#work_item_start_date_2i').find('option[value="3"]').select_option
          find('#work_item_end_date_1i').find("option[value='#{Time.now.year-1}']").select_option
          find('#work_item_end_date_2i').find('option[value="6"]').select_option
        end

        before do
          visit work_items_path
          fill_in_with_valid_attributes
        end

        it 'creates new work item' do
          expect { submit_form }.to change { candidate.work_items.count }
        end

        # Work and education items share templates and therefore have only one
        # and the same class: .cv_item
        it 'displays the new item' do
          submit_form
          expect(page).to have_selector('.cv_item', count: 1)
        end
      end
      
    end

    describe 'deleting items' do
      let!(:work_item) { FactoryBot.create(:work_item, candidate: candidate) }

      before do
        visit work_items_path 
      end

      it 'displays the existing item' do
        expect(page).to have_selector('.cv_item', count: 1)
      end

      context 'when delete button is clicked' do

        it 'destroys the item' do
          expect { find("#delete_work_item_#{work_item.id}").click }.to change { candidate.work_items.count }.by(-1)
        end

      end
    end
  end

  describe 'education items' do
    
    context 'when user clicks edit link' do

      it 'goes to work_items_path' do
        visit profile_path
        within '#candidate_education' do
          click_link_or_button I18n.t('actions.edit')
          expect(current_path).to eq(education_items_path)
        end
      end

    end
    
  end
end
