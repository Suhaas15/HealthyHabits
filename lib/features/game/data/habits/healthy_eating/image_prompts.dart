const String _characterPrefix =
    'A cute cartoon brown monkey character — round face, big warm eyes, a wide grin, '
    'wearing a tiny white chef hat, holding or surrounded by colorful fruits and vegetables. '
    "Children's book illustration style, soft watercolor-like colors, warm and cheerful. ";

const Map<String, String> healthyEatingImagePrompts = {
  'breakfast_oatmealFruit': _characterPrefix + 'The monkey sits at a breakfast table with a warm bowl of oatmeal topped with colorful berries and bananas, looking delighted. Sunny morning kitchen.',
  'breakfast_candyBar': _characterPrefix + 'The monkey holds up a candy bar for breakfast, looking tempted but uncertain. Colorful wrapper, bright sugary packaging. Kitchen background.',
  'snack_applePeanut': _characterPrefix + 'The monkey dips apple slices into a jar of peanut butter, smiling happily. Colorful healthy snack spread on a table. Afternoon light.',
  'snack_chips': _characterPrefix + 'The monkey reaches into a big bag of chips, surrounded by crumbs. The snack looks tempting but nutritionally empty packaging.',
  'lunchbox_veggiesSandwich': _characterPrefix + 'The monkey packs a lunchbox filled with colorful vegetables, a sandwich, and a piece of fruit. The lunchbox looks like a rainbow. Proud expression.',
  'lunchbox_cookiesChips': _characterPrefix + 'The monkey packs a lunchbox full of only cookies and chips. The box looks tasty but unbalanced, no colors or vegetables.',
  'dinner_eatVeggies': _characterPrefix + 'The monkey sits at a dinner table eating broccoli with chicken and rice, looking pleasantly surprised at how good it tastes. Clean plate.',
  'dinner_pushAway': _characterPrefix + 'The monkey pushes broccoli to the edge of the plate, making a reluctant face. The vegetables look healthy and vibrant but untouched.',
};

const String healthyEatingEndingPrompt = _characterPrefix +
    'The monkey stands proudly behind a table full of colorful fruits and vegetables arranged in a rainbow pattern. '
    'Chef hat on, arms spread wide with joy. Confetti and stars float around. A bright, celebratory healthy eating scene.';
