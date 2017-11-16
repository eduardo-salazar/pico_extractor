module DataExtraction

  # Get list of path from file
  def self.get_links(path)
    line_count = self.get_number_of_lines(path)

    links = Array.new
    File.open(path, 'r') do |f|
      f.each_line.with_index do |line, index|
        links.push(line)
      end
    end
    links
  end

  def self.sample_links(links, sample:0.0)
    if sample.to_f > 0.0
      total_links = links.size
      num_rows = total_links.to_f * sample.to_f
      links = links.sample(num_rows.ceil)
    end
    links
  end

  private

  # Get number of lines
  def self.get_number_of_lines(path)
    `wc -l "#{path}"`.strip.split(' ')[0].to_i
  end

end
