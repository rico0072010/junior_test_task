class AdvertsController < ApplicationController
  before_action :set_advert, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :admin_user, only: :destroy

  def index
    @adverts = Advert.paginate(page: params[:page], per_page: 25)
  end

  def show
    @comments = @advert.comments.limit(25)
    @new_comment = @advert.comments.new
  end

  def new
    @advert = current_user.adverts.new
  end

  # GET /adverts/1/edit
  def edit; end

  # POST /adverts
  # POST /adverts.json
  def create
    @advert = current_user.adverts.new(advert_params)

    respond_to do |format|
      if @advert.save
        format.html { redirect_to @advert, notice: 'Advert was successfully created.' }
        format.json { render :show, status: :created, location: @advert }
      else
        format.html { render :new }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adverts/1
  # PATCH/PUT /adverts/1.json
  def update
    respond_to do |format|
      if @advert.update(advert_params)
        format.html { redirect_to @advert, notice: 'Advert was successfully updated.' }
        format.json { render :show, status: :ok, location: @advert }
      else
        format.html { render :edit }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adverts/1
  # DELETE /adverts/1.json
  def destroy
    @advert.destroy
    respond_to do |format|
      format.html { redirect_to adverts_url, notice: 'Advert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_status
    @advert = Advert.find(params[:advert_id])
    if @advert.status?
      @advert.update_attribute(:status, false)
      flash[:notice] = 'Advert was successfully closed'
    else
      @advert.update_attribute(:status, true)
      flash[:notice] = 'Advert was successfully activated'
    end
    redirect_to @advert
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_advert
    @advert = Advert.find(params[:id])
  end

  # Set an admin user
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # Only allow a list of trusted parameters through.
  def advert_params
    params.require(:advert).permit(:title, :content, :picture, :status, :address,
                                   :locality, :administrative_area_level_1, tag_ids: [])
  end
end
