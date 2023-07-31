json.extract! @event, :id, :title, :description, :address, :owner_id, :category, :image_url
json.start_time @event.start_time.strftime('%b %e, %l:%M %p')
json.bookings_count @event.bookings.count
json.promoter do
  json.extract! @event.owner, :id, :name
end
