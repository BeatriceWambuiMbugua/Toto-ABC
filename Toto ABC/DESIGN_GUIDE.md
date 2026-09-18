# Little Global Explorers — SwiftUI Design Guide

## 1. Product principle

The child should feel that they are **bringing a letter to life**, not completing a worksheet.

Core loop:

**See → Trace → Color → Come Alive → Discover → Continue**

The experience is designed for children aged 3–4. It should use one clear action at a time, minimal text, strong audio/visual feedback, and automatic progression so the child is not required to navigate complex controls.

The signature interaction is:

> **Trace → Wake up the letter → Reveal the world**

---

## 2. Final user flow

The app runs in **landscape orientation**.

1. **Onboarding / Welcome** — Little Global Explorers identity and Start button.
2. **Explore Alphabet** — a playful 3D ABC card that begins the alphabet journey.
3. **Trace Letter** — the letter appears muted with a clear guided path. Only essential controls are shown: Close/Cancel and Audio/Mute.
4. **Letter fills with color** — the rich letter color appears progressively under the child's finger.
5. **Googly eyes + wiggle + celebration** — the completed letter comes alive. The celebration uses subtle confetti based on the associated country's flag/colors.
6. **Country reveal** — the country name appears with minimal text and audio support.
7. **Country scene/object** — a friendly 3D animal/object appears inside a simple country-identity scene with the flag and a few recognizable visual cues.
8. **Auto-slide to next letter** — after a short viewing pause, the app automatically transitions to the next letter.

There is no separate Next screen or required Next button in the core A–Z journey.

---

## 3. Visual system

### Pastel background families

Use six repeating background families across A–Z.

| Theme | Background | Asset name |
|---|---|---|
| Coral | `#FFADAD` | `bgPastelCoral` |
| Peach | `#FFD6A5` | `bgPastelPeach` |
| Yellow | `#FDFFB6` | `bgPastelYellow` |
| Mint | `#CAFFBF` | `bgPastelMint` |
| Sky | `#9BF6FF` | `bgPastelSky` |
| Lavender | `#BDB2FF` | `bgPastelLavender` |

Backgrounds should retain the established playful pattern language: clouds, bubbles, stars, dots, soft blobs, and curved exploration paths. Decorative elements should stay near the edges so the center remains calm enough for tracing.

### Rich letter colors

The letter begins almost colorless and becomes a strong, saturated version of its background family only as the child traces it.

| Background | Completed letter |
|---|---|
| Coral | `#B4233B` Deep Berry |
| Peach | `#C95A18` Burnt Orange |
| Yellow | `#8A6D00` Golden Ochre |
| Mint | `#166534` Forest Green |
| Sky | `#0369A1` Ocean Blue |
| Lavender | `#4B0082` Indigo |

Do not use the completed letter color at full strength before tracing.

---

## 4. Letter states

### State 1 — Waiting
- One oversized uppercase 3D-style letter is centered.
- Letter fill uses the completed color at approximately **12–18% opacity**.
- A tracing guide/path is visible at approximately **35–45% opacity**.
- A subtle start-point pulse shows where to begin.
- No googly eyes yet.
- Background remains visible but secondary.

### State 2 — Tracing
- Finger movement reveals the rich letter color underneath the tracing path.
- The traced section remains colored.
- Untraced portions remain muted.
- A very subtle sparkle trail may follow the finger.
- Hit testing must be forgiving. The child should not need precise penmanship.

### State 3 — Trace complete
When the tracing threshold is reached:
1. Finish any tiny remaining gaps over about 150 ms.
2. Speak the letter name, e.g. **“A!”**
3. Add the googly eyes.
4. Blink once.
5. Wiggle the letter.
6. Trigger a short, playful celebration.
7. Use subtle flag-colored / tiny flag confetti associated with the country.
8. Let the eyes glance toward the direction of the reveal.
9. Transition into the country reveal.

