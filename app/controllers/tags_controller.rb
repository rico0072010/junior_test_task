class TagsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :require_admin, except: %i[show]
  before_action :set_tag

  def new; end

  def show
    @adverts = @tag.adverts
  end

  def create; end

  def destroy; end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
