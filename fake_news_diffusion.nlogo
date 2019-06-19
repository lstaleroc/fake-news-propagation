extensions [array]
globals [num_noticias total_facebook total_twitter total_whatsapp total_redes total_x_hora_facebook total_x_hora_twitter total_x_hora_whatsapp]
breed [usuarios usuario]
breed [noticias noticia]

usuarios-own [
  es_familia?
  es_amigo?
  es_colega?
  es_otros?
  intolerancia
  preferencia_privacidad
  preferencia_alcance
  preferencia_facilidad
  decision_difundir
  vinculacion_ideas_pre
  peso_vinculacion_ideas_pre
  verificacion
  peso_verificacion
  confianza
  peso_confianza
  no_confianza_medios
  peso_no_confianza_medios
  impacto_emocional
  peso_impacto_emocional
  experiencia
  propenso_facebook
  limite_propenso_facebook
  propenso_twitter
  limite_propenso_twitter
  propenso_whatsapp
  limite_propenso_whatsapp
  usuario_facebook?
  usuario_twitter?
  usuario_whatsapp?
  contactos_facebook
  contactos_twitter
  contactos_whatsapp
  tema_politico? ;1
  tema_leyendas_urbanas? ;2
  tema_negocios? ;3
  tema_cientifico? ;4
  noticia_formato
  noticia_tema
  noticia_identificador
  noticias_array
  conocimiento_facebook
  conocimiento_twitter
  conocimiento_whatsapp
  afinidad_contactos_facebook_politico
  afinidad_contactos_facebook_leyendas
  afinidad_contactos_facebook_negocios
  afinidad_contactos_facebook_cientifico
  afinidad_contactos_twitter_politico
  afinidad_contactos_twitter_leyendas
  afinidad_contactos_twitter_negocios
  afinidad_contactos_twitter_cientifico
  afinidad_contactos_whatsapp_politico
  afinidad_contactos_whatsapp_leyendas
  afinidad_contactos_whatsapp_negocios
  afinidad_contactos_whatsapp_cientifico
  difusor?
  compartir_noticia_dia?
  conocimiento_twitter]

noticias-own [
  formato ; 0 - Texto, 1 - Imagen, 2 - Video
  tema ;0 - Politico, 1 - LeyendasUrbanas 2 - Negocios, 3 - Cientifico
  canal; 0 - Facebook, 1 - Twitter, 2 - Whatsapp
  reaccion_positiva
  reaccion_negativa
  caracteres
  hora
]


;;------------------------------------------------------------------------------------------------------------------------------------------
;;SETUP modelo
;;------------------------------------------------------------------------------------------------------------------------------------------
to setup
  clear-all
  setup-usuarios
  setup-noticias
  setup-network-links
  ask n-of num-init-usuarios-transmisores usuarios
    [
      ser-fuente-noticia-falsa true 0 0 0
  ]
  setup-globals
  reset-ticks
end

to setup-noticias
  set num_noticias (num-noticias-texto + num-noticias-imagen + num-noticias-video)
  let random_noticias? false
  let aux_solo_noticias_politica? false
  let aux_solo_noticias_leyendas? false
  let aux_solo_noticias_negocios? false
  let aux_solo_noticias_cientifico? false
  if solo_noticias_politica? = false AND solo_noticias_leyendas? = false AND solo_noticias_negocios? = false AND solo_noticias_cientifico? = false [set random_noticias? true]
  if solo_noticias_politica? [
    set aux_solo_noticias_politica? true
  ]
  if solo_noticias_leyendas? [
    set aux_solo_noticias_leyendas? true
  ]
  if solo_noticias_negocios? [
    set aux_solo_noticias_negocios? true
  ]
  if solo_noticias_cientifico? [
    set aux_solo_noticias_cientifico? true
  ]
  create-noticias num-noticias-texto[
    hide-turtle
    set formato 0
    ifelse random_noticias?[
      set tema random 4
    ][
      if solo_noticias_politica? [
        set tema 0
      ]
      if solo_noticias_leyendas? [
        set tema 1
      ]
      if solo_noticias_negocios? [
        set tema 2
      ]
      if solo_noticias_cientifico? [
        set tema 3
      ]
    ]
    set reaccion_positiva 0
    set reaccion_negativa 0
    set caracteres 500
  ]
  create-noticias num-noticias-imagen[
    hide-turtle
    set formato 1
    ifelse random_noticias?[
      set tema random 4
    ][
      if solo_noticias_politica? [
        set tema 0
      ]
      if solo_noticias_leyendas? [
        set tema 1
      ]
      if solo_noticias_negocios? [
        set tema 2
      ]
      if solo_noticias_cientifico? [
        set tema 3
      ]
    ]
    set reaccion_positiva 0
    set reaccion_negativa 0
    set caracteres 0
  ]
  create-noticias num-noticias-video[
    hide-turtle
    set formato 2
    ifelse random_noticias?[
      set tema random 4
    ][
      if solo_noticias_politica? [
        set tema 0
      ]
      if solo_noticias_leyendas? [
        set tema 1
      ]
      if solo_noticias_negocios? [
        set tema 2
      ]
      if solo_noticias_cientifico? [
        set tema 3
      ]
    ]
    set reaccion_positiva 0
    set reaccion_negativa 0
    set caracteres 0
  ]
end

