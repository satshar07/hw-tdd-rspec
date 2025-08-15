class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.with_same_director(movie_or_id)
    movie = movie_or_id.is_a?(Movie) ? movie_or_id : find(movie_or_id)
    return [] if movie.director.blank?
    where(director: movie.director)
  end
end
