---
name: KeyClick
description: Your MacBook keyboard, now mechanical. A night desk where the keyboard is the demo.
colors:
  graphite: "#0a0a0b"
  deck-top: "#18181b"
  deck-bottom: "#111113"
  desk-surface: "#151517"
  keycap-base: "#0b0b0c"
  keycap-face: "#2c2c30"
  keycap-face-raised: "#303035"
  legend: "#d8d8d4"
  warm-white: "#efefec"
  pure-white: "#ffffff"
  ash: "#9b9b9f"
  dim-ash: "#7c7c81"
  wave-idle: "#8d8d92"
  switch-track: "#2a2a2e"
  hairline: "rgb(255 255 255 / 0.09)"
  popover-glass: "rgb(40 40 44 / 0.86)"
  ivory-face: "#fafaf7"
  ivory-base: "#8f8f8b"
  stem-brown: "#c08552"
  stem-smoke: "#c9c9ce"
  stem-red: "#ff5147"
  stem-blue: "#4b93ff"
  stem-purple: "#a582ff"
typography:
  display:
    fontFamily: "Hanken Grotesk Variable, system-ui, sans-serif"
    fontSize: "clamp(2.4rem, min(5vw, 6.4vh), 3.75rem)"
    fontWeight: 620
    lineHeight: 1.04
    letterSpacing: "-0.032em"
  headline:
    fontFamily: "Hanken Grotesk Variable, system-ui, sans-serif"
    fontSize: "clamp(2rem, 4vw, 3.2rem)"
    fontWeight: 620
    lineHeight: 1.04
    letterSpacing: "-0.032em"
  headline-closing:
    fontFamily: "Hanken Grotesk Variable, system-ui, sans-serif"
    fontSize: "clamp(2.75rem, 6vw, 5rem)"
    fontWeight: 620
    lineHeight: 1.04
    letterSpacing: "-0.032em"
  echo:
    fontFamily: "Hanken Grotesk Variable, system-ui, sans-serif"
    fontSize: "clamp(1.125rem, 2vw, 1.5rem)"
    fontWeight: 480
    letterSpacing: "-0.01em"
  lead:
    fontFamily: "Hanken Grotesk Variable, system-ui, sans-serif"
    fontSize: "1.125rem"
    fontWeight: 400
    lineHeight: 1.55
  body:
    fontFamily: "Hanken Grotesk Variable, system-ui, sans-serif"
    fontSize: "1.0625rem"
    fontWeight: 400
    lineHeight: 1.55
  label:
    fontFamily: "Hanken Grotesk Variable, system-ui, sans-serif"
    fontSize: "0.875rem"
    fontWeight: 600
    lineHeight: 1.2
  caption:
    fontFamily: "Hanken Grotesk Variable, system-ui, sans-serif"
    fontSize: "0.8125rem"
    fontWeight: 400
  legend:
    fontFamily: "Hanken Grotesk Variable, system-ui, sans-serif"
    fontSize: "calc(var(--u) * 0.3)"
    fontWeight: 500
    lineHeight: 1
  legend-word:
    fontFamily: "Hanken Grotesk Variable, system-ui, sans-serif"
    fontSize: "calc(var(--u) * 0.18)"
    fontWeight: 520
    lineHeight: 1
    letterSpacing: "0.01em"
  code:
    fontFamily: "ui-monospace, SF Mono, Menlo, monospace"
    fontSize: "clamp(0.75rem, 1.2vw, 0.875rem)"
    fontWeight: 400
    lineHeight: 1.7
rounded:
  focus: "4px"
  select: "6px"
  button: "10px"
  panel: "12px"
  desk: "14px"
  keycap: "calc(var(--u) * 0.13)"
  keycap-face: "calc(var(--u) * 0.12)"
  deck: "calc(var(--u) * 0.32)"
  pill: "999px"
spacing:
  key-unit: "calc(100cqi / 15.4)"
  key-gap: "calc(var(--u) * 0.1)"
  gutter: "clamp(1.25rem, 4vw, 2.5rem)"
  container: "72rem"
  section: "clamp(4rem, 9vw, 7.5rem)"
  section-closing: "clamp(5rem, 11vw, 9rem)"
  stack-sm: "1rem"
  stack-md: "1.25rem"
  stack-lg: "1.75rem"
