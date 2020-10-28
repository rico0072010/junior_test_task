# Users
User.create!(username: 'Example User',
             email: 'example@testuser.org',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true)

24.times do |n|
  username = Faker::Name.name
  email = "example-#{n + 1}@testuser.com"
  password = 'password'
  User.create!(username: username,
               email: email,
               password: password,
               password_confirmation: password)
end

# Tags

tags = %w[Sport Movies CS Coding Books Scripts Algorithms English
          Robots Homestyle Freelance Rails Ruby Js CSS HTML Python Games Cafe Food]

tags.each do |tag|
  Tag.create!(name: tag)
end

# Adverts

users = User.all

i = 1
users.each do |user|
  title = Faker::Lorem.sentence(word_count: 2)
  address = Faker::Address.full_address
  content = Faker::Lorem.sentence(word_count: 50)
  picture = File.open(File.join(Rails.root, "app/assets/images/seed_pics/#{i}.jpg"))
  user.adverts.create!(title: title, address: address, content: content, picture: picture)
  i += 1
end

users = User.order(:created_at).take(10)

users.each do |user|
  title = Faker::Lorem.sentence(word_count: 2)
  address = Faker::Address.full_address
  content = Faker::Lorem.sentence(word_count: 50)
  user.adverts.create!(title: title, address: address, content: content)
end

adverts = Advert.all

adverts.each do |advert|
  advert.update_attribute :created_at, Faker::Date.between(from: 10.days.ago, to: Date.today)
end

# Association between adverts and tags

adverts.each do |advert|
  6.times do
    tag = Tag.find(Tag.pluck(:id).sample)
    advert.tags << tag unless advert.tags.include?(tag)
  end
end

# Comments

30.times do
  adverts.each do |advert|
    comment = Comment.create!(content: Faker::Lorem.sentence(word_count: 6),
                              user_id: User.pluck(:id).sample, advert_id: advert.id)
    advert.comments << comment
  end
end
