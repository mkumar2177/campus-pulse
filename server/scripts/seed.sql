INSERT INTO campus_event
  (title, category, description, "organizerId", venue, "dateTime", capacity, cancelled)
VALUES
  ('Campus Hack Night', 'Hackathon',
   'Build a working prototype with your team in one evening.',
   'organizer-a', 'Lab 2', '2026-11-01 18:00:00+05:30', 50, false),
  ('DSA Study Workshop', 'Workshop',
   'Practice interview patterns with guided peer exercises.',
   'organizer-a', 'Hall B', '2026-11-02 11:00:00+05:30', 30, false),
  ('Open Mic Night', 'Clubs',
   'An evening for music, poetry, and campus stories.',
   'organizer-a', 'Auditorium', '2026-11-09 18:00:00+05:30', 80, false)
ON CONFLICT DO NOTHING;

INSERT INTO profile ("userId", subjects, goal, availability, "visibleToMatches")
VALUES
  ('student-a', '["DSA", "Web Dev"]', 'Placement preparation',
   '["Saturday afternoon", "Sunday morning"]', true),
  ('student-b', '["DSA", "ML"]', 'Placement preparation',
   '["Saturday afternoon", "Monday evening"]', true),
  ('student-c', '["Web Dev", "Design"]', 'Exam revision',
   '["Saturday afternoon"]', true)
ON CONFLICT ("userId") DO NOTHING;

INSERT INTO registration ("eventId", "userId", status)
VALUES ('hack-night', 'student-a', 'registered')
ON CONFLICT ("eventId", "userId") DO NOTHING;

INSERT INTO match_request ("fromUserId", "toUserId", status)
VALUES ('student-a', 'student-b', 'pending')
ON CONFLICT ("fromUserId", "toUserId") DO NOTHING;
