import 'package:flutter/material.dart';
import 'package:mini_project_alterra/data/models/movie_review.dart';
import 'package:mini_project_alterra/providers/movie_review.dart';
import 'package:provider/provider.dart';

class NoteAddUpdatePage extends StatefulWidget {
  final ReviewModel? reviewModel;

  const NoteAddUpdatePage({Key? key, this.reviewModel})
      : super(key: key);

  @override
  State<NoteAddUpdatePage> createState() => _NoteAddUpdatePageState();
}

class _NoteAddUpdatePageState extends State<NoteAddUpdatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.reviewModel != null) {
      _titleController.text = widget.reviewModel!.title;
      _descriptionController.text = widget.reviewModel!.descrption;
      _isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Simpan'),
                onPressed: () async {
                  
                  if (!_isUpdate) {
                    final review = ReviewModel(
                        title: _titleController.text,
                        descrption: _descriptionController.text);
                    Provider.of<MovieReviewProvider>(context, listen: false)
                        .addReview(review);
                  } else {
                    final review = ReviewModel(
                      id: widget.reviewModel!.id,
                        title: _titleController.text,
                        descrption: _descriptionController.text);

                    Provider.of<MovieReviewProvider>(context, listen: false)
                        .updateNote(review);
                  }
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
