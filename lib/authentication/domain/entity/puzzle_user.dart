import 'package:equatable/equatable.dart';

class PuzzleUser extends Equatable {
  final String id;
  final String name;
  final String photoUrl;

  const PuzzleUser({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  factory PuzzleUser.empty() {
    return const PuzzleUser(id: "", name: "", photoUrl: "");
  }

  @override
  List<Object?> get props => [id, name, photoUrl];
}
