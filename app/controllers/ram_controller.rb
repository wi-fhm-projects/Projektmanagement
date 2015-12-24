class RamController < ApplicationController

  def index
   @project = Project.find(params[:project])
  end
end
