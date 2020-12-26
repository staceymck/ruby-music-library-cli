require 'pry'

class Artist
    extend Concerns::Findable
    attr_accessor :name, :songs
    
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
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
        artist = Artist.new(name)
        artist.save
        artist
    end

    def add_song(song)
        song.artist ||= song.artist = self
        #song.artist = self unless song.artist != nil
        songs << song unless songs.include?(song) #add song unless already included in artist's song list
    end

    def genres
        songs.map {|song| song.genre}.uniq
    end
end