FactoryGirl.define do
  factory :move do
    winner true
    turn 1
    card_name 'Something'
  end

  factory :turn_two, class: Move do
    winner false
    turn 2
    card_name 'ARRRRG'
  end

  factory :move_one, class: Move do
    winner true
    turn 3
    card_name 'Tomb Pillager'
  end

  factory :win_axe, class: Move do
    winner true
    turn 2
    card_name 'Axe'
  end

  factory :lose_axe, class: Move do
    winner false
    turn 2
    card_name 'Axe'
  end

  factory :win_axe_3, class: Move do
    winner true
    turn 3
    card_name 'Axe'
  end

  factory :win_ghoul, class: Move do
    winner true
    turn 3
    card_name 'Ghoul'
  end
end
