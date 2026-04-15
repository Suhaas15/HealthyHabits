const String _characterPrefix =
    'A cute cartoon orange kangaroo character — round body, big warm eyes, a wide friendly smile, '
    'a tiny pouch with a little star inside, bouncy rounded ears, small hands. '
    "Children's book illustration style, soft watercolor-like colors, warm and energetic. ";

const Map<String, String> movementImagePrompts = {
  'afterSchool_playOutside': _characterPrefix + 'The kangaroo bounces and plays with a soccer ball in a sunny backyard, arms raised, huge smile. Bright green grass and sunshine.',
  'afterSchool_watchTv': _characterPrefix + 'The kangaroo lies slumped on a couch watching television, looking bored and sleepy. Dim room, still legs.',
  'rainy_danceJump': _characterPrefix + 'The kangaroo dances and jumps joyfully inside a living room with music notes floating around. Rain visible through the window, but character is having a blast.',
  'rainy_lieSofa': _characterPrefix + 'The kangaroo lies flat on a sofa staring at the ceiling looking very bored and sluggish. Rainy window in the background.',
  'park_walkThere': _characterPrefix + 'The kangaroo skips and bounces along a sunny path towards a park, tail wagging, arms swinging happily. Green trees line the path.',
  'park_drive': _characterPrefix + 'The kangaroo sits in the back seat of a car looking out the window at the park passing by. Missing out on the walk.',
  'wakeup_stretch': _characterPrefix + 'The kangaroo jumps out of bed and does big morning stretches with arms wide, looking bright and energized. Sunny morning light.',
  'wakeup_snooze': _characterPrefix + 'The kangaroo lies in bed with eyes half-closed, pressing the snooze button on an alarm clock. Blanket pulled over head, looking groggy.',
};

const String movementEndingPrompt = _characterPrefix +
    'The kangaroo stands triumphantly on a grassy hill with arms raised in celebration, '
    'surrounded by stars and sparkles. A bright sunny day. A golden medal hangs around their neck. Joyful and energetic!';
