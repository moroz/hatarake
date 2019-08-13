# frozen_string_literal: true

ActiveAdmin.register ImportedOffer do
  permit_params :views, :title, :description, :featured_until, :category_until,
                :highlight_until, :social_until, :special_until
  menu label: 'Offers Importer'

  scope :unpublished, default: true
  scope :published
  # scope :poland
  # scope :abroad
  # scope :social_featured
  # scope :homepage_featured
  # scope :highlighted

  # action_item :show, only: :show do
  #   link_to 'View on Website', offer_path(offer), target: '_blank'
  # end

  batch_action :publish do |ids|
    redirect_to imported_offers_select_company_path(ids: ids.join(',')), class: 'button'
  end

  action_item :index, only: :index do
    str = link_to 'Import new offers', import_new_offers_admin_imported_offers_path
    str
  end

  collection_action :import_new_offers, method: :get do
    ImportedOffer.save_offers
    redirect_to admin_imported_offers_path
  end

  index do
    selectable_column
    column :title do |o|
      link_to o.title, admin_imported_offer_path(o)
    end
    column :company
    column :published_at
    column :external_url
    column :source
    column :field_name
    actions
  end

  form partial: 'form', fields: Field.all

  # show do |offer|
  #   attributes_table do
  #     row :views
  #     row :published_at
  #     row :featured_until
  #     row :category_until
  #     row :highlight_until
  #     row :social_until
  #     row :special_until
  #     row :locations
  #     row :company do |o|
  #       link_to o.company.name, o.company, target: '_blank'
  #     end
  #     row :description do
  #       markdown offer.description.truncate(300, separator: /\s/)
  #     end
  #   end
  # end

  # form partial: 'form'

  filter :source
  filter :title

  # controller do
  #   def scoped_collection
  #     super.includes(:locations, :company)
  #   end
  # end

  before_update do |offer|
    offer.field_name = params['imported_offer']['field_name']
  end
end
