const String _characterPrefix =
    'A cute cartoon green robot character — round body, big round glowing screen eyes, '
    'a small antenna with a glowing star tip, tiny metallic hands and feet. '
    "Children's book illustration style, soft watercolor-like colors, warm and friendly. ";

const Map<String, String> screenTimeImagePrompts = {
  'screenLong_takeBreak': _characterPrefix + 'The green robot sits away from all screens with eyes peacefully closed, taking a calm break. Soft warm light, relaxed expression.',
  'screenLong_keepPlaying': _characterPrefix + 'The green robot hunches over a glowing video game controller, eyes red and strained, bright screen blasting light on their face. Looks exhausted.',
  'outdoor_goOutside': _characterPrefix + 'The green robot plays happily outside in a sunny garden with family, arms wide open, laughing. Green trees and bright blue sky.',
  'outdoor_stayTablet': _characterPrefix + 'The green robot sits alone inside staring at a tablet screen, while through the window sunlight and family playing outside are visible.',
  'bedtime_putAway': _characterPrefix + 'The green robot gently places a tablet on a charger and snuggles into a cozy bed with eyes closed. Dark room with a soft night light.',
  'bedtime_keepWatching': _characterPrefix + 'The green robot lies in bed wide-eyed, face lit up by a bright glowing screen in a dark room, looking very tired but unable to stop.',
  'posture_stretch': _characterPrefix + 'The green robot sits up tall and straight, holding a phone at eye level, shoulders back, looking comfortable and healthy.',
  'posture_hunch': _characterPrefix + 'The green robot hunches way over a phone with head drooping down, neck bent awkwardly, looking uncomfortable and pained.',
};

const String screenTimeEndingPrompt = _characterPrefix +
    'The green robot sits happily at a tidy desk with screens off, holding a book and smiling brightly. '
    'A window shows sunshine outside. Cheerful, healthy, balanced scene.';
