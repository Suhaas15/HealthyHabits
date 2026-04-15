const String _characterPrefix =
    'A cute cartoon yellow duck character — fluffy round body, rosy cheeks, a little orange beak, '
    'a tiny white sailor cap, small soap bubbles floating around them, tiny wings. '
    "Children's book illustration style, soft watercolor-like colors, cheerful and clean. ";

const Map<String, String> hygieneImagePrompts = {
  'beforeEating_washHands': _characterPrefix + 'The yellow duck stands at a sink washing hands with soap and water, surrounded by soap bubbles, big happy smile. Clean kitchen scene.',
  'beforeEating_skipWashing': _characterPrefix + 'The yellow duck reaches directly for a sandwich with dirty hands, looking unconcerned. A garden mud patch visible in the background.',
  'sneeze_coverAndWash': _characterPrefix + 'The yellow duck covers a sneeze with their wing/elbow, then walks toward a sink to wash hands. Responsible, hygiene-conscious expression.',
  'sneeze_nothing': _characterPrefix + 'The yellow duck sneezes openly without covering, tiny germ droplets visible in the air around them. Classmates in the background looking concerned.',
  'muddy_takeBath': _characterPrefix + 'The yellow duck sits happily in a bubbly bathtub, scrubbing off mud, surrounded by soap suds. Warm cozy bathroom, delighted expression.',
  'muddy_stayDirty': _characterPrefix + 'The yellow duck stands covered in dried mud, looking itchy and uncomfortable. Scratching at their feathers, looking unhappy.',
  'morning_brushBoth': _characterPrefix + 'The yellow duck stands at a bathroom mirror brushing teeth with a toothbrush, one hand combing feathers, looking neat and ready. Morning light.',
  'morning_rush': _characterPrefix + 'The yellow duck rushes out the door still looking messy—unbrushed, hair wild—looking rushed and flustered. School bag on back.',
};

const String hygieneEndingPrompt = _characterPrefix +
    'The yellow duck stands proudly clean and shiny, surrounded by floating soap bubbles and sparkles. '
    'Toothbrush in hand, hair neatly combed. A gleaming badge of cleanliness on their chest. Bright cheerful background.';
