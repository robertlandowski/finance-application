class BudgetsController < ApplicationController

  def index
  end

  def create
    @budgets = Budget.create(budgets_params)
    @budgets.user = current_user
    @budgets.monthly = (@budgets.yearly)/12
    @budgets.weekly = (@budgets.yearly)/52
    @budgets.daily = (@budgets.yearly)/365

    if @budgets.save
      redirect_to :action => :index, notice: "Budget was saved successfully."
    else
      redirect_to :action => :new, notice: "Error YO!"
    end
  end

  def new
    @budgets = Budget.new
  end

  private

  def budgets_params
    params.require(:budget).permit(:yearly, :monthly, :weekly, :daily)
  end
end
