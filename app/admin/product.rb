# frozen_string_literal: true

ActiveAdmin.register Product do
  permit_params %I[price_pln price_eur description_en description_pl name_pl name_en order]
end
