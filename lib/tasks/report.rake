# TODO: this whole file is just expirimental stuff need to build some reporting classes and test them

namespace :report do
  desc "csv for a specific deck"
  task :deck, [:name, :count] =>  [:environment] do |t, args|
    name = args[:name] || 'Druid'
    count = args[:count] || 10
    time = 5.days.ago

    moves = Game.find_moves(start_time: time, class: name)
    report = Report.moves(moves)

    report.each do |card|
      puts "#{card[:name]}, #{card[:percent]}"
    end
  end

  desc "csv for specific turns for a specific deck"
  task :turn, [:number] =>  [:environment] do |t, args|
    gs = Game.where("updated_at > ?", 1.day.ago)
    druid_games = gs.select{|g| g.winner_class == 'Druid' || g.loser_class == 'Druid'}

    moves = []
    druid_games.each do |game|
      game_moves = game.moves
      winner_moves = game_moves.select{|m| m.winner}
      loser_moves = game_moves.select{|m| !m.winner}
      moves << winner_moves if game.winner_class == 'Druid'
      moves << loser_moves if game.loser_class == 'Druid'
    end

    ms = moves.flatten

    ms.select!{|m| m.turn == args[:number].to_i}

    cards = ms.group_by{|m| m.card_name}

    cf = cards.map do |card|
      card_name = card.first
      results = card.last
      wins = results.select{|c| c.winner}
      percent =  (wins.count/results.count.to_f * 100).round

      {name: card_name, count: results.count, percent: percent}
    end

    cf.select!{|c| c[:count] > 5}

    cs = cf.sort_by{|c| c[:percent]}.reverse

    cs.each do|card|
      puts "#{card[:name]}, #{card[:percent]}"
    end
  end

end
