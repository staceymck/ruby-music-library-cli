require 'pry'
class Song
    extend Concerns::Findable
    attr_accessor :name, :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist unless artist == nil
        self.genre = genre unless genre == nil
    end

    def save
        self.class.all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        all.clear
    end
    
    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.new_from_filename(filename)
        song_details = filename.split(" - ")
        artist = song_details[0]
        name = song_details[1]
        genre = song_details[2].split(".").first
        
        song = Song.new(name)
        song.genre = Genre.find_or_create_by_name(genre)
        song.artist = Artist.find_or_create_by_name(artist)
        song
    end

    def self.create_from_filename(filename)
        song = new_from_filename(filename)
        song.save
    end
end

