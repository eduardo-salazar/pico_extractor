# Pico Extractor
This project is a parser to get the predictors

# Goal
Predict First Purchase Probability

# How to run
1. Copy file `.config.yml.example` to `.config.yml.example`
2. Open .config.yml and set all the variables in the file (Follow indications in file)
3. run `bundle install`

# PreDownload Files [Optional]
If you wan to parse locally the you can first download all links into a folder. 
You can download manually or run ` ruby download.rb ` . Make sure you set env variables cardinalblue_ios_file
and export_directory and set variable links_sample to `1` if you want to download all links or you can set `0.5`
to sample randomly 50% of the total links.

# Save to CSV
run `ruby main.rb` to parse links and save into 3 files. This will create 3 files:
    user_info : contains information about user
    events_info: every row is a event in the session
    summary_info: summary of how many links were processed

# Save to MySql
If you want to dump to Mysql make sure env variable mysql_path is set in `config.yml` and also that mysql server
is running 
run `ruby main_to_mysql.rb`

Note: If you need to save database in a external drive please do this before running script:

1.Stop MySQL (service mysql stop)

Make a dir in the HDD (mkdir /mysqldata)

2.Move your data files to HDD (cp -rp /var/lib/mysql/* /mysqldata)

3.Search datadir in my.cnf (cat /etc/mysql/my.cnf | grep datadir )

4.Change path accordinly (datadir = /var/lib/mysql To: datadir = /mysqldata )

5.Start MySQL (service mysql start)
