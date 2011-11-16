# encoding: UTF-8
class ContactMailer < ActionMailer::Base

  def demande_contact(params,timestamp,to_parents)

    @params = params
    @timestamp = timestamp
    @to_parents = to_parents
    #TODO replace n.couturier by secretariat@ecolevinet.ch
    if  @to_parents
      mail(:to => @params[:email], :subject => "Demande de contact", :from => 'secretariat@ecolevinet.ch')
    else
      mail(:to => 'secretariat@ecolevinet.ch', :subject => "[Ecole Vinet] Demande de contact réf.: #{@timestamp}", :from => @params[:email])
    end

  end

end
