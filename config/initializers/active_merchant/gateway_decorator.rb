ActiveMerchant::Billing::Gateway.class_eval do
  def localized_amount(money,currency)
   amount = amount(money)
 
   # 元コード
   # return amount unless non_fractional_currency?(currency)
 
   # unlessをifに変更する
   return amount if non_fractional_currency?(currency)
 
   if self.money_format == :cents
    sprintf("%.0f", amount.to_f / 100)
   else
    amount.split('.').first
   end
  end
 end
