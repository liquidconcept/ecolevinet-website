# encoding: UTF-8
class AbsenceMailer < ActionMailer::Base

  def justification_absence(params,timestamp,to_parents)

    @params = params
    @timestamp = timestamp
    @to_parents = to_parents
    #TODO replace n.couturier by secretariat@ecolevinet.ch
    if @to_parents
      mail(:to => @params[:email], :subject => "Justification d'absence", :from => 'secretariat@ecolevinet.ch')
    else
      mail(:to => 'secretariat@ecolevinet.ch', :subject => "[Ecole Vinet] Justification d'absence réf.: #{@timestamp}", :from => @params[:email])
    end
  end

  def demande_absence(params,timestamp,to_parents)

    @params = params
    @timestamp = timestamp
    @to_parents = to_parents
    #TODO replace n.couturier by secretariat@ecolevinet.ch
    if  @to_parents
      mail(:to => @params[:email], :subject => "Demande d'absence", :from => 'secretariat@ecolevinet.ch')
    else
      mail(:to => 'secretariat@ecolevinet.ch', :subject => "[Ecole Vinet] Demande d'absence réf.: #{@timestamp}", :from => @params[:email])
    end

  end

end
