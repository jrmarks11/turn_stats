# TODO: this whole file is just expirimental stuff need to build some reporting classes and test them

namespace :report do
  desc "csv for a specific deck"
  task :deck, [:name, :count, :turn] =>  [:environment] do |t, args|
    name = args[:name] || 'Druid'
    count = args[:count] || 10
    turn = args[:turn] || '*'
    time = DateTime.parse('2016-12-1')

    moves = Game.find_moves(start_time: time, class: name, turn: turn)
    report = Report.moves(moves)

    report.each do |card|
      puts "#{card[:name]}, #{card[:percent]}"
    end
  end
end
