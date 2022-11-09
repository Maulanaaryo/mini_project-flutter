import 'package:flutter/material.dart';
import 'package:mini_project_alterra/data/db/database_catatan.dart';
import 'package:mini_project_alterra/data/models/movie_review.dart';

class MovieReviewProvider extends ChangeNotifier {

  List<ReviewModel> _reviewModel = [];
  late DatabaseHelperReview _dbHelperReview;

  List<ReviewModel> get reviews => _reviewModel;

  // mengimplementasi state management untuk mengakses data dari database
  MovieReviewProvider() {
    _dbHelperReview = DatabaseHelperReview();
    _getAllNotes();
  }

  // mendapatkan data notes dari database ketika pertama kali objek DbProvider dibuat
  void _getAllNotes() async {
    _reviewModel = await _dbHelperReview.getReview();
    notifyListeners();
  }

  // menambahkan data ke dalam database
  Future<void> addReview(ReviewModel reviewModel) async {
    await _dbHelperReview.insertReview(reviewModel);
    _getAllNotes();
  }

  // mengembalikan data berdasarkan id-nya
  Future<ReviewModel> getReviewById(int id) async {
    return await _dbHelperReview.getReviewById(id);
  }

  // metode untuk memperbarui dan menghapus data
  void updateNote(ReviewModel reviewModel) async {
    await _dbHelperReview.updateReview(reviewModel);
    _getAllNotes();
  }

  void deleteNote(int id) async {
    await _dbHelperReview.deleteReview(id);
    _getAllNotes();
  }
}