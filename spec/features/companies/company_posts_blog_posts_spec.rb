require 'rails_helper'

RSpec.describe "Company posts blog posts" do
  let(:company) { Company.first || FactoryGirl.create(:company) }
  let(:candidate) { Candidate.first || FactoryGirl.create(:candidate) }
  describe "new blog post form on company profile" do

    context "when not signed in" do
      before do
        login_as(candidate, scope: :candidate)
        visit company_path(company)
      end

      it "doesn't show new post form" do
        expect(page).not_to have_selector('.new_blog_post')
      end
    end

    context "when signed in" do
      before do
        login_as(company, scope: :company)
        visit profile_path
      end

      it "shows a new post form" do
        expect(page).to have_selector('.new_blog_post')       
      end

      context "when filled in and submitted" do
        it "creates a new post" do
          within('.new_blog_post__container') do
            find('#blog_post_body').set("Zażółć gęślą jaźń")
            expect { click_button }.to change { company.blog_posts.count }
          end
        end
      end
    end
  end
end
