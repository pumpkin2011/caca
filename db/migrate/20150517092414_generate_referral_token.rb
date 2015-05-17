class GenerateReferralToken < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.generate_referral_token
    end
  end
end
