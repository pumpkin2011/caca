module DeliversHelper
  def full_address(deliver)
    full = ChinaCity.get(deliver.province)
    full += ChinaCity.get(deliver.city) unless ChinaCity.get(deliver.city) == '市辖区'
    full += ChinaCity.get(deliver.district)
    full += deliver.town
    full += deliver.address
    full += " (#{deliver.zip})" if deliver.zip
  end
end
