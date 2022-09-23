module BaseRepository
  def new(object, attrs = nil)
    object.new attrs
  end

  def save(object)
    object.save
  end

  def create(object, value)
    object.create(value)
  end

  def valid(object)
    object.valid?
  end

  def find(object, id)
    object.find_by id: id
  end

  def delete(object)
    object.destroy
  end
end
