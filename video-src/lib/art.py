"""Draws the shared cast and sets as SVG files in lib/. Run: python3 lib/art.py
Every id starts with $ID; build.py swaps it for a per-use prefix, so one drawing can appear many times.
Flat picture-book style: dark brown outline, warm fills, brand reds.
"""
import os

OUT = os.path.dirname(os.path.abspath(__file__))
LINE, SKIN, SKIN2, HAIR = "#3a2e2a", "#f4c9a3", "#e5ae86", "#2b211d"
SCARF, SCARF2 = "#c8102e", "#9e0c24"


def limb(pts, sleeve=None, hand=True, skin=SKIN, w=30):
    """A round-jointed arm through pts; sleeve=(colour, fraction of the first segment)."""
    d = "M" + " L".join(f"{x} {y}" for x, y in pts)
    s = (f'<path d="{d}" stroke="{LINE}" stroke-width="{w + 10}" fill="none" stroke-linecap="round" stroke-linejoin="round"/>'
         f'<path d="{d}" stroke="{skin}" stroke-width="{w}" fill="none" stroke-linecap="round" stroke-linejoin="round"/>')
    if sleeve:
        (x0, y0), (x1, y1) = pts[0], pts[1]
        f = sleeve[1]
        sd = f"M{x0} {y0} L{x0 + (x1 - x0) * f:.0f} {y0 + (y1 - y0) * f:.0f}"
        s += (f'<path d="{sd}" stroke="{LINE}" stroke-width="{w + 24}" stroke-linecap="round"/>'
              f'<path d="{sd}" stroke="{sleeve[0]}" stroke-width="{w + 14}" stroke-linecap="round"/>')
    if hand:
        x, y = pts[-1]
        s += f'<circle cx="{x}" cy="{y}" r="{w * 0.72:.0f}" fill="{skin}" stroke="{LINE}" stroke-width="5"/>'
    return s


def face(cx=200, cy=175, rx=95, ry=105):
    """Eyes, brows, nose, cheeks and four mouths, each with an id for the timeline."""
    return f"""
  <g id="$ID_blush" opacity=".45"><ellipse cx="{cx-52}" cy="{cy+42}" rx="17" ry="10" fill="#ef8a7a"/><ellipse cx="{cx+52}" cy="{cy+42}" rx="17" ry="10" fill="#ef8a7a"/></g>
  <g id="$ID_eyes">
    <g id="$ID_eyeL"><ellipse cx="{cx-35}" cy="{cy+5}" rx="11" ry="14" fill="{HAIR}"/><circle cx="{cx-31}" cy="{cy}" r="4" fill="#fff"/></g>
    <g id="$ID_eyeR"><ellipse cx="{cx+35}" cy="{cy+5}" rx="11" ry="14" fill="{HAIR}"/><circle cx="{cx+39}" cy="{cy}" r="4" fill="#fff"/></g>
    <g id="$ID_lids" opacity="0" fill="{SKIN}" stroke="{HAIR}" stroke-width="4">
      <path d="M{cx-50} {cy-12} L{cx-20} {cy-12} L{cx-20} {cy+6} L{cx-50} {cy+6}Z" stroke="none"/><line x1="{cx-49}" y1="{cy+6}" x2="{cx-21}" y2="{cy+6}"/>
      <path d="M{cx+20} {cy-12} L{cx+50} {cy-12} L{cx+50} {cy+6} L{cx+20} {cy+6}Z" stroke="none"/><line x1="{cx+21}" y1="{cy+6}" x2="{cx+49}" y2="{cy+6}"/>
    </g>
  </g>
  <path id="$ID_browL" d="M{cx-55} {cy-22} Q{cx-36} {cy-32} {cx-17} {cy-24}" stroke="{HAIR}" stroke-width="7" fill="none" stroke-linecap="round"/>
  <path id="$ID_browR" d="M{cx+17} {cy-24} Q{cx+36} {cy-32} {cx+55} {cy-22}" stroke="{HAIR}" stroke-width="7" fill="none" stroke-linecap="round"/>
  <path d="M{cx-2} {cy+24} Q{cx-8} {cy+38} {cx+4} {cy+40}" stroke="{SKIN2}" stroke-width="5" fill="none" stroke-linecap="round"/>
  <g stroke="{LINE}" stroke-width="6" fill="none" stroke-linecap="round">
    <path id="$ID_mFlat" d="M{cx-17} {cy+62} L{cx+17} {cy+62}"/>
    <g id="$ID_mSmile" opacity="0"><path d="M{cx-24} {cy+55} Q{cx} {cy+60} {cx+24} {cy+55} Q{cx+20} {cy+84} {cx} {cy+84} Q{cx-20} {cy+84} {cx-24} {cy+55}Z" fill="#7a2a2a" stroke-width="5" stroke-linejoin="round"/><ellipse cx="{cx}" cy="{cy+77}" rx="10" ry="5" fill="#e27a7a" stroke="none"/></g>
    <path id="$ID_mFrown" opacity="0" d="M{cx-22} {cy+70} Q{cx} {cy+52} {cx+22} {cy+70}"/>
    <ellipse id="$ID_mO" opacity="0" cx="{cx}" cy="{cy+64}" rx="10" ry="13" fill="#7a2a2a"/>
  </g>
  <path id="$ID_sweat" opacity="0" d="M{cx+rx-6} {cy-40} Q{cx+rx+12} {cy-8} {cx+rx-2} {cy+2} Q{cx+rx-20} {cy-6} {cx+rx-6} {cy-40}Z" fill="#8fd0f5" stroke="{LINE}" stroke-width="3"/>"""


