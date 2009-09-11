module IterationsHelper
  def destination_options_for_cards_in(iteration)
    returning Iteration.all_but(iteration).map {|i| ["Iteration: #{i.start_date.to_s(:iteration_start_date)}", i.id]} do |options|
      options.unshift ["Backlog", 0] unless iteration == :backlog
    end
  end
end
