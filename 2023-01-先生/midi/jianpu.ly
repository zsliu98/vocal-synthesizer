\version "2.18.0"
#(set-global-staff-size 20)

% un-comment the next line to remove Lilypond tagline:
% \header { tagline="" }

\pointAndClickOff

\paper {
  print-all-headers = ##t %% allow per-score headers

  % un-comment the next line for A5:
  % #(set-default-paper-size "a5" )

  % un-comment the next line for no page numbers:
  % print-page-number = ##f

  % un-comment the next 3 lines for a binding edge:
  % two-sided = ##t
  % inner-margin = 20\mm
  % outer-margin = 10\mm

  % un-comment the next line for a more space-saving header layout:
  % scoreTitleMarkup = \markup { \center-column { \fill-line { \magnify #1.5 { \bold { \fromproperty #'header:dedication } } \magnify #1.5 { \bold { \fromproperty #'header:title } } \fromproperty #'header:composer } \fill-line { \fromproperty #'header:instrument \fromproperty #'header:subtitle \smaller{\fromproperty #'header:subsubtitle } } } }

  % As jianpu-ly was run on a Mac, we include a Mac fonts workaround.
  % The Mac version of Lilypond 2.18 used Arial Unicode MS as a
  % fallback even in the Serif font, but 2.20 drops this in Serif
  % (using it only in Sans), which means any Serif text (titles,
  % lyrics etc) that includes Chinese will likely fall back to
  % Japanese fonts which don't support all Simplified hanzi.
  % This brings back 2.18's behaviour on 2.20+
  % (you might have to comment it out to run this on 2.18)
  #(define fonts
    (set-global-fonts
     #:roman "Times New Roman,Arial Unicode MS"
     #:factor (/ staff-height pt 20)
    ))
}

\score {
<< \override Score.BarNumber.break-visibility = #center-visible
\override Score.BarNumber.Y-offset = -1
\set Score.barNumberVisibility = #(every-nth-bar-number-visible 5)

%% === BEGIN JIANPU STAFF ===
    \new RhythmicStaff \with {
    \consists "Accidental_engraver" 
    %% Get rid of the stave but not the barlines:
    \override StaffSymbol.line-count = #0 %% tested in 2.15.40, 2.16.2, 2.18.0, 2.18.2, 2.20.0 and 2.22.2
    \override BarLine.bar-extent = #'(-2 . 2) %% LilyPond 2.18: please make barlines as high as the time signature even though we're on a RhythmicStaff (2.16 and 2.15 don't need this although its presence doesn't hurt; Issue 3685 seems to indicate they'll fix it post-2.18)
    }
    { \new Voice="jianpu" {

    \override Beam.transparent = ##f % (needed for LilyPond 2.18 or the above switch will also hide beams)
    \override Stem.direction = #DOWN
    \override Tie.staff-position = #2.5
    \tupletUp

    \override Stem.length-fraction = #0.5
    \override Beam.beam-thickness = #0.1
    \override Beam.length-fraction = #0.5
    \override Voice.Rest.style = #'neomensural % this size tends to line up better (we'll override the appearance anyway)
    \override Accidental.font-size = #-4
    \override TupletBracket.bracket-visibility = ##t
\set Voice.chordChanges = ##t %% 2.19 bug workaround

    \override Staff.TimeSignature.style = #'numbered
    \override Staff.Stem.transparent = ##t
     \tempo 4=126 \mark \markup{1=G} \time 4/4 #(define (note-nought grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "0")))))))
  \applyOutput #'Voice #note-nought r4
#(define (note-dash grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dash r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 2: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 3: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 4: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 5: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 6: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 7: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 8: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 9: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 10: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 11: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 12: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 13: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 14: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 15: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 16: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
#(define (note-one grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "1")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c8[-\tweak #'X-offset #0.6 _.
#(define (note-two grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "2")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d8]-\tweak #'X-offset #0.6 _.
#(define (note-five grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "5")))))))
| %{ bar 17: %}
  \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d8[-\tweak #'X-offset #0.6 _.
]    \applyOutput #'Voice #note-two d4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d8[]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d8]-\tweak #'X-offset #0.6 _.
( | %{ bar 18: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d8[-\tweak #'X-offset #0.6 _.
]  ) #(define (note-three grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "3")))))))
  \applyOutput #'Voice #note-three e4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8[]-\tweak #'X-offset #0.6 _.
  \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d8]-\tweak #'X-offset #0.6 _.
| %{ bar 19: %}
  \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8[-\tweak #'X-offset #0.6 _.
]    \applyOutput #'Voice #note-two d4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
  \applyOutput #'Voice #note-one c4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8[]-\tweak #'X-offset #0.6 _.
( | %{ bar 20: %}
  \applyOutput #'Voice #note-three e4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
)   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8[-\tweak #'X-offset #0.6 _.
#(define (note-four grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "4")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f8]-\tweak #'X-offset #0.6 _.
| %{ bar 21: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c8]-\tweak #'X-offset #0.6 _.
  \applyOutput #'Voice #note-one c4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d8]-\tweak #'X-offset #0.6 _.
| %{ bar 22: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c8]-\tweak #'X-offset #0.6 _.
  \applyOutput #'Voice #note-nought r4   \applyOutput #'Voice #note-nought r4 #(define (note-six grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "6")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a,8[-\tweak #'X-offset #0.3 _\markup{\bold :}
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c8]-\tweak #'X-offset #0.6 _.
| %{ bar 23: %}
  \applyOutput #'Voice #note-two d4.-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
  \applyOutput #'Voice #note-three e4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
  \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d8[]-\tweak #'X-offset #0.6 _.
( | %{ bar 24: %}
  \applyOutput #'Voice #note-two d4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
)   \applyOutput #'Voice #note-nought r4   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d8]-\tweak #'X-offset #0.6 _.
| %{ bar 25: %}
  \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8]-\tweak #'X-offset #0.6 _.
(   \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8]-\tweak #'X-offset #0.6 _.
| %{ bar 26: %}
  \applyOutput #'Voice #note-six a4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8]-\tweak #'X-offset #0.6 _.
(   \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
#(define (note-seven grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "7")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8]-\tweak #'X-offset #0.6 _.
( | %{ bar 27: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8[-\tweak #'X-offset #0.6 _.
) \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8.[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8.-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8]-\tweak #'X-offset #0.6 _.
( | %{ bar 28: %}
  \applyOutput #'Voice #note-three e4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
)   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 29: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
]    \applyOutput #'Voice #note-one c'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
\once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 30: %}
  \applyOutput #'Voice #note-one c'4
 ~ #(define (note-dashone grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashone c'4
  \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c8]-\tweak #'X-offset #0.6 _.
| %{ bar 31: %}
  \applyOutput #'Voice #note-two d'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
]    \applyOutput #'Voice #note-one c'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[]
( \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 32: %}
  \applyOutput #'Voice #note-two d'4
 ~ #(define (note-dashtwo grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashtwo d'4
)   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
| %{ bar 33: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8]-\tweak #'X-offset #0.6 _.
( \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 34: %}
  \applyOutput #'Voice #note-seven b4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
 ~ #(define (note-dashseven grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashseven b4
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
( | %{ bar 35: %}
  \applyOutput #'Voice #note-six a4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
]    \applyOutput #'Voice #note-six a4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8[]-\tweak #'X-offset #0.6 _.
( \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 36: %}
  \applyOutput #'Voice #note-three e4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
 ~ #(define (note-dashthree grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashthree e4
)   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 37: %}
  \applyOutput #'Voice #note-one c'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
)   \applyOutput #'Voice #note-one c'4 | %{ bar 38: %}
  \applyOutput #'Voice #note-nought r4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
