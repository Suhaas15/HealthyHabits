import 'package:flutter/material.dart';
import '../../models.dart';

final List<StoryScene> hygieneScenes = [
  StoryScene(
    id: 'beforeEating',
    roomGradient: [Color(0xFF10B981), Color(0xFF34D399), Color(0xFF6EE7B7), Color(0xFF10B981)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Bubbles had been playing in the garden all morning. Now it was lunchtime! She ran inside and was about to grab her sandwich when her mom asked, 'Did you wash your hands?'",
      es: 'Bubbles había estado jugando en el jardín toda la mañana. ¡Ahora era la hora del almuerzo! Entró corriendo y estaba a punto de tomar su sándwich cuando su mamá preguntó: "¿Te lavaste las manos?"',
    ),
    question: BilingualText(en: 'What should Bubbles do before eating?', es: '¿Qué debe hacer Bubbles antes de comer?'),
    options: [
      StoryOption(id: 'washHands', emoji: '🧼', label: BilingualText(en: 'Wash hands first', es: 'Lavarse las manos primero'), correct: true,
        acknowledge: BilingualText(en: "Bubbles ran to the sink and scrubbed her hands with soap for 20 seconds. 'Now they're squeaky clean!' she laughed.", es: 'Bubbles corrió al lavabo y frotó sus manos con jabón por 20 segundos. "¡Ahora están limpiísimas!" se rio.'),
        feedback: BilingualText(en: "Washing hands before eating removes germs that can make you sick. Scrub with soap for 20 seconds—that's as long as singing Happy Birthday twice!", es: 'Lavarse las manos antes de comer elimina gérmenes que pueden enfermarte. Frota con jabón por 20 segundos, ¡que es como cantar Cumpleaños Feliz dos veces!')),
      StoryOption(id: 'skipWashing', emoji: '🤷', label: BilingualText(en: 'Skip washing', es: 'Saltarse el lavado'), correct: false,
        acknowledge: BilingualText(en: "Bubbles grabbed the sandwich without washing. But invisible germs from the garden were still on her hands!", es: 'Bubbles tomó el sándwich sin lavarse. ¡Pero los gérmenes invisibles del jardín seguían en sus manos!'),
        feedback: BilingualText(en: "Germs are invisible but real! They can get into your food and make your tummy hurt. Always wash hands before eating.", es: '¡Los gérmenes son invisibles pero reales! Pueden entrar a tu comida y hacerte doler el estómago. Siempre lávate las manos antes de comer.')),
    ],
    tip: BilingualText(en: 'Always wash hands before eating', es: 'Siempre lávate las manos antes de comer'),
  ),
  StoryScene(
    id: 'sneeze',
    roomGradient: [Color(0xFF059669), Color(0xFF10B981), Color(0xFF6EE7B7), Color(0xFF059669)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Bubbles felt a tickle in her nose. 'Ah... ah... ACHOO!' She sneezed a big sneeze right in class. Her friend Lily looked over. 'Are you okay, Bubbles?'",
      es: 'Bubbles sintió un cosquilleo en su nariz. "Ah... ah... ¡ACHÚ!" Estornudó un gran estornudo justo en clase. Su amiga Lily miró. "¿Estás bien, Bubbles?"',
    ),
    question: BilingualText(en: 'What should Bubbles do after sneezing?', es: '¿Qué debe hacer Bubbles después de estornudar?'),
    options: [],
    sceneType: SceneType.tapCollect,
    completionEmoji: '🤧',
    tapItems: [
      TapItem(emoji: '🧼', label: BilingualText(en: 'Soap', es: 'Jabón'), isHealthy: true),
      TapItem(emoji: '🤧', label: BilingualText(en: 'Tissue', es: 'Pañuelo'), isHealthy: true),
      TapItem(emoji: '🚿', label: BilingualText(en: 'Washing hands', es: 'Lavarse las manos'), isHealthy: true),
      TapItem(emoji: '🤝', label: BilingualText(en: 'Shaking hands (when sick)', es: 'Dar la mano (enfermo)'), isHealthy: false),
      TapItem(emoji: '💨', label: BilingualText(en: 'Sneezing freely', es: 'Estornudar libre'), isHealthy: false),
      TapItem(emoji: '😐', label: BilingualText(en: 'Doing nothing', es: 'No hacer nada'), isHealthy: false),
    ],
    tip: BilingualText(en: 'Cover sneezes with your elbow and wash hands after', es: 'Cúbrete el estornudo con el codo y lávate las manos después'),
  ),
  StoryScene(
    id: 'muddy',
    roomGradient: [Color(0xFF26A69A), Color(0xFF4DB6AC), Color(0xFFB2DFDB), Color(0xFF26A69A)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Bubbles had been playing in the mud puddles all afternoon. She was covered head to toe in brown mud! She looked like a little mud monster. 'Time to go inside,' called her dad.",
      es: 'Bubbles había estado jugando en los charcos de barro toda la tarde. ¡Estaba cubierta de barro marrón de pies a cabeza! Parecía un pequeño monstruo de barro. "Hora de entrar", llamó su papá.',
    ),
    question: BilingualText(en: 'What should Bubbles do after playing in the mud?', es: '¿Qué debe hacer Bubbles después de jugar en el barro?'),
    options: [],
    sceneType: SceneType.sorting,
    completionEmoji: '🛁',
    sortingSteps: [
      SortingStep(emoji: '👕', text: BilingualText(en: 'Remove muddy clothes', es: 'Quitar la ropa sucia')),
      SortingStep(emoji: '🚿', text: BilingualText(en: 'Wet your body', es: 'Mojarse el cuerpo')),
      SortingStep(emoji: '🧼', text: BilingualText(en: 'Scrub with soap', es: 'Fregar con jabón')),
      SortingStep(emoji: '✨', text: BilingualText(en: 'Rinse clean and dry off', es: 'Enjuagarse y secarse')),
    ],
    tip: BilingualText(en: 'Bathe after playing outside to clean off dirt and germs', es: 'Báñate después de jugar afuera para limpiar la suciedad y los gérmenes'),
  ),
  StoryScene(
    id: 'morning',
    roomGradient: [Color(0xFF22C55E), Color(0xFF4ADE80), Color(0xFF86EFAC), Color(0xFF22C55E)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "It was a school morning! Bubbles had 20 minutes before the bus came. Her backpack was ready, but she hadn't brushed her teeth or combed her hair yet. The clock was ticking...",
      es: '¡Era una mañana de escuela! Bubbles tenía 20 minutos antes de que llegara el autobús. Su mochila estaba lista, pero aún no se había cepillado los dientes ni peinado el cabello. El reloj corría...',
    ),
    question: BilingualText(en: 'What should Bubbles do before school?', es: '¿Qué debe hacer Bubbles antes de la escuela?'),
    options: [
      StoryOption(id: 'brushBoth', emoji: '🪥', label: BilingualText(en: 'Brush teeth & hair', es: 'Cepillarse dientes y cabello'), correct: true,
        acknowledge: BilingualText(en: "Bubbles brushed her teeth for two minutes and combed her hair. She arrived at school feeling fresh and confident!", es: 'Bubbles se cepilló los dientes por dos minutos y se peinó el cabello. ¡Llegó a la escuela sintiéndose fresca y segura!'),
        feedback: BilingualText(en: "Morning hygiene sets you up for the day! Brushing teeth prevents cavities and combing hair makes you feel confident.", es: '¡La higiene matutina te prepara para el día! Cepillarse los dientes previene caries y peinarse te hace sentir seguro.')),
      StoryOption(id: 'rush', emoji: '🏃', label: BilingualText(en: 'Rush out the door', es: 'Salir corriendo'), correct: false,
        acknowledge: BilingualText(en: "Bubbles rushed out without brushing. At school, she felt self-conscious about her breath and messy hair all day!", es: 'Bubbles salió corriendo sin cepillarse. ¡En la escuela, se sintió insegura con su aliento y cabello desordenado todo el día!'),
        feedback: BilingualText(en: "Skipping morning hygiene can leave you feeling uncomfortable all day. A 5-minute routine makes a big difference for your health and confidence!", es: 'Saltarse la higiene matutina puede dejarte sintiéndote incómodo todo el día. ¡Una rutina de 5 minutos hace una gran diferencia para tu salud y confianza!')),
    ],
    tip: BilingualText(en: 'Build a morning hygiene routine every day', es: 'Construye una rutina de higiene matutina cada día'),
  ),
];

