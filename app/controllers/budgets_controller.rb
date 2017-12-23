class BudgetsController < ApplicationController

  def index
  end

  def edit
    @budget = Budget.find(params[:id])
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

  def update
    @budget = Budget.find(params[:id])
    @budget.update_columns(budgets_params)
    @budget.update(:weekly => @budget.yearly.to_i/52)
    @budget.update(:monthly => @budget.yearly.to_i/12)
    @budget.update(:daily => @budget.yearly.to_i/365)

    if @budget.save
      flash[:notice] = "Goal was updated."
      redirect_to :action => :index
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def new
    @budgets = Budget.new
  end

  private

  def budgets_params
    params.require(:budget).permit(:yearly, :monthly, :weekly, :daily, :created_at)
  end
end
