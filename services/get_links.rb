module DataExtraction

  # Get list of path from file
  def self.get_links(path, sample:0)
    line_count = self.get_number_of_lines(path)

    links = Array.new
    File.open(path, 'r') do |f|
      f.each_line.with_index do |line, index|
        links.push(line)
      end
    end

    links = links.sample(sample) if sample != 0
    links
  end

  private

  # Get number of lines
  def self.get_number_of_lines(path)
    `wc -l "#{path}"`.strip.split(' ')[0].to_i
  end

end
