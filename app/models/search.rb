class Search
  def self.for(keyword)
    keyword_search = "%#{keyword.downcase}%"
    Customer.where("lower(last_name) LIKE ?", keyword_search) +
    Customer.where("lower(email) LIKE ?", keyword_search) +
    Customer.where("phone LIKE ?", keyword_search)
  end
end