to setup-usuarios
  create-usuarios num-usuarios[
    setxy random-xcor random-ycor
    set color gray
    set shape "person student"
    set size 1
    set es_familia? true
    set es_amigo? false
    set es_colega? false
    set es_otros? false
    set intolerancia 0
    set preferencia_privacidad 0
    set preferencia_alcance 0
    set preferencia_facilidad 0
    set decision_difundir precision random-float 1.1 1
    set vinculacion_ideas_pre random 2
    set peso_vinculacion_ideas_pre 0.8
    set verificacion 0
    set confianza 1
    set peso_confianza 0
    set no_confianza_medios 0
    set peso_no_confianza_medios 0
    set impacto_emocional 1
    set peso_impacto_emocional 0.8
    set experiencia 0
    ifelse random-float 1  < 0.9 [ set usuario_whatsapp? true ][set usuario_whatsapp? false]
    ifelse random-float 1  < 0.7 [ set usuario_facebook? true ][set usuario_facebook? false]
    ifelse random-float 1  < 0.4 [ set usuario_twitter? true ][set usuario_twitter? false]
    set tema_politico? true
    set tema_leyendas_urbanas? false
    set tema_negocios? false
    set tema_cientifico? false
    set difusor? false
    set noticias_array []
    set contactos_facebook random (500 - 10) + 10
    set contactos_twitter random (1000 - 10) + 10
    set contactos_whatsapp random (100 - 10) + 10
    set conocimiento_facebook random 2
    set conocimiento_twitter random 2
    set conocimiento_whatsapp random 2
    ifelse conocimiento_facebook = 0 AND conocimiento_twitter = 0 AND conocimiento_whatsapp = 0 [
      let random_conocimiento 3
      if random_conocimiento = 0 [
        let aux_random_propenso_facebook random-float (10 - 0.1) + 0.1
        ifelse aux_random_propenso_facebook + propenso_facebook > 10 [set propenso_facebook 10][set propenso_facebook aux_random_propenso_facebook + propenso_facebook]
      ]
      if random_conocimiento = 1 [
        let aux_random_propenso_twitter random-float (10 - 0.1) + 0.1
        ifelse aux_random_propenso_twitter + propenso_twitter > 10 [set propenso_twitter 10][set propenso_twitter aux_random_propenso_twitter + propenso_twitter]
      ]
      if random_conocimiento = 2 [
        let aux_random_propenso_whatsapp random-float (10 - 0.1) + 0.1
        ifelse aux_random_propenso_whatsapp + propenso_whatsapp > 10 [set propenso_whatsapp 10][set propenso_whatsapp aux_random_propenso_whatsapp + propenso_whatsapp]
      ]
    ] [
      if conocimiento_facebook = 1 [
        let aux_random_propenso_facebook random-float (10 - 0.1) + 0.1
        ifelse aux_random_propenso_facebook + propenso_facebook > 10 [set propenso_facebook 10][set propenso_facebook aux_random_propenso_facebook + propenso_facebook]
      ]
      if conocimiento_twitter = 1 [
        let aux_random_propenso_twitter random-float (10 - 0.1) + 0.1
        ifelse aux_random_propenso_twitter + propenso_twitter > 10 [set propenso_twitter 10][set propenso_twitter aux_random_propenso_twitter + propenso_twitter]
      ]
      if conocimiento_whatsapp = 1 [
        let aux_random_propenso_whatsapp random-float (10 - 0.1) + 0.1
        ifelse aux_random_propenso_whatsapp + propenso_whatsapp > 10 [set propenso_whatsapp 10][set propenso_whatsapp aux_random_propenso_whatsapp + propenso_whatsapp]
      ]
    ]
    set limite_propenso_facebook random propenso_facebook
    set limite_propenso_twitter random propenso_twitter
    set limite_propenso_whatsapp random propenso_whatsapp
    set afinidad_contactos_facebook_politico ((contactos_facebook * random-float (0.75 - 0.05) + 0.05) / 100)
    set afinidad_contactos_facebook_leyendas ((contactos_facebook * random-float (0.75 - 0.05) + 0.05) / 100)
    set afinidad_contactos_facebook_negocios ((contactos_facebook * random-float (0.75 - 0.05) + 0.05) / 100)
    set afinidad_contactos_facebook_cientifico ((contactos_facebook * random-float (0.75 - 0.05) + 0.05) / 100)
    set afinidad_contactos_twitter_politico ((contactos_twitter * random-float (0.75 - 0.50) + 0.50) / 100)
    set afinidad_contactos_twitter_leyendas ((contactos_twitter * random-float (0.75 - 0.50) + 0.50) / 100)
    set afinidad_contactos_twitter_negocios ((contactos_twitter * random-float (0.75 - 0.50) + 0.50) / 100)
    set afinidad_contactos_twitter_cientifico ((contactos_twitter * random-float (0.75 - 0.50) + 0.50) / 100)
    set afinidad_contactos_whatsapp_politico 0
    set afinidad_contactos_whatsapp_leyendas 0
    set afinidad_contactos_whatsapp_negocios 0
    set afinidad_contactos_whatsapp_cientifico 0
    set compartir_noticia_dia? false
    set conocimiento_twitter random 2
  ]
  let i num-usuarios * 0.5
  ask n-of i usuarios[
    set shape "person business"
    setxy random-xcor random-ycor
  ]
  let j num-usuarios * 0.12
  ask n-of j usuarios[
    set peso_vinculacion_ideas_pre 0.6 + random-float 0.25
  ]
  let l num-usuarios * 0.08
  ask n-of l usuarios[
    set verificacion 1
  ]
  let m num-usuarios * 0.286
  ask n-of m usuarios[
    set peso_verificacion 0.7 + random-float 0.3
    set es_familia? false
    set es_amigo? true
    set es_colega? false
    set es_otros? false
  ]
  let n num-usuarios * 0.286
  ask n-of n usuarios[
    set peso_verificacion 0.6 + random-float 0.2
    set es_familia? false
    set es_amigo? false
    set es_colega? true
    set es_otros? false
  ]
  let o num-usuarios * 0.143
  ask n-of o usuarios[
    set peso_verificacion 0.4 + random-float 0.2
  ]
  let p num-usuarios * 0.143
  ask n-of p usuarios[
    set peso_verificacion 0.3 + random-float 0.2
  ]
  let q num-usuarios * 0.143
  ask n-of q usuarios[
    set peso_verificacion 0.2 + random-float 0.1
  ]
  let r num-usuarios * 0.25
  ask n-of r usuarios[
    set peso_confianza 0.65 + random-float 0.15
    set impacto_emocional 0
    set peso_vinculacion_ideas_pre 0.25 + random-float 0.1
    set es_familia? false
    set es_amigo? false
    set es_colega? false
    set es_otros? true
  ]
  let s num-usuarios * 0.125
  ask n-of s usuarios[
    set peso_confianza 0.7
    set peso_impacto_emocional 0.2 + random-float 0.1
    set peso_no_confianza_medios 0.45 + random-float 0.15
    set tema_politico? false
    set tema_leyendas_urbanas? false
    set tema_negocios? true
    set tema_cientifico? false
  ]
  let t num-usuarios * 0.125
  ask n-of t usuarios[
    set peso_no_confianza_medios 0.05  + random-float 0.05
    set tema_politico? false
    set tema_leyendas_urbanas? false
    set tema_negocios? false
    set tema_cientifico? true
  ]
  let u num-usuarios * 0.125
  ask n-of u usuarios[
    set peso_no_confianza_medios 0.4 + random-float 0.1
  ]
  let v num-usuarios * 0.4
  ask n-of v usuarios[
    set no_confianza_medios 1
    set confianza 0
  ]
  let w num-usuarios * 0.375
  ask n-of w usuarios[
    set no_confianza_medios 0.7
  ]
  let x num-usuarios * 0.222
  ask n-of x usuarios[
    set peso_confianza 0.65 + random-float 0.15
    set tema_politico? false
    set tema_leyendas_urbanas? true
    set tema_negocios? false
    set tema_cientifico? false
  ]
  let y num-usuarios * 0.444
  ask n-of y usuarios[
    set peso_confianza 0.6 + random-float 0.1
  ]
  let z num-usuarios * 0.111
  ask n-of z usuarios[
    set peso_confianza 0.2 + random-float 0.1
  ]

  ask n-of num-usuarios usuarios[
    ajustar-pesos
  ]

