import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_examen/File/TachePage.dart';

class TacheService {
  final CollectionReference tacheCollection =
      FirebaseFirestore.instance.collection('tasks');

  // Ajout d'une tâche
  Future<void> addTask(String title, String description) async {
    await tacheCollection.add({
      'title': title,
      'description': description,
      'isCompleted': false,
    });
  }

  // Récupération de l'ensemble les tâches en temps réel
  Stream<List<Tache>> getTache() {
    return tacheCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Tache.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Mettre à jour d'une tâche
  Future<void> updateTache(String tacheId, bool isCompleted) async {
    await tacheCollection.doc(tacheId).update({'isCompleted': isCompleted});
  }

  //Mettre à jour le titre et la description d'une tâche
  void updateTacheDetails(String id, String newTitle, String newDescription) {
    FirebaseFirestore.instance.collection('tasks').doc(id).update({
      'title': newTitle,
      'description': newDescription,
    });
  }

  // Suppression d'une tâche
  Future<void> deleteTache(String tacheId) async {
    await tacheCollection.doc(tacheId).delete();
  }
}
