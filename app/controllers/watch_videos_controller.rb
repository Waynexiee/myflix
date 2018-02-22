class WatchVideosController < ApplicationController
  def watch
    @url = params[:url]
  end
end