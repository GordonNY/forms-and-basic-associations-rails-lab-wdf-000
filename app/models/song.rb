class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name) if name.strip != ''
  end

  def artist_name
    self.artist ? self.artist.name : ""
  end

  def note_ids=(ids)
    ids.each do |id|
      post = Post.find(id)
      self.posts << post
    end
  end

  def note_contents=(notes)
    notes.each do |content|
      if content.strip != ''
        self.notes.build(content: content)
      end
    end
  end

  def note_contents
    self.notes.map(&:content)
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name) if name.strip != ''
  end

  def genre_name
    self.genre ? self.genre.name : ""
  end
end