( | %{ bar 39: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
) \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
( \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-one c'4
 ~ \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-dashone c'4
 ~   \applyOutput #'Voice #note-dashone c'4 ) | %{ bar 40: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-nought r4   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
) | %{ bar 41: %}
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
  \applyOutput #'Voice #note-five g'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 42: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
)   \applyOutput #'Voice #note-five g'4   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
( | %{ bar 43: %}
  \applyOutput #'Voice #note-one c''4^.
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8]^.
  \applyOutput #'Voice #note-one c''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 44: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
(   \applyOutput #'Voice #note-three e'4 )   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
) | %{ bar 45: %}
  \applyOutput #'Voice #note-six a'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
  \applyOutput #'Voice #note-six a'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
| %{ bar 46: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
]    \applyOutput #'Voice #note-six a'4. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 47: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
)   \applyOutput #'Voice #note-two d'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
( \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 48: %}
  \applyOutput #'Voice #note-two d'4
 ~   \applyOutput #'Voice #note-dashtwo d'4 )   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
| %{ bar 49: %}
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
]    \applyOutput #'Voice #note-three e'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[]
| %{ bar 50: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
(   \applyOutput #'Voice #note-five g'4 ) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 51: %}
  \applyOutput #'Voice #note-one c'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 52: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
]    \applyOutput #'Voice #note-three e'4.   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 53: %}
  \applyOutput #'Voice #note-six a'4
  \applyOutput #'Voice #note-six a'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
( | %{ bar 54: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
]  )   \applyOutput #'Voice #note-six a'4.   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 55: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
\once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-two d'4
 ~   \applyOutput #'Voice #note-dashtwo d'4 ) | %{ bar 56: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-nought r4   \applyOutput #'Voice #note-three e'4 (   \applyOutput #'Voice #note-one c'4 ) | %{ bar 57: %}
  \applyOutput #'Voice #note-one c'4
  \applyOutput #'Voice #note-nought r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 58: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 59: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 60: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 61: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 62: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 63: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 64: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 65: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 66: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 67: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 68: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 69: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 70: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 71: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 72: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d8]-\tweak #'X-offset #0.6 _.
| %{ bar 73: %}
  \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8]-\tweak #'X-offset #0.6 _.
