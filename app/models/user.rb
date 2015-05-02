# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  name                   :string(20)
#  qq                     :string(15)
#  amount                 :decimal(10, 2)   default(0.0)
#  frozen_amount          :decimal(10, 2)   default(0.0)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  state                  :string(10)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name)
#  index_users_on_qq                    (qq)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_state                 (state)
#

class User < ActiveRecord::Base
  include AASM
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates_presence_of :name, :qq
  validates :name, length: {in: 2..10}, uniqueness: true, allow_blank: true, on: :create
  validates :qq, length: {in: 4..15}, uniqueness: true, allow_blank: true, on: :create

  has_many :deposits
  has_many :delivers
  has_one :deliver, foreign_key: 'owner_id'
  has_many :wangwangs
  has_many :shops
  has_many :tasks
  has_many :orders
  # 基本身份验证
  has_one :identity, dependent: :destroy
  has_one :bank, dependent: :destroy
  accepts_nested_attributes_for :identity
  accepts_nested_attributes_for :bank

  # 用户状态
  aasm column: :state do
    state :uploading, initial: true
    state :pending
    state :checked
    state :officialed

    event :check_in do
      transitions from: :pending, to: :checked
    end

    event :check_out do
      transitions from: :pending, to: :uploading
    end

    event :official do
      transitions from: :checked, to: :officialed
    end
  end

  after_create do |user|
    user.create_identity
    user.create_bank
  end




end
