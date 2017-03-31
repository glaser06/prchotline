FactoryGirl.define do
  factory :location do
    name "loc"
    website "loc.com"
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    active false
  end

  # factory :locations do
  #   association :store
  #   association :flavor
  # end

end
