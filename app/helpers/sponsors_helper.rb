module SponsorsHelper
  def generate_sponsor_image(image)
    image_tag(image, :class => "sponsor-image")
  end
end
