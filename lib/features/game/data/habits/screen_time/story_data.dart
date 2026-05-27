import 'package:flutter/material.dart';
import '../../models.dart';

final List<StoryScene> screenTimeScenes = [
  StoryScene(
    id: 'screenLong',
    roomGradient: [Color(0xFF8B5CF6), Color(0xFF06B6D4), Color(0xFFA78BFA), Color(0xFF8B5CF6)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Pixel had been playing video games for three whole hours! His eyes were turning red and his head felt heavy. 'Something doesn't feel right,' Pixel thought, rubbing his eyes.",
      es: 'Pixel llevaba tres horas completas jugando videojuegos. Sus ojos se ponían rojos y su cabeza pesaba. "Algo no está bien", pensó Pixel, frotándose los ojos.',
    ),
    question: BilingualText(en: 'What should Pixel do for his tired eyes?', es: '¿Qué debe hacer Pixel para sus ojos cansados?'),
    options: [
      StoryOption(
        id: 'takeBreak', emoji: '👀',
        label: BilingualText(en: 'Take a screen break', es: 'Tomar un descanso de pantalla'),
        correct: true,
        acknowledge: BilingualText(en: "Pixel set down his controller and closed his eyes. Ahh, that feels so much better!", es: 'Pixel dejó su control y cerró los ojos. ¡Ahh, eso se siente mucho mejor!'),
        feedback: BilingualText(en: "The 20-20-20 rule helps! Every 20 minutes, look 20 feet away for 20 seconds. Your eyes need breaks!", es: '¡La regla 20-20-20 ayuda! Cada 20 minutos, mira a 6 metros por 20 segundos. ¡Tus ojos necesitan descanso!'),
      ),
      StoryOption(
        id: 'keepPlaying', emoji: '🎮',
        label: BilingualText(en: 'Keep playing', es: 'Seguir jugando'),
        correct: false,
        acknowledge: BilingualText(en: "Pixel grabbed the controller again. But his eyes got even more tired and strained!", es: 'Pixel tomó el control de nuevo. ¡Pero sus ojos se cansaron aún más!'),
        feedback: BilingualText(en: "Too much screen time strains your eyes and causes headaches. Always take regular breaks!", es: 'Demasiado tiempo en pantallas cansa tus ojos y provoca dolores de cabeza. ¡Siempre toma descansos!'),
      ),
    ],
    tip: BilingualText(en: 'Take a screen break every 20 minutes', es: 'Toma un descanso de pantalla cada 20 minutos'),
  ),
  StoryScene(
    id: 'outdoor',
    roomGradient: [Color(0xFF7C3AED), Color(0xFF38BDF8), Color(0xFFBFA4F8), Color(0xFF7C3AED)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Pixel's family called from outside. 'Come play in the garden!' The sun was shining and birds were singing. But Pixel's tablet was right there on the couch...",
      es: 'La familia de Pixel llamó desde afuera. "¡Ven a jugar al jardín!" El sol brillaba y los pájaros cantaban. Pero la tableta de Pixel estaba justo ahí en el sofá...',
    ),
    question: BilingualText(en: 'What should Pixel choose?', es: '¿Qué debe elegir Pixel?'),
    options: [],
    sceneType: SceneType.tapCollect,
    completionEmoji: '🌳',
    tapItems: [
      TapItem(emoji: '🌳', label: BilingualText(en: 'Playing outside', es: 'Jugar afuera'), isHealthy: true),
      TapItem(emoji: '⚽', label: BilingualText(en: 'Soccer', es: 'Fútbol'), isHealthy: true),
      TapItem(emoji: '🎨', label: BilingualText(en: 'Drawing', es: 'Dibujar'), isHealthy: true),
      TapItem(emoji: '📱', label: BilingualText(en: 'Scrolling phone', es: 'Usar el teléfono'), isHealthy: false),
      TapItem(emoji: '📺', label: BilingualText(en: 'Watching TV', es: 'Ver televisión'), isHealthy: false),
      TapItem(emoji: '🎮', label: BilingualText(en: 'Video games', es: 'Videojuegos'), isHealthy: false),
    ],
    tip: BilingualText(en: 'Balance screen time with outdoor play every day', es: 'Equilibra el tiempo en pantallas con juego al aire libre cada día'),
  ),
  StoryScene(
    id: 'bedtime',
    roomGradient: [Color(0xFFAB47BC), Color(0xFF7C4DFF), Color(0xFFCE93D8), Color(0xFFAB47BC)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "It was bedtime! Pixel's eyes were drooping. But a funny video started playing on his tablet. 'Just one more,' Pixel whispered, the bright screen glowing in the dark room.",
      es: '¡Era hora de dormir! Los ojos de Pixel se cerraban. Pero un video divertido empezó en su tableta. "Solo uno más", susurró Pixel, la pantalla brillante iluminando el cuarto oscuro.',
    ),
    question: BilingualText(en: 'What should Pixel do at bedtime?', es: '¿Qué debe hacer Pixel a la hora de dormir?'),
    options: [],
    sceneType: SceneType.sorting,
    completionEmoji: '😴',
    sortingSteps: [
      SortingStep(emoji: '📚', text: BilingualText(en: 'Finish homework first', es: 'Terminar la tarea primero')),
      SortingStep(emoji: '⏱️', text: BilingualText(en: 'Use screen for 30 minutes', es: 'Usar pantalla 30 minutos')),
      SortingStep(emoji: '📵', text: BilingualText(en: 'Put the device away', es: 'Guardar el dispositivo')),
      SortingStep(emoji: '📖', text: BilingualText(en: 'Read a book before bed', es: 'Leer un libro antes de dormir')),
    ],
    tip: BilingualText(en: 'Put screens away 1 hour before bedtime', es: 'Guarda las pantallas 1 hora antes de dormir'),
  ),
  StoryScene(
    id: 'posture',
    roomGradient: [Color(0xFF5C6BC0), Color(0xFF42A5F5), Color(0xFF90CAF9), Color(0xFF5C6BC0)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Pixel was reading on his phone, hunched way over with his head down. His neck started to ache and his back felt stiff. 'Ouch!' Pixel groaned, rubbing his neck.",
      es: 'Pixel estaba leyendo en su teléfono, muy encorvado con la cabeza hacia abajo. Su cuello empezó a doler y su espalda se sentía rígida. "¡Ay!" gruñó Pixel, frotándose el cuello.',
    ),
    question: BilingualText(en: 'What should Pixel do about his posture?', es: '¿Qué debe hacer Pixel con su postura?'),
    options: [
      StoryOption(
        id: 'stretch', emoji: '🧘',
        label: BilingualText(en: 'Sit up & stretch', es: 'Enderezarse y estirarse'),
        correct: true,
        acknowledge: BilingualText(en: "Pixel sat up tall, rolled his shoulders back, and stretched his neck. Ahhh, much better!", es: 'Pixel se sentó erguido, echó los hombros hacia atrás y estiró el cuello. ¡Ahh, mucho mejor!'),
        feedback: BilingualText(en: "Good posture protects your neck and spine! Hold your device at eye level and take stretch breaks.", es: '¡Una buena postura protege tu cuello y columna! Sostén tu dispositivo a la altura de los ojos.'),
      ),
      StoryOption(
        id: 'hunch', emoji: '😬',
        label: BilingualText(en: 'Keep hunching', es: 'Seguir encorvado'),
        correct: false,
        acknowledge: BilingualText(en: "Pixel kept hunching over. The neck pain got worse and worse!", es: 'Pixel siguió encorvado. ¡El dolor de cuello se puso peor y peor!'),
        feedback: BilingualText(en: '"Tech neck" happens from hunching over devices. Sit up straight to keep your body healthy!', es: '"Cuello tech" ocurre por encorvarse sobre dispositivos. ¡Siéntate erguido para mantener tu cuerpo sano!'),
      ),
    ],
    tip: BilingualText(en: 'Sit up straight and hold screens at eye level', es: 'Siéntate erguido y sostén las pantallas a la altura de los ojos'),
  ),
];

