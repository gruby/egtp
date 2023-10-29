module EventsHelper
  def phrase_that(event)
    if event.item.translation?
      #"Item #{event.item.item.id} - #{event.author} #{event.context_info} to #{event.item.language.name}"
      (link_to "item #{event.item.item.id}", item_path(event.item.item.id)) + " - " + (link_to "#{event.author}", user_path(event.author)) + " " + (link_to "#{event.context_info}", item_path(event.item)) + " to " + (link_to "#{event.item.language.name}", language_path(event.item.language)) 
    else
      #"Item #{event.item_id} - #{event.author} #{event.context_info}"
      (link_to "item #{event.item.id}", item_path(event.item.id)) + " - " + (link_to "#{event.author}", user_path(event.author)) + " #{event.context_info}"
    end
  end

  def phrase_for_item(event)
    "#{event.author} #{event.context_info}"
  end
end