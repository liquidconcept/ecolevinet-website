class SendController < ApplicationController

  def index
    @page = Page.find_by_link_url('/')
  end

  def justification_absence
    @params = params
    @page = Page.find_by_link_url('/')
    AbsenceMailer.justification_absence(@params).deliver
    redirect_to :action => :resultat
  end

  def demande_absence
    @params = params
    @page = Page.find_by_link_url('/')
    AbsenceMailer.demande_absence(@params).deliver
    redirect_to :action => :resultat
  end

  def resultat
    @page = Page.find_by_link_url('/')
  end

end
