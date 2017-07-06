ActiveAdmin.register Field do
  permit_params :name_en, :name_pl
  index do
    column :id
    column :name_en
    column :name_pl
    actions
  end
end
