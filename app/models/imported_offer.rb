class ImportedOffer < ApplicationRecord
  scope :unpublished, -> { where(published: false) }
  scope :published, -> { where(published: true) }

  def publish
    update(published: true)
  end

  def self.save_offers(offers = nil)
    existing_ids = ImportedOffer.pluck(:external_id)

    offers ||= SilverhandService.import
    offers.each do |offer|
      ImportedOffer.new(offer).save unless existing_ids.include?(offer[:external_id])
    end
  end

  def self.prepare_to_publish(offers, **options)
    countries = Country.pluck(:id, :iso).map { |id, name| { id: id, iso: name } }
    delete_keys = %i[id location external_url source published field_name]

    hashed_offers = offers.dup.map do |offer|
      offer = offer.as_json.deep_symbolize_keys
      offer.merge!(options)

      offer[:locations] = split_and_transform_location_info(offer[:location], countries)

      offer[:field_id] = find_field_name(offer[:field_name])

      offer[:published_at] = DateTime.now

      offer.slice!(*delete_keys)
    end

    hashed_offers
  end

  private

  def self.split_and_transform_location_info(location, countries)
    return [] unless location

    country, city = location.split('|', 2)
    country_id = countries.find { |c| c[:iso] == country.upcase }

    return [] unless country_id

    [{
      country_id: country[:id],
      city: offer[:location].split('|').second
    }]
  end

  def self.find_field_name(field_name)
    field_name ||= 'No experience required'
    Field.find_by(name_en: field_name).id
  end

end
