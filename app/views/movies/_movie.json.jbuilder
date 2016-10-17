json.extract! movie, :id, :title, :hotness, :image_url, :synopsis, :rating, :genre, :director, :release_date, :runtime, :user_id, :created_at, :updated_at
json.url movie_url(movie, format: :json)