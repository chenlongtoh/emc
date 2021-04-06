const double CARD_HEIGHT = 80;
const double CARD_WIDTH = 190;

const List<String> SCHEDULE_LABELS = [
  "9: 00",
  "10: 00",
  "11: 00",
  "12: 00",
  "2: 00",
  "3: 00",
  "4: 00",
  "5: 00",
];

enum ScheduleStatus {
  booked,
  pending,
  blocked,
}