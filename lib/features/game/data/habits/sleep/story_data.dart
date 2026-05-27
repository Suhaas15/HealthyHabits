import 'package:flutter/material.dart';
import '../../models.dart';

final List<StoryScene> sleepScenes = [
  StoryScene(
    id: 'awake',
    roomGradient: [Color(0xFF9B59B6), Color(0xFF7C3AED), Color(0xFFA78BFA), Color(0xFF9B59B6)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "The moon rose over the little house. Teddy lay in bed, staring at the ceiling. His eyes felt wide open. 'I need something calm to help me relax,' he thought.",
      es: 'La luna subió sobre la casita. Teddy estaba en la cama, mirando al techo. Sus ojos estaban bien abiertos. "Necesito algo tranquilo para relajarme", pensó.',
    ),
    question: BilingualText(
      en: 'What helps Teddy relax before sleep?',
      es: '¿Qué ayuda a Teddy a relajarse antes de dormir?',
    ),
    options: [
      StoryOption(
        id: 'book',
        emoji: '📖',
        label: BilingualText(en: 'Read a book', es: 'Leer un libro'),
        correct: true,
        acknowledge: BilingualText(
          en: "Teddy reached for his storybook. A soft, calm story—that's just right!",
          es: 'Teddy alcanzó su libro de cuentos. ¡Una historia suave y tranquila es perfecta!',
        ),
        feedback: BilingualText(
          en: 'Reading a calm story helps your brain relax and get ready for sleep. Screens keep us awake!',
          es: '¡Leer un cuento tranquilo ayuda a tu cerebro a relajarse! Las pantallas nos mantienen despiertos.',
        ),
      ),
      StoryOption(
        id: 'tablet',
        emoji: '📱',
        label: BilingualText(en: 'Play on tablet', es: 'Jugar con la tableta'),
        correct: false,
        acknowledge: BilingualText(
          en: "Teddy reached for the tablet. But wait—bright screens aren't good before bed!",
          es: 'Teddy alcanzó la tableta. ¡Pero espera! Las pantallas brillantes no son buenas antes de dormir.',
        ),
        feedback: BilingualText(
          en: "Screens have bright light that tricks your brain into staying awake. A book is much better!",
          es: 'Las pantallas tienen luz brillante que engaña a tu cerebro. ¡Un libro es mucho mejor!',
        ),
      ),
    ],
    tip: BilingualText(
      en: 'Read a book before bed instead of screens',
      es: 'Lee un libro antes de dormir en vez de pantallas',
    ),
  ),
  StoryScene(
    id: 'bright',
    roomGradient: [Color(0xFF7C3AED), Color(0xFF9D5CF0), Color(0xFFBBA4F8), Color(0xFF7C3AED)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Teddy opened his favorite storybook. The stars on the cover twinkled. But the room was glowing—someone had left the big lamp on! 'It's too bright to feel sleepy,' Teddy sighed.",
      es: 'Teddy abrió su libro favorito. Las estrellas en la portada brillaban. Pero el cuarto estaba muy iluminado—¡alguien dejó la lámpara encendida! "Está muy brillante para tener sueño", suspiró Teddy.',
    ),
    question: BilingualText(
      en: 'What should Teddy do to feel sleepy?',
      es: '¿Qué debe hacer Teddy para sentir sueño?',
    ),
    options: [],
    sceneType: SceneType.tapCollect,
    completionEmoji: '🌙',
    tapItems: [
      TapItem(emoji: '📖', label: BilingualText(en: 'Storybook', es: 'Libro de cuentos'), isHealthy: true),
      TapItem(emoji: '🌙', label: BilingualText(en: 'Night light', es: 'Luz nocturna'), isHealthy: true),
      TapItem(emoji: '🎵', label: BilingualText(en: 'Calm music', es: 'Música tranquila'), isHealthy: true),
      TapItem(emoji: '📱', label: BilingualText(en: 'Phone', es: 'Teléfono'), isHealthy: false),
      TapItem(emoji: '💡', label: BilingualText(en: 'Bright lamp', es: 'Lámpara brillante'), isHealthy: false),
      TapItem(emoji: '☕', label: BilingualText(en: 'Hot chocolate', es: 'Chocolate caliente'), isHealthy: false),
    ],
    tip: BilingualText(
      en: 'Keep your room dark at bedtime',
      es: 'Mantén tu cuarto oscuro a la hora de dormir',
    ),
  ),
  StoryScene(
    id: 'teeth',
    roomGradient: [Color(0xFF6D28D9), Color(0xFF8B5CF6), Color(0xFFB39AF8), Color(0xFF6D28D9)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Teddy pulled his cozy blanket up. Wait! He remembered something. 'Before we sleep, we always brush our teeth,' his mom had said. Teddy hopped out of bed.",
      es: 'Teddy subió su cobija acogedora. ¡Espera! Recordó algo. "Antes de dormir, siempre nos cepillamos los dientes", había dicho su mamá. Teddy saltó de la cama.',
    ),
    question: BilingualText(
      en: 'What should Teddy do before bed?',
      es: '¿Qué debe hacer Teddy antes de dormir?',
    ),
    options: [],
    sceneType: SceneType.sorting,
    completionEmoji: '🪥',
    sortingSteps: [
      SortingStep(emoji: '🧸', text: BilingualText(en: 'Put on cozy pajamas', es: 'Ponerse el pijama acogedor')),
      SortingStep(emoji: '🪥', text: BilingualText(en: 'Brush your teeth', es: 'Cepillarse los dientes')),
      SortingStep(emoji: '🌙', text: BilingualText(en: 'Dim the lights', es: 'Bajar las luces')),
      SortingStep(emoji: '🛏️', text: BilingualText(en: 'Get into bed', es: 'Meterse en la cama')),
    ],
    tip: BilingualText(
      en: 'Brush your teeth before bed every night',
      es: 'Cepíllate los dientes antes de dormir cada noche',
    ),
  ),
  StoryScene(
    id: 'bedtime',
    roomGradient: [Color(0xFF5B21B6), Color(0xFF7C3AED), Color(0xFF9D5CF0), Color(0xFF5B21B6)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Teddy's eyes felt heavy. The clock showed his usual bedtime. But the TV in the living room was still on—his favorite show! 'Just one more episode?' Teddy wondered.",
      es: 'Los ojos de Teddy pesaban. El reloj marcaba su hora de dormir. ¡Pero el televisor del salón seguía encendido—su programa favorito! "¿Solo un episodio más?", pensó Teddy.',
    ),
    question: BilingualText(
      en: 'What should Teddy do at bedtime?',
      es: '¿Qué debe hacer Teddy a la hora de dormir?',
    ),
    options: [
      StoryOption(
        id: 'sleep',
        emoji: '🛏️',
        label: BilingualText(en: 'Go to bed on time', es: 'Ir a dormir a tiempo'),
        correct: true,
        acknowledge: BilingualText(
          en: "Teddy turned off the TV and climbed into bed. 'Sticking to bedtime helps me sleep better,' he yawned.",
          es: 'Teddy apagó el televisor y se metió en la cama. "Respetar la hora de dormir me ayuda a descansar mejor", bostezó.',
        ),
        feedback: BilingualText(
          en: 'Going to bed at the same time every night helps your body get good sleep!',
          es: '¡Ir a dormir a la misma hora cada noche ayuda a tu cuerpo a descansar mejor!',
        ),
      ),
      StoryOption(
        id: 'tv',
        emoji: '📺',
        label: BilingualText(en: 'Watch one more show', es: 'Ver un programa más'),
        correct: false,
        acknowledge: BilingualText(
          en: "Teddy crept to the living room. But staying up late makes us tired the next day!",
          es: 'Teddy fue al salón. ¡Pero quedarse despierto hasta tarde nos cansa al día siguiente!',
        ),
        feedback: BilingualText(
          en: "Staying up late throws off your sleep. Stick to your bedtime for a good night's rest!",
          es: '¡Quedarse despierto hasta tarde afecta tu sueño! Respeta tu hora de dormir.',
        ),
      ),
    ],
    tip: BilingualText(
      en: 'Stick to a consistent bedtime every night',
      es: 'Respeta una hora de dormir consistente cada noche',
    ),
  ),
];