def kid():
    shirt = "#ffffff"
    torso = (f'<path d="M86 600 C86 420 112 352 200 345 C288 352 314 420 314 600 Z" fill="{shirt}" stroke="{LINE}" stroke-width="6"/>'
             f'<path d="M160 350 L200 392 L240 350" fill="none" stroke="{LINE}" stroke-width="5"/>'
             f'<path d="M163 352 L200 384 L237 352 L226 346 L200 366 L174 346Z" fill="{SCARF}" stroke="{LINE}" stroke-width="3"/>'
             f'<path d="M194 380 L176 452 L203 434Z" fill="{SCARF}" stroke="{LINE}" stroke-width="3"/>'
             f'<path d="M206 380 L226 448 L199 434Z" fill="{SCARF2}" stroke="{LINE}" stroke-width="3"/>'
             f'<circle cx="200" cy="380" r="11" fill="{SCARF2}" stroke="{LINE}" stroke-width="3"/>')
    neck = f'<rect x="180" y="300" width="40" height="58" rx="16" fill="{SKIN2}" stroke="{LINE}" stroke-width="5"/>'
    legs = (f'<path d="M104 580 L296 580 L292 860 L208 860 L200 680 L192 860 L108 860Z" fill="#2f3a5c" stroke="{LINE}" stroke-width="6" stroke-linejoin="round"/>'
            f'<ellipse cx="146" cy="872" rx="52" ry="20" fill="{LINE}"/><ellipse cx="254" cy="872" rx="52" ry="20" fill="{LINE}"/>')
    torso = legs + torso
    hair_short = (f'<path id="$ID_hairShort" d="M103 182 C92 92 150 56 206 58 C270 60 312 100 298 184 C292 150 278 128 258 118 '
                  f'C238 140 186 138 160 116 C134 132 112 152 103 182Z" fill="{HAIR}"/>')
    # Girl: a rounded bob behind the head, a scalloped fringe in front, a red clip.
    hair_back = (f'<path id="$ID_hairLongBack" opacity="0" d="M92 186 C80 84 146 46 200 46 C254 46 320 84 308 186 '
                 f'C316 236 318 282 312 316 Q302 346 266 340 Q246 334 244 268 L156 268 Q154 334 134 340 Q98 346 88 316 '
                 f'C82 282 84 236 92 186Z" fill="{HAIR}" stroke="{LINE}" stroke-width="5"/>')
    hair_long = (f'<g id="$ID_hairLong" opacity="0">'
                 f'<path d="M102 196 C96 104 150 64 204 64 C262 64 306 104 298 196 C290 160 276 140 258 130 '
                 f'C250 152 226 156 214 136 C200 156 172 158 160 136 C144 150 126 168 102 196Z" fill="{HAIR}"/>'
                 f'<circle cx="284" cy="110" r="17" fill="{SCARF}" stroke="{LINE}" stroke-width="3"/>'
                 f'<circle cx="270" cy="98" r="9" fill="{SCARF2}"/></g>')
    head = (f'<g id="$ID_head"><g transform="translate(0 38)">' + hair_back +
            f'<ellipse class="ear" cx="104" cy="190" rx="20" ry="27" fill="{SKIN}" stroke="{LINE}" stroke-width="5"/>'
            f'<ellipse class="ear" cx="296" cy="190" rx="20" ry="27" fill="{SKIN}" stroke="{LINE}" stroke-width="5"/>'
            f'<ellipse cx="200" cy="178" rx="96" ry="106" fill="{SKIN}" stroke="{LINE}" stroke-width="6"/>'
            + hair_short + hair_long + face() + "</g></g>")
    sl = ("#ffffff", 0.45)
    arms = {
        "Desk": limb([(112, 380), (96, 480), (150, 540)], sl) + limb([(288, 380), (304, 480), (250, 540)], sl),
        "Head": limb([(112, 380), (50, 300), (106, 222)], sl) + limb([(288, 380), (350, 300), (294, 222)], sl),
        "Write": limb([(112, 380), (96, 480), (150, 540)], sl) + f'<g id="$ID_hand">' + limb([(288, 380), (318, 480), (236, 528)], sl)
                 + f'<g id="$ID_pencil"><path d="M226 540 L196 590" stroke="{LINE}" stroke-width="16" stroke-linecap="round"/>'
                   f'<path d="M226 540 L196 590" stroke="#f2b705" stroke-width="9" stroke-linecap="round"/></g></g>',
        "Chin": limb([(112, 380), (96, 480), (150, 540)], sl) + limb([(288, 380), (322, 480), (226, 336)], sl),
        "Hold": limb([(112, 380), (120, 490), (170, 470)], sl) + limb([(288, 380), (280, 490), (230, 470)], sl),
        "Side": limb([(112, 380), (88, 480), (92, 580)], sl) + limb([(288, 380), (312, 480), (308, 580)], sl),
        "Raise": limb([(112, 380), (88, 480), (92, 580)], sl) + limb([(288, 380), (346, 260), (330, 120)], sl),
        "Poster": limb([(112, 380), (60, 470), (40, 380)], sl) + limb([(288, 380), (340, 470), (360, 380)], sl),
    }
    arm_svg = "".join(f'<g id="$ID_arms{k}"{"" if k == "Desk" else " opacity=\"0\""}>{v}</g>' for k, v in arms.items())
    return (f'<svg id="$ID" class="kid" viewBox="0 0 400 900" overflow="visible" xmlns="http://www.w3.org/2000/svg">'
            f'<g id="$ID_body">{torso}{neck}</g>{head}{arm_svg}</svg>')


