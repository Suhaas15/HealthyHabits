import 'package:flutter/material.dart';
import '../../models.dart';

final List<StoryScene> hydrationScenes = [
  StoryScene(
    id: 'wakeup',
    roomGradient: [Color(0xFF38BDF8), Color(0xFF06B6D4), Color(0xFF67E8F9), Color(0xFF38BDF8)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Droppy woke up feeling very thirsty. Her mouth was dry and her tummy was rumbling. 'I need something to drink right away!' she said, jumping out of bed.",
      es: 'Droppy se despertó sintiéndose muy sedienta. Su boca estaba seca y su barriguita gruñía. "¡Necesito algo de beber ahora mismo!" dijo, saltando de la cama.',
    ),
    question: BilingualText(en: 'What should Droppy drink first thing in the morning?', es: '¿Qué debe beber Droppy a primera hora de la mañana?'),
    options: [
      StoryOption(id: 'drinkWater', emoji: '💧', label: BilingualText(en: 'Drink water', es: 'Beber agua'), correct: true,
        acknowledge: BilingualText(en: "Droppy grabbed her water bottle and took a big refreshing sip. 'Ahh, that's exactly what I needed!'", es: 'Droppy agarró su botella de agua y tomó un gran sorbo refrescante. "¡Ahh, eso es exactamente lo que necesitaba!"'),
        feedback: BilingualText(en: "Water is the best drink when you wake up! Your body loses water while you sleep, so drinking water first thing rehydrates you.", es: '¡El agua es la mejor bebida al despertar! Tu cuerpo pierde agua mientras duermes, así que beber agua primero te rehidrata.')),
      StoryOption(id: 'grabSoda', emoji: '🥤', label: BilingualText(en: 'Grab a soda', es: 'Agarrar un refresco'), correct: false,
        acknowledge: BilingualText(en: "Droppy reached for the soda. But sugary drinks don't properly hydrate your body!", es: 'Droppy alcanzó el refresco. ¡Pero las bebidas azucaradas no hidratan bien tu cuerpo!'),
        feedback: BilingualText(en: "Soda has lots of sugar that's not good for your teeth or body. Water is always the best choice to rehydrate!", es: 'Los refrescos tienen mucha azúcar que no es buena para tus dientes ni tu cuerpo. ¡El agua siempre es la mejor opción para hidratarte!')),
    ],
    tip: BilingualText(en: 'Start every morning with a big glass of water', es: 'Empieza cada mañana con un gran vaso de agua'),
  ),
  StoryScene(
    id: 'playing',
    roomGradient: [Color(0xFF3B82F6), Color(0xFF60A5FA), Color(0xFF7DD3FC), Color(0xFF3B82F6)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Droppy was playing outside on a sunny day. She was running and jumping and having so much fun! Soon she felt hot and her mouth was getting dry again.",
      es: 'Droppy estaba jugando afuera en un día soleado. Corría y saltaba y se divertía mucho. ¡Pronto se sintió acalorada y su boca se secaba de nuevo!',
    ),
    question: BilingualText(en: 'What should Droppy drink when playing outside?', es: '¿Qué debe beber Droppy cuando juega afuera?'),
    options: [],
    sceneType: SceneType.tapCollect,
    completionEmoji: '🍶',
    tapItems: [
      TapItem(emoji: '💧', label: BilingualText(en: 'Water', es: 'Agua'), isHealthy: true),
      TapItem(emoji: '🍎', label: BilingualText(en: 'Juicy fruit', es: 'Fruta jugosa'), isHealthy: true),
      TapItem(emoji: '🍵', label: BilingualText(en: 'Herbal tea', es: 'Té de hierbas'), isHealthy: true),
      TapItem(emoji: '🥤', label: BilingualText(en: 'Soda', es: 'Refresco'), isHealthy: false),
      TapItem(emoji: '☕', label: BilingualText(en: 'Coffee', es: 'Café'), isHealthy: false),
      TapItem(emoji: '🍬', label: BilingualText(en: 'Candy', es: 'Dulces'), isHealthy: false),
    ],
    tip: BilingualText(en: 'Carry a water bottle when playing outside', es: 'Lleva una botella de agua cuando juegas afuera'),
  ),
  StoryScene(
    id: 'lunch',
    roomGradient: [Color(0xFF06B6D4), Color(0xFF38BDF8), Color(0xFFA5F3FC), Color(0xFF06B6D4)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Lunchtime! Droppy sat down to eat her favorite sandwich. She looked at the drinks on the table—a glass of cold water and a colorful sugary drink. 'Hmm, what should I pick?' she wondered.",
      es: '¡Hora del almuerzo! Droppy se sentó a comer su sándwich favorito. Miró las bebidas sobre la mesa: un vaso de agua fría y una bebida azucarada colorida. "Hmm, ¿qué debo elegir?" se preguntó.',
    ),
    question: BilingualText(en: 'What should Droppy drink with her lunch?', es: '¿Qué debe beber Droppy con su almuerzo?'),
    options: [],
    sceneType: SceneType.sorting,
    completionEmoji: '💧',
    sortingSteps: [
      SortingStep(emoji: '🪑', text: BilingualText(en: 'Sit down at the table', es: 'Sentarse en la mesa')),
      SortingStep(emoji: '🥛', text: BilingualText(en: 'Pour a glass of water', es: 'Servir un vaso de agua')),
      SortingStep(emoji: '🥪', text: BilingualText(en: 'Eat your meal slowly', es: 'Comer despacio')),
      SortingStep(emoji: '💧', text: BilingualText(en: 'Refill water if thirsty', es: 'Rellenar agua si tienes sed')),
    ],
    tip: BilingualText(en: 'Choose water with every meal', es: 'Elige agua con cada comida'),
  ),
  StoryScene(
    id: 'exercise',
    roomGradient: [Color(0xFF29B6F6), Color(0xFF4FC3F7), Color(0xFFB3E5FC), Color(0xFF29B6F6)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Droppy was about to start her gymnastics class! She was so excited she ran straight to the mat. 'Wait!' called her coach. 'Did you drink water before exercising?'",
      es: '¡Droppy estaba a punto de empezar su clase de gimnasia! Estaba tan emocionada que corrió directamente al tapete. "¡Espera!" llamó su entrenadora. "¿Bebiste agua antes de hacer ejercicio?"',
    ),
    question: BilingualText(en: 'What should Droppy do before exercising?', es: '¿Qué debe hacer Droppy antes de hacer ejercicio?'),
    options: [
      StoryOption(id: 'drinkFirst', emoji: '💪', label: BilingualText(en: 'Drink water first', es: 'Beber agua primero'), correct: true,
        acknowledge: BilingualText(en: "Droppy drank a big cup of water before starting. She felt strong and ready! 'Now I can do my best!'", es: 'Droppy bebió un gran vaso de agua antes de empezar. ¡Se sintió fuerte y lista! "¡Ahora puedo dar lo mejor de mí!"'),
        feedback: BilingualText(en: "Drinking water before exercise keeps your muscles working well and prevents cramps. Stay hydrated to perform your best!", es: 'Beber agua antes del ejercicio mantiene tus músculos funcionando bien y previene calambres. ¡Mantente hidratado para dar lo mejor!')),
      StoryOption(id: 'skip', emoji: '🏃', label: BilingualText(en: 'Skip and start', es: 'Saltarlo y empezar'), correct: false,
        acknowledge: BilingualText(en: "Droppy skipped the water and started exercising. Soon she felt dizzy and had to stop. Oh no!", es: 'Droppy se saltó el agua y empezó a hacer ejercicio. Pronto se sintió mareada y tuvo que parar. ¡Oh no!'),
        feedback: BilingualText(en: "Without enough water, your body can't exercise well. You might get cramps or feel dizzy. Always hydrate before working out!", es: 'Sin suficiente agua, tu cuerpo no puede hacer ejercicio bien. Puedes tener calambres o marearte. ¡Siempre hidrátate antes de hacer ejercicio!')),
    ],
    tip: BilingualText(en: 'Always drink water before and after exercise', es: 'Siempre bebe agua antes y después del ejercicio'),
  ),
];

