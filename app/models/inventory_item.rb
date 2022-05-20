class InventoryItem < ApplicationRecord
  # validates :cost, :format => { :with => /^\d+(\.\d{2})?$/, :allow_blank => false }

  validate :location


  def location
    if country_code_of_origin 
      current_country = ISO3166::Country.find_country_by_alpha2(country_code_of_origin)
      if current_country
        #valid regions would be something Like "Europe" or "Americas" or "Africa"  etc.
        puts 'HERE'
        errors.add(:region, "incorrect region for country #{current_country.name}.") unless current_country.region == region
        #this will work for short codes like "CA" or "01" etc.
        #for named states use current_country.states.map{ |k,v| v["name"}.include?(state)
        #which would work for "California" Or "Lusaka"(it's in Zambia learn something new every day)
        errors.add(:state, "incorrect state for country #{current_country.name}.") unless current_country.states.keys.include?(state)
      else
        puts 'HERE1'
        errors.add(:country, "must be a 2 character country representation (ISO 3166-1).")
      end
    end
  end
end