def teacher():
    blouse, skirt = "#cfe3f2", "#3d4a6b"
    body = (f'<path d="M80 760 C80 470 108 372 200 362 C292 372 320 470 320 760 Z" fill="{blouse}" stroke="{LINE}" stroke-width="6"/>'
            f'<rect x="130" y="880" width="44" height="100" fill="{SKIN}" stroke="{LINE}" stroke-width="5"/><rect x="226" y="880" width="44" height="100" fill="{SKIN}" stroke="{LINE}" stroke-width="5"/>'
            f'<ellipse cx="146" cy="990" rx="44" ry="16" fill="{LINE}"/><ellipse cx="254" cy="990" rx="44" ry="16" fill="{LINE}"/>'
            f'<path d="M100 620 L300 620 L330 900 L70 900Z" fill="{skirt}" stroke="{LINE}" stroke-width="6"/>'
            f'<path d="M168 368 L200 410 L232 368" fill="none" stroke="{LINE}" stroke-width="5"/>'
            f'<rect x="182" y="310" width="36" height="62" rx="14" fill="{SKIN2}" stroke="{LINE}" stroke-width="5"/>')
    head = (f'<g id="$ID_head"><g transform="translate(0 30)"><circle cx="200" cy="64" r="44" fill="{HAIR}"/>'
            f'<ellipse cx="200" cy="190" rx="88" ry="100" fill="{SKIN}" stroke="{LINE}" stroke-width="6"/>'
            f'<path d="M110 196 C100 100 150 82 200 82 C254 82 304 104 292 196 C270 150 230 128 200 130 C160 132 128 150 110 196Z" fill="{HAIR}"/>'
            + face(200, 190, 88, 100) + "</g></g>")
    sl = (blouse, 0.5)
    arms = {
        "Down": limb([(112, 400), (92, 520), (120, 620)], sl) + limb([(288, 400), (308, 520), (280, 620)], sl),
        "Give": limb([(112, 400), (92, 520), (120, 620)], sl) + limb([(288, 400), (230, 470), (120, 430)], sl)
                + f'<g><rect x="40" y="390" width="120" height="84" rx="6" fill="#fff" stroke="{LINE}" stroke-width="5" transform="rotate(-8 100 432)"/>'
                  f'<path d="M100 392 L100 474" stroke="{LINE}" stroke-width="3" transform="rotate(-8 100 432)"/></g>',
        "Point": limb([(288, 400), (308, 520), (280, 620)], sl) + limb([(112, 400), (20, 470), (-90, 520)], sl)
                 + f'<path d="M-100 520 L-150 534" stroke="{LINE}" stroke-width="20" stroke-linecap="round"/><path d="M-100 520 L-150 534" stroke="{SKIN}" stroke-width="11" stroke-linecap="round"/>',
    }
    arm_svg = "".join(f'<g id="$ID_arms{k}"{"" if k == "Down" else " opacity=\"0\""}>{v}</g>' for k, v in arms.items())
    return (f'<svg id="$ID" class="teacher" viewBox="0 0 400 1000" overflow="visible" xmlns="http://www.w3.org/2000/svg">'
            f'<g id="$ID_body">{body}</g>{head}{arm_svg}</svg>')


