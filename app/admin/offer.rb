ActiveAdmin.register Offer do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :views, :title, :description, :featured_until, :category_until, :highlight_until
  menu label: "Offers"
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

  member_action :increment_views, method: :patch do
    by = params[:by] || 10
    resource.increment!(:views, by)
    respond_to do |f|
      f.js
    end
  end

  index do
    column :title do |o|
      link_to o.title, admin_offer_path(o)
    end
    column :company
    column :published_at
    column :views do |o|
      str = content_tag :span, id: "offer_#{o.id}_views" do
        o.views.to_s
      end
      str += link_to '+10', increment_views_admin_offer_path(id: o.id), method: :patch, class: 'increment-button', remote: true
      raw(str)
    end
    actions
  end

  show do |offer|
    attributes_table do
      row :views
      row :published_at
      row :featured_until
      row :category_until
      row :highlight_until
      row :location
      row :company do |o|
        link_to o.company.name, o.company, target: '_blank'
      end
      row :description do
        markdown offer.description.truncate(300, separator: /\s/)
      end
    end
  end

  form partial: 'form'

  filter :company
  filter :title

  controller do
    def scoped_collection
      super.includes(:location, :company)
    end
  end
end
