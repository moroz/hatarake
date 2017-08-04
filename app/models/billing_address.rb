class BillingAddress < ApplicationRecord
  belongs_to :order, required: true
  validates_presence_of :first_name, :last_name, :street, :house_no, :nip
  validate :check_nip_validity

  private

  def check_nip_validity
    return if nip.nil?
    # we make a local copy to avoid modifying the actual number
    copy = nip.dup
    copy.gsub!(/\-/, '')
    if copy.length != 10
      errors.add(:nip, "is not a valid NIP")
    end
    copy.each_char do |char|
      unless ('0'..'9').include?(char)
        errors.add(:nip, "is not a valid NIP")
      end
    end
    sum = 6 * copy[0].to_i +
      5 * copy[1].to_i + 7 * copy[2].to_i +
      2 * copy[3].to_i + 3 * copy[4].to_i +
      4 * copy[5].to_i + 5 * copy[6].to_i +
      6 * copy[7].to_i + 7 * copy[8].to_i
    sum = sum % 11
    if copy[9].to_i != sum
      errors.add(:nip, "is not a valid NIP")
    end
    true
  end
end
