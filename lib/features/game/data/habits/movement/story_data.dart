import 'package:flutter/material.dart';
import '../../models.dart';

final List<StoryScene> movementScenes = [
  StoryScene(
    id: 'afterSchool',
    roomGradient: [Color(0xFFF97316), Color(0xFFFBBF24), Color(0xFF84CC16), Color(0xFFF97316)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "School was finally over! Hoppy had finished all her homework. Now she had free time until dinner. She looked out the window at the sunny backyard, then glanced at the TV...",
      es: '¡Por fin terminó la escuela! Hoppy había terminado toda su tarea. Ahora tenía tiempo libre hasta la cena. Miró por la ventana al patio soleado, luego echó un vistazo al televisor...',
    ),
    question: BilingualText(en: 'How should Hoppy spend her free time?', es: '¿Cómo debe pasar Hoppy su tiempo libre?'),
    options: [
      StoryOption(id: 'playOutside', emoji: '⚽', label: BilingualText(en: 'Play outside', es: 'Jugar afuera'), correct: true,
        acknowledge: BilingualText(en: "Hoppy grabbed her soccer ball and bounced outside. She ran and jumped and felt amazing!", es: '¡Hoppy agarró su pelota de fútbol y salió saltando. Corrió y saltó y se sintió increíble!'),
        feedback: BilingualText(en: "Kids need at least 60 minutes of active play every day! Moving your body makes you stronger and happier.", es: '¡Los niños necesitan al menos 60 minutos de juego activo cada día! Mover tu cuerpo te hace más fuerte y feliz.')),
      StoryOption(id: 'watchTv', emoji: '📺', label: BilingualText(en: 'Watch TV', es: 'Ver televisión'), correct: false,
        acknowledge: BilingualText(en: "Hoppy flopped on the couch and turned on the TV. Her legs stayed still and she felt sleepy...", es: 'Hoppy se tiró en el sofá y encendió la televisión. Sus piernas se quedaron quietas y se sintió somnolienta...'),
        feedback: BilingualText(en: "Too much sitting isn't good for your body! After sitting in school all day, your body needs to move and stretch.", es: '¡Sentarse demasiado no es bueno para tu cuerpo! Después de sentarse en la escuela todo el día, tu cuerpo necesita moverse y estirarse.')),
    ],
    tip: BilingualText(en: 'Get at least 60 minutes of active play every day', es: 'Consigue al menos 60 minutos de juego activo cada día'),
  ),
  StoryScene(
    id: 'rainy',
    roomGradient: [Color(0xFFEA580C), Color(0xFFF97316), Color(0xFFFCD34D), Color(0xFFEA580C)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "It was a rainy Saturday and Hoppy was stuck inside. She pressed her nose against the window. 'I can't go outside,' she sighed. But then she had an idea...",
      es: 'Era un sábado lluvioso y Hoppy estaba atrapada adentro. Presionó su nariz contra la ventana. "No puedo salir", suspiró. Pero entonces tuvo una idea...',
    ),
    question: BilingualText(en: 'How can Hoppy move when stuck inside?', es: '¿Cómo puede moverse Hoppy cuando está adentro?'),
    options: [],
    sceneType: SceneType.tapCollect,
    completionEmoji: '💃',
    tapItems: [
      TapItem(emoji: '💃', label: BilingualText(en: 'Dancing', es: 'Bailar'), isHealthy: true),
      TapItem(emoji: '🧘', label: BilingualText(en: 'Yoga', es: 'Yoga'), isHealthy: true),
      TapItem(emoji: '🤸', label: BilingualText(en: 'Jumping jacks', es: 'Saltos de tijera'), isHealthy: true),
      TapItem(emoji: '🛋️', label: BilingualText(en: 'Lying on sofa', es: 'Tumbarse en el sofá'), isHealthy: false),
      TapItem(emoji: '📺', label: BilingualText(en: 'Watching TV', es: 'Ver televisión'), isHealthy: false),
      TapItem(emoji: '😴', label: BilingualText(en: 'Taking a long nap', es: 'Dormir una siesta larga'), isHealthy: false),
    ],
    tip: BilingualText(en: 'Dance or jump indoors on rainy days', es: 'Baila o salta adentro en días lluviosos'),
  ),
  StoryScene(
    id: 'park',
    roomGradient: [Color(0xFFFBBF24), Color(0xFFF59E0B), Color(0xFF84CC16), Color(0xFFFBBF24)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Hoppy and her family were going to the park! It was just a few blocks away. Her dad jingled the car keys, but her mom said, 'The weather is so nice today...'",
      es: '¡Hoppy y su familia iban al parque! Estaba a solo unas cuadras. Su papá tintineó las llaves del coche, pero su mamá dijo: "El clima está muy lindo hoy..."',
    ),
    question: BilingualText(en: 'How should Hoppy get to the park?', es: '¿Cómo debe ir Hoppy al parque?'),
    options: [],
    sceneType: SceneType.sorting,
    completionEmoji: '🚶',
    sortingSteps: [
      SortingStep(emoji: '👟', text: BilingualText(en: 'Put on your shoes', es: 'Ponerse los zapatos')),
      SortingStep(emoji: '🙆', text: BilingualText(en: 'Warm up your muscles', es: 'Calentar los músculos')),
      SortingStep(emoji: '⚽', text: BilingualText(en: 'Play and exercise hard', es: 'Jugar y ejercitarse')),
      SortingStep(emoji: '🧘', text: BilingualText(en: 'Cool down and stretch', es: 'Enfriarse y estirarse')),
    ],
    tip: BilingualText(en: 'Walk or bike for short trips instead of driving', es: 'Camina o anda en bici para viajes cortos en vez de ir en coche'),
  ),
  StoryScene(
    id: 'wakeup',
    roomGradient: [Color(0xFFFF7C2A), Color(0xFFFCD34D), Color(0xFF86EFAC), Color(0xFFFF7C2A)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Beep beep beep! Hoppy's alarm went off. She opened one eye and groaned. Her body felt stiff from sleeping. The snooze button was right there...",
      es: '¡Bip bip bip! La alarma de Hoppy sonó. Abrió un ojo y gruñó. Su cuerpo se sentía rígido de dormir. El botón de repetición estaba justo ahí...',
    ),
    question: BilingualText(en: "What should Hoppy do to start her day right?", es: '¿Qué debe hacer Hoppy para empezar bien su día?'),
    options: [
      StoryOption(id: 'stretch', emoji: '🌅', label: BilingualText(en: 'Stretch & move', es: 'Estirarse y moverse'), correct: true,
        acknowledge: BilingualText(en: "Hoppy jumped out of bed and did some big stretches and jumps. 'I feel so awake now!' she cheered.", es: 'Hoppy saltó de la cama y hizo grandes estiramientos y saltos. "¡Me siento tan despierta ahora!" animó.'),
        feedback: BilingualText(en: "Morning movement wakes up your body and brain! Even 5 minutes of stretching or jumping jacks sets you up for a great day.", es: '¡El movimiento matutino despierta tu cuerpo y cerebro! Incluso 5 minutos de estiramientos te preparan para un gran día.')),
      StoryOption(id: 'snooze', emoji: '😴', label: BilingualText(en: 'Hit snooze', es: 'Dar dormitar'), correct: false,
        acknowledge: BilingualText(en: "Hoppy pressed snooze and stayed in bed. When she finally got up, she felt groggy all morning!", es: 'Hoppy presionó repetir y se quedó en cama. Cuando finalmente se levantó, ¡se sintió somnolienta toda la mañana!'),
        feedback: BilingualText(en: "Snoozing too long makes you feel more tired! Getting up and moving right away helps you feel alert and energized all day.", es: 'Dormir demasiado te hace sentir más cansado. ¡Levantarte y moverte de inmediato te ayuda a sentirte alerta y lleno de energía todo el día!')),
    ],
    tip: BilingualText(en: 'Do morning stretches to start your day with energy', es: 'Haz estiramientos matutinos para empezar el día con energía'),
  ),
];

