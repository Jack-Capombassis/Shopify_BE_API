class InventoryItem < ApplicationRecord
  validate :location_country_and_province
  validate :validate_sku
  validate :validate_cost

  def location_country_and_province
    if country_code_of_origin 
      current_country = ISO3166::Country.find_country_by_alpha2(country_code_of_origin)
      if !current_country.present?
        errors.add(:country_code_of_origin, "must be a 2 character country representation (ISO 3166-1).")
      end
    end

    province_codes_array = ["AB", "BC", "MB", "NB", "NL", "NS", "NT", "NU", "ON", "PE", "QC", "SK", "YT"]
    if province_code_of_origin.present? && !(province_codes_array.include?(province_code_of_origin))
      errors.add(:province_code_of_origin, "must be Canadian province (ISO 3166-2).")
    end
  end

  def validate_sku
    if sku.nil?
      errors.add(:sku, "is a required field")
    elsif sku.empty?
      errors.add(:sku, "can't be empty")
    end
  end

  def validate_cost
    if cost.nil?
      errors.add(:cost, "is a required field")
    elsif cost.empty?
      errors.add(:cost, "can't be empty")
    elsif !(cost =~ /\A\d+(?:\.\d{0,2})?\z/)
      errors.add(:cost, "must be a valid format")
    end
  end
end
