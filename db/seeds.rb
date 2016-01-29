

tags = ["arts & culture", "books & literature", "cars & motorcycles", "city life", "dancing", "fashion & beauty", "food & drink", "games", "movies & film", "music", "outdoors", "adventure", "hobbies & crafts", "paranormal", "family", "pets & animals", "photography", "sports & recreation", "tech"]

tags.each do |tag|
  Tag.create(name: tag)
end
