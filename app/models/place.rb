class Place < OpenStruct
  def self.rendered_fields
    [:status, :street, :city, :zip, :country, :overall]
  end
end
