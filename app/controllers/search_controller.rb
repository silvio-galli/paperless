class SearchController < ApplicationController
  def index
    if params[:keyword].nil?
      flash[:alert] = "Please, enter something to search for."
      redirect_to customers_path
    else
      @results = Search.for(params[:keyword])
    end
  end
end
