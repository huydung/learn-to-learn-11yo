"""Fill <case>/index.html.tpl with timings from the narration files and write <case>/index.html.

  python3 tools/build.py case1

Tokens in the template:
  {{s1.start}} {{s1.dur}}      scene window (seconds)
  {{s1.vstart}} {{s1.vdur}}    narration window
  {{s1.say}}                   narration text (for captions)
  {{total}}                    video length
  {{img:name|description}}     assets/img/name.png, or a labelled placeholder until it exists
"""
import json, os, re, subprocess, sys

case = sys.argv[1]
os.chdir(os.path.join(os.path.dirname(__file__), "..", case))
LEAD, TAIL, TITLE = 0.35, 0.5, 2.4  # seconds before/after each line; opening title card

def length(path):
    out = subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", path],
                         capture_output=True, text=True, check=True).stdout
    return float(out)

tok, t = {}, TITLE
for line in json.load(open("script.json")):
    i, v = line["id"], length(f"assets/voice/{line['id']}.m4a")
    dur = LEAD + v + TAIL + line.get("hold", 0)
    tok.update({f"{i}.start": t, f"{i}.dur": dur, f"{i}.vstart": t + LEAD, f"{i}.vdur": v, f"{i}.say": line["say"], f"{i}.cdur": dur - LEAD - 0.1})
    if line.get("pause"):
        print(f"pauseAt: {t + LEAD + v + 0.8:.1f}  (put this in the slide's video widget)")
    t += dur
tok["total"] = t

def img(m):
    name, desc = m.group(1), m.group(2)
    if os.path.exists(f"assets/img/{name}.png"):
        return f'<img id="art-{name}" class="art" src="assets/img/{name}.png" alt="">'
    return f'<div id="art-{name}" class="art ph"><span>Ảnh minh họa<br>{desc}</span></div>'

html = open("index.html.tpl", encoding="utf-8").read()
# {{narration}} and {{captions}} expand to one tag per script line (no caption on the vote line).
lines = json.load(open("script.json"))
html = html.replace("{{narration}}", "\n".join(
    f'<audio id="v_{l["id"]}" class="clip" src="assets/voice/{l["id"]}.m4a" data-start="{{{{{l["id"]}.vstart}}}}" '
    f'data-duration="{{{{{l["id"]}.vdur}}}}" data-volume="1" data-track-index="3"></audio>' for l in lines))
html = html.replace("{{captions}}", "\n".join(
    f'<div id="cap_{l["id"]}" class="clip cap" data-start="{{{{{l["id"]}.vstart}}}}" data-duration="{{{{{l["id"]}.cdur}}}}" '
    f'data-track-index="2"><span>{{{{{l["id"]}.say}}}}</span></div>' for l in lines if not l.get("pause")))
html = re.sub(r"\{\{img:([\w-]+)\|([^}]*)\}\}", img, html)
# {{inc:kid|k1}} pastes lib/kid.svg with every $ID renamed to k1, so one drawing can be used many times.
LIB = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "lib")
# {{raw:base.css}} pastes a shared file from lib/ as it is.
html = re.sub(r"\{\{raw:([\w.]+)\}\}", lambda m: open(os.path.join(LIB, m.group(1)), encoding="utf-8").read(), html)
html = re.sub(r"\{\{inc:(\w+)\|(\w+)\}\}",
              lambda m: open(os.path.join(LIB, m.group(1) + ".svg"), encoding="utf-8").read().replace("$ID", m.group(2)), html)
def fill(m):  # {{s1.say}}, {{s1.start}}, or arithmetic like {{s3.dur+s4.dur}} or {{s7.vstart+s7.vdur-0.6}}
    expr = m.group(1).strip()
    if isinstance(tok.get(expr), str):
        return tok[expr]
    return f"{eval(re.sub(r'[a-z]+\d*\.\w+|total', lambda k: repr(tok[k.group(0)]), expr)):.3f}"
html = re.sub(r"\{\{([\w.+\- ]+)\}\}", fill, html)
open("index.html", "w", encoding="utf-8").write(html)
print(f"index.html written, {t:.1f} s")
