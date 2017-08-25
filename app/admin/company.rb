ActiveAdmin.register Company do
  permit_params :name, :description, :website
  menu label: "Companies"

  scope :all
  scope :premium_users

  action_item :show, only: :show do
    link_to "View on Website", company_path(company), target: '_blank'
  end

  action_item :index, only: :index do
    link_to "View on Website", companies_path, target: '_blank'
  end

  index title: "Companies" do
    column :premium do |company|
      company.premium?
    end
    column :name { |company| link_to company.name, admin_company_path(company) }
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
      row :premium_until
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

  form partial: 'form'
end
