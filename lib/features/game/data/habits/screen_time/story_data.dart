import 'package:flutter/material.dart';
import '../../models.dart';

final List<StoryScene> screenTimeScenes = [
  StoryScene(
    id: 'screenLong',
    roomGradient: [Color(0xFF0C2332), Color(0xFF0A3D54), Color(0xFF0C4A6E), Color(0xFF0C2332)],
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
    roomGradient: [Color(0xFF0A2E1A), Color(0xFF0D4426), Color(0xFF136132), Color(0xFF0A2E1A)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Pixel's family called from outside. 'Come play in the garden!' The sun was shining and birds were singing. But Pixel's tablet was right there on the couch...",
      es: 'La familia de Pixel llamó desde afuera. "¡Ven a jugar al jardín!" El sol brillaba y los pájaros cantaban. Pero la tableta de Pixel estaba justo ahí en el sofá...',
    ),
    question: BilingualText(en: 'What should Pixel choose?', es: '¿Qué debe elegir Pixel?'),
    options: [
      StoryOption(
        id: 'goOutside', emoji: '🌳',
        label: BilingualText(en: 'Go outside', es: 'Salir afuera'),
        correct: true,
        acknowledge: BilingualText(en: "Pixel ran outside and played with his family. The fresh air felt amazing!", es: '¡Pixel corrió afuera y jugó con su familia. El aire fresco se sentía increíble!'),
        feedback: BilingualText(en: "Outdoor play is great for your body AND your eyes! Natural light helps your vision stay healthy.", es: '¡Jugar afuera es genial para tu cuerpo Y tus ojos! La luz natural ayuda a tu visión a mantenerse sana.'),
      ),
      StoryOption(
        id: 'stayTablet', emoji: '📱',
        label: BilingualText(en: 'Stay on tablet', es: 'Quedarse con la tableta'),
        correct: false,
        acknowledge: BilingualText(en: "Pixel stayed inside with the tablet. His family had fun without him—he missed out!", es: 'Pixel se quedó adentro con la tableta. Su familia se divirtió sin él—¡se lo perdió!'),
        feedback: BilingualText(en: "Screen time should be balanced with outdoor play. Real-world fun keeps you healthy and happy!", es: 'El tiempo en pantallas debe equilibrarse con el juego al aire libre. ¡La diversión real te mantiene sano y feliz!'),
      ),
    ],
    tip: BilingualText(en: 'Balance screen time with outdoor play every day', es: 'Equilibra el tiempo en pantallas con juego al aire libre cada día'),
  ),
  StoryScene(
    id: 'bedtime',
    roomGradient: [Color(0xFF1E1B4B), Color(0xFF2D1B69), Color(0xFF4C1D95), Color(0xFF1E1B4B)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "It was bedtime! Pixel's eyes were drooping. But a funny video started playing on his tablet. 'Just one more,' Pixel whispered, the bright screen glowing in the dark room.",
      es: '¡Era hora de dormir! Los ojos de Pixel se cerraban. Pero un video divertido empezó en su tableta. "Solo uno más", susurró Pixel, la pantalla brillante iluminando el cuarto oscuro.',
    ),
    question: BilingualText(en: 'What should Pixel do at bedtime?', es: '¿Qué debe hacer Pixel a la hora de dormir?'),
    options: [
      StoryOption(
        id: 'putAway', emoji: '😴',
        label: BilingualText(en: 'Put device away', es: 'Guardar el dispositivo'),
        correct: true,
        acknowledge: BilingualText(en: "Pixel placed his tablet on the charger and pulled up his blanket. His eyes felt so relieved!", es: 'Pixel puso su tableta en el cargador y jaló su cobija. ¡Sus ojos se sintieron muy aliviados!'),
        feedback: BilingualText(en: "Screen light at bedtime tricks your brain into staying awake. Put devices away 1 hour before bed!", es: 'La luz de pantallas a la hora de dormir engaña a tu cerebro. ¡Guarda los dispositivos 1 hora antes de dormir!'),
      ),
      StoryOption(
        id: 'keepWatching', emoji: '📺',
        label: BilingualText(en: 'Keep watching', es: 'Seguir viendo'),
        correct: false,
        acknowledge: BilingualText(en: "Pixel kept watching video after video. Soon it was very late and he was exhausted!", es: 'Pixel siguió viendo video tras video. ¡Pronto era muy tarde y estaba agotado!'),
        feedback: BilingualText(en: "Blue light from screens makes it harder to fall asleep. Your brain needs to wind down before bed!", es: 'La luz azul de las pantallas hace más difícil dormirse. ¡Tu cerebro necesita calmarse antes de dormir!'),
      ),
    ],
    tip: BilingualText(en: 'Put screens away 1 hour before bedtime', es: 'Guarda las pantallas 1 hora antes de dormir'),
  ),
  StoryScene(
    id: 'posture',
    roomGradient: [Color(0xFF0C2332), Color(0xFF0A3A50), Color(0xFF085F82), Color(0xFF0C2332)],
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
