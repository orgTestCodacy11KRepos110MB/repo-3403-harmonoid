/// This file is a part of Harmonoid (https://github.com/harmonoid/harmonoid).
///
/// Copyright © 2020-2022, Hitesh Kumar Saini <saini123hitesh@gmail.com>.
/// All rights reserved.
///
/// Use of this source code is governed by the End-User License Agreement for Harmonoid that can be found in the EULA.txt file.
///

part of 'media.dart';

class Artist extends Media {
  final String artistName;
  final HashSet<Track> tracks = HashSet<Track>();
  final HashSet<Album> albums = HashSet<Album>();

  @override
  Map<String, dynamic> toJson() => {
        'artistName': artistName,
        'albums': albums.map((album) => album.toJson()).toList(),
        'tracks': tracks.map((track) => track.toJson()).toList(),
      };

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        artistName: json['artistName'] ?? kUnknownArtist,
      )
        ..tracks.addAll(
            json['tracks']?.map((e) => Track.fromJson(e))?.cast<Track>() ?? [])
        ..albums.addAll(
            json['albums']?.map((e) => Album.fromJson(e))?.cast<Album>() ?? []);

  Artist({
    required this.artistName,
  });

  @override
  bool operator ==(Object media) {
    if (media is Artist) {
      return media.artistName == artistName;
    }
    throw FormatException();
  }

  @override
  int get hashCode => artistName.hashCode;

  DateTime get timeAdded => tracks.reduce((value, element) {
        if (element.timeAdded.millisecondsSinceEpoch >
            value.timeAdded.millisecondsSinceEpoch) return value;
        return element;
      }).timeAdded;
}