const StoryStrings screenTimeStrings = StoryStrings(
  title: BilingualText(en: "Pixel's Screen\nSmart Day", es: 'El Día Inteligente\nde Pixel'),
  subtitle: BilingualText(en: 'Help Pixel use screens the smart way!', es: '¡Ayuda a Pixel a usar pantallas inteligentemente!'),
  startButton: BilingualText(en: "Let's Go!", es: '¡Vamos!'),
  endingTitle: BilingualText(en: 'Screen Smart, Pixel!', es: '¡Pantalla Inteligente, Pixel!'),
  endingSubtitle: BilingualText(en: "Pixel learned to use screens wisely! Here's what we learned:", es: '¡Pixel aprendió a usar las pantallas sabiamente! Esto es lo que aprendimos:'),
  playAgain: BilingualText(en: 'Play Again', es: 'Jugar de Nuevo'),
  backToHabits: BilingualText(en: 'Back to Habits', es: 'Volver a Hábitos'),
  back: BilingualText(en: 'Back', es: 'Volver'),
  goodJob: BilingualText(en: 'Great choice!', es: '¡Gran elección!'),
  tryAgain: BilingualText(en: 'Hmm, not quite...', es: 'Hmm, no exactamente...'),
  next: BilingualText(en: 'Next', es: 'Siguiente'),
  finish: BilingualText(en: 'Finish', es: 'Terminar'),
  retry: BilingualText(en: 'Try Again', es: 'Intentar de nuevo'),
);