end

to setup-network-links
  let num-links (5 * num-usuarios) / 2
  while [count links < num-links ]
  [
    ask one-of usuarios
    [
      let choice (min-one-of (other usuarios with [not link-neighbor? myself])
        [distance myself])
      if choice != nobody [ create-link-with choice ]
    ]
  ]
  repeat 10
  [
    layout-spring usuarios links 0.3 (world-width / (sqrt num-usuarios)) 1
  ]
end

to setup-globals
  set total_facebook 0
  set total_twitter 0
  set total_whatsapp 0
  set total_x_hora_facebook 0
  set total_x_hora_twitter 0
  set total_x_hora_whatsapp 0
end

;;------------------------------------------------------------------------------------------------------------------------------------------
;;Go model
;;------------------------------------------------------------------------------------------------------------------------------------------

to go
  transmitir-noticia-falsa
  update_globals
  tick
  clean_globals
  if count usuarios with [difusor?] = 0 [
    stop
  ]
  if ticks mod 24 = 0 [
    ask usuarios[
      set compartir_noticia_dia? false
    ]
  ]
end

to transmitir-noticia-falsa
  ask usuarios with [difusor?] [
    set difusor? false
    let usuario_facebook_actual? usuario_facebook?
    let usuario_twitter_actual? usuario_twitter?
    let usuario_whatsapp_actual? usuario_whatsapp?
    let aux_noticia_formato noticia_formato
    let aux_noticia_tema noticia_tema
    let aux_noticia_identificador noticia_identificador
    let aux_self self
    let aux_conocimiento_twitter conocimiento_twitter
    let aux_preferencia_facilidad preferencia_facilidad
    let aux_preferencia_alcance preferencia_alcance
    let aux_es_familia? es_familia?
    let aux_es_amigo? es_amigo?
    let aux_es_otros? es_otros?
    let aux_preferencia_privacidad preferencia_privacidad
    ask link-neighbors with [usuario_facebook? = usuario_facebook_actual? OR usuario_twitter? = usuario_twitter_actual? OR usuario_whatsapp? = usuario_whatsapp_actual?] [
      ;show position aux_noticia_identificador noticias_array
      if position aux_noticia_identificador noticias_array = false [
        ; SET no_confianza_medios
        ifelse random-float 1 < 0.751 [set no_confianza_medios 1] [set no_confianza_medios 0]
        ; SET peso_no_confianza_medios
        ifelse random-float 1 < 0.268 [set peso_no_confianza_medios random-float 0.4] [ifelse random-float 1 < 0.3 [set peso_no_confianza_medios random-float (0.6 - 0.4) + 0.4 ] [ifelse random-float 1 < 0.432 [set peso_no_confianza_medios random-float (1 - 0.7) + 0.7 ][]]]
        ; SET confianza
        if es_amigo? [ifelse random-float 1 < 0.42 [set confianza 1][set confianza 0]]
        if es_familia? [ifelse random-float 1 < 0.40 [set confianza 1][set confianza 0]]
        if es_colega? [ifelse random-float 1 < 0.10 [set confianza 1][set confianza 0]]
        if es_familia? [ifelse random-float 1 < 0.07 [set confianza 1][set confianza 0]]
        ; SET peso_confianza
        ifelse random-float 1 < 0.293 [set peso_confianza random-float 0.4] [ifelse random-float 1 < 0.387 [set peso_confianza random-float (0.7 - 0.4) + 0.4 ] [ifelse random-float 1 < 0.326 [set peso_confianza random-float (1 - 0.8) + 0.8 ][]]]
        ;SET temas
        if random-float 1 < 0.7 [set tema_politico? true]
        if random-float 1 < 0.55 [set tema_leyendas_urbanas? true]
        if random-float 1 < 0.7 [set tema_negocios? true]
        if random-float 1 < 0.7 [set tema_cientifico? true]
        ; SET verificacion
        if experiencia >= 0 AND experiencia <= 20 [ifelse random-float 1 < 0.9 [set verificacion 1][set verificacion 0]]
        if experiencia > 20 AND experiencia <= 40 [ifelse random-float 1 < 0.7 [set verificacion 1][set verificacion 0]]
        if experiencia > 40 AND experiencia <= 60 [ifelse random-float 1 < 0.6 [set verificacion 1][set verificacion 0]]
        if experiencia > 60 AND experiencia <= 80 [ifelse random-float 1 < 0.4 [set verificacion 1][set verificacion 0]]
        if experiencia > 80 AND experiencia <= 100 [ifelse random-float 1 < 0.2 [set verificacion 1][set verificacion 0]]
        ; SET impacto emocional
        if aux_noticia_tema = 0 AND aux_noticia_formato = 2 [ifelse random-float 1 < 0.6 [set impacto_emocional 1][set impacto_emocional 0]]
        if aux_noticia_tema = 0 AND aux_noticia_formato = 1 [ifelse random-float 1 < 0.45 [set impacto_emocional 1][set impacto_emocional 0]]
        if aux_noticia_tema = 0 AND aux_noticia_formato = 0 [ifelse random-float 1 < 0.38 [set impacto_emocional 1][set impacto_emocional 0]]
        if aux_noticia_tema = 1 AND aux_noticia_formato = 2 [ifelse random-float 1 < 0.52 [set impacto_emocional 1][set impacto_emocional 0]]
        if aux_noticia_tema = 1 AND aux_noticia_formato = 1 [ifelse random-float 1 < 0.32 [set impacto_emocional 1][set impacto_emocional 0]]
        if aux_noticia_tema = 1 AND aux_noticia_formato = 0 [ifelse random-float 1 < 0.28 [set impacto_emocional 1][set impacto_emocional 0]]
        if aux_noticia_tema = 2 AND aux_noticia_formato = 2 [ifelse random-float 1 < 0.47 [set impacto_emocional 1][set impacto_emocional 0]]
        if aux_noticia_tema = 2 AND aux_noticia_formato = 1 [ifelse random-float 1 < 0.28 [set impacto_emocional 1][set impacto_emocional 0]]
        if aux_noticia_tema = 2 AND aux_noticia_formato = 0 [ifelse random-float 1 < 0.20 [set impacto_emocional 1][set impacto_emocional 0]]
        if aux_noticia_tema = 3 AND aux_noticia_formato = 2 [ifelse random-float 1 < 0.38 [set impacto_emocional 1][set impacto_emocional 0]]
        if aux_noticia_tema = 3 AND aux_noticia_formato = 1 [ifelse random-float 1 < 0.20 [set impacto_emocional 1][set impacto_emocional 0]]
        if aux_noticia_tema = 3 AND aux_noticia_formato = 0 [ifelse random-float 1 < 0.15 [set impacto_emocional 1][set impacto_emocional 0]]
        ; SET peso impacto emocional
        ifelse random-float 1 < 0.25 [set peso_impacto_emocional random-float 0.40] [ifelse random-float 1 < 0.452 [set peso_impacto_emocional random-float (0.7 - 0.4) + 0.4 ] [ifelse random-float 1 < 0.291 [set peso_impacto_emocional random-float (1 - 0.7) + 0.7 ][]]]
        ; Ajuste pesos para que sumPesos = 1
        ajustar-pesos
        let decision_compartir (no_confianza_medios * peso_no_confianza_medios) + (vinculacion_ideas_pre * peso_vinculacion_ideas_pre) + (verificacion * peso_verificacion) + (confianza * peso_confianza) + (impacto_emocional * peso_impacto_emocional)
        if decision_compartir < random-float 1 [
          let aux_compartir_noticia_dia? false
          ifelse compartir_noticia_dia? [set aux_compartir_noticia_dia? true] [set compartir_noticia_dia? true]
          definir-canal aux_self aux_noticia_identificador aux_noticia_formato aux_noticia_tema aux_compartir_noticia_dia? aux_conocimiento_twitter
          aux_preferencia_facilidad aux_preferencia_alcance aux_es_familia? aux_es_amigo? aux_es_otros? aux_preferencia_privacidad
        ]
      ]
    ]
    set color gray
  ]