components:
  button-primary:
    backgroundColor: "{colors.warm-white}"
    textColor: "{colors.graphite}"
    typography: "{typography.label}"
    rounded: "{rounded.button}"
    padding: "0 1.25rem"
    height: "2.9rem"
  button-primary-hover:
    backgroundColor: "{colors.pure-white}"
    textColor: "{colors.graphite}"
  button-small:
    backgroundColor: "{colors.warm-white}"
    textColor: "{colors.graphite}"
    rounded: "{rounded.button}"
    padding: "0 0.9rem"
    height: "2.25rem"
  keycap:
    backgroundColor: "{colors.keycap-face}"
    textColor: "{colors.legend}"
    typography: "{typography.legend}"
    rounded: "{rounded.keycap-face}"
    height: "var(--u)"
  keycap-download:
    backgroundColor: "{colors.ivory-face}"
    textColor: "{colors.graphite}"
    rounded: "{rounded.keycap-face}"
    height: "92px"
    width: "min(22rem, 100%)"
  stem-chip:
    textColor: "{colors.ash}"
    typography: "{typography.label}"
    rounded: "{rounded.button}"
    padding: "0.45rem 0.8rem 0.45rem 0.6rem"
  stem-chip-selected:
    backgroundColor: "rgb(255 255 255 / 0.04)"
    textColor: "{colors.warm-white}"
  power-switch:
    backgroundColor: "{colors.switch-track}"
    rounded: "{rounded.pill}"
    height: "24px"
    width: "42px"
  code-panel:
    backgroundColor: "{colors.deck-bottom}"
    textColor: "{colors.warm-white}"
    typography: "{typography.code}"
    rounded: "{rounded.panel}"
    padding: "1.1rem 1.2rem 1.3rem"
  desk-panel:
    backgroundColor: "{colors.desk-surface}"
    rounded: "{rounded.desk}"
  popover:
    backgroundColor: "{colors.popover-glass}"
    textColor: "{colors.warm-white}"
    rounded: "{rounded.panel}"
    padding: "15px 16px"
    width: "260px"
  wave-tile:
    textColor: "{colors.ash}"
    padding: "6px 2px 2px"
    height: "clamp(40px, 5.4vw, 64px)"
---

# Design System: KeyClick

## Overview

**Creative North Star: "The Night Desk"**

KeyClick's world is a desk at night: a graphite room, a space-black keyboard deck under a faint pool of light, dark keycaps with warm white legends. Nothing on the page is a card or a widget; the keyboard itself is the interface, drawn with real Mac legends and real proportions, and everything else is quiet type separated by hairlines. The page does not describe the sound, it lets the visitor type and hear it.

The only colour in the world is the selected switch's stem colour. It glows from under a pressed keycap, it fills the caret and the switches, it marks the selected switch, and it lights the waveform of the key you just hit. Choosing a different switch recolours the whole page at once, because the whole page is one keyboard with one switch in it.

Motion is mechanical, not decorative. On load the flat MacBook keys rise into keycaps in a left-to-right wave while the deck tilts back into perspective; turning KeyClick off lays them flat again. A press sinks the cap in 40ms and lights the stem instantly; the light fades slowly after release. Density is low: one idea per band, generous vertical space, text measured to 36–40em.

**Key Characteristics:**
- Graphite ground, near-neutral greys with a faint cool cast, warm white text.
- One hue at a time, owned by the selected switch (`--stem`).
- The keyboard is the signature component and reappears as the waveform map and the final Download keycap.
- Hanken Grotesk throughout, tight and medium-heavy for headlines.
- Hairline section rules, no cards; bordered panels only when they depict a real object (a screen, a source file).
- Physical motion on one easing curve, fully disabled under reduced motion.

## Colors

A near-monochrome graphite palette whose single accent is swapped in by the chosen switch.

### Primary
- **Stem Light** (`--stem`, one of the five stem colours below): the live accent. Used for the caret, the pressed-key underglow, the pressed-keycap inner ring (45% mix), the On state of both switches, the selected stem chip's border (55% mix), the waveform tile on hit, the range slider accent, `::selection`, and the highlighted `.listenOnly` in the code panel (22% mix). Defaults to Stem Brown.
- **Stem Brown** (MX Brown), **Stem Smoke** (MX Black), **Stem Red** (MX Red), **Stem Blue** (MX Blue), **Stem Purple** (Topre, after the recorded Topre Purple Hybrid): the five values `--stem` can take. Each also tints its own chip's cross-stem (or Topre dome) icon, at 55% opacity unselected and full when selected.