const StoryStrings movementStrings = StoryStrings(
  title: BilingualText(en: "Hoppy's Jump\nDay", es: 'El Día de\nSaltos de Hoppy'),
  subtitle: BilingualText(en: "Help Hoppy stay active all day!", es: '¡Ayuda a Hoppy a mantenerse activa todo el día!'),
  startButton: BilingualText(en: "Let's Go!", es: '¡Vamos!'),
  endingTitle: BilingualText(en: "Amazing, Hoppy!", es: '¡Increíble, Hoppy!'),
  endingSubtitle: BilingualText(en: "Hoppy stayed active and healthy! Here's what we learned:", es: '¡Hoppy se mantuvo activa y saludable! Esto es lo que aprendimos:'),
  playAgain: BilingualText(en: 'Play Again', es: 'Jugar de Nuevo'),
  backToHabits: BilingualText(en: 'Back to Habits', es: 'Volver a Hábitos'),
  back: BilingualText(en: 'Back', es: 'Volver'),
  goodJob: BilingualText(en: 'Great choice!', es: '¡Gran elección!'),
  tryAgain: BilingualText(en: 'Hmm, not quite...', es: 'Hmm, no exactamente...'),
  next: BilingualText(en: 'Next', es: 'Siguiente'),
  finish: BilingualText(en: 'Finish', es: 'Terminar'),
  retry: BilingualText(en: 'Try Again', es: 'Intentar de nuevo'),
);
