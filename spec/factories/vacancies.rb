FactoryGirl.define do
  factory :vacancy do
    name { FFaker::Company.name }
    salary { rand(100_000..150_000) }
    validity_days { rand(7..30) }
    contacts { "#{FFaker::PhoneNumber.phone_number}, #{FFaker::Internet.email}" }

    skills { build_list :skill, 1 }
  end
end
