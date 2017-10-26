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

  action_item :index, only: :index do
    link_to 'Download as XLSX', candidates_path(format: 'xlsx')
  end

  action_item :mailing_list, only: :index do
    link_to "Mailing list", mailing_list_companies_path, target: '_blank'
  end

  member_action :activate, method: :patch do
    resource.update(confirmed_at: Time.now) if resource.is_a?(User)
    flash[:success] = 'Account has been activated.'
    redirect_to admin_company_path(id: resource.id)
  end

  index title: "Companies" do
    column :premium do |company|
      company.premium?
    end
    column :active do |company|
      !!company.confirmed_at
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
      row :avatar do
        content = if company.avatar.present?
          avatar_for company
        else
          "No avatar<br/>".html_safe
        end
        content + (link_to "Edit avatar", new_admin_avatar_path(id: company.to_param), class: 'button')
      end
      row :active do
        content = I18n.t((!!company.confirmed_at).to_s)
        content += '<br/>' + (link_to 'Activate', activate_admin_company_path(company), method: :patch, class: 'button') unless company.confirmed_at
        raw(content)
      end
      row :email
      row :name
      row :created_at
      row :updated_at
      row :slug
      row :premium { |company| company.premium? }
      row :premium_until
      row :offers { |company| company.offers.count }
      row :description do
        if company.description.present?
          markdown company.description.truncate(300, separator: /\s/)
        end
      end
    end
  end

  filter :name
  filter :contact_email
  filter :email
  filter :phone

  form partial: 'form'
end
