module MoviesHelper
  def short_synopsis(synopsis)
    if synopsis.size > 300
      synopsis[0..300] + " ...."
    else
      synopsis
    end
  end
end
