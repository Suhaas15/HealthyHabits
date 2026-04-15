import 'package:flutter/material.dart';
import '../../models.dart';

final List<StoryScene> hygieneScenes = [
  StoryScene(
    id: 'beforeEating',
    roomGradient: [Color(0xFF021A10), Color(0xFF042E1E), Color(0xFF06402A), Color(0xFF021A10)],
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
    roomGradient: [Color(0xFF032A18), Color(0xFF044A28), Color(0xFF046834), Color(0xFF032A18)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Bubbles felt a tickle in her nose. 'Ah... ah... ACHOO!' She sneezed a big sneeze right in class. Her friend Lily looked over. 'Are you okay, Bubbles?'",
      es: 'Bubbles sintió un cosquilleo en su nariz. "Ah... ah... ¡ACHÚ!" Estornudó un gran estornudo justo en clase. Su amiga Lily miró. "¿Estás bien, Bubbles?"',
    ),
    question: BilingualText(en: 'What should Bubbles do after sneezing?', es: '¿Qué debe hacer Bubbles después de estornudar?'),
    options: [
      StoryOption(id: 'coverAndWash', emoji: '🤧', label: BilingualText(en: 'Cover & wash hands', es: 'Cubrirse y lavarse'), correct: true,
        acknowledge: BilingualText(en: "Bubbles had covered her sneeze with her elbow and then went to wash her hands. 'That's the hygienic way!' smiled her teacher.", es: 'Bubbles se había cubierto el estornudo con el codo y luego fue a lavarse las manos. "¡Esa es la manera higiénica!" sonrió su maestra.'),
        feedback: BilingualText(en: "Cover sneezes with your elbow (not hands!) so germs don't spread. Then wash your hands to stop germs from reaching others.", es: 'Cubre los estornudos con el codo (¡no las manos!) para que los gérmenes no se propaguen. Luego lávate las manos para evitar que los gérmenes lleguen a otros.')),
      StoryOption(id: 'nothing', emoji: '😐', label: BilingualText(en: 'Do nothing', es: 'No hacer nada'), correct: false,
        acknowledge: BilingualText(en: "Bubbles didn't cover or wash. The sneezing germs spread through the air and onto nearby surfaces!", es: '¡Bubbles no se cubrió ni se lavó. Los gérmenes del estornudo se propagaron por el aire y sobre las superficies cercanas!'),
        feedback: BilingualText(en: "When you sneeze without covering, tiny droplets carrying germs fly up to 6 feet! Always cover your sneeze and wash up afterward.", es: 'Cuando estornudas sin cubrirte, ¡las pequeñas gotas con gérmenes vuelan hasta 2 metros! Siempre cúbrete el estornudo y lávate después.')),
    ],
    tip: BilingualText(en: 'Cover sneezes with your elbow and wash hands after', es: 'Cúbrete el estornudo con el codo y lávate las manos después'),
  ),
  StoryScene(
    id: 'muddy',
    roomGradient: [Color(0xFF042C1C), Color(0xFF064A2C), Color(0xFF076038), Color(0xFF042C1C)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Bubbles had been playing in the mud puddles all afternoon. She was covered head to toe in brown mud! She looked like a little mud monster. 'Time to go inside,' called her dad.",
      es: 'Bubbles había estado jugando en los charcos de barro toda la tarde. ¡Estaba cubierta de barro marrón de pies a cabeza! Parecía un pequeño monstruo de barro. "Hora de entrar", llamó su papá.',
    ),
    question: BilingualText(en: 'What should Bubbles do after playing in the mud?', es: '¿Qué debe hacer Bubbles después de jugar en el barro?'),
    options: [
      StoryOption(id: 'takeBath', emoji: '🛁', label: BilingualText(en: 'Take a bath', es: 'Bañarse'), correct: true,
        acknowledge: BilingualText(en: "Bubbles took a warm bubbly bath and scrubbed off all the mud. She came out fresh and sparkling clean!", es: '¡Bubbles se dio un baño caliente con burbujas y se quitó todo el barro. ¡Salió fresca y reluciente limpia!'),
        feedback: BilingualText(en: "Bathing removes dirt, germs, and sweat from your skin. Clean skin stays healthier and prevents rashes and infections!", es: 'Bañarse elimina la suciedad, los gérmenes y el sudor de tu piel. ¡La piel limpia se mantiene más sana y previene sarpullidos e infecciones!')),
      StoryOption(id: 'stayDirty', emoji: '😬', label: BilingualText(en: 'Stay dirty', es: 'Quedarse sucio'), correct: false,
        acknowledge: BilingualText(en: "Bubbles stayed muddy all evening. The dirt dried on her skin and started to itch and feel uncomfortable!", es: 'Bubbles se quedó sucia toda la tarde. ¡La suciedad se secó sobre su piel y empezó a picar y sentirse incómoda!'),
        feedback: BilingualText(en: "Dirt left on your skin can cause irritation and let germs in. Regular bathing keeps your skin healthy and comfortable!", es: 'La suciedad sobre tu piel puede causar irritación y permitir que entren gérmenes. ¡Bañarse regularmente mantiene tu piel sana y cómoda!')),
    ],
    tip: BilingualText(en: 'Bathe after playing outside to clean off dirt and germs', es: 'Báñate después de jugar afuera para limpiar la suciedad y los gérmenes'),
  ),
  StoryScene(
    id: 'morning',
    roomGradient: [Color(0xFF052E16), Color(0xFF074A20), Color(0xFF09602A), Color(0xFF052E16)],
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
