class ProjectsController < ApplicationController

  layout "one_column"

  active_tab :projects

  def index
    @page_ttle = "Projects"
  end

  def wisepatient
    @page_title = "WisePatient | Projects"
  end

  def splash_surveys
    @page_title = "Splash Surveys | Projects"
  end

end
