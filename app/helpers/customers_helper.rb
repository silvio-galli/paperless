module CustomersHelper
  def full_address(address, postcode, city, country)
    full_address = ""
    if address != ""
      full_address << "#{address} -"
    end
    if postcode != ""
      full_address << " #{postcode}"
    end
    if city != ""
      full_address << " #{city.capitalize}"
    end
    if country != ""
      full_address << " (#{country.capitalize})"
    end
  end
end