end

to definir-canal [aux_self aux_noticia_identificador aux_noticia_formato aux_noticia_tema aux_compartir_noticia_dia? aux_conocimiento_twitter
  aux_preferencia_facilidad aux_preferencia_alcance aux_es_familia? aux_es_amigo? aux_es_otros? aux_preferencia_privacidad]
let aux_propenso_facebook propenso_facebook
let aux_propenso_twitter propenso_twitter
let aux_propenso_whatsapp propenso_whatsapp
let aux_limite_propenso_facebook limite_propenso_facebook
let aux_limite_propenso_twitter limite_propenso_twitter
let aux_limite_propenso_whatsapp limite_propenso_whatsapp
let aux_afinidad_contactos_facebook_politico afinidad_contactos_facebook_politico
let aux_afinidad_contactos_facebook_leyendas afinidad_contactos_facebook_leyendas
let aux_afinidad_contactos_facebook_negocios afinidad_contactos_facebook_negocios
let aux_afinidad_contactos_facebook_cientifico afinidad_contactos_facebook_cientifico
let aux_afinidad_contactos_twitter_politico afinidad_contactos_twitter_politico
let aux_afinidad_contactos_twitter_leyendas afinidad_contactos_twitter_leyendas
let aux_afinidad_contactos_twitter_negocios afinidad_contactos_twitter_negocios
let aux_afinidad_contactos_twitter_cientifico afinidad_contactos_twitter_cientifico
let aux_afinidad_contactos_whatsapp_politico afinidad_contactos_whatsapp_politico
let aux_afinidad_contactos_whatsapp_leyendas afinidad_contactos_whatsapp_leyendas
let aux_afinidad_contactos_whatsapp_negocios afinidad_contactos_whatsapp_negocios
let aux_afinidad_contactos_whatsapp_cientifico afinidad_contactos_whatsapp_cientifico
let aux_contactos_facebook contactos_facebook
let aux_contactos_twitter contactos_twitter
let aux_contactos_whatsapp contactos_whatsapp
let aux_reaccion_positiva 0
let aux_reaccion_negativa 0
let verificaciones 0
ask link-with aux_self [
  ifelse (aux_propenso_facebook > aux_propenso_twitter AND aux_propenso_facebook > aux_propenso_whatsapp) [
    calcular-canal-facebook aux_contactos_facebook aux_compartir_noticia_dia? aux_noticia_identificador verificaciones
    aux_afinidad_contactos_facebook_politico aux_reaccion_positiva aux_reaccion_negativa aux_afinidad_contactos_facebook_leyendas aux_afinidad_contactos_facebook_negocios
    aux_afinidad_contactos_facebook_cientifico aux_propenso_facebook aux_preferencia_alcance aux_limite_propenso_facebook
    set total_facebook total_facebook + 1
    set total_x_hora_facebook total_x_hora_facebook + 1
    ][ifelse (aux_propenso_twitter > aux_propenso_facebook AND aux_propenso_twitter > aux_propenso_whatsapp) [
      calcular-canal-twitter aux_contactos_twitter aux_compartir_noticia_dia? aux_noticia_identificador verificaciones aux_afinidad_contactos_twitter_politico
      aux_reaccion_positiva aux_reaccion_negativa aux_afinidad_contactos_twitter_leyendas aux_afinidad_contactos_twitter_negocios aux_afinidad_contactos_twitter_cientifico
      aux_propenso_twitter aux_conocimiento_twitter aux_preferencia_facilidad aux_limite_propenso_twitter
      set total_twitter total_twitter + 1
      set total_x_hora_twitter total_x_hora_twitter + 1
    ][
      calcular-canal-whatsapp aux_es_familia? aux_noticia_identificador aux_es_amigo? aux_es_otros? aux_propenso_whatsapp aux_preferencia_privacidad aux_limite_propenso_whatsapp
      set total_whatsapp total_whatsapp + 1
      set total_x_hora_whatsapp total_x_hora_whatsapp + 1
  ]]
]
set propenso_facebook aux_propenso_facebook
set propenso_twitter aux_propenso_twitter
set propenso_whatsapp aux_propenso_whatsapp
ser-fuente-noticia-falsa false aux_noticia_formato aux_noticia_tema aux_noticia_identificador
end

