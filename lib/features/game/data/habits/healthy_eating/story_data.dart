import 'package:flutter/material.dart';
import '../../models.dart';

final List<StoryScene> healthyEatingScenes = [
  StoryScene(
    id: 'breakfast',
    roomGradient: [Color(0xFF1C0505), Color(0xFF2D0808), Color(0xFF4A0E0E), Color(0xFF1C0505)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Good morning! Mango woke up feeling hungry. It was time for breakfast. In the kitchen, he saw two choices on the counter. His tummy was growling, but which food would give him energy for the whole day?",
      es: '¡Buenos días! Mango se despertó sintiendo hambre. Era hora del desayuno. En la cocina, vio dos opciones sobre el mostrador. Su barriga gruñía, ¿pero cuál alimento le daría energía para todo el día?',
    ),
    question: BilingualText(en: 'What should Mango eat for breakfast?', es: '¿Qué debe comer Mango para el desayuno?'),
    options: [
      StoryOption(id: 'oatmealFruit', emoji: '🍓', label: BilingualText(en: 'Oatmeal with fruit', es: 'Avena con frutas'), correct: true,
        acknowledge: BilingualText(en: "Mango made a warm bowl of oatmeal topped with fresh berries. 'This will keep me going all morning!' he smiled.", es: 'Mango preparó un tazón caliente de avena cubierto con bayas frescas. "¡Esto me mantendrá activo toda la mañana!" sonrió.'),
        feedback: BilingualText(en: "Oatmeal with fruit gives you slow-burning energy that lasts for hours! Healthy breakfast foods help your brain think better at school.", es: '¡La avena con frutas te da energía de combustión lenta que dura horas! Los desayunos saludables ayudan a tu cerebro a pensar mejor en la escuela.')),
      StoryOption(id: 'candyBar', emoji: '🍬', label: BilingualText(en: 'Candy bar', es: 'Barra de dulce'), correct: false,
        acknowledge: BilingualText(en: "Mango unwrapped the candy bar. But the sugar rush wouldn't last—he'd be hungry and tired by 9am!", es: 'Mango desenvolvió la barra de dulce. ¡Pero el impulso de azúcar no duraría: ¡estaría hambriento y cansado para las 9am!'),
        feedback: BilingualText(en: "Candy for breakfast causes a sugar crash! Your brain needs real nutrients to focus and learn. Save sweets for occasional treats.", es: 'El dulce para el desayuno causa un bajón de azúcar. ¡Tu cerebro necesita nutrientes reales para concentrarse y aprender! Guarda los dulces para ocasiones especiales.')),
    ],
    tip: BilingualText(en: 'Eat a nutritious breakfast to fuel your brain and body', es: 'Come un desayuno nutritivo para nutrir tu cerebro y cuerpo'),
  ),
  StoryScene(
    id: 'snack',
    roomGradient: [Color(0xFF260808), Color(0xFF3D0E0E), Color(0xFF6B1818), Color(0xFF260808)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "After school, Mango's tummy was rumbling. Snack time! He opened the fridge and the pantry. On one side was a crisp red apple and some peanut butter. On the other was a shiny bag of chips.",
      es: 'Después de la escuela, la barriga de Mango gruñía. ¡Hora del refrigerio! Abrió el refrigerador y la despensa. A un lado había una manzana roja crujiente y mantequilla de cacahuate. Al otro, una bolsa brillante de papas fritas.',
    ),
    question: BilingualText(en: 'What should Mango choose for his snack?', es: '¿Qué debe elegir Mango para su refrigerio?'),
    options: [
      StoryOption(id: 'applePeanut', emoji: '🍎', label: BilingualText(en: 'Apple with peanut butter', es: 'Manzana con mantequilla de cacahuate'), correct: true,
        acknowledge: BilingualText(en: "Mango sliced the apple and dipped it in peanut butter. 'Crunchy and delicious!' he said with a grin.", es: 'Mango cortó la manzana y la mojó en mantequilla de cacahuate. "¡Crujiente y deliciosa!" dijo con una sonrisa.'),
        feedback: BilingualText(en: "Fruits and nuts give you healthy energy! The apple provides vitamins and fiber, while peanut butter adds protein to keep you full longer.", es: 'Las frutas y nueces te dan energía saludable. La manzana aporta vitaminas y fibra, mientras que la mantequilla de cacahuate añade proteína para mantenerte lleno más tiempo.')),
      StoryOption(id: 'chips', emoji: '🥔', label: BilingualText(en: 'Bag of chips', es: 'Bolsa de papas fritas'), correct: false,
        acknowledge: BilingualText(en: "Mango grabbed the chips. They tasted good but were full of salt and had almost no nutrients!", es: '¡Mango agarró las papas fritas. Sabían bien pero estaban llenas de sal y tenían casi ningún nutriente!'),
        feedback: BilingualText(en: "Chips are tasty but don't give your body what it needs to grow strong. Choose snacks with real ingredients like fruit, veggies, or nuts!", es: 'Las papas fritas son sabrosas pero no le dan a tu cuerpo lo que necesita para crecer fuerte. ¡Elige refrigerios con ingredientes reales como frutas, verduras o nueces!')),
    ],
    tip: BilingualText(en: 'Choose fruit and nuts for a healthy snack', es: 'Elige frutas y nueces para un refrigerio saludable'),
  ),
  StoryScene(
    id: 'lunchbox',
    roomGradient: [Color(0xFF1C0808), Color(0xFF300D0D), Color(0xFF501515), Color(0xFF1C0808)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "It was Sunday night and Mango was packing his lunchbox for school. He stood in front of the kitchen, thinking about what to put inside. A healthy mix? Or just the things he loved the most?",
      es: 'Era el domingo por la noche y Mango estaba empacando su fiambrera para la escuela. Estaba frente a la cocina, pensando qué meter adentro. ¿Una mezcla saludable? ¿O solo las cosas que más le gustaban?',
    ),
    question: BilingualText(en: 'How should Mango fill his lunchbox?', es: '¿Cómo debe llenar Mango su fiambrera?'),
    options: [
      StoryOption(id: 'veggiesSandwich', emoji: '🥗', label: BilingualText(en: 'Veggies & sandwich', es: 'Verduras y sándwich'), correct: true,
        acknowledge: BilingualText(en: "Mango packed colorful veggies, a turkey sandwich, and a piece of fruit. His lunchbox looked like a rainbow!", es: 'Mango empacó verduras coloridas, un sándwich de pavo y una fruta. ¡Su fiambrera parecía un arcoíris!'),
        feedback: BilingualText(en: "A colorful lunch means lots of different nutrients! Try to eat every color of the rainbow throughout your day—each color has special benefits!", es: '¡Un almuerzo colorido significa muchos nutrientes diferentes! Intenta comer cada color del arcoíris durante tu día. ¡Cada color tiene beneficios especiales!')),
      StoryOption(id: 'cookiesChips', emoji: '🍪', label: BilingualText(en: 'Just cookies & chips', es: 'Solo galletas y papas fritas'), correct: false,
        acknowledge: BilingualText(en: "Mango packed only cookies and chips. They tasted amazing but his body wouldn't get the fuel it needed!", es: 'Mango empacó solo galletas y papas fritas. ¡Sabían increíble pero su cuerpo no obtendría el combustible que necesitaba!'),
        feedback: BilingualText(en: "A lunch with only snack foods leaves your body without the proteins, vitamins, and fiber it needs to grow and stay healthy!", es: 'Un almuerzo con solo bocadillos deja a tu cuerpo sin las proteínas, vitaminas y fibra que necesita para crecer y mantenerse sano.')),
    ],
    tip: BilingualText(en: 'Pack a colorful lunchbox with different food groups', es: 'Empaca una fiambrera colorida con diferentes grupos de alimentos'),
  ),
  StoryScene(
    id: 'dinner',
    roomGradient: [Color(0xFF1C0606), Color(0xFF300B0B), Color(0xFF501212), Color(0xFF1C0606)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Dinner was on the table! Mango's plate had a yummy piece of chicken, rice, and... broccoli. He poked at the green trees with his fork. 'Do I have to eat the broccoli?' he sighed.",
      es: 'La cena estaba en la mesa. El plato de Mango tenía un sabroso trozo de pollo, arroz y... brócoli. Pinchó los arbolitos verdes con su tenedor. "¿Tengo que comer el brócoli?" suspiró.',
    ),
    question: BilingualText(en: 'What should Mango do with the vegetables?', es: '¿Qué debe hacer Mango con las verduras?'),
    options: [
      StoryOption(id: 'eatVeggies', emoji: '🥦', label: BilingualText(en: 'Eat the veggies', es: 'Comer las verduras'), correct: true,
        acknowledge: BilingualText(en: "Mango took a bite of broccoli. 'Hey, it's not so bad with the chicken!' he discovered. He cleared his whole plate!", es: 'Mango dio un mordisco de brócoli. "¡Oye, no está tan mal con el pollo!" descubrió. ¡Limpió todo su plato!'),
        feedback: BilingualText(en: "Vegetables give your body powerful vitamins and minerals! Try eating them with other foods you like—they might taste better that way!", es: '¡Las verduras le dan a tu cuerpo poderosas vitaminas y minerales! Intenta comerlas con otros alimentos que te gusten, ¡puede que sepan mejor así!')),
      StoryOption(id: 'pushAway', emoji: '😒', label: BilingualText(en: 'Push them away', es: 'Empujarlas lejos'), correct: false,
        acknowledge: BilingualText(en: "Mango pushed the broccoli to the edge of his plate. But his body missed out on all those important vitamins!", es: 'Mango empujó el brócoli al borde de su plato. ¡Pero su cuerpo se perdió todas esas vitaminas importantes!'),
        feedback: BilingualText(en: "Vegetables like broccoli are full of vitamins that help you grow strong and fight off colds. Give them a chance—you might discover a new favorite!", es: 'Las verduras como el brócoli están llenas de vitaminas que te ayudan a crecer fuerte y combatir los resfriados. ¡Dales una oportunidad, podrías descubrir un nuevo favorito!')),
    ],
    tip: BilingualText(en: 'Try to eat vegetables at every meal', es: 'Intenta comer verduras en cada comida'),
  ),
];

