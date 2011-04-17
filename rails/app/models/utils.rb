module Utils
  def normalize_text(string)
    string = string.strip
    string.split(/\s+/).each{|word| word.capitalize!}.join(" ")
  end
end