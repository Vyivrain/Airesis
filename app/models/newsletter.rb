class Newsletter < ActiveRecord::Base
  validates :subject, presence: true
  validates :body, presence: true

  attr_accessor :receiver

  def publish
    user_ids = case (receiver)
               when 'all'
                 User.confirmed.where(blocked: false, receive_newsletter: true).where.not(email: nil).pluck(:id)
               when 'not_confirmed'
                 User.unconfirmed.pluck(:id)
               when 'admin'
                 User.where(user_type_id: UserType::ADMINISTRATOR).pluck(:id)
               else
                 [User.last.id]
    end
    NewsletterSender.perform_in(5.seconds, id, user_ids)
  end
end