to calcular-canal-facebook [aux_contactos_facebook aux_compartir_noticia_dia? aux_noticia_identificador verificaciones aux_afinidad_contactos_facebook_politico
  aux_reaccion_positiva aux_reaccion_negativa aux_afinidad_contactos_facebook_leyendas aux_afinidad_contactos_facebook_negocios aux_afinidad_contactos_facebook_cientifico
  aux_propenso_facebook aux_preferencia_alcance aux_limite_propenso_facebook]
let reacciones random aux_contactos_facebook
if ticks mod 24 = 13 OR ticks mod 24 = 14 OR ticks mod 24 = 15 OR ticks mod 24 = 16
  [
    set reacciones reacciones + reacciones * 0.18
  ]
if ticks mod 24 = 0 OR ticks mod 24 = 1 OR ticks mod 24 = 2
OR ticks mod 24 = 3 OR ticks mod 24 = 4 OR ticks mod 24 = 5
OR ticks mod 24 = 6 OR ticks mod 24 = 7 OR ticks mod 24 = 8
[
  set reacciones random 6
]
if aux_compartir_noticia_dia? [ set reacciones reacciones - reacciones * random-float(0.7 - 0.5) + 0.5 ]
if [formato] of aux_noticia_identificador = 0 AND [caracteres] of aux_noticia_identificador > 250 [
  set reacciones reacciones - reacciones * random-float(0.25 - 0.15) + 0.15
]
if [formato] of aux_noticia_identificador = 1 [
  set reacciones reacciones + reacciones * random-float(0.15 - 0.08) + 0.08
]
if [formato] of aux_noticia_identificador = 2 [
  set reacciones reacciones + reacciones * random-float(0.18 - 0.10) + 0.10
]
set verificaciones reacciones * random (0.15 - 0.1) + 0.1
if aux_contactos_facebook > 200 [set aux_afinidad_contactos_facebook_politico aux_afinidad_contactos_facebook_politico - ((aux_afinidad_contactos_facebook_politico * random-float (0.15 - 0.05) + 0.05) / 100) ]
if aux_afinidad_contactos_facebook_politico > 0.5 [
  set aux_reaccion_positiva (reacciones * random-float (0.9 - 0.6) + 0.6)
  set aux_reaccion_negativa reacciones - aux_reaccion_positiva
]
ifelse [tema] of aux_noticia_identificador = 1 [
  set reacciones reacciones * 0.33
  if aux_contactos_facebook > 200 [set aux_afinidad_contactos_facebook_leyendas aux_afinidad_contactos_facebook_leyendas - ((aux_afinidad_contactos_facebook_leyendas * random-float (0.06 - 0.03) + 0.03) / 100) ]
  if aux_afinidad_contactos_facebook_politico > 0.5 [
    set aux_reaccion_positiva (reacciones * random-float (0.85 - 0.55) + 0.55)
    set aux_reaccion_negativa reacciones - aux_reaccion_positiva
  ]
] [
  if [tema] of aux_noticia_identificador = 2[
    set reacciones reacciones * 0.60
    if aux_contactos_facebook > 200 [set aux_afinidad_contactos_facebook_negocios aux_afinidad_contactos_facebook_negocios - ((aux_afinidad_contactos_facebook_negocios * random-float (0.08 - 0.04) + 0.04) / 100) ]
    if aux_afinidad_contactos_facebook_politico > 0.5 [
      set aux_reaccion_positiva (reacciones * random-float (0.84 - 0.54) + 0.54)
      set aux_reaccion_negativa reacciones - aux_reaccion_positiva
    ]
  ]
  if [tema] of aux_noticia_identificador = 3[
    set reacciones reacciones * 0.73
    if aux_contactos_facebook > 200 [set aux_afinidad_contactos_facebook_cientifico aux_afinidad_contactos_facebook_cientifico - ((aux_afinidad_contactos_facebook_cientifico * random-float random-float (0.05 - 0.03) + 0.03) / 100) ]
    if aux_afinidad_contactos_facebook_politico > 0.5 [
      set aux_reaccion_positiva (reacciones * random-float (0.83 - 0.53) + 0.53)
      set aux_reaccion_negativa reacciones - aux_reaccion_positiva
    ]
  ]
]
ifelse aux_reaccion_positiva > aux_reaccion_negativa[
  ifelse aux_preferencia_alcance = 1 [
    ifelse aux_reaccion_positiva > reacciones * 0.8 [set aux_propenso_facebook aux_propenso_facebook + 1] [set aux_propenso_facebook aux_propenso_facebook + 0.5]
  ][
    ifelse aux_reaccion_positiva > reacciones * 0.8 [set aux_propenso_facebook aux_propenso_facebook + 0.7] [set aux_propenso_facebook aux_propenso_facebook + 0.5]
  ]
] [
  ifelse aux_preferencia_alcance = 1 [
    ifelse aux_reaccion_positiva > reacciones * 0.8 [set aux_propenso_facebook aux_propenso_facebook - 1] [set aux_propenso_facebook aux_propenso_facebook - 0.5]
  ][
    ifelse aux_reaccion_positiva > reacciones * 0.8 [set aux_propenso_facebook aux_propenso_facebook - 0.7] [set aux_propenso_facebook aux_propenso_facebook - 0.5]
  ]
]
if random 2 = 1 [
  ifelse verificaciones > reacciones * 0.10 [
    set aux_propenso_facebook aux_propenso_facebook + 1
  ] [
    set aux_propenso_facebook aux_propenso_facebook + 0.5
  ]
]
if reacciones = 0 [set aux_propenso_facebook aux_propenso_facebook - 0.5]
if reacciones < 0 [set aux_propenso_facebook aux_propenso_facebook - 0.3]
set color blue
if aux_propenso_facebook < aux_limite_propenso_facebook [
  set aux_propenso_facebook 0
]
end

