describe ImageManagement::File do
  # Attributes

    it { should have_field :public_id }
    it { should have_field :version }
    it { should have_field(:width).of_type(Integer) }
    it { should have_field(:height).of_type(Integer) }
    it { should have_field :format }
    it { should have_field :resource_type }

  # Relations
    it { should be_embedded_in :file_container }
  # Methods
end