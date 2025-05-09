class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: "Заявка успешно создана"
    else
      render :new
    end
  end

  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(
      :first_name, :last_name, :middle_name,
      :phone, :email, :weight, :length, :width, :height,
      :from_city, :to_city
    )
  end
end