to calcular-canal-twitter [aux_contactos_twitter aux_compartir_noticia_dia? aux_noticia_identificador verificaciones aux_afinidad_contactos_twitter_politico
  aux_reaccion_positiva aux_reaccion_negativa aux_afinidad_contactos_twitter_leyendas aux_afinidad_contactos_twitter_negocios aux_afinidad_contactos_twitter_cientifico
  aux_propenso_twitter aux_conocimiento_twitter aux_preferencia_facilidad aux_limite_propenso_twitter]
let es_tendencia_twitter random 2
let reacciones random aux_contactos_twitter
if ticks mod 24 = 13 OR ticks mod 24 = 14 OR ticks mod 24 = 15
  [
    set reacciones reacciones + reacciones * 0.22
  ]
if ticks mod 24 = 20 OR ticks mod 24 = 21 OR ticks mod 24 = 22
OR ticks mod 24 = 23 OR ticks mod 24 = 0 OR ticks mod 24 = 1
OR ticks mod 24 = 2 OR ticks mod 24 = 3 OR ticks mod 24 = 4
OR ticks mod 24 = 5 OR ticks mod 24 = 6 OR ticks mod 24 = 7 OR ticks mod 24 = 8
[
  set reacciones random 20
]
if aux_compartir_noticia_dia? [ set reacciones reacciones + reacciones * random-float(0.15 - 0.1) + 0.1 ]
if [formato] of aux_noticia_identificador = 1 [
  set reacciones reacciones + reacciones * random-float(0.15 - 0.08) + 0.08
]
if [formato] of aux_noticia_identificador = 2 [
  set reacciones reacciones + reacciones * random-float(0.18 - 0.10) + 0.10
]
ifelse es_tendencia_twitter = 1 AND aux_conocimiento_twitter = 1 [set reacciones reacciones + reacciones * 0.12] [set reacciones reacciones - reacciones * 0.12]
set verificaciones reacciones * random (0.15 - 0.1) + 0.1
if aux_contactos_twitter > 700 [set aux_afinidad_contactos_twitter_politico aux_afinidad_contactos_twitter_politico - ((aux_afinidad_contactos_twitter_politico * random-float (0.11 - 0.03) + 0.03) / 100) ]
if aux_afinidad_contactos_twitter_politico > 0.5 [
  set aux_reaccion_positiva (reacciones * random-float (0.9 - 0.6) + 0.6)
  set aux_reaccion_negativa reacciones - aux_reaccion_positiva
]
ifelse [tema] of aux_noticia_identificador = 1 [
  set reacciones reacciones * 0.33
  if aux_contactos_twitter > 700 [set aux_afinidad_contactos_twitter_leyendas aux_afinidad_contactos_twitter_leyendas - ((aux_afinidad_contactos_twitter_leyendas * random-float (0.05 - 0.03) + 0.03) / 100) ]
  if aux_afinidad_contactos_twitter_politico > 0.5 [
    set aux_reaccion_positiva (reacciones * random-float (0.85 - 0.55) + 0.55)
    set aux_reaccion_negativa reacciones - aux_reaccion_positiva
  ]
] [
  if [tema] of aux_noticia_identificador = 2[
    set reacciones reacciones * 0.60
    if aux_contactos_twitter > 700 [set aux_afinidad_contactos_twitter_negocios aux_afinidad_contactos_twitter_negocios - ((aux_afinidad_contactos_twitter_negocios * random-float (0.06 - 0.03) + 0.03) / 100) ]
    if aux_afinidad_contactos_twitter_politico > 0.5 [
      set aux_reaccion_positiva (reacciones * random-float (0.84 - 0.54) + 0.54)
      set aux_reaccion_negativa reacciones - aux_reaccion_positiva
    ]
  ]
  if [tema] of aux_noticia_identificador = 3[
    set reacciones reacciones * 0.73
    if aux_contactos_twitter > 700 [set aux_afinidad_contactos_twitter_cientifico aux_afinidad_contactos_twitter_cientifico - ((aux_afinidad_contactos_twitter_cientifico * random-float random-float (0.04 - 0.02) + 0.02) / 100) ]
    if aux_afinidad_contactos_twitter_politico > 0.5 [
      set aux_reaccion_positiva (reacciones * random-float (0.83 - 0.53) + 0.53)
      set aux_reaccion_negativa reacciones - aux_reaccion_positiva
    ]
  ]
]
ifelse aux_reaccion_positiva > aux_reaccion_negativa[
  ifelse aux_preferencia_facilidad = 1 [
    ifelse aux_reaccion_positiva > reacciones * 0.8 [set aux_propenso_twitter aux_propenso_twitter + 1] [set aux_propenso_twitter aux_propenso_twitter + 0.5]
  ][
    ifelse aux_reaccion_positiva > reacciones * 0.8 [set aux_propenso_twitter aux_propenso_twitter + 0.7] [set aux_propenso_twitter aux_propenso_twitter + 0.5]
  ]
] [
  ifelse aux_preferencia_facilidad = 1 [
    ifelse aux_reaccion_positiva > reacciones * 0.8 [set aux_propenso_twitter aux_propenso_twitter - 1] [set aux_propenso_twitter aux_propenso_twitter - 0.5]
  ][
    ifelse aux_reaccion_positiva > reacciones * 0.8 [set aux_propenso_twitter aux_propenso_twitter - 0.7] [set aux_propenso_twitter aux_propenso_twitter - 0.5]
  ]
]
if random 2 = 1 [
  ifelse verificaciones > reacciones * 0.10 [
    set aux_propenso_twitter aux_propenso_twitter + 1
  ] [
    set aux_propenso_twitter aux_propenso_twitter + 0.5
  ]
]
if reacciones = 0 [set aux_propenso_twitter aux_propenso_twitter - 0.5]
if reacciones < 0 [set aux_propenso_twitter aux_propenso_twitter - 0.3]
set color cyan + 1
if aux_propenso_twitter < aux_limite_propenso_twitter [
  set aux_propenso_twitter 0
]
end

