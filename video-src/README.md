# Tòa án AI videos

Source for the 4 case videos on slides 29–32. Each `caseN/` folder is a HyperFrames project.

| Folder | Slide | Story | Answer |
|---|---|---|---|
| case1 | 29 | Tiếng Anh: Gemini đố 30 câu trong một tối | B · Nhớ một phần |
| case2 | 30 | Khoa học tự nhiên: Gemini viết hộ bài quan sát cây | C · Quên |
| case3 | 31 | Ngữ văn: Gemini chỉ lỗi, tự sửa | A · Nhớ |
| case4 | 32 | Giáo dục địa phương: Gemini dùng số liệu cũ về Hà Nội | C · Điểm thấp |

Scripts as approved: `SCRIPTS-2-4.md`. Cases 1, 3 and 4 share `lib/base.css` and `lib/rig.js` through `{{raw:...}}`; `{{captions}}` and `{{narration}}` are generated from `script.json`. Everything is free and runs on this Mac.

## Pieces
- `lib/art.py` draws the cast and sets as SVG (student, teacher, bedroom, classroom, desks). Run `python3 lib/art.py` after changing it.
- `caseN/script.json`: the narration, one line per scene. `hold` adds seconds after a line; `pause` marks the vote card.
- `caseN/index.html.tpl`: the scenes and animation. **Edit this, not `index.html`.**
  `{{inc:kid|k1}}` pastes `lib/kid.svg` as character `k1`; `mood("k1","worried",t)`, `pose("k1","Head",t)`, `blink`, `look` act it out.
- Sound: music bed `case1/assets/music/carefree.mp3` at volume 0.13, effects in `case1/assets/sfx/` (peak-normalised). Every effect is an `<audio>` tag in the template, timed like `{{s3.start+0.7}}`.
- Voice: VieNeu-TTS (open source, Apache-2.0), voice "Ngọc Linh". Samples of other Northern voices are in `voice-test/`.

## Make or remake a video
```
tools/make.sh case1                      # voice + build + render, default voice Ngọc Linh
tools/make.sh case1 vieneu "Thiện Minh"  # another voice
```
It renders the full video, then `tools/split.sh` cuts it at the vote card (the `pauseAt` time that `build.py` prints) into `slides/videos/case1-1.mp4` (part 1, shown before the quiz slide) and `case1-2.mp4` (part 2, shown after it). Nothing to copy into the slides; the file names stay the same.
To re-render without new voices: `cd caseN && python3 ../tools/build.py caseN && npx hyperframes render --quality looks -o ../../slides/videos/caseN.mp4 && cd .. && tools/split.sh caseN <pauseAt>`.

Preview while editing: `cd case1 && npx hyperframes preview`.

Needs: Node 22+, ffmpeg, jq, and the Python venv in `.venv` (VieNeu; onnxruntime pinned below 1.30).
The VieNeu model is cached in `~/.cache/vieneu-local`, outside OneDrive. Telemetry is off (`HYPERFRAMES_NO_TELEMETRY=1`).

## Credits (CC BY 4.0, shown at the end of the video)
- Music: "Carefree", Kevin MacLeod (incompetech.com).
- Page-turn sound: flag2, freesound.org/people/flag2/sounds/63318.
- Other effects: CC0 from Openverse, or bundled with HyperFrames.
