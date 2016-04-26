FactoryGirl.define do
  factory :applicant do
    name do
      [
        FFaker::NameRU.first_name,
        FFaker::NameRU.last_name,
        FFaker::NameRU.patronymic
      ].join(' ')
    end

    contact do
      FFaker::Internet.email
    end

    active { true }

    expected_salary { rand(100_000..200_000) }

    skills { build_list :skill, 1 }
  end
end