to calcular-canal-whatsapp[aux_es_familia? aux_noticia_identificador aux_es_amigo? aux_es_otros? aux_propenso_whatsapp aux_preferencia_privacidad aux_limite_propenso_whatsapp]
  let rechazo 1
  if aux_es_familia? AND [tema] of aux_noticia_identificador = 0 [if random-float 1 < random-float (0.25 - 0.08) + 0.08 [set rechazo 0]]
  if aux_es_familia? AND [tema] of aux_noticia_identificador = 1 [if random-float 1 < random-float (0.1 - 0.05) + 0.05 [set rechazo 0]]
  if aux_es_familia? AND [tema] of aux_noticia_identificador = 2 [if random-float 1 < random-float (0.15 - 0.06) + 0.06 [set rechazo 0]]
  if aux_es_familia? AND [tema] of aux_noticia_identificador = 3 [if random-float 1 < random-float (0.18 - 0.07) + 0.07 [set rechazo 0]]
  if aux_es_amigo? AND [tema] of aux_noticia_identificador = 0 [if random-float 1 < random-float (0.05 - 0.01) + 0.01 [set rechazo 0]]
  if aux_es_amigo? AND [tema] of aux_noticia_identificador = 1 [if random-float 1 < random-float (0.02 - 0.01) + 0.01 [set rechazo 0]]
  if aux_es_amigo? AND [tema] of aux_noticia_identificador = 2 [if random-float 1 < random-float (0.03 - 0.03) + 0.01 [set rechazo 0]]
  if aux_es_amigo? AND [tema] of aux_noticia_identificador = 3 [if random-float 1 < random-float (0.06 - 0.01) + 0.01 [set rechazo 0]]
  if aux_es_otros? AND [tema] of aux_noticia_identificador = 0 [if random-float 1 < random-float (0.3 - 0.02) + 0.02 [set rechazo 0]]
  if aux_es_otros? AND [tema] of aux_noticia_identificador = 1 [if random-float 1 < random-float (0.2 - 0.05) + 0.05 [set rechazo 0]]
  if aux_es_otros? AND [tema] of aux_noticia_identificador = 2 [if random-float 1 < random-float (0.18 - 0.03) + 0.03 [set rechazo 0]]
  if aux_es_otros? AND [tema] of aux_noticia_identificador = 3 [if random-float 1 < random-float (0.2 - 0.04) + 0.04 [set rechazo 0]]
  if [formato] of aux_noticia_identificador = 0 AND [caracteres] of aux_noticia_identificador > 200 [
    if random-float 1 < random-float (0.08 - 0.06) + 0.06 [set rechazo 0]
  ]
  if [formato] of aux_noticia_identificador = 1 [
    if random-float 1 < random-float (0.15 - 0.08) + 0.08 [set rechazo 0]
  ]
  if [formato] of aux_noticia_identificador = 1 [
    if random-float 1 < random-float (0.18 - 0.09) + 0.09 [set rechazo 0]
  ]
  ifelse rechazo = 0 [set aux_propenso_whatsapp aux_propenso_whatsapp + 1] [set aux_propenso_whatsapp aux_propenso_whatsapp - 1]
  let aprobacion random-float 1
  let comentario_positivo 0
  ifelse aprobacion > 0.5  [
    set comentario_positivo comentario_positivo + 1
    set aux_propenso_whatsapp aux_propenso_whatsapp + 1
  ] [
    set aux_propenso_whatsapp aux_propenso_whatsapp - 0.5
  ]
  if ([reaccion_positiva] of aux_noticia_identificador) > ([reaccion_negativa] of aux_noticia_identificador)[
    set aux_propenso_whatsapp aux_propenso_whatsapp + 1
  ]
  if aux_preferencia_privacidad = 1 AND rechazo = 0 [set aux_propenso_whatsapp aux_propenso_whatsapp + 1.5]
  if aux_preferencia_privacidad = 1 AND rechazo = 1 [set aux_propenso_whatsapp aux_propenso_whatsapp + 0.8]
  if random-float 1 < 0.05 [
    set aux_propenso_whatsapp aux_propenso_whatsapp - 0.08
  ]
  set color green
  if aux_propenso_whatsapp < aux_limite_propenso_whatsapp [
  set aux_propenso_whatsapp 0
]
end

