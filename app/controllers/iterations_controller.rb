class IterationsController < ApplicationController
  def index
    @iterations = Iteration.all
    @backlog = Card.backlog
  end
  
  def new
    @iteration = Iteration.new
  end
  
  def create
    Iteration.create!(params[:iteration])
    redirect_to iterations_path
  end
end