(   \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8]-\tweak #'X-offset #0.6 _.
| %{ bar 74: %}
  \applyOutput #'Voice #note-six a4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8]-\tweak #'X-offset #0.6 _.
(   \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8]-\tweak #'X-offset #0.6 _.
( | %{ bar 75: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
) \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8.[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8.-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8]-\tweak #'X-offset #0.6 _.
( | %{ bar 76: %}
  \applyOutput #'Voice #note-three e4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
)   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 77: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
]    \applyOutput #'Voice #note-one c'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
\once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 78: %}
  \applyOutput #'Voice #note-one c'4
 ~   \applyOutput #'Voice #note-dashone c'4   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
| %{ bar 79: %}
  \applyOutput #'Voice #note-two d'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[]
( \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
]  )   \applyOutput #'Voice #note-one c'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[]
( \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 80: %}
  \applyOutput #'Voice #note-two d'4
 ~   \applyOutput #'Voice #note-dashtwo d'4 )   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
| %{ bar 81: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8]-\tweak #'X-offset #0.6 _.
( \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 82: %}
  \applyOutput #'Voice #note-seven b4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
 ~   \applyOutput #'Voice #note-dashseven b4 ) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
( | %{ bar 83: %}
  \applyOutput #'Voice #note-six a4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
]    \applyOutput #'Voice #note-six a4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e8[]-\tweak #'X-offset #0.6 _.
( \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 84: %}
  \applyOutput #'Voice #note-three e4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
 ~   \applyOutput #'Voice #note-dashthree e4 ) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
( | %{ bar 85: %}
  \applyOutput #'Voice #note-one c'4
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-one c'16[
( \set stemLeftBeamCount = #2
\set stemRightBeamCount = #2
  \applyOutput #'Voice #note-two d'16
) \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
(   \applyOutput #'Voice #note-one c'4 ) | %{ bar 86: %}
  \applyOutput #'Voice #note-nought r4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
( | %{ bar 87: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
) \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
( \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-one c'4
 ~ \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-dashone c'4
 ~   \applyOutput #'Voice #note-dashone c'4 ) | %{ bar 88: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
) | %{ bar 89: %}
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
  \applyOutput #'Voice #note-five g'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 90: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
)   \applyOutput #'Voice #note-five g'4   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
) | %{ bar 91: %}
  \applyOutput #'Voice #note-one c''4^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8]^.
  \applyOutput #'Voice #note-one c''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 92: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
(   \applyOutput #'Voice #note-three e'4 )   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
) | %{ bar 93: %}
  \applyOutput #'Voice #note-six a'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
  \applyOutput #'Voice #note-six a'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
| %{ bar 94: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
]    \applyOutput #'Voice #note-six a'4. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 95: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
)   \applyOutput #'Voice #note-two d'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
( \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 96: %}
  \applyOutput #'Voice #note-two d'4
 ~   \applyOutput #'Voice #note-dashtwo d'4 )   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