### State 4 — Alive
- The letter stays fully colored.
- Googly eyes stay attached.
- The letter may blink or sway briefly.
- The celebration should be short, approximately **1–2 seconds**.
- The app then progresses into the country discovery without requiring reading or another button.

---

## 5. Googly-eye identity

The googly eyes are a recurring brand behavior, not random decoration.

### Rules
- Eyes only appear **after successful tracing**.
- Keep the same eye design across all letters.
- Adjust anchor points per letter so they feel naturally placed.
- Prefer the upper third of the letter unless the shape suggests a better position.
- Blink duration: about **120–160 ms** closed, then open.
- Wiggle: about **±4° rotation**, 2–3 quick oscillations.
- Optional tiny bounce: `1.0 → 1.04 → 1.0`.
- Eyes can glance toward the next reveal before the scene changes.

This creates the repeatable expectation:

> **“When I finish tracing, my letter wakes up.”**

---

## 6. Celebration system

Celebration must reinforce the country without becoming visually noisy.

### Flag confetti rules
- Use the country's flag colors as the main palette.
- A few tiny flag pieces may appear, but do not fill the screen with literal flags.
- Keep the completed letter as the visual focus.
- Use 3D confetti pieces that match the visual style of the letter.
- Celebration duration: approximately **0.6–1.0 seconds**.
- Confetti should disappear before or during the country transition.

Example:
- Algeria: green, white, red, with a few tiny crescent/star or Algerian-flag details.
- Brazil: green, yellow, blue, white.
- Canada: red and white, with subtle maple-leaf shapes.

---

## 7. Country discovery scene style

The country reveal is a **full landscape visual scene**, not an information card.

Each scene should contain:
- one friendly, large 3D animal/object as the primary memory hook
- the country's flag
- 2–4 simple environmental/cultural cues
- bright daylight and warm, playful styling
- no paragraphs or fact blocks
- country name only when needed

The scene should help a 3–4-year-old form a simple association, for example:

**A → Algeria → Camel**

Do not speak the animal name in the core flow if it risks competing with the alphabet-country association. The visual object acts as the memory hook while the audio focuses on the letter and country.

### Landscape scene composition

Country scenes are designed for an iPhone landscape reference frame of approximately **874 × 402 px** (about **2.17:1**).

Keep:
- the animal/object in the left or center-left safe zone
- the flag visible but secondary
- major landmarks/environmental cues across the center/right
- essential content away from extreme edges so it survives device cropping

In SwiftUI, scenes should normally use full-bleed presentation with careful aspect-fill cropping.

---

## 8. A–Z content and visual map

The six pastel background families repeat in order so the child gets variety while the app stays coherent.

| Letter | Background asset | Rich letter color | Place | Primary scene association |
|---|---|---|---|---|
| **A** | `bgPastelCoral` | Berry `#B4233B` | Algeria | Camel |
| **B** | `bgPastelPeach` | Orange `#C95A18` | Brazil | Macaw |
| **C** | `bgPastelYellow` | Ochre `#8A6D00` | Canada | Beaver |
| **D** | `bgPastelMint` | Green `#166534` | Denmark | Swan |
| **E** | `bgPastelSky` | Blue `#0369A1` | Egypt | Cat |
| **F** | `bgPastelLavender` | Indigo `#4B0082` | France | Rooster |
| **G** | `bgPastelCoral` | Berry | Ghana | Elephant |
| **H** | `bgPastelPeach` | Orange | Hungary | Horse |
| **I** | `bgPastelYellow` | Ochre | Indonesia | Komodo dragon |
| **J** | `bgPastelMint` | Green | Japan | Crane |
| **K** | `bgPastelSky` | Blue | Kenya | Giraffe |
| **L** | `bgPastelLavender` | Indigo | Laos | Gibbon |
| **M** | `bgPastelCoral` | Berry | Mexico | Axolotl |
| **N** | `bgPastelPeach` | Orange | Norway | Reindeer |
| **O** | `bgPastelYellow` | Ochre | Oman | Arabian oryx |
| **P** | `bgPastelMint` | Green | Peru | Llama |
| **Q** | `bgPastelSky` | Blue | Qatar | Falcon |
| **R** | `bgPastelLavender` | Indigo | Rwanda | Mountain gorilla |
| **S** | `bgPastelCoral` | Berry | South Africa | Springbok |
| **T** | `bgPastelPeach` | Orange | Thailand | Elephant |
| **U** | `bgPastelYellow` | Ochre | Uganda | Crested crane |
| **V** | `bgPastelMint` | Green | Vietnam | Water buffalo |
| **W** | `bgPastelSky` | Blue | Wales | Red dragon |
| **X** | `bgPastelLavender` | Indigo | Explorer special | Treasure map / X marks the spot |
| **Y** | `bgPastelCoral` | Berry | Yemen | Arabian leopard |
| **Z** | `bgPastelPeach` | Orange | Zambia | Hippo |