def room(day=False):
    """Bedroom wall, at night or on a sunny afternoon: window, shelf, wall clock. 1920×1080."""
    books = "".join(f'<rect x="{1452 + i * 34}" y="{318 - h}" width="28" height="{h}" rx="3" fill="{c}" stroke="{LINE}" stroke-width="3"/>'
                    for i, (h, c) in enumerate([(92, "#bd0129"), (78, "#1e63c6"), (100, "#2e8b47"), (70, "#f2b705"),
                                                (88, "#8e011f"), (96, "#5e5a55"), (74, "#1e63c6"), (84, "#f2b705")]))
    ticks = "".join(f'<line x1="0" y1="-62" x2="0" y2="-52" stroke="{LINE}" stroke-width="5" transform="rotate({a})"/>' for a in range(0, 360, 30))
    stars = "".join(f'<circle cx="{x}" cy="{y}" r="{r}" fill="#fff8d0"/>' for x, y, r in
                    [(230, 170, 4), (330, 120, 3), (420, 210, 5), (520, 150, 3), (300, 260, 3), (470, 290, 4)])
    outside = (f'<circle cx="530" cy="150" r="44" fill="#ffe27a"/>'
               f'<path d="M160 480 L160 380 Q230 330 300 380 Q370 320 450 375 Q530 335 620 385 L620 480Z" fill="#6fbf5a" stroke="{LINE}" stroke-width="5"/>'
               f'<rect x="246" y="250" width="22" height="140" fill="#8a5a33" stroke="{LINE}" stroke-width="4"/>'
               f'<circle cx="257" cy="230" r="70" fill="#4fa25a" stroke="{LINE}" stroke-width="5"/>'
               f'<circle cx="470" cy="420" r="9" fill="#e85a7a"/><circle cx="500" cy="430" r="9" fill="#f2b705"/><circle cx="350" cy="425" r="9" fill="#e85a7a"/>')
    import math
    a = math.radians((4 if day else 9) * 30)
    hx, hy = round(34 * math.sin(a)), round(-34 * math.cos(a))
    return f"""<svg id="$ID" viewBox="0 0 1920 1080" xmlns="http://www.w3.org/2000/svg">
  <rect width="1920" height="1080" fill="#f1dfbd"/>
  <rect y="620" width="1920" height="460" fill="#e6cfa6"/>
  <line x1="0" y1="620" x2="1920" y2="620" stroke="#cdb48a" stroke-width="6"/>
  <g><rect x="160" y="80" width="460" height="400" rx="14" fill="{'#bfe6ff' if day else '#25335e'}" stroke="{LINE}" stroke-width="8"/>
    {outside if day else stars + '<circle cx="540" cy="160" r="38" fill="#fff4c2"/><circle cx="556" cy="150" r="34" fill="#25335e"/>'}
    <line x1="390" y1="80" x2="390" y2="480" stroke="{LINE}" stroke-width="8"/><line x1="160" y1="280" x2="620" y2="280" stroke="{LINE}" stroke-width="8"/>
    <path d="M140 70 L240 70 L220 520 L130 520Z" fill="#bd0129" opacity=".85"/><path d="M640 70 L540 70 L560 520 L650 520Z" fill="#bd0129" opacity=".85"/></g>
  <g><rect x="1430" y="318" width="330" height="18" rx="4" fill="#9c6b3f" stroke="{LINE}" stroke-width="4"/>{books}</g>
  <rect x="1480" y="420" width="200" height="150" rx="8" fill="#fff" stroke="{LINE}" stroke-width="5" transform="rotate(3 1580 495)"/>
  <path d="M1510 520 L1560 470 L1600 505 L1630 480 L1660 520Z" fill="#2e8b47" transform="rotate(3 1580 495)"/>
  <g transform="translate(1180 190)"><circle r="78" fill="#fff" stroke="{LINE}" stroke-width="8"/>{ticks}
    <line id="$ID_hour" x1="0" y1="0" x2="{hx}" y2="{hy}" stroke="{LINE}" stroke-width="8" stroke-linecap="round"/>
    <line id="$ID_min" x1="0" y1="0" x2="0" y2="-54" stroke="#bd0129" stroke-width="6" stroke-linecap="round"/>
    <circle r="7" fill="{LINE}"/></g>
</svg>"""


