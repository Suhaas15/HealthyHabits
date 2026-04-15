import 'package:flutter/material.dart';
import '../../models.dart';

final List<StoryScene> movementScenes = [
  StoryScene(
    id: 'afterSchool',
    roomGradient: [Color(0xFF1A0F00), Color(0xFF2C1A00), Color(0xFF4A2800), Color(0xFF1A0F00)],
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
    roomGradient: [Color(0xFF1A1200), Color(0xFF2E1F00), Color(0xFF4A3200), Color(0xFF1A1200)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "It was a rainy Saturday and Hoppy was stuck inside. She pressed her nose against the window. 'I can't go outside,' she sighed. But then she had an idea...",
      es: 'Era un sábado lluvioso y Hoppy estaba atrapada adentro. Presionó su nariz contra la ventana. "No puedo salir", suspiró. Pero entonces tuvo una idea...',
    ),
    question: BilingualText(en: 'How can Hoppy move when stuck inside?', es: '¿Cómo puede moverse Hoppy cuando está adentro?'),
    options: [
      StoryOption(id: 'danceJump', emoji: '💃', label: BilingualText(en: 'Dance & jump', es: 'Bailar y saltar'), correct: true,
        acknowledge: BilingualText(en: "Hoppy turned on music and started dancing and jumping around the living room. This is so fun!", es: '¡Hoppy puso música y empezó a bailar y saltar por la sala. ¡Esto es muy divertido!'),
        feedback: BilingualText(en: "You don't need to go outside to be active! Dancing, jumping, yoga, or even cleaning up can keep your body moving!", es: '¡No necesitas salir para estar activo! Bailar, saltar, yoga, ¡o incluso limpiar puede mantener tu cuerpo en movimiento!')),
      StoryOption(id: 'lieSofa', emoji: '🛋️', label: BilingualText(en: 'Lie on the sofa', es: 'Acostarse en el sofá'), correct: false,
        acknowledge: BilingualText(en: "Hoppy plopped on the sofa and stayed still all day. She felt bored and sluggish by the evening.", es: 'Hoppy se tiró en el sofá y se quedó quieta todo el día. Se sintió aburrida y lenta para la tarde.'),
        feedback: BilingualText(en: "Lying still all day makes your muscles weak and your mood low. Even a 10-minute dance party counts as exercise!", es: 'Quedarse quieto todo el día debilita tus músculos y baja tu ánimo. ¡Incluso una fiesta de baile de 10 minutos cuenta como ejercicio!')),
    ],
    tip: BilingualText(en: 'Dance or jump indoors on rainy days', es: 'Baila o salta adentro en días lluviosos'),
  ),
  StoryScene(
    id: 'park',
    roomGradient: [Color(0xFF211500), Color(0xFF362000), Color(0xFF573400), Color(0xFF211500)],
    roomGradientLocations: [0, 0.3, 0.7, 1],
    narration: BilingualText(
      en: "Hoppy and her family were going to the park! It was just a few blocks away. Her dad jingled the car keys, but her mom said, 'The weather is so nice today...'",
      es: '¡Hoppy y su familia iban al parque! Estaba a solo unas cuadras. Su papá tintineó las llaves del coche, pero su mamá dijo: "El clima está muy lindo hoy..."',
    ),
    question: BilingualText(en: 'How should Hoppy get to the park?', es: '¿Cómo debe ir Hoppy al parque?'),
    options: [
      StoryOption(id: 'walkThere', emoji: '🚶', label: BilingualText(en: 'Walk there', es: 'Caminar allá'), correct: true,
        acknowledge: BilingualText(en: "Hoppy skipped and bounced all the way to the park! She was already warmed up and ready to play!", es: '¡Hoppy saltó y brincó todo el camino al parque! ¡Ya estaba calentada y lista para jugar!'),
        feedback: BilingualText(en: "Walking instead of driving is extra exercise! Short trips on foot add up and keep your body healthy.", es: '¡Caminar en lugar de manejar es ejercicio adicional! Los viajes cortos a pie se suman y mantienen tu cuerpo sano.')),
      StoryOption(id: 'drive', emoji: '🚗', label: BilingualText(en: 'Drive there', es: 'Ir en coche'), correct: false,
        acknowledge: BilingualText(en: "They drove to the park. But they missed out on a nice walk in the fresh air!", es: 'Fueron al parque en coche. ¡Pero se perdieron un lindo paseo al aire libre!'),
        feedback: BilingualText(en: "Short walks add up! Walking just 15 minutes adds movement to your day and is good for the planet too!", es: '¡Las caminatas cortas se acumulan! Caminar solo 15 minutos añade movimiento a tu día y también es bueno para el planeta.')),
    ],
    tip: BilingualText(en: 'Walk or bike for short trips instead of driving', es: 'Camina o anda en bici para viajes cortos en vez de ir en coche'),
  ),
  StoryScene(
    id: 'wakeup',
    roomGradient: [Color(0xFF1A1000), Color(0xFF2B1A00), Color(0xFF442A00), Color(0xFF1A1000)],
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