const StoryStrings sleepStrings = StoryStrings(
  title: BilingualText(en: "Teddy's Bedtime\nAdventure", es: 'La Aventura de Teddy\na la Hora de Dormir'),
  subtitle: BilingualText(en: 'Help Teddy get ready for bed!', es: '¡Ayuda a Teddy a prepararse para dormir!'),
  startButton: BilingualText(en: "Let's Go!", es: '¡Vamos!'),
  endingTitle: BilingualText(en: 'Sweet Dreams, Teddy!', es: '¡Dulces Sueños, Teddy!'),
  endingSubtitle: BilingualText(en: "You helped Teddy fall asleep! Here's what we learned:", es: '¡Ayudaste a Teddy a dormirse! Esto es lo que aprendimos:'),
  playAgain: BilingualText(en: 'Play Again', es: 'Jugar de Nuevo'),
  backToHabits: BilingualText(en: 'Back to Habits', es: 'Volver a Hábitos'),
  back: BilingualText(en: 'Back', es: 'Volver'),
  goodJob: BilingualText(en: 'Great choice!', es: '¡Gran elección!'),
  tryAgain: BilingualText(en: 'Hmm, not quite...', es: 'Hmm, no exactamente...'),
  next: BilingualText(en: 'Next', es: 'Siguiente'),
  finish: BilingualText(en: 'Finish', es: 'Terminar'),
  retry: BilingualText(en: 'Try Again', es: 'Intentar de nuevo'),
);
