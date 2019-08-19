# frozen_string_literal: true

ActiveAdmin.register ImportedOffer do
  permit_params :views, :title, :description, :featured_until, :category_until,
                :highlight_until, :social_until, :special_until
  menu label: 'Offers Importer'

  scope :unpublished, default: true
  scope :published

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

  filter :source
  filter :title

  before_update do |offer|
    offer.field_name = params['imported_offer']['field_name']
  end
end
