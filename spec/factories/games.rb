FactoryGirl.define do
  factory :game_one, class: Game do
    trackobot_id 49923902
    winner_class 'Paladin'
    winner_deck "N'Zoth"
    loser_class 'Paladin'
    loser_deck nil
    time DateTime.strptime("2016-11-16T20:18:01.000Z", "%Y-%m-%dT%H")
  end

  factory :game_two, class: Game do
    trackobot_id 3
    winner_class 'Warlock'
    loser_class 'Mage'
    time DateTime.now

    after(:create) do |game|
      create(:move, game: game)
      create(:turn_two, game: game)
      create(:move, game: game)
    end
  end
  

  factory :old_game, class: Game do
    winner_class 'Paladin'
    loser_class 'Hunter'
    time DateTime.strptime("2013-11-16T20:18:01.000Z", "%Y-%m-%dT%H")
    after(:create) do |game|
      create(:move, game: game)
    end
  end

  factory :new_game, class: Game do
    winner_class 'Warlock'
    loser_class 'Hunter'
    time DateTime.now
    after(:create) do |game|
      create(:move, game: game)
    end
  end

  factory :sixtey_seven, class: Game do
    after(:create) do |game|
      create(:win_axe, game: game)
      create(:win_axe, game: game)
      create(:lose_axe, game: game)
    end
  end

  factory :twenty_five, class: Game do
    after(:create) do |game|
      create(:win_axe, game: game)
      create(:lose_axe, game: game)
      create(:lose_axe, game: game)
      create(:lose_axe, game: game)
    end
  end

  factory :two_moves_game, class: Game do
    after(:create) do |game|
      create(:win_axe, game: game)
      create(:lose_axe, game: game)
      create(:win_ghoul, game: game)
    end
  end

  factory :winner_move, class: Game do
    winner_class 'Druid'
    loser_class 'Warrior'
    after(:create) do |game|
      create(:lose_axe, game: game)
      create(:win_ghoul, game: game)
    end
  end
end
