const String _characterPrefix =
    'A cute cartoon teddy bear character — soft brown fur, round body, small black '
    'button eyes, a tiny dark nose, wearing a tiny blue nightcap. Children\'s book '
    'illustration style, soft watercolor-like colors, warm and friendly. '
    'The bedroom has a wooden bed with a purple blanket, a window showing the night '
    'sky with a crescent moon, a small nightstand with a lamp, and a bookshelf. ';

const Map<String, String> sleepImagePrompts = {
  'awake_book': _characterPrefix +
      'The teddy bear sits on the bed reading a picture book with a calm, happy expression. The room is softly lit and peaceful.',
  'awake_tablet': _characterPrefix +
      'The teddy bear sits on the bed staring at a glowing tablet screen, looking wide-eyed and excited. Bright light from the screen illuminates the dark room.',
  'bright_lightsOff': _characterPrefix +
      'The teddy bear is in a cozy dark room lit only by moonlight from the window. The lamp is off. The teddy looks relaxed and sleepy with half-closed eyes.',
  'bright_lightsOn': _characterPrefix +
      'The teddy bear squints and covers its eyes with its paws. The room is very brightly lit with harsh white light from multiple lamps. The teddy looks uncomfortable.',
  'teeth_brush': _characterPrefix +
      'The teddy bear stands in a bathroom brushing its teeth with a small toothbrush, looking happy and clean. Soft night light. Cozy bedtime scene.',
  'teeth_skip': _characterPrefix +
      'The teddy bear lies in bed with a guilty expression, as if it forgot something. The room is dark. A toothbrush sits unused on the nightstand.',
  'bedtime_sleep': _characterPrefix +
      'The teddy bear is peacefully getting into bed, pulling up the purple blanket, eyes half-closed with sleepiness. The room is dark and cozy.',
  'bedtime_tv': _characterPrefix +
      'The teddy bear sits on the edge of the bed staring at a glowing TV screen in the distance, looking wide-eyed and awake. The room is dim.',
};

const String sleepEndingPrompt = _characterPrefix +
    'The teddy bear is peacefully sleeping in the wooden bed under the purple blanket, hugging a small white bunny. '
    'Zzz symbols float above. The room is dark and peaceful with moonlight streaming through the window.';