### X rule
There is no sovereign country beginning with X. Do not invent one. X becomes the special explorer moment: **“X marks the spot!”**

---

## 9. Global asset naming convention

All asset names use **camelCase** with predictable prefixes.

### Prefixes
- `bg...` — reusable backgrounds
- `letterCelebrate...` — completed 3D letters with googly eyes and country celebration
- `scene...` — full landscape country discovery scene
- `object...` — optional isolated country animal/object asset
- `flag...` — country flag asset
- `ui...` — reusable interface artwork/icons
- `audio...` — future audio assets

Do not use spaces in Xcode asset names.

### Background assets — exact global names

```text
bgPastelCoral
bgPastelPeach
bgPastelYellow
bgPastelMint
bgPastelSky
bgPastelLavender
```


### Reserved letter-state asset names

Use the same naming pattern for every letter, even when a state is drawn dynamically in SwiftUI. This keeps exported or fallback artwork predictable.

- `letterOutlineX` — muted/untraced letter artwork
- `letterTracingX` — optional tracing-state artwork or mask
- `letterFilledX` — fully colored letter before the character celebration
- `letterCelebrateX` — fully colored 3D letter with googly eyes and country-themed confetti

For example, A uses:

```text
letterOutlineA
letterTracingA
letterFilledA
letterCelebrateA
```

The same pattern continues through `letterOutlineZ`, `letterTracingZ`, `letterFilledZ`, and `letterCelebrateZ`.

### Full A–Z asset naming map

