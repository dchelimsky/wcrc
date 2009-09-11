class CardsController < ApplicationController
  def new
    @card = Card.new
  end
  
  def create
    Card.create!(params[:card])
    redirect_to(iterations_path)
  end
  
  def update
    card = Card.find(params[:id])
    if params[:commit] == "Move up"
      card.move_higher
    else
      card.update_attributes!(params[:card])
    end
    redirect_to :back
  end
  
  def show
    @card = Card.find(params[:id])
  end
end
