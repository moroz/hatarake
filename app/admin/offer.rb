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
#
  index do
    column :title { |o| link_to o.title, o, target: '_blank' }
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
