class CatsController < ApplicationController
  before_filter :require_current_user_owns_cat!, :only => [:edit, :update]

  def index
    @cats = Cat.all

    render :index
  end

  def show
    @cat = Cat.find(params[:id])

    render :show
  end

  def new
    @cat = Cat.new

    render :new
  end

  def create
    @cat = Cat.new(params[:cat])
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    raise "you can't edit an unexisting cat!" unless @cat.persisted?
    if @cat.update_attributes(params[:cat])
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end
end