| %{ bar 97: %}
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
]    \applyOutput #'Voice #note-three e'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[]
| %{ bar 98: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
(   \applyOutput #'Voice #note-five g'4 ) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 99: %}
  \applyOutput #'Voice #note-one c'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 100: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
]    \applyOutput #'Voice #note-three e'4.   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 101: %}
  \applyOutput #'Voice #note-six a'4
  \applyOutput #'Voice #note-six a'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
( | %{ bar 102: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
]  )   \applyOutput #'Voice #note-six a'4.   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 103: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
\once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-two d'4
 ~   \applyOutput #'Voice #note-dashtwo d'4 ) | %{ bar 104: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-nought r4   \applyOutput #'Voice #note-three e'4 ( \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
) \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
( | %{ bar 105: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-one c'4
 ~ \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-dashone c'4
 ~   \applyOutput #'Voice #note-dashone c'4 ) | %{ bar 106: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 107: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 108: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 109: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 110: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 111: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 112: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 113: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 114: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 115: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 | %{ bar 116: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-dash r4   \applyOutput #'Voice #note-dash r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
) | %{ bar 117: %}
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
  \applyOutput #'Voice #note-five g'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 118: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
)   \applyOutput #'Voice #note-five g'4   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
) | %{ bar 119: %}
  \applyOutput #'Voice #note-one c''4^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8]^.
  \applyOutput #'Voice #note-one c''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 120: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
(   \applyOutput #'Voice #note-three e'4 )   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
) | %{ bar 121: %}
  \applyOutput #'Voice #note-six a'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
  \applyOutput #'Voice #note-six a'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
| %{ bar 122: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
]    \applyOutput #'Voice #note-six a'4. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 123: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
)   \applyOutput #'Voice #note-two d'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
( \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 124: %}
  \applyOutput #'Voice #note-two d'4
 ~   \applyOutput #'Voice #note-dashtwo d'4 )   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
