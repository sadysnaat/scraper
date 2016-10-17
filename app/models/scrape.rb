class Scrape
  attr_accessor :title, :hotness, :image_url, :rating, 
                :director, :genre, :release_date, :runtime, :synopsis, :failure

  def scrape_new_movie(url)
    begin
      doc = Nokogiri::HTML(open(url))
      self.title = doc.css("#movie-title").children[0].text.strip
      self.hotness = doc.css("#all-critics-numbers  span.meter-value").text.to_i
      self.image_url = doc.css("#poster_link > img").attribute("src").value
      self.rating = doc.css('div.info > div:nth-child(2)').text
      self.director = doc.at('div.info > div:contains("Directed By:")').next_sibling.next_sibling.css("a").text.strip
      self.genre = doc.at('div.info > div:contains("Genre")').next_sibling.next_sibling.css("span").map {|spanaa| spanaa.text}.join(", ")
      self.release_date = doc.at('div.info > div:contains("In Theaters")').next_sibling.next_sibling.css("time").text
      self.runtime = doc.at('div.info > div:contains("Runtime")').next_sibling.next_sibling.text.strip
      self.synopsis = doc.css("#movieSynopsis").text
      s = doc.css("#movieSynopsis").text
      if ! s.valid_encoding?
        s = s.encode("UTF-16be", invalid: :replace, replace: '?').encode("UTF-8")      
      end
      self.synopsis = s
      return true
    rescue Exception => e
      puts e
      self.failure = "Something went wrong while scraping"
    end 
      
  end
end
