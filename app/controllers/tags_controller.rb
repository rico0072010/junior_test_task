class TagsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]
  before_action :admin_user, except: %i[show index]
  before_action :set_tag, only: %i[show edit update]

  def index
    @tags = Tag.paginate(page: params[:page], per_page: 5)
  end

  def new
    @tag = Tag.new
  end

  def show
    @adverts = @tag.adverts.paginate(page: params[:page], per_page: 25)
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = 'Tag was successfully created'
      redirect_to @tag
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @tag.update(tag_params)
      flash[:notice] = 'Tag name was successfully updated'
      redirect_to @tag
    else
      render 'edit'
    end
  end

  private

  # Set an admin user
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
