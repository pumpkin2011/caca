# == Schema Information
#
# Table name: vips
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  pricing    :integer
#  largess    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_vips_on_user_id  (user_id)
#

class Vip < ActiveRecord::Base
  extend Enumerize
  belongs_to :user

  enumerize :pricing, in: {
    :ten_day => 10,
    :one_month => 30, :three_month => 90,
    :six_month => 180,:tlewve_month => 360
  }

  validate :with_amount_limit, unless: Proc.new{|vip| vip.largess}

  after_create :update_vip_at
  after_create :with_largess, :with_bill, unless: Proc.new{|vip| vip.largess}

  private
    # 更新vip到期时间
    def update_vip_at
      if self.user.vip_at.blank? || self.user.vip_at< Time.now
        self.user.vip_at = self.pricing.value.days.from_now
      else
        self.user.vip_at += self.pricing.value.days
      end
      self.user.save
    end

    # 优惠赠送
    def with_largess
      case self.pricing
        when 'three_month'
          Vip.create(user: self.user, pricing: 'ten_day', largess: true)
        when 'six_month'
          Vip.create(user: self.user, pricing: 'one_month', largess: true)
        when 'tlewve_month'
          Vip.create(user: self.user, pricing: 'three_month', largess: true)
      end
    end

    # 交易明细
    def with_bill
      self.user.decrement(:amount, self.pricing.value)
      self.user.save
      Bill.create(
        user: self.user,
        log: self.id,
        amount: -self.pricing.value,
        state: 'vip',
      )
    end

    # 检查余额
    def with_amount_limit
      errors.add(:base, "账户余额为: #{sprintf('%0.02f元', self.user.amount)}, 不能购买此套餐。") if self.user.amount < self.pricing.value
    end
end
