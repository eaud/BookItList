# This file should contain all the record creation needed to seed the database with its default values.
 # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
 #
 # Examples:
 #
 #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
 #   Mayor.create(name: 'Emanuel', city: cities.first)
 # 10.times do
 #   Tag.create(name: Faker::Commerce.department(1))
 # end

 alltags = Tag.all

 # 20.times do
 #   user = User.create(token: "FdsafasdfasdfsdfasdF4432432423432432fasdfa", uid: Faker::Number.number(17), name: Faker::Name.name, email: Faker::Internet.email, bio: Faker::Hipster.paragraph, image_url: "josh", token_expiration: Time.now)
 #   user.update(image_url: Faker::Avatar.image("#{user.name}"))
 #   user.tags << alltags.sample(3)
 # end

 tags = ["arts & culture", "books & literature", "cars & motorcycles", "city life", "dancing", "fashion & beauty", "food & drink", "games", "movies & film", "music", "outdoors", "adventure", "hobbies & crafts", "paranormal", "family", "pets & animals", "photography", "sports & recreation", "tech"]

 allusers = User.all
 i = 1
 50.times do
   activity = Activity.create(host: User.find(i), name: Faker::Hipster.sentence(5), datetime: Faker::Time.forward(30), cost: Faker::Number.decimal(2), guest_min: 1, guest_max: Faker::Number.between(1, 4), details: Faker::Hipster.sentences(3), image_url: Faker::Placeholdit.image)
   activity.tags << alltags.sample(2)
   i < 20 ? i += 1 : i = 1
 end
# 
# tags.each do |tag|
#   Tag.create(name: tag)
# end
