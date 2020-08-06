require 'faker'

# Purge the city table before create 10 cities to fill it
City.destroy_all
10.times do
  City.create(
    name: Faker::TvShows::GameOfThrones.city,
    zip_code: Faker::Address.zip_code
  )
end

# Get the ids of the extremities of the city table
first_city_id = City.first.id
last_city_id = City.last.id

# Purge the user table before create 10 users to fill it
User.destroy_all
10.times do
  User.create(
    first_name: Faker::Superhero.prefix,
    last_name: Faker::Games::Pokemon.name,
    description: Faker::TvShows::HowIMetYourMother.quote,
    email: Faker::Internet.unique.email,
    age: rand(18..125),
    city: City.all.sample, #City.find(rand(first_city_id..last_city_id)),
    password: "password"
  )
end

# Get the ids of the extremities of the user table
first_user_id = User.first.id
last_user_id = User.last.id

# Purge the gossip table before create 20 gossips to fill it
Gossip.destroy_all
20.times do
  Gossip.create(
    title: Faker::Book.title,
    content: Faker::Movie.quote + ". " + Faker::Movies::HarryPotter.quote,
    user: User.find(rand(first_user_id..last_user_id))
  )
end

# Get the ids of the extremities of the gossip table
first_gossip_id = Gossip.first.id
last_gossip_id = Gossip.last.id

# Purge the tag table before create 10 tags to fill it
Tag.destroy_all
10.times do
  Tag.create(title: "#" + Faker::Cannabis.unique.buzzword.gsub(/ /, "_"))
end

# Get the ids of the extremities of the gossip table
first_tag_id = Tag.first.id
last_tag_id = Tag.last.id

# Purge the table linking tags and gossips.
# Link a tag to each gossip then create a random number of links between tags
# and gossips
TagGossipLink.destroy_all
Gossip.all.each do |gossip|
  TagGossipLink.create(gossip: gossip, tag: Tag.find(rand(first_tag_id..last_tag_id)))
end

rand(0..20).times do
  TagGossipLink.create(
    gossip: Gossip.find(rand(first_gossip_id..last_gossip_id)),
    tag: Tag.find(rand(first_tag_id..last_tag_id))
  )
end

# Purge the tables about the private messages. Then create a random number of
# pm, which one with a random number of unique recipients.
PrivateMessage.destroy_all
RecipientToPmLink.destroy_all
rand(20..40).times do
  pm = PrivateMessage.create(
    sender: User.find(rand(first_user_id..last_user_id)),
    content: "\"#{Faker::Games::WorldOfWarcraft.quote}\" dixit #{Faker::Games::WorldOfWarcraft.hero}\n\"#{Faker::Games::Fallout.quote}\" answered #{Faker::Games::Fallout.character}"
  )
  recipients = Array.new

  rand(1..10).times do
    while true
      recipient = User.find(rand(first_user_id..last_user_id))
      break unless recipients.include?(recipient)
    end
    recipients << recipient
    RecipientToPmLink.create(
      received_message: pm,
      recipient: recipient
    )
  end
end
