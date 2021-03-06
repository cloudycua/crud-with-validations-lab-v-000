class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: {
    scope: %i[release_year artist_name]
  }

  with_options if: :released? do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: {
      less_than_or_equal_to: Date.today.year
    }
    validates :released, inclusion: { in: [true, false] }
    validates :artist_name, presence: true
  end

  def released?
    released
  end

end
