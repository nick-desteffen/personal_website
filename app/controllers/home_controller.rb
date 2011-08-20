class HomeController < ApplicationController
  
  active_tab :home
  
  def index
  end
  
  def about
    @page_title = "About"
  end
  
end
