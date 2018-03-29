FactoryBot.define do 
  factory :user do
    name "Lee Mulvey"
    email "Dogs@dog.com"
    bio "I am an artist"
    password "foobary"
    password_confirmation "foobary"
  end
end

FactoryBot.define do
  factory :band do
    name "Hot Sick"
    bio "Wow, what a great band we are"
    profile_image_url "http://www.google.ca"
    genre "Rock"
  end
end

FactoryBot.define do
  factory :band_membership do
    access_level 0
  end
end