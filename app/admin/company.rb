ActiveAdmin.register Company do
  config.per_page = [50, 250, 500]
  permit_params :name, :description, :website, :email, :contact_email, :balance
  menu label: "Companies"
  scope :all
  scope :premium_users

  action_item :show, only: :show do
    link_to "View on Website", company_path(company), target: '_blank'
  end

  action_item :index, only: :index do
    link_to "View on Website", companies_path, target: '_blank'
  end

  sidebar :actions, only: :index, priority: 0 do
    str = link_to "Mailing list", mailing_list_companies_path(format: :xlsx), target: '_blank', class: 'button'
    str += link_to 'Download as XLSX', companies_path(format: 'xlsx'), class: 'button'
    str += link_to 'Wszyscy +10 PLN', increment_all_admin_companies_path, class: 'button', method: :patch
    str
  end

  member_action :activate, method: :patch do
    resource.update(confirmed_at: Time.now) if resource.is_a?(User)
    flash[:success] = 'Account has been activated.'
    redirect_to admin_company_path(id: resource.id)
  end

  member_action :increment_balance, method: :patch do
    resource.increment!(:balance, 10)
    respond_to do |f|
      f.js
    end
  end

  collection_action :increment_all, method: :patch do
    q = %{update users set balance = coalesce(balance, 0) + 10 where type = 'Company'}
    User.connection.execute(q)
    redirect_to admin_companies_path, success: 'Zwiększono stan konta wszystkich firm o 10 PLN.'
  end

  batch_action :email_list do |ids|
    redirect_to mailing_list_companies_path(format: :xlsx, ids: ids.join(',')), target: '_blank', class: 'button'
  end

  index title: "Companies" do
    selectable_column
    column :premium do |company|
      company.premium?
    end
    column :active do |company|
      !!company.confirmed_at
    end
    column :name do |company|
      link_to company.name, admin_company_path(company) 
    end
    column :email do |company|
      [company.email, company.contact_email].compact.join(', ')
    end

    column :phone

    column :balance do |c|
      str = content_tag :span, id: "company_#{c.id}_balance" do
        Prices.formatted_price(c.balance, 'pln') if c.balance
      end
      str += link_to '+10', increment_balance_admin_company_path(id: c.id), method: :patch, class: 'increment-button', remote: true
      raw(str)
    end

    column :published_offers_count
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
      row :phone
      row :name
      row :balance do |company|
        Prices.formatted_price(company.balance || 0, 'pln')
      end
      row :created_at
      row :updated_at
      row :slug
      row :premium do |company|
        company.premium?
      end
      row :premium_until
      row :offers do |company|
        company.offers.count
      end
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