| Letter | Background | Outline | Filled | Celebration | Country scene | Optional object | Flag |
|---|---|---|---|---|---|---|---|
| A | `bgPastelCoral` | `letterOutlineA` | `letterFilledA` | `letterCelebrateA` | `sceneAAlgeria` | `objectAAlgeriaCamel` | `flagAAlgeria` |
| B | `bgPastelPeach` | `letterOutlineB` | `letterFilledB` | `letterCelebrateB` | `sceneBBrazil` | `objectBBrazilMacaw` | `flagBBrazil` |
| C | `bgPastelYellow` | `letterOutlineC` | `letterFilledC` | `letterCelebrateC` | `sceneCCanada` | `objectCCanadaBeaver` | `flagCCanada` |
| D | `bgPastelMint` | `letterOutlineD` | `letterFilledD` | `letterCelebrateD` | `sceneDDenmark` | `objectDDenmarkSwan` | `flagDDenmark` |
| E | `bgPastelSky` | `letterOutlineE` | `letterFilledE` | `letterCelebrateE` | `sceneEEgypt` | `objectEEgyptCat` | `flagEEgypt` |
| F | `bgPastelLavender` | `letterOutlineF` | `letterFilledF` | `letterCelebrateF` | `sceneFFrance` | `objectFFranceRooster` | `flagFFrance` |
| G | `bgPastelCoral` | `letterOutlineG` | `letterFilledG` | `letterCelebrateG` | `sceneGGhana` | `objectGGhanaElephant` | `flagGGhana` |
| H | `bgPastelPeach` | `letterOutlineH` | `letterFilledH` | `letterCelebrateH` | `sceneHHungary` | `objectHHungaryHorse` | `flagHHungary` |
| I | `bgPastelYellow` | `letterOutlineI` | `letterFilledI` | `letterCelebrateI` | `sceneIIndonesia` | `objectIIndonesiaKomodo` | `flagIIndonesia` |
| J | `bgPastelMint` | `letterOutlineJ` | `letterFilledJ` | `letterCelebrateJ` | `sceneJJapan` | `objectJJapanCrane` | `flagJJapan` |
| K | `bgPastelSky` | `letterOutlineK` | `letterFilledK` | `letterCelebrateK` | `sceneKKenya` | `objectKKenyaGiraffe` | `flagKKenya` |
| L | `bgPastelLavender` | `letterOutlineL` | `letterFilledL` | `letterCelebrateL` | `sceneLLaos` | `objectLLaosGibbon` | `flagLLaos` |
| M | `bgPastelCoral` | `letterOutlineM` | `letterFilledM` | `letterCelebrateM` | `sceneMMexico` | `objectMMexicoAxolotl` | `flagMMexico` |
| N | `bgPastelPeach` | `letterOutlineN` | `letterFilledN` | `letterCelebrateN` | `sceneNNorway` | `objectNNorwayReindeer` | `flagNNorway` |
| O | `bgPastelYellow` | `letterOutlineO` | `letterFilledO` | `letterCelebrateO` | `sceneOOman` | `objectOOmanArabianOryx` | `flagOOman` |
| P | `bgPastelMint` | `letterOutlineP` | `letterFilledP` | `letterCelebrateP` | `scenePPeru` | `objectPPeruLlama` | `flagPPeru` |
| Q | `bgPastelSky` | `letterOutlineQ` | `letterFilledQ` | `letterCelebrateQ` | `sceneQQatar` | `objectQQatarFalcon` | `flagQQatar` |
| R | `bgPastelLavender` | `letterOutlineR` | `letterFilledR` | `letterCelebrateR` | `sceneRRwanda` | `objectRRwandaMountainGorilla` | `flagRRwanda` |
| S | `bgPastelCoral` | `letterOutlineS` | `letterFilledS` | `letterCelebrateS` | `sceneSSouthAfrica` | `objectSSouthAfricaSpringbok` | `flagSSouthAfrica` |
| T | `bgPastelPeach` | `letterOutlineT` | `letterFilledT` | `letterCelebrateT` | `sceneTThailand` | `objectTThailandElephant` | `flagTThailand` |
| U | `bgPastelYellow` | `letterOutlineU` | `letterFilledU` | `letterCelebrateU` | `sceneUUganda` | `objectUUgandaCrestedCrane` | `flagUUganda` |
| V | `bgPastelMint` | `letterOutlineV` | `letterFilledV` | `letterCelebrateV` | `sceneVVietnam` | `objectVVietnamWaterBuffalo` | `flagVVietnam` |
| W | `bgPastelSky` | `letterOutlineW` | `letterFilledW` | `letterCelebrateW` | `sceneWWales` | `objectWWalesRedDragon` | `flagWWales` |
| X | `bgPastelLavender` | `letterOutlineX` | `letterFilledX` | `letterCelebrateX` | `sceneXExplorer` | `objectXExplorerTreasureMap` | — |
| Y | `bgPastelCoral` | `letterOutlineY` | `letterFilledY` | `letterCelebrateY` | `sceneYYemen` | `objectYYemenArabianLeopard` | `flagYYemen` |
| Z | `bgPastelPeach` | `letterOutlineZ` | `letterFilledZ` | `letterCelebrateZ` | `sceneZZambia` | `objectZZambiaHippo` | `flagZZambia` |

### Current created A–J assets

The currently created A–J celebration and country-scene assets should be renamed in `Assets.xcassets` to exactly:

