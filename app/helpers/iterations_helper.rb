module IterationsHelper
  def destination_options_for_cards_in(iteration)
    if iteration == :backlog
      Iteration.all.map &format
    else
      returning Iteration.all_but(iteration).map &format do |options|
        options.unshift ["Backlog", 0]
      end
    end
  end
  
  def with_iterations
    yield IterationsCache.new(Iteration.all)
  end
  
  class IterationsCache
    def initialize(iterations)
      @iterations = iterations
    end
    def destination_options_for_cards_in(iteration)
      return @iterations.map &format if iteration == :backlog
      returning @iterations.reject{|i| i == iteration}.map &format do |iterations|
        iterations.unshift ["Backlog", 0]
      end
    end
  def format
    lambda {|i| ["Iteration: #{i.start_date.to_s(:iteration_start_date)}", i.id]}
  end
  end
  
private

  def format
    lambda {|i| ["Iteration: #{i.start_date.to_s(:iteration_start_date)}", i.id]}
  end
end
