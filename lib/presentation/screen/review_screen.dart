import 'package:flutter/material.dart';
import 'package:mini_project_alterra/presentation/providers/movie_review.dart';
import 'package:mini_project_alterra/widgets/custom_review.dart';
import 'package:provider/provider.dart';

class ReviewListScreen extends StatelessWidget {
  static const routeName = '/review';
  const ReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Consumer<MovieReviewProvider>(
        builder: (context, provider, child) {
          final notes = provider.reviews;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Dismissible(
                key: Key(note.id.toString()),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  provider.deleteNote(note.id!);
                },
                child: Card(
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.descrption),
                    onTap: () async {

                      final navigator = Navigator.of(context);
                      final selectedNote =
                          await provider.getReviewById(note.id!);

                      navigator.push(
                        MaterialPageRoute(
                          builder: (context) {
                            return NoteAddUpdatePage(reviewModel: selectedNote);
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoteAddUpdatePage()));
        },
      ),
    );
  }
}