| %{ bar 125: %}
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
]    \applyOutput #'Voice #note-three e'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[]
| %{ bar 126: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
(   \applyOutput #'Voice #note-five g'4 ) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 127: %}
  \applyOutput #'Voice #note-one c'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 128: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
]    \applyOutput #'Voice #note-three e'4.   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-nought c'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a8]-\tweak #'X-offset #0.6 _.
| %{ bar 129: %}
  \applyOutput #'Voice #note-six a'4
  \applyOutput #'Voice #note-six a'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
( | %{ bar 130: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
]  )   \applyOutput #'Voice #note-six a'4.   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
| %{ bar 131: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
\once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-two d'4
 ~   \applyOutput #'Voice #note-dashtwo d'4 ) | %{ bar 132: %}
  \applyOutput #'Voice #note-nought r4
  \applyOutput #'Voice #note-nought r4   \applyOutput #'Voice #note-three e'4 ( \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
) \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8]
( | %{ bar 133: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-one c'4
 ~   \applyOutput #'Voice #note-dashone c'4 ) \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g8[-\tweak #'X-offset #0.6 _.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
| %{ bar 134: %}
  \applyOutput #'Voice #note-two d'4
\once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-two d'4
 ~   \applyOutput #'Voice #note-dashtwo d'4   \applyOutput #'Voice #note-one c'4 \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0 | %{ bar 135: %}
  \applyOutput #'Voice #note-two d'4
 ~   \applyOutput #'Voice #note-dashtwo d'4   \applyOutput #'Voice #note-nought r4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
( | %{ bar 136: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
]  )   \applyOutput #'Voice #note-two d'4.   \applyOutput #'Voice #note-nought r4   \applyOutput #'Voice #note-five g4-\tweak #'Y-offset #-1.2 -\tweak #'X-offset #0.6 _.
| %{ bar 137: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
( \set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-one c'4
 ~ \once \override Tie.transparent = ##t \once \override Tie.staff-position = #0   \applyOutput #'Voice #note-dashone c'4
 ~   \applyOutput #'Voice #note-dashone c'4 ) \bar "|." } }
% === END JIANPU STAFF ===

>>
\header{
title="先生"
arranger=""
}
\layout{} }
\score {
\unfoldRepeats
<< 

% === BEGIN MIDI STAFF ===
    \new Staff { \new Voice="midi" { \tempo 4=126 \transpose c g, { \key c \major  \time 4/4 r1 | %{ bar 2: %} r1 | %{ bar 3: %} r1 | %{ bar 4: %} r1 | %{ bar 5: %} r1 | %{ bar 6: %} r1 | %{ bar 7: %} r1 | %{ bar 8: %} r1 | %{ bar 9: %} r1 | %{ bar 10: %} r1 | %{ bar 11: %} r1 | %{ bar 12: %} r1 | %{ bar 13: %} r1 | %{ bar 14: %} r1 | %{ bar 15: %} r1 | %{ bar 16: %} r2 r8 c8 c8 d8 | %{ bar 17: %} g4 d8 d4 d8 c8 d8 ( | %{ bar 18: %} d8 ) e4 e8 r4 c8 d8 | %{ bar 19: %} g4 e8 d4 c4 e8 ( | %{ bar 20: %} e4 ) r4 r8 e8 e8 f8 | %{ bar 21: %} e8 c8 c4 r8 c8 c8 d8 | %{ bar 22: %} e8 c8 r2 a,8 c8 | %{ bar 23: %} d4. e4 g4 d8 ( | %{ bar 24: %} d4 ) r2 c8 d8 | %{ bar 25: %} g4 g8 g8 ( g4 ) a8 e8 | %{ bar 26: %} a4 g8 g8 ( g4 ) r8 b8 ( | %{ bar 27: %} b8 ) b8 b8 c'8 b8. g8. e8 ( | %{ bar 28: %} e4 ) r4 r8 a8 g8 a8 | %{ bar 29: %} c'8 c'8 r8 c'4 c'8 c'8 a8 | %{ bar 30: %} c'2 r4 a8 c8 | %{ bar 31: %} d'4. e'8 e'8 c'4 d'8 ( | %{ bar 32: %} d'2 ) r4 e'8 d'8 | %{ bar 33: %} d'8 ( c'8 ) r8 c'8 c'8 e8 c'8 b8 ( | %{ bar 34: %} b2 ) r8 b8 g8 a8 ( | %{ bar 35: %} a4 ) a8 c'8 g8 a4 e8 ( | %{ bar 36: %} e2 ) r4 g8 a8 | %{ bar 37: %} c'4 c'8 a8 c'8 ( d'8 ) c'4 | %{ bar 38: %} r4 a8 g8 a8 e'8 a8 c'8 ( | %{ bar 39: %} d'8 ) c'8 ( c'2. ) | %{ bar 40: %} r2. c''8 ( a'8 ) | %{ bar 41: %} g'4 c''8 a'8 g'4 e'8 g'8 | %{ bar 42: %} g'8 ( a'8 ) g'4 r4 g'8 a'8 ( | %{ bar 43: %} c''4 ) c''8 d''8 c''4 a'8 g'8 | %{ bar 44: %} d'8 g'8 ( e'4 ) r4 e'8 ( g'8 ) | %{ bar 45: %} a'4 a'8 a'8 a'4 c''8 a'8 | %{ bar 46: %} g'8 a'4. r8 g'8 g'8 a8 | %{ bar 47: %} e'8 ( d'8 ) d'4 d'8 e'8 c'8 d'8 ( | %{ bar 48: %} d'2 ) r4 r8 e'8 | %{ bar 49: %} g'4 g'8 e'8 g'8 e'4 a'8 | %{ bar 50: %} a'8 ( b'8 ) a'8 g'8 ( g'4 ) r8 a8 | %{ bar 51: %} c'4 c'8 a8 c'8 a'8 a'8 g'8 | %{ bar 52: %} d'8 e'4. r4 r8 a8 | %{ bar 53: %} a'4 a'4 a'8 e'8 g'8 g'8 ( | %{ bar 54: %} a'8 ) a'4. r4 e'8 ( g'8 | %{ bar 55: %} a'8 g'8 e'8 d'8 d'2 ) | %{ bar 56: %} r2 e'4 ( c'4 ) | %{ bar 57: %} c'4 r2. | %{ bar 58: %} r1 | %{ bar 59: %} r1 | %{ bar 60: %} r1 | %{ bar 61: %} r1 | %{ bar 62: %} r1 | %{ bar 63: %} r1 | %{ bar 64: %} r1 | %{ bar 65: %} r1 | %{ bar 66: %} r1 | %{ bar 67: %} r1 | %{ bar 68: %} r1 | %{ bar 69: %} r1 | %{ bar 70: %} r1 | %{ bar 71: %} r1 | %{ bar 72: %} r2. c8 d8 | %{ bar 73: %} g4 g8 g8 ( g4 ) g8 e8 | %{ bar 74: %} a4 g8 g8 ( g4 ) r8 b8 ( | %{ bar 75: %} b'8 ) b8 b8 c'8 b8. g8. e8 ( | %{ bar 76: %} e4 ) r4 r8 g8 g8 a8 | %{ bar 77: %} c'8 c'8 r8 c'4 c'8 c'8 a8 | %{ bar 78: %} c'2 r4 a8 c'8 | %{ bar 79: %} d'4. e'8 ( d'8 ) c'4 d'8 ( | %{ bar 80: %} d'2 ) r4 e'8 d'8 | %{ bar 81: %} d'8 ( c'8 ) r8 c'8 c'8 e8 c'8 b8 ( | %{ bar 82: %} b2 ) r8 b8 g8 a8 ( | %{ bar 83: %} a4 ) a8 c'8 g8 a4 e8 ( | %{ bar 84: %} e2 ) r8 g8 a8 c'8 ( | %{ bar 85: %} c'4 ) c'8 a8 c'16 ( d'16 ) c'8 ( c'4 ) | %{ bar 86: %} r4 a8 g8 a8 e'8 a8 c'8 ( | %{ bar 87: %} d'8 ) c'8 ( c'2. ) | %{ bar 88: %} r2. c''8 ( a'8 ) | %{ bar 89: %} g'4 c''8 a'8 g'4 e'8 g'8 | %{ bar 90: %} g'8 ( a'8 ) g'4 r4 g'8 ( a'8 ) | %{ bar 91: %} c''4 c''8 d''8 c''4 a'8 g'8 | %{ bar 92: %} d'8 g'8 ( e'4 ) r4 e'8 ( g'8 ) | %{ bar 93: %} a'4 a'8 a'8 a'4 c''8 a'8 | %{ bar 94: %} g'8 a'4. r8 g'8 g'8 a8 | %{ bar 95: %} e'8 ( d'8 ) d'4 d'8 e'8 c'8 d'8 ( | %{ bar 96: %} d'2 ) r4 r8 e'8 | %{ bar 97: %} g'4 g'8 e'8 g'8 e'4 a'8 | %{ bar 98: %} a'8 ( b'8 ) a'8 g'8 ( g'4 ) r8 a8 | %{ bar 99: %} c'4 c'8 a8 c'8 a'8 a'8 g'8 | %{ bar 100: %} d'8 e'4. r4 r8 a8 | %{ bar 101: %} a'4 a'4 a'8 e'8 g'8 g'8 ( | %{ bar 102: %} a'8 ) a'4. r4 e'8 ( g'8 | %{ bar 103: %} a'8 g'8 e'8 d'8 d'2 ) | %{ bar 104: %} r2 e'4 ( c'8 ) d'8 ( | %{ bar 105: %} d'8 c'8 c'2. ) | %{ bar 106: %} r1 | %{ bar 107: %} r1 | %{ bar 108: %} r1 | %{ bar 109: %} r1 | %{ bar 110: %} r1 | %{ bar 111: %} r1 | %{ bar 112: %} r1 | %{ bar 113: %} r1 | %{ bar 114: %} r1 | %{ bar 115: %} r1 | %{ bar 116: %} r2. c''8 ( a'8 ) | %{ bar 117: %} g'4 c''8 a'8 g'4 e'8 g'8 | %{ bar 118: %} g'8 ( a'8 ) g'4 r4 g'8 ( a'8 ) | %{ bar 119: %} c''4 c''8 d''8 c''4 a'8 g'8 | %{ bar 120: %} d'8 g'8 ( e'4 ) r4 e'8 ( g'8 ) | %{ bar 121: %} a'4 a'8 a'8 a'4 c''8 a'8 | %{ bar 122: %} g'8 a'4. r8 g'8 g'8 a8 | %{ bar 123: %} e'8 ( d'8 ) d'4 d'8 e'8 c'8 d'8 ( | %{ bar 124: %} d'2 ) r4 r8 e'8 | %{ bar 125: %} g'4 g'8 e'8 g'8 e'4 a'8 | %{ bar 126: %} a'8 ( b'8 ) a'8 g'8 ( g'4 ) r8 a8 | %{ bar 127: %} c'4 c'8 a8 c'8 a'8 a'8 g'8 | %{ bar 128: %} d'8 e'4. r4 r8 a8 | %{ bar 129: %} a'4 a'4 a'8 e'8 g'8 g'8 ( | %{ bar 130: %} a'8 ) a'4. r4 e'8 ( g'8 | %{ bar 131: %} a'8 g'8 e'8 d'8 d'2 ) | %{ bar 132: %} r2 e'4 ( c'8 ) d'8 ( | %{ bar 133: %} d'8 c'8 c'2 ) g8 c'8 | %{ bar 134: %} d'4 d'2 c'4 | %{ bar 135: %} d'2 r4 d'8 e'8 ( | %{ bar 136: %} d'8 ) d'4. r4 g4 | %{ bar 137: %} d'8 ( c'8 c'2. ) } } }
% === END MIDI STAFF ===

>>
\header{
title="先生"
arranger=""
}
\midi { \context { \Score tempoWholesPerMinute = #(ly:make-moment 84 4)}} }
