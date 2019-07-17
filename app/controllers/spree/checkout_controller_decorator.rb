Spree::CheckoutController.class_eval do
  before_action :update_payment_method_fee, only: :update

  private
  def update_payment_method_fee
    return unless params['state'] == "payment"

    if params[:order][:wallet_payment_source_id].present?
      # solidusはparams[:wallet_payment_source_id]の有無でwalletの使用/不使用を判定している
      # カードの場合0円にしてます。適時書き換えてください。
      payment_method_fee_is = 0
    else
      payment_method_fee_is = Spree::PaymentMethod.find(params['order']['payments_attributes'][0]['payment_method_id']).preferred_payment_method_fee
    end
    payment_method_fee_was = @order.adjustments.eligible.where(label: Spree.t(:payment_method_fee)).sum(:amount).to_i

    if payment_method_fee_is != payment_method_fee_was
      @order.adjustments.eligible.where(label: Spree.t(:payment_method_fee)).update_all(eligible: false)
      Spree::Adjustment.create(label: Spree.t(:payment_method_fee), adjustable: @order, order: @order, amount: payment_method_fee_is) if payment_method_fee_is != 0
      @order.adjustments.reload
      @order.updater.update # @order.totalや@order.adjustment_totalを再計算する
    end
  end
end
