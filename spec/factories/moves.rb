FactoryGirl.define do
  factory :move_one, class: Move do
    winner true
    turn 3
    card_name 'Tomb Pillager'
  end
end
