class HomeController < ApplicationController
  
  before_filter :set_active_tab
  
  def index
  end
  
  private
  
  def set_active_tab
    @active_tab = :home
  end
  
end
