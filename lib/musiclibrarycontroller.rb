class MusicLibraryController

    def initialize(path = "./db/mp3s")
        MusicImporter.new(path).import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        puts "To list all of the songs by a particular artist, enter 'list artist'."

        input = gets.strip 

        if input != "exit" 
            case input
                when "list songs"
                    list_songs
                when "list artists"
                    list_artists
                when "list genres"
                    list_genres
                when "list artist"
                    list_songs_by_artist
                when "list genre"
                    list_songs_by_genre
                when "play song"
                    play_song
                else
                    call
            end
        end
    end

    def sort_songs_by_name
        list = Song.all.sort_by {|song| song.name}
    end

    def list_songs
        sort_songs_by_name.each.with_index(1) do |song, i|
            puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        list = Artist.all.map {|artist| artist.name}.sort
        list.each.with_index(1) do |artist, i|
            puts "#{i}. #{artist}"
        end
    end

    def list_genres
        list = Genre.all.map {|genre| genre.name}.sort
        list.each.with_index(1) do |genre, i|
            puts "#{i}. #{genre}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist_name = gets.strip
        artist_obj = Artist.find_by_name(artist_name)

        if artist_obj
            sorted_song_list = artist_obj.songs.sort_by {|song| song.name}
            sorted_song_list.each.with_index(1) do |song, i|
                puts "#{i}. #{song.name} - #{song.genre.name}"
            end 
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre_name = gets.strip
        genre_obj = Genre.find_by_name(genre_name)

        if genre_obj
            sorted_song_list = genre_obj.songs.sort_by {|song| song.name}
            sorted_song_list.each.with_index(1) do |song, i|
                puts "#{i}. #{song.artist.name} - #{song.name}"
            end 
        end
    end


    def play_song
        puts "Which song number would you like to play?"
        song_num = gets.strip.to_i - 1

        if song_num >= 0 && song_num < Song.all.size
            sorted_list = sort_songs_by_name
            puts "Playing #{sorted_list[song_num].name} by #{sorted_list[song_num].artist.name}"
        end
    end
end

