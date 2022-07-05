class CommentariesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_commentary, only: %i[ edit update destroy ]

  # GET /commentaries/1/edit
  def edit
    @commentary = Commentary.find(params[:id])
  end

  # POST /commentaries or /commentaries.json
  def create
    @commentary = Commentary.new(commentary_params)

    respond_to do |format|
      if @commentary.save
        format.html { redirect_to post_path(@commentary.post.id) }
        format.json { render :show, status: :created, location: @commentary }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @commentary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commentaries/1 or /commentaries/1.json
  def update
    respond_to do |format|
      if @commentary.update(update_commentary_params)
        format.html { redirect_to profile_path(@commentary.post.user.id) }
        format.json { render :show, status: :ok, location: @commentary }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @commentary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commentaries/1 or /commentaries/1.json
  def destroy
    @user_profile_id = @commentary.post.user.id
    @commentary.destroy

    respond_to do |format|
      format.html { redirect_to profile_path(@user_profile_id), notice: "Commentary was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_commentary
    @commentary = Commentary.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def commentary_params
    params.require(:commentary).permit(:comment_text, :post_id, :user_id)
  end

  def update_commentary_params
    params.require(:commentary).permit(:comment_text, :post_id)
  end
end
