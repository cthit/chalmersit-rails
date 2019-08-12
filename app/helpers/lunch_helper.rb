Paint::SHORTCUTS[:terminal] = {
  :rest_title => Paint.color(:green, :bold),
  :meal_title => Paint.color(:blue, :italic),
  :meal_desc => Paint.color(:reset),
  :frame => Paint.color(:cyan),
}
include Paint::Terminal::String
module LunchHelper
  def format_rest(rest, lang)
    title = rest["name"].rest_title
    top = frame_w("┏━", "┓", rest["name"].length)
    side =        "┃".frame
    bot = frame_w("┗┳", "┛", rest["name"].length)

    restaurant = "#{top}#{side} #{title} #{side}\n#{bot}"
    @meals = rest["meals"][lang]
    @meals.each do |meal|
      restaurant << format_meal(meal, meal == @meals.last) + "\n"
    end
    restaurant
  end

  def format_meal(meal, last)
    prefix = " ┃  ".frame
    meal_s = " ┣━ ".frame
    if last
      prefix = "    ".frame
      meal_s = " ┗━ ".frame
    end
    meal_len = 0
    if meal["title"].present?
      meal_s << meal["title"].meal_title + ":".frame
      meal_len += 2
    end
    summary = ""

    desired_chunk_length = 76 - meal_len

    @chunks = meal["summary"].scan(/\S.{1,#{desired_chunk_length}}(?!\S)/)
    @chunks.each do |chunk|
      if meal["title"].present?
        summary << "\n" if chunk == @chunks.first
        summary << prefix
      else
        summary << prefix unless chunk == @chunks.first
      end
      summary << " " * meal_len + chunk.meal_desc
      unless chunk == @chunks.last
        summary << "\n"
      end
    end
    meal_s << summary
    meal_s
  end

  def frame_w(left, right, width)
    (left + "━" * (width + 1) + right +"\n").frame
  end

  def format_allergens(allergens)
    if allergens.nil? || allergens.empty?
      " - N/A"
    else
      " - " + translate_allergens(allergens) unless allergens.empty?
    end
  end

  def translate_meal_title(meal_title)
    I18n.t "food.#{meal_title}", default: meal_title
  end

  def translate_allergens(allergens)
    allergens.map{ |text| I18n.t "allergens.#{text}", default: text }.join(", ")
  end
end
