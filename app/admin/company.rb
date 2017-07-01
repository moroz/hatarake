ActiveAdmin.register Company do
  permit_params :name, :description, :website

  scope :all
  scope :premium_users

  index do
    column :premium do |company|
      company.premium?
    end
    column :name
    column :email
    column :contact_email
    column :phone
    column :offer_count { |company| company.offers.count }
    actions
  end

  show do |company|
    attributes_table do
      row :email
      row :name
      row :created_at
      row :updated_at
      row :slug
      row :premium { |company| company.premium? }
      row :premium_until { |company| company.subscriptions_valid_until }
      row :offers { |company| company.offers.count }
      row :description do
        markdown company.description.truncate(300, separator: /\s/)
      end
    end
  end

  filter :name
  filter :contact_email
  filter :email
  filter :phone
end
