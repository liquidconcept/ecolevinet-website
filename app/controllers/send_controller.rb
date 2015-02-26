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
    @params = params.select {|k, v| %w(
      booklet
      email
      name
      phone
      message
    ).include?(k) }.with_indifferent_access
    @timestamp = DateTime.now.to_i

    if @params[:email].empty? || params[:email] !~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      respond_to do |format|
       format.js { render :text => "<p>Votre demande ne peut pas être envoyée si vous n'indiquez pas un email.</p>", :content_type => 'text/html'}
      end
    else
      Delayed::Job.enqueue MailingJob.new(@params, @timestamp)

      respond_to do |format|
       format.js { render :text => "<p>Un message a été envoyé au secrétariat de l'école</p><p>Ainsi qu'une copie sur votre mail.</p>", :content_type => 'text/html'}
      end
    end
  end
end
