class ImportProductsFromCsvJob < ActiveJob::Base
  queue_as :default

  def perform(file, user)
    Product.import(file, user)
  end

end