### Neutral
- **Graphite** (page ground, `theme-color`, text on white surfaces).
- **Deck Top → Deck Bottom** (the keyboard deck's vertical gradient; Deck Bottom is also the code panel).
- **Desk Surface** (the menu bar scene's screen).
- **Keycap Base** (the dark skirt under every keycap) and **Keycap Face** (flat MacBook key top, gradient #2c2c30 → #222225 → #1d1d20). **Keycap Face Raised** (#303035 → #242428 → #1f1f23 plus a soft top highlight) replaces it when the keys are mechanical.
- **Legend** (keycap legends; slightly dimmer than text so the caps read as objects, not UI).
- **Warm White** (all primary text, primary buttons, focus outline). **Pure White** only on button hover and switch thumbs.
- **Ash** (secondary text: lede, section support copy, nav links, unselected chips, tile labels). **Dim Ash** (fine print and footer).
- **Wave Idle** (waveform strokes at rest). **Switch Track** (Off state of the power switch).
- **Hairline** (every divider and panel border). **Popover Glass** (the macOS menu replica, with a 24px blur).
- **Ivory Face / Ivory Base** (only the final Download keycap: a light keycap on a grey skirt).

### Named Rules
**The Stem Is the Only Colour Rule.** Chroma on the page comes from `--stem` and nowhere else. If a new element needs emphasis, it gets Warm White, weight, or the stem colour; never a second accent. The one scoped exception is syntax highlighting inside the source-file replica (#ff7ab2 keywords, #7fd5ea types, #d9c97c numbers), which depicts Xcode, not the brand.

**The One Switch Rule.** Selecting a switch rewrites `--stem` on `body`; every stem-coloured element changes together. Never hard-code a stem hex on an element that should follow the selection.

**The White Is the Action Rule.** Download is Warm White on Graphite (or the Ivory keycap). The stem colour marks state and feedback, never the call to action.

## Typography

**Display Font:** Hanken Grotesk Variable (with system-ui, sans-serif)
**Body Font:** Hanken Grotesk Variable
**Label/Mono Font:** ui-monospace, "SF Mono", Menlo (code panel only)

**Character:** One grotesk carries everything, set tight and at in-between variable weights (480, 520, 620, 650) so headlines feel engineered rather than bold. The keycap legends use the same family, so the keyboard and the copy read as one object.

### Hierarchy
- **Display** (620, clamp 2.4–3.75rem capped by viewport height, 1.04, −0.032em): the two-line hero headline only, balanced, centred.
- **Headline** (620, clamp 2–3.2rem, 1.04, −0.032em): section titles, short declarative sentences ending in a full stop.
- **Headline Closing** (620, clamp 2.75–5rem): the final "Get KeyClick." above the Download keycap.
- **Echo** (480, clamp 1.125–1.5rem, −0.01em): the live line of what the visitor types, Warm White; its hint state is Ash.
- **Lead** (400, 1.125rem, 1.55): section support copy and privacy claims in Ash, with bold lead-ins (600) in Warm White. Hero lede is fluid 1.0625–1.2rem, max 36em.
- **Body** (400, 1.0625rem, 1.55): base size.
- **Label** (600, 0.875rem, 1.2): stem names; buttons and brand at 650. Stem type sub-label 0.75rem at 80% opacity.
- **Caption** (0.8125rem): requirements line, footer, popover rows; fine print at 0.875rem in Dim Ash.
- **Legend** (500, 0.3u) for single characters, **Legend Word** (520, 0.18u, +0.01em) for lowercase word legends (esc, tab, shift, command); shifted symbols at 0.2u, 75% opacity; F-row and arrows at 0.15u.
- **Code** (ui-monospace, clamp 0.75–0.875rem, 1.7): the source-file replica; the file path caption at 0.75rem in Ash.

### Named Rules
**The One Family Rule.** Hanken Grotesk for everything outside two replicas: monospace inside the source file, and `-apple-system` inside the macOS menu popover, because those depict Xcode and macOS. Never set a headline in a system face.

**The Real Legend Rule.** Keycaps carry real Mac legends: ⌘ ⌥ ⌃ ⇧ ⇥ ⇪ over lowercase words, modifier legends pinned to the key's outer corner (left keys bottom-left, right keys bottom-right), shifted symbols above their digit or punctuation.

## Layout

A single centred column (`max-width: 72rem`, fluid gutter clamp 1.25–2.5rem) of full-width bands, each separated by a 1px Hairline top rule and padded clamp 4–7.5rem (the closing band clamp 5–9rem).

The first viewport is fixed in shape: minimal nav, a centred headline + lede + Download + requirements, the echo line, the keyboard, then the On/Off switch and the five stems. The hero copy and keyboard are sized against viewport height (`min(5vw, 6.4vh)` headline, keyboard `max-width: min(60rem, 92vh)`) so the whole instrument fits above the fold on a laptop.

**The keyboard unit.** Every key is measured in `--u = 100cqi / 15.4` (the keyboard frame is a size container), with gaps of `0.1u` and each key's width as a flex ratio `--w` (esc 1.5, caps lock 1.8, shift 2.3/2.2, command 1.3, space 5.1). The F-row is 0.56u tall; arrows form a half-height inverted T in a 3u slot. The waveform map reuses the same rows and `--w` values with a 6px gap, so it reads as the keyboard seen as sound.

Below the fold, sections alternate between a text-over-content stack (sounds) and a two-column split (menu bar: 1fr / 1.1fr; privacy: 0.9fr / 1.1fr).

**Responsive.** At ≤880px both two-column splits stack. At ≤640px: nav keeps only the Download button; the F-row is hidden; the keyboard switches to a fixed `--u: 42px`, scrolls sideways with a hidden scrollbar and opens centred on H; tilt drops from 22° to 14°; stems become a five-column grid with names only; waveform tiles drop their labels and shrink to 30px; the popover centres under a centred menu bar icon.

### Named Rules
**The Keyboard Unit Rule.** Anything keyboard-shaped is sized in `--u` and `--w`, never in fixed pixels, so the keyboard, its legends, radii and glow scale together.

## Elevation & Depth

Depth is physical, not atmospheric. The keyboard deck is the only lifted object at page scale (`inset 0 1px 0 rgb(255 255 255 / 0.07), 0 40px 80px -30px rgb(0 0 0 / 0.9)`), tilted `rotateX(22deg)` under 1600px perspective when mechanical. A faint radial pool of white light (6%) sits behind the stage. Keycaps get their height from `--lift` (1px flat, 0.13u mechanical): the face translates up off its dark base and insets by 0.35 × lift, so a side skirt appears.

### Shadow Vocabulary
- **Deck** (`inset 0 1px 0 rgb(255 255 255 / 0.07), 0 40px 80px -30px rgb(0 0 0 / 0.9)`): the keyboard only.
- **Keycap Face** (`inset 0 1px 0 rgb(255 255 255 / 0.08), inset 0 -1px 0 rgb(0 0 0 / 0.4)`): top highlight, bottom edge.
- **Pressed Keycap** (`inset 0 0 0 1px color-mix(in srgb, var(--stem) 45%, transparent), inset 0 -1px 0 rgb(0 0 0 / 0.4)`).
- **Stem Underglow** (radial `var(--stem)` → transparent, blurred 0.14u, 95% opacity, bleeding 45%/30% past the key): the light from the switch, only while pressed and only when mechanical.
- **Popover** (`0 0 0 0.5px rgb(255 255 255 / 0.18), 0 20px 50px -12px rgb(0 0 0 / 0.8)`, backdrop blur 24px saturate 1.4): the macOS menu replica.
- **Switch Thumb** (`0 1px 3px rgb(0 0 0 / 0.5)`; 0 1px 2px / 0.4 in the popover).

### Named Rules
**The Light From Below Rule.** Coloured light only ever comes from under a pressed keycap. No stem-coloured glows, gradients or halos anywhere else.

**The No Cards Rule.** Content sits on the ground divided by hairlines. A bordered panel is allowed only when it depicts a real object: the desk screen, the source file, the menu popover.

## Shapes

Soft, object-true corners. Keyboard radii scale with the unit: deck 0.32u, keycap base 0.13u, keycap face 0.12u. Interface radii are small and fixed: 10px buttons and stem chips, 12px code panel and popover, 14px desk screen, 6px select, 5px menu bar icon, 4px focus ring, full pills for switches. Borders are always 1px Hairline, except a 0.5px glass ring on the popover. Iconography is drawn, not glyph-font: a stroked download arrow, a Cherry MX cross stem, a round Topre dome, a stroked keyboard menu bar icon, and a keycap favicon (dark skirt, #2a2a2e face, Warm White K).

## Components

### Buttons
Solid, quiet, white.
- **Shape:** gently rounded (10px).
- **Primary:** Warm White on Graphite text, weight 650, min-height 2.9rem, 1.25rem inline padding, optional 16px stroked icon at 1.6 stroke.
- **Small:** 0.875rem, min-height 2.25rem, 0.9rem padding (nav Download).
- **Hover / Active:** background to Pure White (160ms); active nudges down 1px on the shared easing.
- **Focus:** 2px Warm White outline, 3px offset, 4px radius (global).

### Keycap (signature)
The page's core object: a dark base with a face on top, legend grid inside.
- **Flat (KeyClick off):** lift 1px, flat face gradient, no underglow; the deck is untilted.
- **Mechanical (on):** lift 0.13u, raised face gradient with a top highlight, deck tilted 22°. Keys rise over 700ms with a per-key delay of 0–420ms by horizontal position, starting 450ms after load.
- **Pressed:** face sinks to 0.15 × lift in 40ms with a 45% stem inner ring; the underglow snaps on at 95% and fades over 600ms after release.
- **Touch ID key:** a blank cap with a 1px 12% white ring, not pressable.

### Download Keycap
The final call to action is the same keycap, inverted: Ivory face on an Ivory Base skirt, lift 12px, 92px tall, up to 22rem wide, label 1.375rem/600 with a 0.8125rem sub-line. Hover raises it to 0.8 × lift; press sinks it and plays the Enter recording.

### Stem Selector
A radio group of five chips.
- **Style:** transparent, 1px transparent border, 10px radius, stem icon (20px) + name (label) + type (0.75rem).
- **Unselected:** Ash text, icon at 55%. Hover: Warm White text.
- **Selected:** 4% white fill, border at 55% of the chip's own stem colour, Warm White text, icon at full strength.
- **Keyboard:** roving tabindex, arrow keys move and select.

### Power Switch
A labelled toggle: 42 × 24px pill, Switch Track when off, `--stem` when on, 20px white thumb travelling 18px over 240ms; label "KeyClick" in 600 with state in Ash. The popover uses a smaller macOS-scale version (34 × 20px, 16px thumb, 180ms).

### Waveform Tile
One per key, laid out as the keyboard. A 1px Hairline top rule, an 11px Ash label, and a 24-bar peak waveform in Wave Idle at 1.2px non-scaling stroke. On hit, rule and waveform snap to `--stem` and fade back over 500ms. Tiles are pressable and play their key.

### Navigation
Brand (22px favicon + "KeyClick", 650, −0.02em) left; links at 0.9375rem in Ash, Warm White on hover (160ms), 1.75rem apart, ending in the small Download button. Mobile keeps only the button.

### Code Panel
A source-file replica: Deck Bottom fill, 1px Hairline border, 12px radius, file path caption in monospace above a Hairline rule. The one line that proves the claim is marked with a 22% stem wash and 2px stem ring.

### Menu Bar Scene
A desk-screen panel (Desk Surface with a top-right 7% light, 14px radius) with a 30px translucent menu bar and a working glass popover (Sound switch, volume range with stem accent, switch select, inert "Open at login" and "Quit" rows in #cfcfd3).

## Do's and Don'ts

### Do:
- **Do** route every accent through `--stem` so a switch change recolours the whole page.
- **Do** size anything keyboard-shaped in `--u` and `--w`, with `0.1u` gaps.
- **Do** use the shared easing `cubic-bezier(0.16, 1, 0.3, 1)` for physical motion: fast attack (0–40ms) on press, slow decay (500–600ms) on release.
- **Do** separate bands with a 1px Hairline top rule and clamp 4–7.5rem padding.
- **Do** keep Download Warm White (or the Ivory keycap) with Graphite text.
- **Do** zero every transition and stop the caret under `prefers-reduced-motion`, landing directly in the mechanical state.

### Don't:
- **Don't** introduce a second accent hue or colour a CTA with the stem colour.
- **Don't** put content in cards; bordered panels are for depicted objects only.
- **Don't** add glows, gradients or halos in stem colour outside the pressed-key underglow.
- **Don't** set headlines in a system face or a second family.
- **Don't** replace Mac legends with generic ones (Ctrl, Alt, Win) or set keycap legends in uppercase words.
