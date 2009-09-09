class BacklogsController < ApplicationController
  def show
    @cards = Card.backlog
  end
end