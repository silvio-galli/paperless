class SearchController < ApplicationController
  def index
    if params[:keyword] == ""
      flash[:alert] = t('search.index.flash.alert')
      redirect_to request.referer
    else
      if request.env["HTTP_REFERER"].include? "customer"
        @results = Search.for(params[:keyword], Customer)
      elsif request.env["HTTP_REFERER"].include? "product"
        @results = Search.for(params[:keyword], Product)
      end
    end
  end
end
