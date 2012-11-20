# encoding: UTF-8
class ContactMailer < ActionMailer::Base

  def demande_information(params,timestamp,to_parents)

    @params = params
    @timestamp = timestamp
    @to_parents = to_parents
    #TODO replace n.couturier by secretariat@ecolevinet.ch
    if  @to_parents
      if @params[:booklet] != nil  
        attachments['brochure_information.pdf'] = File.read("#{Rails.root}/public/pdf/brochure_information.pdf")
        mail(:to => @params[:email], :subject => "Demande d'information avec la brochure", :from => 'ludovic.turmel@liquid-concept.ch')
      else 
        mail(:to => @params[:email], :subject => "Demande d'information", :from => 'secretariat@ecolevinet.ch')
      end
    else
      mail(:to => 'secretariat@ecolevinet.ch', :subject => "[Ecole Vinet] Demande d'information réf.: #{@timestamp}", :from => @params[:email])
    end

  end

end


