class SilverhandService < OfferImporter

  def self.root_url
    'https://silverhand.eu/jooble.php'
  end

  def self.import
    response = super[:source]

    response[:job].map do |job|
      job = map_schema(job)

      locations = job.delete(:locations)
      job[:location] = [locations[:country], locations[:city]].join('|')

      job[:currency] = extract_currency(job[:salary])

      map_salaries(job)

      job[:source] = response[:publisher]

      job
    end
  end

  def self.schema
    [
      { internal: :external_id, external: :id },
      { internal: :published_at, external: :date },
      { internal: :title, external: :title },
      { internal: [:locations, :city], external: :location },
      { internal: [:locations, :country], external: :country },
      { internal: :external_url, external: :url },
      { internal: :description, external: :description },
      { internal: :salary, external: :salary },
      { internal: :source, external: :publisher }
    ]
  end

  private

  def self.extract_currency(salary)
    currency = %w[EUR PLN USD GPB euro].flat_map { |currency| salary.scan(currency) }.compact.first
    currency = 'eur' if currency == 'euro'
    currency.downcase
  end

  def self.map_salaries(job)
    salary = job.delete(:salary)

    salary_range = make_salary_range(salary)
    if salary.ends_with?('miesiąc')
      job[:salary] = stringify_salary_range(salary_range)
    elsif salary.ends_with?('tydzień')
      job[:salary] = stringify_salary_range(salary_range.map { |s| s.is_a?(Float) ? s * 4 : s })
    elsif salary.ends_with?('godzinę')
      job[:hourly_wage] = stringify_salary_range(salary_range)
    end
  end

  def self.make_salary_range(salary)
    salary = salary.gsub(',', '.').split('-', 2).map(&:to_f)

    salary.insert(0, nil) if salary.size == 1

    salary.sort! if salary[0].is_a?(Float) && salary[1].is_a?(Float)

    salary
  end

  def self.stringify_salary_range(range)
    range.to_s.gsub(' ', '')
  end

end
