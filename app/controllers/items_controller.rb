class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]
  #before_action :process_relevant_actions, only: %i[ update ]
  before_action :relevant_processing, only: %i[ update ]
  after_action :register_created_items, only: %i[ create ]


  # GET /items or /items.json
  def index
    #@pagy, @items = pagy(Item.all.order(:id), items: 10, size: [2,2,2,2])
    @items = Item.all.order(:language_id, :status)
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    unless current_user.admin? or (current_user.id == @item.user_id)
      redirect_to root_url, notice: "You did not claim this task"
      return
    end
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)
    if @item.language_id != 1
      @item.title = @item.item.title
      @item.description = @item.item.description
      @item.content = @item.item.content
    end
    respond_to do |format|
      if @item.save
        format.html { redirect_to edit_item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        if params[:commit].downcase.include?("resign") or params[:commit].downcase.include?("submit")
          format.html { redirect_to root_path }
        elsif params[:commit].downcase.include?("admin")
          format.html { redirect_to item_path(@item) }
        else
          format.html { redirect_to edit_item_url(@item), notice: "Item was successfully updated." }
          format.json { render :show, status: :ok, location: @item }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:language_id, :media, :status, :title, :description, :content, :user_id, :item_id, :context_info, :published)
    end

    def relevant_processing
      if ["start", "submit", "resign", "admin"].any? { |action| params[:commit].downcase.include? action }
        ev = Event.new
        ev.item = @item
        ev.user = current_user
        if params[:commit].downcase.include? "start"
          @item.status == 3 ? params[:item][:status] = 4 : params[:item][:status] = 2
          @item.translation? ? ev.context_info = "started #{ @item.status==3 ? "a revision" : "a translation" }" : ev.context_info = "started a #{ @item.status==3 ? "revision" : "transcription" }"
        elsif params[:commit].downcase.include? "submit"
          params[:item][:status] = @item.status + 1
          params[:item][:user_id] = nil
          @item.translation? ? ev.context_info = "submitted #{ @item.status=4 ? "a revision" : "a translation" }" : ev.context_info = "submitted a #{ @item.status==4 ? "revision" : "transcription" }"
        elsif params[:commit].downcase.include? "resign"
          params[:item][:status] = @item.status - 1
          params[:item][:user_id] = nil
          @item.translation? ? ev.context_info = "resigned from #{ @item.status==4 ? "a revision" : "a translation" }" : ev.context_info = "resigned from a #{ @item.status==4 ? "revision" : "transcription" }"
        end
        ev.save
      end
    end

    def register_created_items
      ev = Event.new 
      ev.item = @item
      ev.user = current_user
      ev.context_info = "#{@item.translation? ? "started a translation" : "added a new content"}"
      ev.save
    end
end