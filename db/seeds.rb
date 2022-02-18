# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
require "json"

p 'cleaning seed'
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

url = "http://tmdb.lewagon.com/movie/top_rated"

puts "adding movies"

20.times do
  read_url = URI.open(url).read
  movies = JSON.parse(read_url)["results"]
  movies.each do |movie|
    poster_url = "https://image.tmdb.org/t/p/w500/"
    Movie.create(
      title: movie["title"],
      poster_url: "#{poster_url}#{movie["poster_path"]}",
      overview: movie["overview"],
      rating: movie["vote_average"].to_i
    )
  end
end

puts "movies added"
