class Api::V1::OwnerSerializer < ActiveModel::Serializer
  attributes :id, :name, :booked_events, :created_events

  def created_events
    object.events
  end

  def booked_events
    object.booked_events.map do |event|
      {
        id: event.id,
        title: event.title,
        category: event.category,
        address: event.address,
        description: event.description,
        start_time: event.start_time.strftime('%b %d, %H:%M'),
        image_url: event.image_url
      }
    end
  end
end
