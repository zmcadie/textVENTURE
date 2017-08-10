class StatesController < ApplicationController

  def show
    @state = State.find(1)
  end

end
