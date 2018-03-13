class Search
  def self.for(keyword, model)
    keyword_search = "%#{keyword.downcase}%"
    if model == Customer
      model.where("lower(last_name) LIKE ?", keyword_search) +
      model.where("lower(email) LIKE ?", keyword_search) +
      model.where("phone LIKE ?", keyword_search)
    elsif model == Product
      model.where("lower(description) LIKE ?", keyword_search)
    end
  end
end
