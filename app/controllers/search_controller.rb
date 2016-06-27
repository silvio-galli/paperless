class SearchController < ApplicationController
  def index
    if params[:keyword].nil?
      flash[:alert] = "Please, enter something to search for."
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
