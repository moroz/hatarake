require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  let(:company) { FactoryBot.create(:company) }
  describe "validations" do
    describe "uniqueness validation in user scope" do
      let!(:post1) { FactoryBot.create(:blog_post, company: company, body: "Zażółć gęślą jaźń.") }
      let(:new_post) { FactoryBot.build(:blog_post, company: company) }

      context "when new post has identical body" do
        it "is invalid" do
          new_post.body = "Zażółć gęślą jaźń."
          expect(new_post).not_to be_valid
        end
      end

      context "when new post has identical body but with trailing newlines" do
        it "is invalid" do
          new_post.body = "Zażółć gęślą jaźń.\n\n\n"
          expect(new_post).not_to be_valid
        end
      end
    end
  end
end
