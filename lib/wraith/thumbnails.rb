require 'wraith'

class Wraith::Thumbnails
  attr_reader :wraith

  def initialize(config)
    @wraith = Wraith::Wraith.new(config)
  end

  def generate_thumbnails
    Dir.glob("#{wraith.directory}/*/*.png").each do |filename|
      new_name = filename.gsub(/^#{wraith.directory}/, "#{wraith.directory}/thumbnails")
      puts "Generating thumbnail #{new_name}"
      unless Dir.directory?(File.dirname(new_name))
        Dir.mkdir(File.dirname(new_name))
      end
      wraith.thumbnail_image(filename, new_name)
    end
    puts 'Generating thumbnails'
  end
end