def desk():
    """Home desk seen from the front, with lamp, worksheet, notebook and tablet. 1920×400, placed at the bottom."""
    lines = "".join(f'<line x1="{x0}" y1="{y}" x2="{x0 + 190}" y2="{y}" stroke="#c9d6ea" stroke-width="3"/>'
                    for x0 in (700, 915) for y in range(78, 200, 22))
    scrib = "".join(f'<path id="$ID_w{i}" d="M935 {80 + i * 22} q20 -8 40 0 t40 0 t40 0 t40 0" stroke="#33446b" stroke-width="4" fill="none" opacity="0"/>'
                    for i in range(1, 6))
    return f"""<svg id="$ID" viewBox="0 0 1920 400" xmlns="http://www.w3.org/2000/svg" overflow="visible">
  <defs><radialGradient id="$ID_glow"><stop offset="0" stop-color="#fff3b0" stop-opacity=".75"/><stop offset="1" stop-color="#fff3b0" stop-opacity="0"/></radialGradient></defs>
  <ellipse cx="470" cy="70" rx="420" ry="190" fill="url(#$ID_glow)"/>
  <rect x="0" y="40" width="1920" height="360" fill="#b47c48"/>
  <rect x="0" y="20" width="1920" height="40" fill="#cf995f" stroke="{LINE}" stroke-width="6"/>
  <g transform="translate(330 -250)"><rect x="70" y="260" width="120" height="26" rx="10" fill="#bd0129" stroke="{LINE}" stroke-width="5"/>
    <path d="M130 262 L110 140 L220 70" stroke="{LINE}" stroke-width="12" fill="none" stroke-linecap="round"/>
    <path d="M180 20 L290 60 L250 130 L150 80Z" fill="#bd0129" stroke="{LINE}" stroke-width="6"/></g>
  <g transform="translate(0 -14)"><path d="M690 40 L900 34 L910 214 L700 222Z" fill="#fff" stroke="{LINE}" stroke-width="5"/>
    <path d="M905 34 L1115 40 L1105 222 L910 214Z" fill="#fff" stroke="{LINE}" stroke-width="5"/>{lines}{scrib}</g>
  <path id="$ID_sheet" d="M1170 30 L1370 22 L1384 190 L1180 200Z" fill="#fffdf2" stroke="{LINE}" stroke-width="5"/>
  <g id="$ID_tabFlat"><rect x="1450" y="30" width="300" height="170" rx="18" fill="#2a2a33" stroke="{LINE}" stroke-width="5"/><rect x="1466" y="44" width="268" height="142" rx="8" fill="#3b3f52"/></g>
  <g id="$ID_tabUp" opacity="0"><path d="M1500 -230 L1760 -250 L1770 30 L1500 40Z" fill="#2a2a33" stroke="{LINE}" stroke-width="6"/>
    <path d="M1516 -214 L1746 -232 L1754 16 L1516 24Z" fill="#e9f0fb"/>
    <g fill="#9bb4dd"><rect x="1600" y="-200" width="130" height="22" rx="10"/><rect x="1540" y="-150" width="180" height="12" rx="6"/>
    <rect x="1540" y="-126" width="160" height="12" rx="6"/><rect x="1540" y="-102" width="190" height="12" rx="6"/><rect x="1540" y="-78" width="120" height="12" rx="6"/></g>
    <path d="M1620 40 L1600 60 L1700 60 L1680 40Z" fill="{LINE}"/></g>
</svg>"""


