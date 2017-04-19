module WelcomeHelper

  def product_row_tag(product, &block)
    if product.in_stock?
      content_tag :tr, capture(&block), class: 'bg-success'
    else
      if product.arriving_date >= Time.now
        content_tag :tr, capture(&block), class: 'bg-info'
      else
        content_tag :tr, capture(&block), class: 'bg-danger'
      end
    end
  end

end
