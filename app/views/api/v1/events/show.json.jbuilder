json.extract! @event, :id, :title, :description, :address, :owner_id, :category
json.start_time @event.start_time.strftime('%b %e, %l:%M %p')
json.bookings_count @event.bookings.count
json.promoter do
  json.extract! @event.owner, :id, :nickname
end
json.can_edit policy(@event).edit?