def classroom():
    """Back wall of a classroom, seen from the teacher's side. 1920×1080."""
    papers = "".join(f'<rect x="{1180 + (i % 4) * 120}" y="{200 + (i // 4) * 120}" width="96" height="92" rx="6" fill="{c}" stroke="{LINE}" stroke-width="3" transform="rotate({(-3, 2, -1, 3)[i % 4]} {1228 + (i % 4) * 120} {246 + (i // 4) * 120})"/>'
                     for i, c in enumerate(["#fff", "#f8f7d0", "#ffe1e6", "#e3f0ff", "#e8f6ea", "#fff", "#f8f7d0", "#ffe1e6"]))
    return f"""<svg id="$ID" viewBox="0 0 1920 1080" xmlns="http://www.w3.org/2000/svg">
  <rect width="1920" height="1080" fill="#e7efd9"/>
  <rect y="600" width="1920" height="480" fill="#d9c09a"/>
  <line x1="0" y1="600" x2="1920" y2="600" stroke="#bfa47c" stroke-width="6"/>
  <g>{''.join(f'<g transform="translate({x} 110)"><rect width="300" height="330" rx="10" fill="#bfe3f5" stroke="{LINE}" stroke-width="8"/><line x1="150" y1="0" x2="150" y2="330" stroke="{LINE}" stroke-width="7"/><line x1="0" y1="165" x2="300" y2="165" stroke="{LINE}" stroke-width="7"/>{'<circle cx="230" cy="80" r="36" fill="#fff6c9"/>' if x == 470 else ''}</g>' for x in (90, 470))}</g>
  <rect x="1150" y="170" width="520" height="290" rx="10" fill="#c99a62" stroke="{LINE}" stroke-width="7"/>{papers}
  <rect x="860" y="120" width="190" height="64" rx="8" fill="#bd0129" stroke="{LINE}" stroke-width="5"/>
  <rect x="890" y="140" width="130" height="10" rx="5" fill="#f8f7d0"/><rect x="900" y="158" width="110" height="8" rx="4" fill="#f8f7d0"/>
</svg>"""


