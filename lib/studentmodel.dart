class Student{
  String? uid;
  String? name;
  String? surname;
  int? rollno;
  Student({
    this.name,this.rollno,this.surname,this.uid
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Student && runtimeType == other.runtimeType && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}