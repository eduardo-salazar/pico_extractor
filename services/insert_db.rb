require 'json'
require "csv"
require 'mysql2'
module DataExtraction

  class DbClient 
    def initialize(host,username,password)
      # Connect to MySQL
      @client = Mysql2::Client.new(:host => host, :username => username, :password => password)
    end 
   
    # insert into table
    def insert_into(table,values)

    end

    # This will clean all data from tables
    def clear_table(table_name)
    
    end

    # Run query
    def run_query(query_name)
      File.foreach("queries/#{query_name}.sql", ';') do |li|
        @client.query(li.strip) unless li.strip.empty?
      end
    end
  end
end