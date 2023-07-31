json.array! @events do |event|
  json.extract! event, :id, :title, :description, :address, :owner_id, :category, :image_url
  json.start_time event.start_time.strftime('%b %e, %l:%M %p')
  json.address event.address.truncate(30, omission: '...')
  json.bookings_count event.bookings.count
  json.bookings event.bookings

  json.has_booking event.bookings.exists?(owner_id: 1)
end