const StoryStrings hydrationStrings = StoryStrings(
  title: BilingualText(en: "Droppy's Thirsty\nQuest", es: 'La Búsqueda\nSedienta de Droppy'),
  subtitle: BilingualText(en: "Help Droppy stay hydrated all day!", es: '¡Ayuda a Droppy a mantenerse hidratada todo el día!'),
  startButton: BilingualText(en: "Let's Go!", es: '¡Vamos!'),
  endingTitle: BilingualText(en: "Well Done, Droppy!", es: '¡Bien Hecho, Droppy!'),
  endingSubtitle: BilingualText(en: "Droppy stayed hydrated and healthy! Here's what we learned:", es: '¡Droppy se mantuvo hidratada y saludable! Esto es lo que aprendimos:'),
  playAgain: BilingualText(en: 'Play Again', es: 'Jugar de Nuevo'),
  backToHabits: BilingualText(en: 'Back to Habits', es: 'Volver a Hábitos'),
  back: BilingualText(en: 'Back', es: 'Volver'),
  goodJob: BilingualText(en: 'Great choice!', es: '¡Gran elección!'),
  tryAgain: BilingualText(en: 'Hmm, not quite...', es: 'Hmm, no exactamente...'),
  next: BilingualText(en: 'Next', es: 'Siguiente'),
  finish: BilingualText(en: 'Finish', es: 'Terminar'),
  retry: BilingualText(en: 'Try Again', es: 'Intentar de nuevo'),
);
