FactoryBot.define do
  factory :user do
    username { "Pekka" }
    password { "Foobar1" }
    password_confirmation { "Foobar1" }
  end

  factory :style do
    beer_type { "Lager" }
    description { "Lager is beer." }
  end

  factory :brewery do
    name { "anonymous" }
    year { 1900 }
    active { true }
  end

  factory :beer do
    name { "anonymous" }
    style
    brewery
  end

  factory :rating do
    score { 10 }
    beer
    user
  end
end