

 tags = [
   "art",
   "books",
   "literature",
   "culture",
   "cars",
   "nightlife",
   "dancing",
   "fashion",
   "food",
   "drinks",
   "games",
   "film",
   "music",
   "pop music",
   "house music",
   "rock music",
   "r&b",
   "hip hop",
   "outdoors",
   "adventure",
   "crafts",
   "hobbies",
   "paranormal",
   "family",
   "animals",
   "photography",
   "sports",
   "recreation",
   "tech",
   "comedy",
   "travel",
   "health",
   "science",
   "lifestyle",
   "community",
   "candy"
    ]

   tags.each do |tag|
     Tag.create(name: tag)
   end
