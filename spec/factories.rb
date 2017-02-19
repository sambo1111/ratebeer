FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score 10
  end

  factory :rating_with_beer, class: Rating do
    score 15
    beer
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :beer do
    name "anynomous"
    brewery
    style
  end

  factory :style do
    name "Lager"
    description "Best style"
  end
end
