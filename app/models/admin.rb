# == Schema Information
#
# Table name: admins
#
#  id                  :integer          not null, primary key
#  email               :string(255)      default(""), not null
#  encrypted_password  :string(255)      default(""), not null
#  remember_created_at :datetime
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_admins_on_email  (email) UNIQUE
#

class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :recoverable, :trackable
  devise :database_authenticatable, :rememberable, :validatable

  has_many :deposits
end
