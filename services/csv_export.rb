require 'json'
require "csv"
module DataExtraction

  def self.csv_create(path,cols)

    CSV.open(path, "wb") do |csv|
      csv << cols
    end

  end

  def self.csv_add_line(path,values)
    CSV.open(path, "a+") do |csv|
      csv << values
    end
  end
end