```text
letterCelebrateA
letterCelebrateB
letterCelebrateC
letterCelebrateD
letterCelebrateE
letterCelebrateF
letterCelebrateG
letterCelebrateH
letterCelebrateI
letterCelebrateJ

sceneAAlgeria
sceneBBrazil
sceneCCanada
sceneDDenmark
sceneEEgypt
sceneFFrance
sceneGGhana
sceneHHungary
sceneIIndonesia
sceneJJapan
```

When outline or filled letter artwork is exported later, use the same pattern (`letterOutlineA`, `letterFilledA`, etc.). `letterTracingX` is reserved for an optional mask/fallback asset; the primary tracing interaction should still be rendered dynamically in SwiftUI.

---

## 10. Shared UI asset names

Reserve these names for global UI pieces:

```text
uiLogoLittleGlobalExplorers
uiCardExploreAlphabet
uiIconAudio
uiIconMute
uiIconClose
```

The audio/mute and close controls should remain visually consistent throughout the tracing journey.

---

## 11. SwiftUI data model guidance

The naming scheme should allow one letter model to drive the full experience.

Example structure:

```swift
struct LetterJourney {
    let letter: String
    let country: String
    let backgroundAsset: String
    let celebrationAsset: String
    let sceneAsset: String
    let flagAsset: String?
}
```

Example A configuration:

```swift
LetterJourney(
    letter: "A",
    country: "Algeria",
    backgroundAsset: "bgPastelCoral",
    celebrationAsset: "letterCelebrateA",
    sceneAsset: "sceneAAlgeria",
    flagAsset: "flagAAlgeria"
)
```

The views should read asset names from the model instead of using `switch` statements or hard-coded image strings throughout the UI.

---

## 12. Recommended reusable SwiftUI pieces

- `OnboardingView`
- `ExploreAlphabetView`
- `LetterPlayView`
- `TraceCanvas`
- `LetterGuidePath`
- `CelebrationView`
- `CountryRevealView`
- `AlphabetTheme`

### State machine

```swift
enum LetterPlayState {
    case waiting
    case tracing
    case celebrating
    case countryReveal
    case transitioning
}
```

---

## 13. Tracing guidance

Use `Canvas` + `DragGesture` for drawing and hit testing.

For children aged 3–4:
- use a generous path width
- never show “wrong”
- never reset the entire trace because the finger briefly leaves the path
- allow completion around **80–90%** coverage
- snap the final small gap into place once the threshold is reached
- give immediate visual feedback as the finger moves

---

## 14. Animation timing baseline

| Event | Suggested duration |
|---|---:|
| Rich-color fill while tracing | follows finger |
| Final fill snap | 0.15 s |
| Eye pop-in | 0.2 s |
| Blink | 0.12–0.16 s |
| Letter wiggle | 0.5–0.7 s |
| Flag/confetti celebration | 0.6–1.0 s |
| Country transition | 0.4–0.7 s |
| Country scene viewing pause | about 2–4 s initially; tune through testing |
| Auto-slide to next letter | 0.5–0.8 s |

The viewing pause should be long enough for recognition but short enough to maintain momentum. Validate the exact timing with children rather than treating it as fixed.

---

## 15. Accessibility and interaction rules

- **Landscape-first** iPhone layout.
- Large touch targets.
- One primary action at a time.
- No reading required to progress.
- Use voice and visual animation together.
- Avoid failure states and red error symbols.
- Keep the central tracing area visually calm.
- Respect Reduce Motion by replacing wiggles/confetti with fades and small scale changes.
- Provide a persistent Audio/Mute control.
- Provide a simple Close/Cancel control on the tracing experience.
- Do not rely on color alone to communicate tracing progress; shape fill and motion should change as well.
- Progress to the next letter automatically after the country scene.

---

## 16. Non-negotiable experience rule

**Before tracing:** the letter is quiet and nearly colorless.

**During tracing:** the child creates the color.

**After tracing:** the letter wakes up.

**Then:** the child discovers a place through one memorable visual association.

That transformation is the core reward loop and should remain consistent from A through Z.
