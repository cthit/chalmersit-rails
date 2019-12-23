module SponsorsHelper
  def generate_sponsor_image(image)
    image_tag(image.url, :class => "sponsor-image")
  end
end