def classdesk(paper=True):
    """A pupil's desk front, 640×260, with an optional test paper on top."""
    p = (f'<path id="$ID_paper" d="M210 6 L430 0 L440 66 L200 72Z" fill="#fffdf2" stroke="{LINE}" stroke-width="4"/>'
         f'<g stroke="#c9d6ea" stroke-width="3">{"".join(f"<line x1=\"{230}\" y1=\"{18 + i * 14}\" x2=\"{415}\" y2=\"{15 + i * 14}\"/>" for i in range(4))}</g>') if paper else ""
    return f"""<svg id="$ID" viewBox="0 0 640 260" xmlns="http://www.w3.org/2000/svg" overflow="visible">
  <rect x="10" y="40" width="620" height="220" rx="8" fill="#b47c48" stroke="{LINE}" stroke-width="6"/>
  <rect x="0" y="22" width="640" height="34" rx="6" fill="#cf995f" stroke="{LINE}" stroke-width="6"/>{p}
</svg>"""


def garden():
    """School garden by day: sky, school building, tree, grass, path, flower bed, mossy stone. 1920×1080."""
    wins = "".join(f'<rect x="{x}" y="{y}" width="110" height="90" rx="6" fill="#bfe6ff" stroke="{LINE}" stroke-width="5"/>'
                   for x in range(560, 1800, 170) for y in (210, 360))
    flowers = "".join(f'<circle cx="{x}" cy="{y}" r="13" fill="{c}" stroke="{LINE}" stroke-width="3"/>'
                      for x, y, c in [(1450, 760, "#e85a7a"), (1500, 740, "#f2b705"), (1560, 765, "#e85a7a"), (1620, 745, "#bd0129"),
                                      (1680, 768, "#f2b705"), (1740, 748, "#e85a7a"), (1800, 770, "#bd0129")])
    return f"""<svg id="$ID" viewBox="0 0 1920 1080" xmlns="http://www.w3.org/2000/svg">
  <rect width="1920" height="1080" fill="#cdeefe"/>
  <circle cx="300" cy="140" r="60" fill="#ffe27a"/>
  <path d="M500 150 L1920 150 L1920 600 L500 600Z" fill="#f6d77a" stroke="{LINE}" stroke-width="7"/>
  <path d="M470 150 L1920 150 L1920 112 L520 112Z" fill="#c8513b" stroke="{LINE}" stroke-width="7"/>{wins}
  <rect y="600" width="1920" height="480" fill="#8fcf6a"/>
  <path d="M760 1080 L900 600 L1020 600 L1180 1080Z" fill="#e8d6b0"/>
  <rect x="190" y="300" width="50" height="330" fill="#8a5a33" stroke="{LINE}" stroke-width="6"/>
  <circle cx="215" cy="260" r="170" fill="#4fa25a" stroke="{LINE}" stroke-width="7"/><circle cx="120" cy="330" r="90" fill="#5bb565" stroke="{LINE}" stroke-width="6"/>
  <path d="M1400 800 Q1620 700 1860 800 L1860 820 L1400 820Z" fill="#5c8f3f" stroke="{LINE}" stroke-width="5"/>{flowers}
  <ellipse cx="1700" cy="960" rx="130" ry="70" fill="#9a9a90" stroke="{LINE}" stroke-width="6"/>
  <path d="M1590 940 Q1640 880 1720 892 Q1790 900 1812 950 Q1760 930 1700 940 Q1640 950 1590 940Z" fill="#5f8f2f"/>
</svg>"""


