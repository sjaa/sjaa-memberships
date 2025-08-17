module Resizable
  extend ActiveSupport::Concern
  
  def resize_and_attach(images: [], object: nil)
    images = images.is_a?(Array) ? images : [images]
    images.each do |img|
      next if(img.is_a?(String))
      resized = ImageProcessing::Vips
      .source(img.tempfile)
      .resize_to_limit(800, 800)
      .convert("jpg")
      .call
      
      object&.images&.attach(
      io: File.open(resized.path),
      filename: "#{img.original_filename.split('.')[0...-1].join('.')}.jpg",
      content_type: "image/jpeg"
      )
    end
  end
  
end