class AbsenceMailer < ActionMailer::Base
  default :from => "n.couturier@gmail.com", :to => 'n.couturier@gmail.com', :subject => 'test'

  def justification_absence(params)
    @params = params
  end

  def demande_absence(params)
    @params = params
    timestamp
    #TODO replace n.couturier by secretariat@ecolevinet.ch
    mail(:to => 'n.couturier@gmail.com', :subject => "Demande d'absence", :from => @params[:email])
    
    #TODO replace n.couturier by secretariat@ecolevinet.ch
    mail(:to => @params[:email] 'n.couturier@gmail.com', :subject => "Demande d'absence", :from => 'n.couturier@gmail.com')

  end

end
