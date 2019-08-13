class ImportedOffer < ApplicationRecord
  scope :unpublished, -> { where(published: false) }
  scope :published, -> { where(published: true) }

  def publish
    update(published: true)
  end

  def self.save_offers
    existing_ids = ImportedOffer.pluck(:external_id)

    offers = SilverhandService.import
    offers.each do |offer|
      ImportedOffer.new(offer).save unless existing_ids.include?(offer[:external_id])
    end
  end

  def self.prepare_to_publish(offers, **options)
    countries = Country.pluck(:id, :iso).map { |id, name| { id: id, iso: name } }
    delete_keys = %i[id location external_url source published]

    hashed_offers = offers.dup.map do |offer|
      offer = offer.as_json.deep_symbolize_keys
      offer.merge!(options)

      if (country = countries.find { |c| c[:iso] == offer[:location].split('|').first.upcase })
        offer[:locations] = [{
          country_id: country[:id],
          city: offer[:location].split('|').second
        }]
      end

      field_name = offer.delete(:field_name) || 'No experience required'
      offer[:field_id] = Field.find_by(name_en: field_name).id

      offer[:published_at] = DateTime.now

      offer.slice!(*delete_keys)
    end

    hashed_offers
  end
end
