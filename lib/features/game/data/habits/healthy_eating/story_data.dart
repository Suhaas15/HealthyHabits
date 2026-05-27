import 'package:flutter/material.dart';
import '../../models.dart';

final List<StoryScene> healthyEatingScenes = [
  StoryScene(
    id: 'breakfast',
    roomGradient: [Color(0xFFFF6B6B), Color(0xFFFFA07A), Color(0xFFFF85A1), Color(0xFFFF6B6B)],
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
    roomGradient: [Color(0xFFEF4444), Color(0xFFF97316), Color(0xFFFDA4AF), Color(0xFFEF4444)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "After school, Mango's tummy was rumbling. Snack time! He opened the fridge and the pantry. On one side was a crisp red apple and some peanut butter. On the other was a shiny bag of chips.",
      es: 'Después de la escuela, la barriga de Mango gruñía. ¡Hora del refrigerio! Abrió el refrigerador y la despensa. A un lado había una manzana roja crujiente y mantequilla de cacahuate. Al otro, una bolsa brillante de papas fritas.',
    ),
    question: BilingualText(en: 'What should Mango choose for his snack?', es: '¿Qué debe elegir Mango para su refrigerio?'),
    options: [],
    sceneType: SceneType.tapCollect,
    completionEmoji: '🍎',
    tapItems: [
      TapItem(emoji: '🍎', label: BilingualText(en: 'Apple', es: 'Manzana'), isHealthy: true),
      TapItem(emoji: '🥕', label: BilingualText(en: 'Carrot sticks', es: 'Palitos de zanahoria'), isHealthy: true),
      TapItem(emoji: '🥜', label: BilingualText(en: 'Nuts', es: 'Nueces'), isHealthy: true),
      TapItem(emoji: '🍟', label: BilingualText(en: 'French fries', es: 'Papas fritas'), isHealthy: false),
      TapItem(emoji: '🍪', label: BilingualText(en: 'Cookies', es: 'Galletas'), isHealthy: false),
      TapItem(emoji: '🥤', label: BilingualText(en: 'Soda', es: 'Refresco'), isHealthy: false),
    ],
    tip: BilingualText(en: 'Choose fruit and nuts for a healthy snack', es: 'Elige frutas y nueces para un refrigerio saludable'),
  ),
  StoryScene(
    id: 'lunchbox',
    roomGradient: [Color(0xFFFF7043), Color(0xFFFFAB40), Color(0xFFEC407A), Color(0xFFFF7043)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "It was Sunday night and Mango was packing his lunchbox for school. He stood in front of the kitchen, thinking about what to put inside. A healthy mix? Or just the things he loved the most?",
      es: 'Era el domingo por la noche y Mango estaba empacando su fiambrera para la escuela. Estaba frente a la cocina, pensando qué meter adentro. ¿Una mezcla saludable? ¿O solo las cosas que más le gustaban?',
    ),
    question: BilingualText(en: 'How should Mango fill his lunchbox?', es: '¿Cómo debe llenar Mango su fiambrera?'),
    options: [],
    sceneType: SceneType.sorting,
    completionEmoji: '🥗',
    sortingSteps: [
      SortingStep(emoji: '🥦', text: BilingualText(en: 'Pick a fruit or veggie', es: 'Elegir una fruta o verdura')),
      SortingStep(emoji: '🍗', text: BilingualText(en: 'Add a protein (chicken or beans)', es: 'Agregar proteína (pollo o frijoles)')),
      SortingStep(emoji: '🍞', text: BilingualText(en: 'Include a whole grain', es: 'Incluir un grano integral')),
      SortingStep(emoji: '💧', text: BilingualText(en: 'Pack water to drink', es: 'Empacar agua para beber')),
    ],
    tip: BilingualText(en: 'Pack a colorful lunchbox with different food groups', es: 'Empaca una fiambrera colorida con diferentes grupos de alimentos'),
  ),
  StoryScene(
    id: 'dinner',
    roomGradient: [Color(0xFFFF6B9D), Color(0xFFFF8C42), Color(0xFFFFD166), Color(0xFFFF6B9D)],
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
