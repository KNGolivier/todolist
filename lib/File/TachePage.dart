class Tache {
  String id;
  String title;
  String description;
  bool isCompleted;

  Tache({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  // Convertion d'un objet Tache en Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  // Créaction d'un objet Tache à partir d’un document Firestore
  factory Tache.fromMap(Map<String, dynamic> map, String documentId) {
    return Tache(
      id: documentId,
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'],
    );
  }
}
