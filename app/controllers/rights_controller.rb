class RightsController < ApplicationController
  before_action :set_right, only: %i[ show edit update destroy ]

  # GET /rights or /rights.json
  def index
    @rights = Right.all
  end

  # GET /rights/1 or /rights/1.json
  def show
  end

  # GET /rights/new
  def new
    @right = Right.new
  end

  # GET /rights/1/edit
  def edit
  end

  # POST /rights or /rights.json
  def create
    @right = Right.new(right_params)

    respond_to do |format|
      if @right.save
        format.html { redirect_to right_url(@right), notice: "Right was successfully created." }
        format.json { render :show, status: :created, location: @right }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rights/1 or /rights/1.json
  def update
    respond_to do |format|
      if @right.update(right_params)
        format.html { redirect_to right_url(@right), notice: "Right was successfully updated." }
        format.json { render :show, status: :ok, location: @right }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rights/1 or /rights/1.json
  def destroy
    @right.destroy!

    respond_to do |format|
      format.html { redirect_to rights_url, notice: "Right was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_right
      @right = Right.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def right_params
      params.require(:right).permit(:role, :user_id, :language_id)
    end
end