const StoryStrings healthyEatingStrings = StoryStrings(
  title: BilingualText(en: "Mango's Rainbow\nPlate", es: 'El Plato Arcoíris\nde Mango'),
  subtitle: BilingualText(en: "Help Mango make healthy food choices!", es: '¡Ayuda a Mango a hacer elecciones de comida saludables!'),
  startButton: BilingualText(en: "Let's Go!", es: '¡Vamos!'),
  endingTitle: BilingualText(en: "Yummy & Healthy, Mango!", es: '¡Sabroso y Saludable, Mango!'),
  endingSubtitle: BilingualText(en: "Mango learned to eat healthy! Here's what we learned:", es: '¡Mango aprendió a comer sano! Esto es lo que aprendimos:'),
  playAgain: BilingualText(en: 'Play Again', es: 'Jugar de Nuevo'),
  backToHabits: BilingualText(en: 'Back to Habits', es: 'Volver a Hábitos'),
  back: BilingualText(en: 'Back', es: 'Volver'),
  goodJob: BilingualText(en: 'Great choice!', es: '¡Gran elección!'),
  tryAgain: BilingualText(en: 'Hmm, not quite...', es: 'Hmm, no exactamente...'),
  next: BilingualText(en: 'Next', es: 'Siguiente'),
  finish: BilingualText(en: 'Finish', es: 'Terminar'),
  retry: BilingualText(en: 'Try Again', es: 'Intentar de nuevo'),
);
