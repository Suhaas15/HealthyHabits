const String _characterPrefix =
    'A cute cartoon blue water droplet character — teardrop body shape, big shiny eyes, '
    'a wide friendly smile, tiny arms and legs. '
    "Children's book illustration style, soft watercolor-like colors, bright and cheerful. ";

const Map<String, String> hydrationImagePrompts = {
  'wakeup_drinkWater': _characterPrefix + 'The water droplet character drinks from a large glass of clear water in the morning, looking refreshed and happy. Bright sunny bedroom.',
  'wakeup_grabSoda': _characterPrefix + 'The water droplet character reaches for a fizzy soda can, looking a bit uncertain. Colorful bubbles and sugary packaging.',
  'playing_waterBottle': _characterPrefix + 'The water droplet character drinks from a water bottle outdoors on a sunny day, arms raised, looking energized and joyful.',
  'playing_juiceBox': _characterPrefix + 'The water droplet character holds a juice box while playing outside. Colorful but small juice box with lots of sugar labels.',
  'lunch_water': _characterPrefix + 'The water droplet character sits at a lunch table and chooses a big glass of water alongside a healthy sandwich. Happy and focused.',
  'lunch_sugaryDrink': _characterPrefix + 'The water droplet character reaches for a bright colorful sugary drink at the lunch table. Lots of sugar and artificial colors.',
  'exercise_drinkFirst': _characterPrefix + 'The water droplet character drinks water before gymnastics class, looking strong and ready to go. Sporty, energetic scene.',
  'exercise_skip': _characterPrefix + 'The water droplet character tries to exercise without water and looks dizzy and tired, holding their head. No water bottle nearby.',
};

const String hydrationEndingPrompt = _characterPrefix +
    'The water droplet character stands happily next to a tall glass of water and a colorful water bottle, '
    'arms raised in celebration. Bright sunny background. Health and energy radiate from the scene.';
