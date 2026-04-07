  const List<String> weekDays = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

class DoctorModel {
  final String Speciality;
  // final String image;
  final String location;
  final double rating;
  final int phoneNumber;
  final int reviewCount;
  final String bio;
  final int yearsExperience;
   bool isComplete;
   Map<String,List<Map<String,dynamic>>>weeklySchedule;
  DoctorModel( {Map<String,List<Map<String,dynamic>>>?weeklySchedule,this.isComplete=false,required this.yearsExperience,required this.bio,this.reviewCount=0, required this.Speciality, required this.location, this.rating=0.0, required this.phoneNumber}): this.weeklySchedule = weeklySchedule ?? {
          'Sat': [], 'Sun': [], 'Mon': [], 'Tue': [],
          'Wed': [], 'Thu': [], 'Fri': [],
        };
  factory DoctorModel.fromMap(Map<String ,dynamic>map){
        var savedSchedule = map['weeklySchedule'] as Map<String, dynamic>?;

  return DoctorModel( Speciality: map['Speciality'], isComplete: map['isComplete'],location: map['location'], rating: map['rating'], phoneNumber: map['phoneNumber'], reviewCount: map['reviewCount'], bio: map['bio'], yearsExperience: map['yearsExperience'],weeklySchedule: savedSchedule?.map((key, value) => 
          MapEntry(key, (value as List).map((e) => Map<String, dynamic>.from(e)).toList(),
            )) ?? {
          'Sat': [], 'Sun': [], 'Mon': [], 'Tue': [],
          'Wed': [], 'Thu': [], 'Fri': [],
        },);
}
Map<String ,dynamic>toMap(){
  return {
    'Speciality':Speciality,
    'location':location,
    'rating':rating,
    'phoneNumber':phoneNumber,
    'reviewCount':reviewCount,
    'bio':bio,
    'yearsExperience':yearsExperience,
    'isComplete':isComplete,
     'weeklySchedule': weeklySchedule,

  };
}
}
