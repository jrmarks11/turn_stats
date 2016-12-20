class Report
  def self.moves(moves, opts={})
    count = opts[:count] || 10
    cards = moves.group_by{|m| m.card_name}

    cards = cards.map do |card|
      card_name = card.first
      results = card.last
      wins = results.select{|c| c.winner}
      percent =  (wins.count/results.count.to_f * 100).round
      {name: card_name, count: results.count, percent: percent}
    end

    cards = cards.select!{|c| c[:count] > count.to_i}

    cards = cards.sort_by{|c| c[:percent]}.reverse
  end
end