to ajustar-pesos
  let sumPesos (peso_vinculacion_ideas_pre + peso_verificacion + peso_confianza + peso_no_confianza_medios + peso_impacto_emocional)
  if(sumPesos != 1)[
    ifelse sumPesos < 1 [
      let diff 1 - sumPesos
      let randomPeso random 5
      if randomPeso = 0 [set peso_vinculacion_ideas_pre (peso_vinculacion_ideas_pre + diff)]
      if randomPeso = 1 [set peso_verificacion (peso_verificacion + diff)]
      if randomPeso = 2 [set peso_confianza (peso_confianza + diff)]
      if randomPeso = 3 [set peso_no_confianza_medios (peso_no_confianza_medios + diff)]
      if randomPeso = 4 [set peso_impacto_emocional (peso_impacto_emocional + diff)]
    ] [
      let diff sumPesos - 1
      let randomPeso random 5
      if randomPeso = 0 [set peso_vinculacion_ideas_pre (peso_vinculacion_ideas_pre - diff)]
      if randomPeso = 1 [set peso_verificacion (peso_verificacion - diff)]
      if randomPeso = 2 [set peso_confianza (peso_confianza - diff)]
      if randomPeso = 3 [set peso_no_confianza_medios (peso_no_confianza_medios - diff)]
      if randomPeso = 4 [set peso_impacto_emocional (peso_impacto_emocional - diff)]
    ]
  ]
end

to ser-fuente-noticia-falsa [nueva_noticia? parametro_noticia_formato parametro_noticia_tema parametro_noticia]
  set difusor? true
  set color red
  set compartir_noticia_dia? true
  ifelse(nueva_noticia?)[
    let init_current_noticia one-of noticias
    set noticia_formato [formato] of init_current_noticia
    set noticia_tema [tema] of init_current_noticia
    set noticias_array lput init_current_noticia noticias_array
    set noticia_identificador init_current_noticia
    ask init_current_noticia [
      set canal random 3
    ]
  ][
    set noticia_formato parametro_noticia_formato
    set noticia_tema parametro_noticia_tema
    set noticia_identificador parametro_noticia
    set noticias_array lput parametro_noticia noticias_array
  ]

end

to update_globals
  set total_redes total_facebook + total_twitter + total_whatsapp
end

to clean_globals
  set total_x_hora_facebook 0
  set total_x_hora_twitter 0
  set total_x_hora_whatsapp 0
end





@#$#@#$#@
GRAPHICS-WINDOW
226
10
894
679
-1
-1
20.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

SLIDER
4
11
211
44
num-usuarios
num-usuarios
0
2000
2000.0
5
1
NIL
HORIZONTAL

BUTTON
9
494
206
527
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
9
536
206
569
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
4
49
212
82
num-init-usuarios-transmisores
num-init-usuarios-transmisores
0
200
200.0
1
1
NIL
HORIZONTAL

SLIDER
159
96
192
268
num-noticias-video
num-noticias-video
0
1000
1000.0
1
1
NIL
VERTICAL

SLIDER
81
96
114
267
num-noticias-imagen
num-noticias-imagen
0
1000
1000.0
1
1
NIL
VERTICAL

SLIDER
7
95
40
267
num-noticias-texto
num-noticias-texto
0
1000
1000.0
1
1
NIL
VERTICAL

SWITCH
5
289
205
322
solo_noticias_politica?
solo_noticias_politica?
1
1
-1000

SWITCH
4
335
209
368
solo_noticias_leyendas?
solo_noticias_leyendas?
1
1
-1000

SWITCH
6
381
209
414
solo_noticias_negocios?
solo_noticias_negocios?
1
1
-1000

SWITCH
9
435
208
468
solo_noticias_cientifico?
solo_noticias_cientifico?
0
1
-1000

PLOT
947
18
1597
257
Transmision progresiva
horas
noticias
0.0
150.0
0.0
10000.0
true
true
"" ""
PENS
"facebook" 1.0 0 -13345367 true "" "plot total_facebook"
"twitter" 1.0 0 -8990512 true "" "plot total_twitter"
"whatsapp" 1.0 0 -10899396 true "" "plot total_whatsapp"
"todas" 1.0 0 -5825686 true "" "plot total_redes"

PLOT
946
290
1595
538
Transmision frecuencia
horas
noticias
0.0
130.0
0.0
100.0
true
true
"" ""
PENS
"facebook" 1.0 0 -13345367 true "" "plot total_x_hora_facebook"
"twitter" 1.0 0 -8990512 true "" "plot total_x_hora_twitter"
"whatsapp" 1.0 0 -10899396 true "" "plot total_x_hora_whatsapp"
"todas" 1.0 0 -5825686 true "" ""

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

person business
false
0
Rectangle -1 true false 120 90 180 180
Polygon -13345367 true false 135 90 150 105 135 180 150 195 165 180 150 105 165 90
Polygon -7500403 true true 120 90 105 90 60 195 90 210 116 154 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 183 153 210 210 240 195 195 90 180 90 150 165
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 76 172 91
Line -16777216 false 172 90 161 94
Line -16777216 false 128 90 139 94
Polygon -13345367 true false 195 225 195 300 270 270 270 195
Rectangle -13791810 true false 180 225 195 300
Polygon -14835848 true false 180 226 195 226 270 196 255 196
Polygon -13345367 true false 209 202 209 216 244 202 243 188
Line -16777216 false 180 90 150 165
Line -16777216 false 120 90 150 165

person student
false
0
Polygon -13791810 true false 135 90 150 105 135 165 150 180 165 165 150 105 165 90
Polygon -7500403 true true 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -1 true false 100 210 130 225 145 165 85 135 63 189
Polygon -13791810 true false 90 210 120 225 135 165 67 130 53 189
Polygon -1 true false 120 224 131 225 124 210
Line -16777216 false 139 168 126 225
Line -16777216 false 140 167 76 136
Polygon -7500403 true true 105 90 60 195 90 210 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
