class CommentsController < ApplicationController
  before_action :correct_user, only: :destroy

  def index
    @advert = Advert.find(params[:advert_id])
    @comments = @advert.comments.paginate(page: params[:page], per_page: 25)
  end

  def create
    @advert = Advert.find(params[:advert_id])
    @comment = @advert.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      @new_comment = @advert.comments.new
      respond_to do |format|
        format.html do
          flash[:notice] = 'Comment posted.'
          redirect_to @advert
        end
        format.js
      end
    else
      @new_comment = @comment
      respond_to do |format|
        format.html { render @advert }
        format.js { render action: 'failed' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @advert = @comment.advert
    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'Comment deleted.'
        redirect_to @advert
      end
      format.js
    end
  end

  private

  # Set an admin user
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment.user == current_user || current_user.admin? || @comment.user == @comment.advert.user
      redirect_to @comment.advert
    end
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content)
  end
end
