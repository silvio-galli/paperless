module ApplicationHelper

  def get_user_for_paper_trail(whodunnit)
    whodunnit != nil ? User.find(whodunnit).name : "system"
  end

  def get_product_for_paper_trail(id)
    Product.find(id)
  end
end
