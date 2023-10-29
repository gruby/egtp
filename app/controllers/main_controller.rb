class MainController < ApplicationController
  def index
    @ongoing_tasks = current_user.items.ongoing_tasks_in(current_user.language.id)
    #unless @ongoing_tasks.empty?
    #  redirect_to edit_item_path(@ongoing_tasks.first)
    #end
    @for_revision = Item.ready_for_rv_in(current_user.language.id)
    @pagy, @for_tt = pagy(Item.ready_for_tt_in(current_user.language.id).order(:id), items:5)
  end
end
