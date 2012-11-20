# encoding: UTF-8
class SendController < ApplicationController

  def justification_absence
    #serve parents page
    @page = Section.find(5).page
  end

  def resultat_justification
    @params = params
    #serve parents page
    @page = Section.find(5).page
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
    #serve parents page
    @page = Section.find(5).page
  end

  def resultat_demande
    @params = params
    #serve parents page
    @page = Section.find(5).page
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

  def demande_contact
    @params = params
    @timestamp = DateTime.now.to_i
    
    ContactMailer.demande_contact(@params,@timestamp,true).deliver
    ContactMailer.demande_contact(@params,@timestamp,false).deliver

    respond_to do |format|
     format.js { render :text => "<p>Un message a été envoyé</p><p>au secrétariat de l'école</p>", :content_type => 'text/html'}
    end

  rescue Exception => exc
    logger.error(" #{exc.message}")
  end

  def demande_contact_homepage
    @params = params
    @timestamp = DateTime.now.to_i
    
    ContactMailer.demande_information(@params,@timestamp,true).deliver
    ContactMailer.demande_information(@params,@timestamp,false).deliver

    respond_to do |format|
     format.js { render :text => "<p>Un message a été envoyé au secrétariat de l'école</p>", :content_type => 'text/html'}
    end

  rescue Exception => exc
    logger.error(" #{exc.message}")
  end

end
