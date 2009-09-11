module IterationsHelper
  def with_iterations
    yield IterationCache.new(Iteration.all)
  end
  
  class IterationCache
    include Enumerable
    
    def initialize(iterations = [])
      @iterations = iterations
    end
    
    def each(&block)
      @iterations.each(&block)
    end
    
    def destination_options_for_cards_in(iteration)
      if iteration == :backlog
        @iterations.map &format
      else
        returning @iterations.reject{|i| i.id == iteration.id}.map &format do |options|
          options.unshift ["Backlog", 0]
        end
      end
    end
    def format
      lambda {|i| ["Iteration: #{i.start_date.to_s(:iteration_start_date)}", i.id]}
    end
  end
end
