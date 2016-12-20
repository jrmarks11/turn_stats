namespace :report do
  desc "report for a specific deck"
  task :deck, [:name, :count, :turn] =>  [:environment] do |t, args|

    name = args[:name] || 'Druid'
    count = args[:count] || 10
    turn = args[:turn] || '*'
    time = DateTime.parse('2016-12-1') #start of the msog meta

    puts "Report for class #{name} at least #{count} games."
    puts "turn #{turn} time #{time.to_s}"

    moves = Game.find_moves(start_time: time, class: name, turn: turn)
    report = Report.moves(moves, count: count)

    report.each do |card|
      puts "#{card[:name]}, #{card[:percent]}"
    end
  end
end
