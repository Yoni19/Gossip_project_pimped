class StaticPagesController < ApplicationController

  def index
    @all_gossips = Gossip.all
  end

end
