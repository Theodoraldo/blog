# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Clear existing data
Comment.delete_all
Like.delete_all
Post.delete_all
User.delete_all

# Users
user_0 = User.create!(
  name: "Theodoraldo Gishun",
  photo: "http://via.placeholder.com/250x250",
  bio: "This is User 1's bio. A developer from Poland, specialize in rails."
)
user_1 = User.create!(
  name: "Franklin Osei",
  photo: "http://via.placeholder.com/250x250",
  bio: "This is User 2's bio. A developer from Ghana, specialize in react."
)

user_2 = User.create!(
  name: "Douglas Agyemang",
  photo: "http://via.placeholder.com/250x250",
  bio: "This is User 2's bio. A developer from Ghana, specialize in react."
)

# Posts
post_1 = Post.create!(
  title: "Arrival and First Impressions",
  text: "As my plane touched down at Kansai International Airport, I could hardly contain my excitement. 
        Kyoto was everything I had imagined and more. The city greeted me with a warm embrace of cherry 
        blossoms in full bloom, their delicate petals drifting gently through the air. After checking into 
        my cozy ryokan, I ventured out to explore the historic Gion district. The narrow cobblestone streets 
        and traditional wooden machiya houses left me in awe, and I couldn't resist indulging in some delectable 
        matcha treats at a local teahouse.",
  author: user_0
)
post_2 = Post.create!(
  title: "Temples, Tea, and Tranquility",
  text: "The second day was dedicated to immersing myself in Kyoto's spiritual side. I began with a visit to the 
        iconic Kinkaku-ji, the Golden Pavilion, a Zen Buddhist temple covered in shimmering gold leaf. The reflections 
        of the temple on the still waters of the surrounding pond were a sight to behold. Later, I participated in a 
        traditional tea ceremony, sipping matcha tea in a serene tatami room. The calmness and precision of the 
        ceremony left me feeling deeply connected to Japanese culture.",
  author: user_1
)

# Comments by created users
Comment.create!(
  text: "Wow, your post brought back so many memories of my own trip to Kyoto! It truly is a magical place. 
        I'm glad you had such a wonderful experience, and your descriptions are so vivid. I miss the cherry 
        blossoms already!",
  author: user_1,
  post: post_1
)
Comment.create!(
  text: "Your experience with the traditional tea ceremony sounds so authentic and enlightening. 
        It's these cultural moments that make travel so enriching. I hope to have a similar experience when 
        I visit Kyoto someday.",
  author: user_2,
  post: post_2
)

# Likes by created users
Like.create!(
  author: user_1,
  post: post_1
)
Like.create!(
  author: user_2,
  post: post_2
)