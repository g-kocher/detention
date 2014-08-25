module Factory
  class << self
    def detention_data
      File.read(File.join('spec', 'fixtures', 'import.html'))
    end
  end
end