const StoryStrings hygieneStrings = StoryStrings(
  title: BilingualText(en: "Bubbles' Clean\nAdventure", es: 'La Aventura\nLimpia de Bubbles'),
  subtitle: BilingualText(en: "Help Bubbles stay clean and healthy!", es: '¡Ayuda a Bubbles a mantenerse limpia y saludable!'),
  startButton: BilingualText(en: "Let's Go!", es: '¡Vamos!'),
  endingTitle: BilingualText(en: "Squeaky Clean, Bubbles!", es: '¡Limpia y Brillante, Bubbles!'),
  endingSubtitle: BilingualText(en: "Bubbles kept clean and healthy! Here's what we learned:", es: '¡Bubbles se mantuvo limpia y saludable! Esto es lo que aprendimos:'),
  playAgain: BilingualText(en: 'Play Again', es: 'Jugar de Nuevo'),
  backToHabits: BilingualText(en: 'Back to Habits', es: 'Volver a Hábitos'),
  back: BilingualText(en: 'Back', es: 'Volver'),
  goodJob: BilingualText(en: 'Great choice!', es: '¡Gran elección!'),
  tryAgain: BilingualText(en: 'Hmm, not quite...', es: 'Hmm, no exactamente...'),
  next: BilingualText(en: 'Next', es: 'Siguiente'),
  finish: BilingualText(en: 'Finish', es: 'Terminar'),
  retry: BilingualText(en: 'Try Again', es: 'Intentar de nuevo'),
);
