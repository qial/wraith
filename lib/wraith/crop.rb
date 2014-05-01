require 'wraith'
require 'image_size'

class Wraith::CropImages
  attr_reader :wraith

  def initialize(config)
    @wraith = Wraith::Wraith.new(config)
  end

  def crop
    crop_value(base_height, compare_height, @compare, @base)
  end

  def height
    crop_value(base_height, compare_height, base_height, compare_height)
  end

  def base_height
    find_heights(@base)
  end

  def compare_height
    find_heights(@compare)
  end

  def crop_images
    files = Dir.glob("#{wraith.directory}/*/*.png").sort
    until files.empty?
      @base, @compare = files.slice!(0, 2)
      puts "cropping images #{@base} #{@compare}"
      unless @base.nil? || @compare.nil?
          Wraith::Wraith.crop_images(crop, height)
      end
    end
  end

  def crop_value(base_height, compare_height, arg3, arg4)
    if base_height > compare_height
      arg3
    else
      arg4
    end
  end

  def find_heights(height)
    unless height.nil?
      File.open(height, 'rb') do |fh|
        isize = ImageSize.new(fh.read)
        unless isize.nil?
          size = isize.size
          height = size[1]
        else
          height = 0
        end
      end
    else
      height = 0
    end
  end
end

