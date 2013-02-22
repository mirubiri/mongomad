class User::Thing
  include Mongoid::Document

  embedded_in :user

  field :name,        type: String
  field :description, type: String
  field :stock,       type: Integer

  mount_uploader :image, ThingImageUploader, :mount_on => :image_name

  validates :user,
            :name,
            :description,
            :stock,
            :image_name,
            presence: true

  validates :stock,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }

  def self.generate(thing_params=[])
    thing = new(
      name: thing_params[:name],
      description: thing_params[:description],
      stock: thing_params[:stock],
      image_name: thing_params[:image_name]
    )
    thing.self_update
  end

  def alter_contents(thing_params=[])
  end

  def publish
    save
  end

  def unpublish
    destroy
  end

  def self_update
    reload if persisted?
    self
  end
end
