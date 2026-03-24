class Cau3Model {
  Map<String, bool> interests = {
    'Phim ảnh (Movies)': false,
    'Thể thao (Sports)': false,
    'Âm nhạc (Music)': false,
    'Du lịch (Travel)': false,
  };
  String satisfaction = 'Neutral';
  String notes = "";

  bool get isCheckboxValid => interests.values.any((e) => e);
}