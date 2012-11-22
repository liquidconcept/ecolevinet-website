# encoding: UTF-8
class MailingJob < Struct.new(:params, :timestamp)

  def perform
    ContactMailer.demande_information(params.with_indifferent_access, timestamp, true).deliver
    ContactMailer.demande_information(params.with_indifferent_access, timestamp, false).deliver
  end

end
