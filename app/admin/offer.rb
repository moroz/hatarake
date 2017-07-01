ActiveAdmin.register Offer do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :views, :title, :description
#
# or
  #
  scope :all, default: true
  scope :poland
  scope :abroad

  action_item :show, only: :show do
    link_to "View on Website", offer_path(offer), target: '_blank'
  end

  action_item :index, only: :index do
    link_to "View on Website", offers_path, target: '_blank'
  end
#
  index do
    column :title { |o| link_to o.title, admin_offer_path(o) }
    column :company
    column :published_at
    column :views
    actions
  end

  show do |offer|
    attributes_table do
      row :views
      row :published_at
      row :location
      row :company { |o| link_to o.company.name, o.company, target: '_blank' }
      row :description do
        markdown offer.description.truncate(300, separator: /\s/)
      end
    end
  end

  form partial: 'form'

  filter :company
  filter :title
end
