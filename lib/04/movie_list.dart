import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

void main() {
  runApp(const MyApp());
}

class Movie {
  Movie({
    @required this.id,
    @required this.title,
    @required this.year,
    @required this.torrent,
    @required this.genres,
    @required this.rating,
    @required this.cover,
  });

  final int id;
  final String title;
  final int year;
  final List<Torrent> torrent;
  final List<dynamic> genres;
  final double rating;
  final String cover;

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, year: $year, torrent: $torrent, genres: $genres, rating: $rating, cover: $cover}';
  }
}

class Torrent {
  Torrent({
    @required this.quality,
  });

  final String quality;

  @override
  String toString() {
    return 'Torrent{quality: $quality}';
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(
        title: 'Movies',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownValue1 = 'Quality'; // Quality
  String dropdownValue2 = 'Minimum Rating'; // Rating (minimum)
  String dropdownValue3 = 'Genre'; // Comedy
  String genreFilter = 'Genre';
  String ratingFilter = 'Minimum Rating';
  String qualityFilter = 'Quality';
  final List<Movie> movieList = <Movie>[];
  List<Movie> filteredMovieList = <Movie>[];
  final List<Torrent> torrentList = <Torrent>[];

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  Future<void> getMovies() async {
    final Response response = await get('https://yts.mx/api/v2/list_movies.json');

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];

    final List<dynamic> movies = data['movies'];

    for (int i = 0; i < movies.length; i++) {
      final Map<String, dynamic> item = movies[i];
      final List<dynamic> torrents = movies[i]['torrents'];

      for (int j = 0; j < torrents.length; j++) {
        final Map<String, dynamic> itemTor = torrents[j];
        final Torrent torrent = Torrent(
          quality: itemTor['quality'],
        );
        torrentList.add(torrent);
      }

      final Movie movie = Movie(
        id: item['id'], // we use the string names from the json file
        title: item['title'],
        year: item['year'],
        torrent: torrentList,
        genres: item['genres'],
        rating: item['rating'].toDouble(),
        cover: item['medium_cover_image'],
      );

      movieList.add(movie);
    }

    setState(() {
      // movies changed
    });
  }

  @override
  Widget build(BuildContext context) {
    filteredMovieList = movieList;

    if (genreFilter != 'Genre') {
      filteredMovieList = filteredMovieList
          .where((Movie f) => f.genres.where((dynamic element) => element.toString() == genreFilter).isNotEmpty)
          .toList();
    }

    if (ratingFilter != 'Minimum Rating') {
      filteredMovieList = filteredMovieList.where((Movie f) => f.rating >= double.tryParse(ratingFilter)).toList();
    }

    if (qualityFilter != 'Quality') {
      filteredMovieList = filteredMovieList
          .where((Movie f) => f.torrent.where((Torrent element) => element.quality == qualityFilter).isNotEmpty)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton<String>(
                    value: dropdownValue1,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        qualityFilter = newValue;
                        dropdownValue1 = newValue;
                      });
                    },
                    items: <String>['Quality', '720p', '1080p', '4k'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue2,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        ratingFilter = newValue;
                        dropdownValue2 = newValue;
                      });
                    },
                    items: <String>[
                      'Minimum Rating',
                      '0',
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue3,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue3 = newValue;
                        genreFilter = newValue;
                      });
                    },
                    items: <String>[
                      'Genre',
                      'Comedy',
                      'Sci-Fi',
                      'Horror',
                      'Romance',
                      'Action',
                      'Thriller',
                      'Drama',
                      'Mystery',
                      'Crime',
                      'Animation',
                      'Adventure',
                      'Fantasy',
                      'Comedy-Romance',
                      'Action-Comedy',
                      'Superhero',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 12,
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: filteredMovieList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 32.0,
                  crossAxisSpacing: 32.0,
                  childAspectRatio: 7 / 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Image.network(
                            filteredMovieList[index].cover,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            filteredMovieList[index].title,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
