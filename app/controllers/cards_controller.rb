class CardsController < ApplicationController
  def new
    @card = Card.new
  end
  
  def create
    Card.create!(params[:card])
    redirect_to(backlog_path)
  end
  
  def update
    card = Card.find(params[:id])
    card.update_attributes!(params[:card])
    redirect_to :back
  end
  
  def show
    @card = Card.find(params[:id])
  end
end
