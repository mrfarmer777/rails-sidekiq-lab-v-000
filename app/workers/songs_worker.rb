class SongsWorker
  include Sidekiq::Worker
  require 'csv'

  def perform(songs_file)
    CSV.foreach(songs_file, headers: true) do |song|
      artist=Artist.find_or_create_by(name: song[1])
      artist.songs.build(title: song[0])
      artist.save
    end
  end
end
