# encoding: UTF-8
class SendController < ApplicationController

  def justification_absence
    @page = Page.find_by_link_url('/')
  end

  def resultat_justification
    @params = params
    @page = Page.find_by_link_url('/')
    @timestamp = DateTime.now.to_i
    AbsenceMailer.justification_absence(@params,@timestamp,false).deliver
    AbsenceMailer.justification_absence(@params,@timestamp,true).deliver

    respond_to do |format|
     format.html
    end
  rescue Exception => exc
    logger.error(" #{exc.message}")
    flash["Un problème est survenu. Merci d'essayer à nouveau ou de contacter votre administrateur."]
    redirect_to :action => :justification_absence
  end

  def demande_absence
    @page = Page.find_by_link_url('/')
  end

  def resultat_demande
    @params = params
    @page = Page.find_by_link_url('/')
    @timestamp = DateTime.now.to_i
    
    AbsenceMailer.demande_absence(@params,@timestamp,true).deliver
    AbsenceMailer.demande_absence(@params,@timestamp,false).deliver

    respond_to do |format|
     format.html
    end
  rescue Exception => exc
    logger.error(" #{exc.message}")
    flash["Un problème est survenu. Merci d'essayer à nouveau ou de contacter votre administrateur."]
    redirect_to :action => :demande_absence
  end

end
