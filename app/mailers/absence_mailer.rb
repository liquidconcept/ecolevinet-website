class AbsenceMailer < ActionMailer::Base
  default :from => "n.couturier@gmail.com", :to => 'n.couturier@gmail.com', :subject => 'test'

  def justification_absence(params)
    @params = params
  end

  def demande_absence(params)
    @params = params
     mail(:to => 'n.couturier@gmail.com', :subject => "Demande d'absence", :from => @params[:email])
  end

end