def fern():
    """A clump of fern fronds with one young curled frond (lá non cuộn tròn). 600×520."""
    import math
    out = []
    for i, (ang, length) in enumerate([(-62, 330), (-38, 380), (-12, 410), (14, 400), (40, 370), (64, 320)]):
        a = math.radians(ang - 90)
        bx, by = 300, 500
        ex, ey = bx + length * math.cos(a), by + length * math.sin(a)
        cx, cy = bx + length * 0.55 * math.cos(a - 0.35 * (1 if ang > 0 else -1)), by + length * 0.55 * math.sin(a - 0.35 * (1 if ang > 0 else -1))
        leaf = []
        for k in range(1, 15):
            t = k / 15
            px = (1 - t) ** 2 * bx + 2 * (1 - t) * t * cx + t * t * ex
            py = (1 - t) ** 2 * by + 2 * (1 - t) * t * cy + t * t * ey
            dx = 2 * (1 - t) * (cx - bx) + 2 * t * (ex - cx); dy = 2 * (1 - t) * (cy - by) + 2 * t * (ey - cy)
            d = math.atan2(dy, dx); size = 56 * (1 - t) + 14
            for side in (1, -1):
                nx, ny = px + math.cos(d + side * 1.2) * size, py + math.sin(d + side * 1.2) * size
                leaf.append(f'<ellipse cx="{(px + nx) / 2:.0f}" cy="{(py + ny) / 2:.0f}" rx="{size / 2 + 4:.0f}" ry="{size / 3.4 + 3:.0f}" '
                            f'transform="rotate({math.degrees(d + side * 1.2):.0f} {(px + nx) / 2:.0f} {(py + ny) / 2:.0f})" fill="#3f8f3a" stroke="{LINE}" stroke-width="2.5"/>')
        out.append(f'<g id="$ID_f{i}"><path d="M{bx} {by} Q{cx:.0f} {cy:.0f} {ex:.0f} {ey:.0f}" stroke="{LINE}" stroke-width="7" fill="none"/>'
                   f'<path d="M{bx} {by} Q{cx:.0f} {cy:.0f} {ex:.0f} {ey:.0f}" stroke="#5a7f2a" stroke-width="3" fill="none"/>{"".join(leaf)}</g>')
    curl = (f'<path d="M300 500 Q290 380 320 330 Q350 290 330 270 Q306 256 296 280 Q292 298 312 300" stroke="{LINE}" stroke-width="9" fill="none" stroke-linecap="round"/>'
            f'<path d="M300 500 Q290 380 320 330 Q350 290 330 270 Q306 256 296 280 Q292 298 312 300" stroke="#7fbf4a" stroke-width="5" fill="none" stroke-linecap="round"/>')
    return (f'<svg id="$ID" viewBox="0 0 600 520" overflow="visible" xmlns="http://www.w3.org/2000/svg">{"".join(out)}{curl}'
            f'<ellipse cx="300" cy="505" rx="120" ry="22" fill="#6b4a2b" stroke="{LINE}" stroke-width="5"/></svg>')


for name, svg in {"room_day": room(day=True), "garden": garden(), "fern": fern(), "kid": kid(), "teacher": teacher(), "room": room(), "desk": desk(),
                  "classroom": classroom(), "classdesk": classdesk()}.items():
    open(os.path.join(OUT, name + ".svg"), "w", encoding="utf-8").write(svg)
    print("wrote lib/" + name + ".svg")
