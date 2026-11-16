# 6B0 "Học cách học": handoff for a new session

Last updated: 16 Nov 2026 (Hanoi), card race removed (60 slides, 9 printable pages); stops renamed Đọc hiểu, Bình chọn, Trả lời. Author of the session: Huy Dũng (always write the name with diacritics).

Read this file first. It explains what exists, how the two HTML files work, what has been decided, and what is still open.

---

## 1. The event

- **What:** a parent-led session ("Cha mẹ cùng thầy cô lên lớp") for class **6B0**, 16 students. The homeroom teacher, **cô Tươi**, stays in the room as referee and scorer.
- **When:** Tuesday **17/11/2026**, tiết 4–5. That is 10:15–11:00, a school break 11:00–11:05, then 11:05–11:50.
- **Content:**
  - "Dở → Tập → Giỏi → Thích".
  - The learning ladder (thang học, based on ICAP, Chi & Wylie 2014): **1 Nhận vào · 2 Làm theo · 3 Tự chế · 4 Tương tác**.
  - The four hacks (from Oakley et al., *Learning How to Learn*):
    1. Tập trung từng việc
    2. Chia nhóm, vẽ sơ đồ
    3. Nghỉ ngơi, rải đều
    4. Luyện nhiều chỗ yếu
  - Card text lives in `Tai-lieu-in-6B0.docx` pages 2–5 (the only copy; the old `.md` copy was removed on 14 Nov).
  - Using AI (Gemini) well and badly.
  - Group slides on Canva.
- **Format:** a game. There are 4 colour teams, chosen and seated by cô Tươi: Red (R), Blue (B), Green (G), Yellow (Y). The names are in English everywhere (slides, HUD, printables) so they are similar in length. A wheel gives each team one hack; the whole team reads it and teaches it to the class.

### Constraints that always hold
- Never spotlight Nam Anh (Huy Dũng's son is in the class).
- Every activity has a countdown. The class is lively.
- No pre-reading and no homework.
- Vietnamese text in natural full sentences. Prefer ideas over single-study numbers, and only use verified statistics.
- Brand (huydung-brand):
  - Fonts: Merriweather headings, Be Vietnam Pro body.
  - Reds: #BD0129, #8E011F, #51000C. Cream: #F8F7D0.
  - Team colours: R #D32F2F, B #1E63C6, G #2E8B47, Y #F2B705.

---

## 2. Deliverables

| # | What | Where | Source in this folder |
|---|---|---|---|
| A | **Student slides + leaderboard** (projected in class) | Local folder `slides/` (open `6B0slides.html`). Older online copy: https://claude.ai/artifact/DEWBsWs7xBedRFo4CiY3Rm | `slides/` · see `slides/README.md`. `InteractiveSlides.html` is the old single-file version. |
| B | **A4 printables** (9 pages) | `Tai-lieu-in-6B0.docx` (edit and print in Word). Older online copy: https://claude.ai/artifact/AR2vJGv2TKAzz5LM2Wgv76 | `Tai-lieu-in-6B0.docx`. `ToPrint.html` is the old HTML version. |
| C | Plan deck for cô Tươi (Slides type, 28 pages) | claude.ai artifact https://claude.ai/artifact/KFFwru2snypPApxmFKyrEx | Not a file. Edit it in the claude.ai Slides editor, or export to PDF/PPTX from there. |

The claude.ai Project "6B0 Teaching" holds the same two sources and a status doc.

### Running locally (since 11 Nov 2026)
- **Slides, with a server (recommended):** double-click `start-slides.command` (Mac) or `start-slides.bat` (Windows). Both run `serve.py`, which serves `slides/` at http://localhost:8611 with caching off and opens the deck. Close the window to stop. Scores live per address, so always use this same launcher on the day. If a browser shows old slides from an earlier server on 8611, hard-refresh once (Cmd+Shift+R).
- **Slides, without a server:** double-click `slides/6B0slides.html`. Fonts are in `slides/fonts/`, so it works offline. Scores, wheel results and in-browser edits save to the browser's `localStorage` (prefix `hch-6b0-v2-`; the old `hch-6b0-` keys are ignored). Slide edits made in the browser are written into `6B0slides.html` with Ctrl+S (or `?` → **Lưu trang vào 6B0slides.html**). Scores stay in the browser, so run the class in one browser.
- **Videos:** copy files into `slides/videos/`, then edit mode → **Gắn video**.
- **Printables:** open `Tai-lieu-in-6B0.docx` in Word. Fonts used: Merriweather and Be Vietnam Pro (copies in `slides/fonts/`; install them on the printing computer, or Word substitutes).

---

## 3. Session flow (60 slides, 9 map stops)

Two columns of minutes: the plan, and a realistic estimate (16 eleven-year-olds, including moving, explaining rules, reveals and scoring). Class time is 90 minutes (10:15–11:00, school break 11:00–11:05, 11:05–11:50).

| Plan | Realistic | Phần | Slides |
|---|---|---|---|
| 8 | 10–12 | Chặng 1 · Khởi động: Clash Royale story, Bài học 1 (Tập → Giỏi → Thích), Bài học 2 (the ladder), lập đội with the climb teaser, luật tính điểm, tín hiệu khiên | 1–8 |
| 9 | 11–13 | Chặng 2 · Đọc hiểu: hand out cards and posters, one slide with one 9 min timer: 4 min silent reading alone, then the team fills in the poster (host calls the switch) | 9–10 |
| 13 | 16–18 | Chặng 3 · Giảng giỏi: rules, 4 teams × 3 min, about 1 min to change teams | 11–16 |
| 4 | 4–5 (+5 break) | Chặng 4 · Bình chọn: dot vote and count, then the giải lao slide (5 min timer), which lands on the 11:00 school break | 17–19 |
| 7 | 10–11 | Chặng 5 · Trả lời: 4 questions (1 min each) plus reveal and short explanation, results, "Ai học nhiều nhất" | 20–27 |
| 10 | 17–19 | Chặng 6 · Dùng AI: rules, wheel, 4 cases × about 3.5 min (part 1 video 35–51 s, 45 s guess, part 2 video 26–47 s, one team explains, verdict), results, wrap-up | 28–44 |
| 15 | 12–15 | Chặng 7 · Làm Slides: why, idea-board rules, idea round (each idea ≤10 s plus typing and judging), Canva tips, Canva example | 45–50 |
| 10 | 13–15 | Chặng 8 · Chung kết: 5 questions × (90 s + reveal), results | 51–58 |
| 5 | 7–9 | Chặng 9 · Về đích: standings, gifts (2 picks per kid, about 32 picks), cheat sheet | 59–60 |
| **81** | **100–117** | | |

**Timing:**
- Realistic total is about 108 minutes of class time against 90 available (the 5-minute break is the school's). Expect to cut 10–25 minutes on the day.
- Map stops keep their buildings: stop 4 (the second stage) is now Bình chọn, and the arena (stop 5) now holds Trả lời.

## 4. Scoring (locked)

- **Every round is ranked and gives 4 · 3 · 2 · 2** (Chung kết 8 · 6 · 4 · 4). 3rd and 4th get the same. Ties share the higher place. A round's own count (dots, correct cards, ideas) only decides the place; it is never added to the total. Only Khiên is a flat bonus.
- **Correct beats fast.** Speed only breaks ties.

| Round | How | Points |
|---|---|---|
| Giảng hay | dot votes after all 4 talks: each kid 2 dots in their own team colour for 2 other teams (a dot under its own colour is void), cô Tươi and Huy Dũng 4 white dots each (40 dots: 8 per team colour + 8 white) | 4·3·2·2 |
| Trả lời | number of the 4 questions the team answers correctly (every team answers all 4) | 4·3·2·2 |
| Dùng AI | every team predicts each case with an A–D card: +1 per correct prediction; the wheel-picked team explains why (hack or ladder step): +1. Ranked by that total (0–5) | 4·3·2·2 |
| Slide nhóm | idea round: +1 per valid idea linked to something from the session, no duplicates. Turns go from the last-placed team to the leader; one speaker, within a count of 10; the round ends when no team has a new idea after 10 s. Ranked by the number of valid ideas | 4·3·2·2 |
| Chung kết | number of the 5 questions correct, double points | 8·6·4·4 |
| Khiên ✋ | quietest team when chú raises a hand | +1, max 3 |

- **All questions are answered by the team** with one coloured A/B/C/D card (printables pages 6–9). **No Wayground.** The team discusses for 1 minute (90 s in Chung kết).
- **Leaderboard display modes:** full scores, ranks only, or hidden.
- **Gifts:** "Every kid gets a gift; winning only means choosing first" is said **only at the end** (bangdiem slide), never up front. Gifts: 40 items, 2 per kid, two picking rounds in rank order.

### Questions (answers spread A–D)
- **Trả lời** (one per hack, in card order, asked after all 4 talks; every team answers every question): new scenarios, deliberately unlike the card examples. The hack name is not shown.
  1. Minh does maths while a friend tells a story → **B** (slower, more mistakes).
  2. 12 history events, test on Friday → **C** (split into 3 periods on a labelled timeline).
  3. Nam has been stuck on a maths problem for 30 min → **D** (stand up and walk a few minutes, or switch subject, then come back). Replaced the Lan piano question on 14 Nov so each question maps to one card.
  4. Good at English listening, weak at spelling → **A** (mostly writing, with some listening mixed in).
- **Chung kết:**
  Five questions on the whole session, easy to hard. Q1, Q2 and Q4 are ordering questions: each card A–D is one ordering.
  Every scenario is new: none repeats a hack card, a video case, the ladder slide or the slide checklist.
  1. Minh learns to swim, put the four stages in order → **D** (④ → ② → ③ → ①: dở, tập, giỏi, thích). A and C put "thích" before "giỏi".
  2. Order four ways of learning an English dialogue from the lowest ladder step to the highest → **C** (③ listen to cô read it → ① copy it word for word → ④ write a new dialogue about your family → ② role-play with a friend and correct each other).
  3. Which kids use AI to move up the ladder → **B** (An asks for 3 similar maths problems to solve; Bình writes 5 key points then asks what is missing; Dũng has Gemini grill his presentation). Chi has Gemini write her intro and copies it.
  4. Order the steps for a group wall newspaper about Tết → **A** (② tree outline of the sections → ④ who writes what, by when → ① each writes at home a bit each evening → ③ one person proofreads).
  5. Which statements are true → **C** (① 5 minutes of times tables every morning for 7 days beats 35 minutes in one go; ③ a 10-minute break playing đá cầu can unlock a geometry problem). ② TV on low while working still costs attention; ④ feeling familiar after rereading is not remembering.

### Group-slide ideas (no fixed checklist since 16 Nov)
The class builds the list. On `y-tuong-kq` the host clicks a team button (or "Ý của chú"), types the idea and files it under Nên (Enter) or Không nên. Each team note is +1 in round `nhom`; "Ghi điểm" records it. The cheat sheet box lists the first 7 Nên notes (blank lines if there are none).

Ideas the host can add if the class misses them: thống nhất dàn ý trước (hack 2) · mỗi bạn một phần, tự viết bằng lời của mình (bậc 3) · bảng phân công có tên và hạn · làm rải ra nhiều buổi (hack 3) · ghi nguồn chữ và ảnh · mỗi slide một ý, chữ ít và to · một bạn kiểm tra thông tin và chính tả. Không nên: mất nhiều thời gian chọn màu, phông, hiệu ứng · chép nguyên văn từ mạng hoặc AI · một bạn làm hết.

---

## 5. How the slides work (`slides/`)

`slides/README.md` explains running and editing. In short:
- `6B0slides.html` (was `index.html` until 14 Nov) holds everything the class sees. `TEAMS`, `ROUNDS`, `POINTS_RANKED`, `POINTS_FINAL` and `SHIELD_MAX` are in a small `<script>`. The 60 slides are `<section>` elements in `<div id="slides">`; each box is a `<div data-box="x y w h">`, and widgets add `data-widget` and `data-opts` (JSON). Quiz answers are letters (`"answer":"B"`).
- Edit mode (`E`) keeps changes in `localStorage`; Ctrl+S writes the whole deck back to `6B0slides.html` in the same format (File System Access API in Chrome, download elsewhere). Unchanged slides come out byte for byte the same, so `git diff` shows only real edits. (`content.js` was removed on 13 Nov; it is in the first git commit.)
- `app.js` is the engine. Widgets live in the `WIDGETS` object: `html teams timer reveal video thiviet wheel quiz tally roundres checkstep standings`.
- `style.css` holds the brand tokens and all styles.
- Storage keys: `hch-6b0-v2-board`, `-thiviet`, `-wheels`, `-edits`.
- Leaderboard → **Xóa điểm, đáp án và bốc thăm…** (click twice) clears scores, team answers and wheel results. Slide edits stay.
- Every change saves to `localStorage` the moment it happens, including running timers (stored as an end time), Văn hóa đọc progress, revealed answers, the current slide and in-progress slide edits. A reload loses nothing. Two open tabs sync through the `storage` event. A red bar appears if the browser cannot save.

## 6. How the old `ToPrint.html` worked (the .docx replaces it)

- **Data:** JS arrays `TEAMS`, `HACK`, `ACTS` (8 matching-card actions with their hack), `CHECK`, `CARDS` (4 hack cards: body HTML split into `.sec` blocks, a "say" line, a source).
- **Page builder:** `P(html, info, cls)` adds an A4 page (`@page{size:A4;margin:0}`; print CSS sets body margin 0).

**Pages:**

| Page | Content |
|---|---|
| 1 | index (what to print, how many copies) |
| 2–5 | hack cards, one per A4 page; "Khi giảng cho đội (2 phút, gồm cả hỏi đáp)" |
| 6–9 | A/B/C/D answer cards, one page per team colour |
| ~~old 6–13~~ | matching cards and floor signs for the card race: removed on 16 Nov |
| ~~18–20~~ | team sheet, take-home slips, scoring poster: removed from the .docx on 14 Nov |

**Regenerate the PDF with Playwright:**
```js
const {chromium}=require('playwright');(async()=>{const b=await chromium.launch();const p=await b.newPage();
const h=require('fs').readFileSync('tai-lieu-in-6b0.html','utf8');
await p.setContent(`<!doctype html><html><head><meta charset=utf8></head><body>${h}</body></html>`,{waitUntil:'networkidle'});
await p.pdf({path:'Tai-lieu-in-6B0.pdf',format:'A4',printBackground:true,preferCSSPageSize:true});await b.close()})();
```
Check the PDF afterwards: it should be exactly 9 pages in Word (LibreOffice shows 10, with an empty last page), with no blank ones.

---

## 7. Checking changes to the student slides

- **Render every slide headless** at 1920×1080 with Playwright, using the same `setContent` wrapper as above.
- **Check overflow:** each `.blk`'s inner `scrollHeight` should not exceed its height, and content should stay above y≈1000, where the footer is.
- **Screenshot** the slides you changed and look at them.
- **Navigation in a script:** press ArrowRight; `location.hash` holds the slide id. The cheat sheet hides its footer (`nofoot:true`), so scripts reading `.foot` must allow for a missing element.

---

## 8. Plan deck for cô Tươi (C), for reference

- Sections:
  1. Tổng quan: tóm tắt, thang, hack, lịch, điểm
  2. Trong lớp
  3. Tài liệu: 4 thẻ, câu hỏi
  4. Góp ý, nguồn
- **Sources slide:**
  - Oakley, Sejnowski & McConville (2018).
  - Roediger & Karpicke (2006).
  - Rohrer, Dedrick & Stershic (2015).
  - Chi & Wylie (2014).
  - Nestojko et al. (2014).
  - Cepeda et al. (2006).
  - Letrud & Hernes (2018), cited as the reason there is no "learning pyramid".
- **Kept in step with A and B:** timings, scoring, team A–D answering, the new round-2 questions, and the ladder names Tự chế / Tương tác. Step 3's description is "tự giải thích, tự đặt câu hỏi".
- **Suggested but not yet applied:** on the ladder page, step 3's school example still says "gấp vở tự nhớ lại, luyện chỗ yếu". Retrieval is a hack, not strictly ICAP step 3. The suggested replacement is "giải thích bài bằng lời của mình, tự đặt câu hỏi cho bài".

---

## 9. Open items to finalize

1. Reconcile giải lao with the 11:00 school break (section 3).
2. ~~Make the 4 Dùng AI videos.~~ Done 12 Nov: `slides/videos/case1–4.mp4`, built in `video-src/` (see its README). Each stops by itself at the vote card (`pauseAt` in each video's `data-opts`, index.html).
3. Confirm with cô Tươi:
   - the session teams stay together for bài 20/11;
   - she gives groups in-class time later;
   - board, ladder and floor-zone setup (Huy Dũng may involve the art teacher).
4. Print everything (see printables page 1 for copies), cut the A–D cards, and print the 4 A1 posters.
5. Optional:
   - an A4 print version of the cheat sheet (page 50 is a 16:9 slide);
   - put "Mình nghĩ trước, AI hỏi sau" back as the first "Nên" item on the cheat sheet (it was removed with the subtitle);
   - number the 7 tick boxes on the cheat sheet.
6. Before class: clear all test scores, wheel results and team answers.

---

## 10. Decisions log (most recent first)

- **Canva example file (16 Nov, late night):** no live demo. Huy Dũng built the example in Canva from the template "Green Blue and Pink Illustrated Butterfly Group Project" (11 pages, "6b0 example slides"), with a real Canva table for the task list (Task · Owner · Due date · Status). Link: https://canva.link/3bjgbu2asex0qyi. New slide `canva-vd` (50) shows four screenshots, one per click: search templates, pick one, keep the template, the task table (`slides/images/canva-vd-1…4.webp`, browser bars cropped off). Each image and the "Mở trong Canva" link open the file; slide 49 also has the link. Canva's AI tools could not make a real table (they draw boxes with text on top), so the AI-made deck was dropped.

- **Every round is ranked (16 Nov, late night):** Dùng AI and Slide nhóm used to add raw points (up to 5 and up to 20). Now their counts only decide the place, like the other rounds, and the place gives 4 · 3 · 2 · 2. The "points" round kind is gone from the code. The Dùng AI tally shows a Tổng column (cards + explanation); the leaderboard only offers "Hạng N · Xđ". Slides: the Dùng AI scoring note is now "Cách xếp hạng"; on `y-tuong` the "+1 điểm" is gone and the last line says the team with the most sticky notes ranks first. Khiên stays a +1 bonus (max 3).

- **Big text everywhere it fits (16 Nov, late night):** instruction and question text uses `lead` (46px) instead of `body` (38px) on 11 slides. Layout nudges: `luat-giang` note moved to y590; `binhchon` text box 250 tall, results table at y470; `y-tuong` text box 600 tall; all five Chung kết answer-card widgets at y570 (h410). Three stay at `body` because `lead` does not fit: `thang` (the ladder fills the slide), `ck-cau5` (four long statements) and `bangdiem` (would run into the footer). Checked by measuring the text bottom of every box on all 59 slides.

- **Reading and poster prep merged (16 Nov, late night):** `doc` (4 min) and `chuanbi` (5 min) are now one slide, `doc` "Đọc và chuẩn bị giảng", with one 9 min timer. The first line says the first 4 minutes are silent reading alone; the host calls the switch. The question and voting lines were dropped from it because `luat-giang` already says them. 59 slides.

- **Huy Dũng's docx pass, other materials synced (16 Nov, late night):**
  - Card labels in the docx are now "HACK 1–4" (was "THẺ N · ĐỌC TRONG 4 PHÚT"). Hack 3 is now **Nghỉ ngơi, rải đều**, hack 4 **Luyện nhiều chỗ yếu**. Renamed on the slides (`giang3`, `giang4`, cheat sheet) and the posters.
  - Poster 1: the driver line drops "nghiêm trọng" and says "lái xe"; the Altmann line says the extra task was unrelated.
  - Poster 3: the football line says the team does not cram one long session before the match; "Khi gặp một vấn đề khó" replaces "Khi chưa nghĩ ra cách".
  - Poster 4: the Rohrer line now just says the test was unannounced (the chart shows the 30-day result).
  - Docx card 1: the Altmann method now says each person's errors right after an interruption were compared with their own errors when working without one (within-subject, as in the paper). Fixed the "taajp trung" typo.
  - Docx card 4: Rohrer now says half the pupils were tested after 1 day and half after 30 days (63 per delay), and the 80% vs 64% result is per problem type (mixed vs blocked), not per group.
  - Cheat sheet hack 4: "Luyện thêm dạng bài hay sai" (was "nhiều nhất"), matching the card.

- **Slide walk-through for grade 6 (16 Nov, late night):** wording and flow only; no change to stops, scoring, timers or answer letters.
  - `bai1`: the note now asks each kid to think of a subject they do not like yet. The last stop (`bangdiem`, "Môn mình chưa thích") closes that loop.
  - `lapdoi`: shorter sentences ("Hack là mẹo học, giúp đoạn “Tập” ngắn lại").
  - `khien`: new step 3, practise the shield signal once before the game starts.
  - `giang1`–`giang4`: a note for the listening teams (cards face down; the next stop has a question on this hack).
  - `nghi`: the break names hack 3.
  - `v2-cau2`: option D was a rhyme for each event, which the book supports (memory tricks, ch8), so a kid could argue for it. It is now "Tô bút nhớ lên cả 12 sự kiện trong sách giáo khoa." The answer is still C.
  - `chot2`: the title question now gets an answer on the slide (the one who thinks and says it aloud learns most).
  - `toaan`: title "Dùng AI: chuyện gì xảy ra sau đó?" (the divider before it has the same stop name).
  - `toaan-chot`: "Mình nghĩ trước, AI hỏi sau." is back, as the first line of the note (open item 5).
  - `y-tuong`: 6 rules became 5, with an example idea in a note.
  - Not done, for Huy Dũng to decide: the session still runs about 108 minutes against 90.

- **Key D: test data for rehearsals (16 Nov, late night):** on an open slide, D fills the widget with made-up results, different on every press. Quiz: a card for each team (right about 6 times in 10). Wheel: spins for the next slot; when all slots are full, deals a new order. AI case part 2: cards, a team to explain (kept if the wheel chose one), a verdict. Idea board: one more sticky note from a pool of 18. Vote count: 40 dots split over the 4 teams. Results tables: cards for every question, and the 0/1 bonus. D does nothing on the map or with the leaderboard open. Each press is written to the board log as "Dữ liệu thử (D)". Widgets register it with `ctx.onKey("D", …)`; helpers `dummyAnswers`, `different`, `DUMMY_IDEAS` sit above `answerOf` in app.js. **Before class: clear everything (leaderboard → Xóa điểm, đáp án và bốc thăm…) and do not press D.**

- **Poster illustrations redrawn (16 Nov, late night):** all drawings are original native shapes, one group per illustration (ungroup to edit). Step 1 on every poster now uses a real-life example from the card, not the game hook (driver and one second on the phone; library topics; football week and "ngủ một đêm"; pianist and the hard passage), with a matching drawing. Poster 1: octopus with four arms holding four cards (the dashed card has the phone). Poster 2: a real tree to fill in: blank root box, three branch boxes, two leaves on each branch (the card's supermarket example goes in it). Poster 3: flashlight and ceiling lamp over idea dots, three evenings with a link that gets thicker; step 3 is a pictogram, 22 people per row, pupils colour 5 and 13. Poster 4 step 2: an old test with ticks and crosses for three kinds of problem (pupils circle the weak one), a blocked row of shapes, and an empty row to draw the mixed order. Charts on posters 1, 2 and 4 have a real scale; pupils colour each bar up to the right line. No picture comes from the book or the web. Source list with links: `Ref/Nguon-da-kiem-tra.md`.

- **Source audit: exact numbers on cards, poster and slides (16 Nov, late night):**
  - Every study number on the 4 cards was checked against the paper. Altmann 2014: 300 people, a 7-step task; error rate about 2% with no interruption, 4.3% after 2.8 s (Exp. 2), 5.8% after 4.4 s (Exp. 1). Bower 1969: 112 words, 2 s per word, first-trial recall 20.6 (random) against 73.0 (tree), 8 students per group; the tree group recalled all 112 on trial 3. The old "gấp 2 đến 3 lần" was too low (it is 3.5 times). Wagner 2004: 66 people aged 18 to 31, 22 per group, 13/22 (59%) after sleep against 5/22 (23%) in each of the two awake groups. Rohrer 2015: 126 pupils, 3 months, 10 assignments; only half took the 30-day test (74% against 42%), the other half took it after 1 day (80% against 64%).
  - Vague advice now has numbers: stuck after 10 to 15 minutes, then a 5 to 10 minute break (book ch2); start review at least 3 days before a test, 15 to 20 minutes each evening (a practical rule, not a study result); sleep 9 to 12 hours (AASM, Paruthi 2016, ages 6 to 12). Card 1 driver example (Huy Dũng's wording): "Chỉ 1 giây nhìn điện thoại là có thể gây tai nạn nghiêm trọng." It is a caution, not a study number. Poster 1 step 1 has the same sentence with blanks (nhắn tin · 1 · tai nạn).
  - Book chapters rechecked in the full reader: card 2 now cites ch1 (picture walk), 7, 9; card 4 cites ch12 only (ch6 is sleep and spacing, which moved to card 3).
  - Not in the book: "no phone in the break" (the book lists videos and chatting as rewards) and the flashlight and ceiling-lamp image (the book uses pinball). Both stay as the session's own advice.
  - Slides: Trả lời Q3 option D and the cheat sheet hack 3 line carry the same numbers. No answer letter changed.
  - Poster: step 3 blanks, bar labels, captions and speaker-note answers match the cards. Poster 2 tree root is now "Siêu thị" (three branches rau, sữa, bánh kẹo from the card; the old Thư viện chain did not fit a 1-3-3 tree). Poster 3 step 2 no longer asks for "3 tối, 20 phút" (not on the card); it asks for "nhất" and "đêm".

- **Card race removed; stops re-split and renamed (16 Nov, night):**
  - Đúng chỗ (đua ghép thẻ) is gone: hectic, about 9 minutes in class, 8 printed pages to cut and tape, and recall is already practised in Trả lời and Chung kết. Slides `p3`, `ghepthe`, `kq-ghep`, `ghepthe-chot`, round `ghepthe` and the running penalty removed. Printables: matching cards and floor signs removed (17 → 9 pages); the "đội Đỏ" footer on the Red answer page now says "đội Red".
  - The map keeps all 9 buildings. Stop 4 (the second stage) is a new stop **Bình chọn** (divider `p-binh`, the vote, then the giải lao slide, timed to land on the 11:00 school break). The arena (stop 5, bell and cards) now holds the quiz round.
  - Renamed: Chuẩn bị → **Đọc hiểu**, Nghe hiểu → **Trả lời** (stop, divider, slide tags, round name).

- **Card 1/3 rebalance, docx voice pass, launchers (16 Nov, night):**
  - Card 1 Áp dụng now holds the whole Pomodoro: phone away; 15-minute timer, note stray thoughts on paper, build up to 25; then a 5-minute break without the phone (the book calls the break the reward).
  - Card 3 Áp dụng: (1) "Làm môn khó nhất trước" (the book's "ăn những con ếch trước", ch13, 15) merged with the stuck rule, because the book's reason for doing the hard thing first is time to get stuck, rest and come back; (2) spacing, with "gấp vở lại và tự nhớ trước" (the book: each review is recall, not rereading); (3) sleep, then retry last night's hard problem.
  - Smaller wording fixes on cards 1 and 4; page 1 now lists the 4 A1 posters. Page layout unchanged (each card one page).
  - Cheat sheet hack 1 and 3 lines updated to match.
  - Book check (full reader edition): hacks 1, 3, 4 match techniques the book repeats; hack 2's tree diagram is not a book technique (Bower 1969 still backs it). The book's closest stronger option is memory tricks (ch8); kept hack 2 for 17 Nov because switching would touch the card, poster, matching cards and two questions.
  - `serve.py` + `start-slides.command` + `start-slides.bat` added.

- **Structure follow-ups (16 Nov, late):**
  - `lapdoi` teases the plan: the stops are ordered so the class climbs the ladder, from bậc 2 at the start to bậc 4 at the end.
  - The vote is now about the presentation: "Đội nào trình bày tốt nhất?", judged on clear, easy to follow, and all 4 kids took part. The prep and rules slides use the same words.
  - Each `giang` slide is now only the title, the timer and the poster's four box titles. The rules stay once on `luat-giang`.
  - Dùng AI stays as it is (all 4 cases); the host will cut elsewhere if time runs short.
- **Wording pass and map HUD (16 Nov, evening):**
  - HUD: the "Về bản đồ" button is gone. Esc or a click outside the slide returns to the map (both already worked). A small "?" button opens the shortcut list. "▶ Vào chặng" shows only on the map.
  - Slides now match the posters: the prep slide (`chuanbi`) says one kid per poster box, fill in from the card, read in order 1 → 4; the four `giang` slides say the team brings its poster and each kid reads a box; `chot2` maps listening to bậc 1, filling the poster to bậc 2, answering with cards face down to bậc 3, and says the AI and Slides stops are bậc 3–4.
  - Scoring card "Đúng hơn nhanh" replaced by "Bằng điểm" (ties share the higher place; speed earns nothing). No round uses speed any more.
  - Nghe hiểu Q1 and Q2 options rebalanced so the right answer is not the longest. Answers unchanged (B, C).
  - Plainer Vietnamese on: Clash Royale, Bài học 1 (dropped the unchecked "phổ biến hơn nhiều"), the ladder line, luật xoay vòng, luật giảng, the AI wrap-up note, Canva tip 4, and the closing line (now a concrete "chọn một hack và dùng nó tuần này").

- **Team-talk posters and a sticky-note idea board (16 Nov, later):**
  - Teaching a hack is the "Làm theo" step: kids find the card's own words and numbers and say them aloud. Recall comes in the quiz; new ideas come in the AI and Slides rounds.
  - `Poster-giang-A1-6B0.pptx`: 4 A1 landscape slides, one per hack, all native shapes so they can be edited. Each has 4 numbered steps that follow the card headings (Bạn có để ý không? · Vì sao? · Thử nghiệm · Áp dụng), one kid per step with a blank name line, fill-in blanks with the card's wording, and a visual to complete (octopus, tree, two lamps with three evenings, A/B/C rows, empty bar chart). Step 4 has only three numbered lines for the three Áp dụng actions. Answers are in each slide's speaker notes. Hand each team the poster for the card it drew.
  - Slides: `y-tuong-kq` is now the sticky-note board (new `ideas` widget in app.js, notes stored in `board.ideas`, cleared with the scores). The fixed checklist slide `nhom` was removed (65 slides). The rules slide now asks for one nên or không nên idea. The cheat sheet's Canva box became "Slide nhóm · lớp mình nói nên" and is filled from the board by the `html` widget (`data-ideas="nen"`).

- **Spacing moved to card 3; card 4 is weak spots + mixing (16 Nov):**
  - New names: **Nghỉ đúng, ôn rải đều** (card 3) and **Luyện chỗ yếu, trộn bài** (card 4). Spacing sits with diffuse mode and sleep: each night of sleep between short sessions builds the new connections. Card 4 now teaches deliberate practice (most review time on the problem types you get wrong) and interleaving. The Nghe hiểu hack 4 question (listening vs spelling → A) already tested exactly this.
  - Card 3: football training example moved over from card 4 (replaces the two-halves line); new "Rải đều là…" paragraph; Áp dụng bullet 3 combines spacing and sleep; Cepeda 2006 moved to its sources. Study is still Wagner 2004.
  - Card 4: new hook (easy monsters never level you up), piano example for weak spots, new Vì sao and Áp dụng; Ericsson, Krampe & Tesch-Römer 1993 added to sources. Study is still Rohrer 2015; "rải ra nhiều tuần" and the "Trộn và rải ra" label stay, because in that study the mixed practice was also spread out.
  - Both cards were trimmed so each fits one page with room to spare. Oakley chapter numbers were not rechecked.
  - Matching cards: the song card ("Nghĩ mãi không ra tên bài hát…", hack 3) is replaced by "Tìm dạng bài mình hay sai, rồi luyện thêm dạng đó" (hack 4). Hack 3 is now "Bí bài toán tối qua, sáng nay thử lại thì giải ra" · "Ôn 20 phút mỗi tối trong ba tối"; hack 4 is "Trộn ba dạng toán trong một buổi ôn" · the new card.
  - Slides: giang3/giang4 titles, the ghép thẻ wrap-up (now names three hacks), the Canva checklist "(hack 3)", the cheat sheet boxes, and the Dùng AI table's Hack column (it still pointed at the old "Tự đố, tự giảng" hack 2: quiz-me-each-evening → 3, find-my-weak-spots → 4, teach-the-AI → –).
  - Not changed: the videos (they never name a hack), `ToPrint.html` and `InteractiveSlides.html` (old versions).

- **AI case results move to part 2; explorers on the leaderboard (15 Nov, evening):**
  - Quiz slides `case1–4` have `"noReveal":true`: they record each team's card but show no result and have no reveal button.
  - The part 2 slides have a new `aicase` panel beside the video: the answers saved on the quiz slide, buttons to set the team that explains (stored as the `boc-toaan` wheel result for that case), Đúng / Chưa đúng for its explanation (stored as the `toaan` Giải thích bonus the results slide already reads), and the answer, shown when the video ends or on R. The panel redraws only itself, so clicks never restart the video.
  - Team cards (leaderboard slide and the L overlay) show each team's explorer.
  - Behind an open slide, a blurred, dimmed copy of the map fills the screen edges, so there are no light strips on screens that are not 16:9.

- **Map fog, bridge, caching (15 Nov, evening):**
  - Fog over the map (`map/fog.webp`, generated cloud texture) sits above the background and trail, below the landmarks and teams. Clear patches: small at stops not reached yet, larger at the current stop, large at finished stops (they open up over 2.5 s), plus one that follows the teams as they walk. Sizes are `FOG` in app.js.
  - The trail goes over the bridge between stops 2 and 3 (`via` points in `STOPS`) and is 50% transparent.
  - The local preview server sends `Cache-Control: no-store` (`.claude/launch.json`), and the Pages deploy adds `?v=<commit>` to style.css and app.js, so browsers stop showing old versions after a change.

- **Case videos split in two (15 Nov, evening):** each AI case video is now two files, `slides/videos/caseN-1.mp4` (up to the vote card) and `caseN-2.mp4` (the rest), cut by `video-src/tools/split.sh`, which `make.sh` now runs. One file with a start time failed because `python3 -m http.server` cannot seek, so part 2 restarted at 0:00. The deck also downloads all video files in the background after it opens (blob URLs), so video slides play at once online; from `file://` it falls back to the files on disk.

- **Hack 2 tree and new Chung kết scenarios (15 Nov, evening):**
  - Card 2 now says the groups form a tree: big groups split into smaller ones, main idea at the root, details on the branches. The library example is a tree (Khoa học → Sinh học → Động vật), and step 3 tells kids to split a crowded group further. The cheat sheet line matches.
  - All 5 Chung kết questions rewritten with new scenarios (swimming, an English dialogue, new AI uses, a Tết wall newspaper, new hack statements). Answer letters unchanged (D, C, B, A, C).

- **Card race, AI cases, Slides stop and Chung kết simplified (15 Nov, later):**
  - Đua ghép thẻ: no bell. A 3-minute timer; teams may move cards until it ends. `roundres` uses `"bell":false`.
  - Each AI case is three slides: `caseN-v1` (video part 1), `caseN` (a normal quiz slide; `"explain":{"wheel":"boc-toaan","slot":N-1}` shows which team explains why), `caseN-v2` (video part 2). The on-slide lesson boxes are gone; chú explains part 2 aloud. Quiz ids stay `case1–4`, so the results tally is unchanged.
  - Làm Slides: "Giảng cho người khác" removed from the why slide (most assignments so far were print-only). Văn hóa đọc review and the bài 20/11 team activity removed. New idea round (`y-tuong`, `y-tuong-kq`), round `nhom` is now points, +1 per valid idea. The checklist is shown afterwards as nên (7) / không nên (3); "Cả nhóm tập nói" was replaced by "Làm rải ra nhiều buổi (hack 4)". The cheat sheet uses the same 7 points.
  - Chung kết: the "giải thích một hack" wheel and round are removed. Dead code for the teaching-team skip (`teach`), the wheel `avoid` and `data-judged-by` was deleted from app.js.
  - Layout: quiz boxes on question slides now end at y = 980, so they no longer run into the page number and logo.

- **Opening, teaching and quiz restructured (15 Nov):**
  - "Ba câu hỏi" slide removed. The Clash Royale slide ends with "Chú rút ra được HAI bài học". New slide `bai1`: "Người ta thường nghĩ: thích thì giỏi. Đúng trong nhiều trường hợp. Còn một con đường phổ biến hơn nhiều: Tập → Giỏi → Thích." The phrase "Dở → Tập → Giỏi → Thích" is replaced by "Tập → Giỏi → Thích" everywhere (lời kết, cheat sheet).
  - Ladder slide is "Bài học 2"; the 4 steps are a `data-each` list, one step per → press.
  - Lập đội: a note that the session is about the 2 lessons plus 4 hacks; the first bullet says what a hack is for.
  - Tín hiệu khiên: chú giơ tay và lắc chuông.
  - Red section dividers show only the stop name, vertically centred (no big number, no subtitle).
  - Wheel `boc-hack` removed: teams pick a printed card at random. So the deck no longer knows who taught what: every team answers all 4 quiz questions, and the final "giải thích một hack" wheel has no `avoid`. Its note says a team that draws its own hack swaps with another team.
  - Chuẩn bị: the only criterion is to explain what the hack is and why it works. Two or more speakers is suggested, an own example is optional, teams may draw on A1 paper as a "slide", and they can use the 3 minutes for talking or for questions. A1 paper and markers added to the supplies note on printables page 1.
  - Giảng giỏi and Nghe hiểu are now separate stops (9 stops). The teaching stop ends with the dot vote. The new stop `p-nghe` has its own rules slide, the 4 questions, results and the "Ai học nhiều nhất" wrap-up. Its landmark `map/stop-nghe.webp` is a mirrored copy of stop 3, a placeholder to replace with proper art.

- **Card 2 replaced; printables trimmed (14 Nov, late):**
  - "Tự đố, tự giảng" overlapped the ladder: teaching is step 4, and self-testing sits in step 3. It is now **Chia nhóm, vẽ sơ đồ**: sort ideas into named groups and lay them out as a tree, table or timeline. Theory: long-term memory is a big locker; a structure gives each idea a place and a path back. Study: Bower, Clark, Lesgold & Winzenz 1969 (112 words in 4-level trees, e.g. minerals; recall 2–3× better than the same words placed at random). The exact first-trial numbers were checked on 16 Nov: 73.0 against 20.6 words, 3.5 times.
  - Self-testing and teaching now belong to the ladder. Cheat-sheet step 3 reads "Gấp vở tự nhớ lại, giải thích bằng lời mình". Slide references that said "hack 2" for self-testing or teaching now name the ladder step (AI cases 1 and 3, Giúp hay cản, bài 20/11).
  - Matching cards for hack 2: "Vẽ sơ đồ cây cho bài Sinh học, mỗi nhánh một ý" · "Xem các đề mục trước, rồi chia bài thành mấy phần". The ghép thẻ wrap-up names hack 2 as sorting 8 cards into 4 groups.
  - Hack 2 question is now the 12 history events (answer C, timeline in 3 periods).
  - Removed from the .docx: team sheet (old p. 18; the Slides activity will be redone), take-home slips and scoring poster. The bangdiem slide no longer mentions a printed slip.
  - Memory palace was considered and rejected by Huy Dũng. The ladder is the one idea every kid should keep; remembering one or two hacks is enough.

- **Dùng AI and take-home slip (14 Nov):**
  - Every team now predicts every case with an A–D card instead of one "judge" team; appeals and the chánh án role are gone. The A–D options sit beside the video on each case slide (`"layout":"stack"` quiz). R reveals the right option; the lesson box under the video opens on click.
  - Answers: case 1 B (about half remembered two weeks later), case 2 C, case 3 D, case 4 A.
  - Results slide uses `tally` with a 0–1 "Giải thích" column for the wheel-picked team; round `toaan` is points, max 5.
  - Take-home slip is now an if-then plan: "Khi … (lúc nào, ở đâu?), mình sẽ … (làm gì, hack nào?)" (Gollwitzer & Sheeran 2006). The slide line matches.
  - Kept out on purpose: teams writing a "fixed" prompt for Gemini, and a live Gemini demo (Huy Dũng may show Gemini himself if time allows).

- **Team teaching replaces the experts and Viết nhanh (14 Nov):**
  - Viết nhanh (thi viết A/B) removed: it gave hack 1 a live demo the other hacks did not get, pre-empted the card-1 expert and made the hack-1 question a free point. Writing sheets removed from the printables.
  - Each team gets one hack from a wheel (`boc-hack`), reads it together and teaches it to the whole class. Reason: one randomly chosen reader no longer decides a team's score, and the whole team works at bậc 3–4 while preparing.
  - Two separate scores instead of one coupled formula (a "listeners right → teacher points" scheme was tried and dropped as too hard to explain): **Giảng hay** by dot vote, with adults holding 8 of 40 dots to temper the pull towards the most eloquent team; **Nghe hiểu** by the 4 scenario questions, each team skipping its own hack. Both ranked 4·3·2·2.
  - The final "giải thích một hack" wheel never gives a team the hack it taught (`"avoid":"boc-hack"`).
  - Map stop 2 is now "Chuẩn bị" (8 stops at the time). Card footer reads "Gợi ý khi cả đội giảng cho lớp (3 phút…)".
  - AI and Canva slides tied back to the hacks and ladder: case 1 reveal names hack 2 and 4; case 4 reveal now teaches bậc 4 (check and argue back); case 1 timing fixed to "hai tuần sau"; AI summary table has a Hack column; group-slide "giúp học" list and Canva note name hacks 1, 2, 4.
  - Session runs about 7 minutes longer than before; the giải lao vs 11:00 school break question is still open.

- **Map stops and Chung kết (14 Nov):**
  - Stops 1–4 renamed Khởi động · Viết nhanh · Giảng giỏi · Đúng chỗ. The writing test is now stop 2 on its own; "Đọc im lặng" moved after it and opens stop 3, right before the experts teach.
  - One red divider per stop, numbered like the HUD (Chặng 1–7, data-nav "Chặng N"). A new divider `p2b` opens Giảng giỏi.
  - No "Vòng 1/2/3/4" anywhere in the slides or the Word printables. Rounds go by their activity: Thi viết, Chuyên gia, Đua ghép thẻ, Dùng AI, Slide nhóm, Chung kết.
  - Chung kết now has 5 questions on the whole session (not only the hacks), 90 s each, laid out like the Chuyên gia questions: stem as the title, numbered items, short options.
  - The Chuyên gia rules slide says 1 minute to match the 60 s timers. The take-home line on the last slide matches the printed slip ("Hack mình sẽ thử với môn đó").

- **Hack cards restructured (14 Nov):**
  - New names: Tập trung từng việc · Tự đố, tự giảng · Nghỉ đúng, ngủ đủ · Rải đều, trộn bài. Diffuse mode and sleep now share card 3; spacing and interleaving share card 4. "Luyện nhiều chỗ yếu" is no longer a hack; weak spots are a step on cards 2 and 4.
  - Every card has the same headings: Bạn có để ý không? · Vì sao lại như vậy? · Các nhà khoa học đã thử nghiệm thế nào? · Áp dụng vào việc học như thế nào? · Gợi ý khi giảng cho đội. No "Trên thang" line.
  - One study per card, each checked against the paper: Altmann, Trafton & Hambrick 2014 (3 s interruption doubles errors, ~4 s triples); Roediger & Karpicke 2006; Wagner et al. 2004 (59% vs 23% found the shortcut after 8 h sleep vs awake); Rohrer, Dedrick & Stershic 2015 (126 seventh-graders, 74% vs 42% a month later, within-subject: each student did one skill each way). The old card 4 numbers (140 students, 72% vs 38%) did not match the cited paper and were dropped.
  - Timer advice is 15 min, building to 25 (the book suggests 10–15 min for ages 10–12). Sleep advice 9–12 h (AASM, Paruthi 2016).
  - Matching cards, 2 per hack: (1) Làm bài 15 phút, điện thoại để ở phòng khác · Đang làm bài nhớ ra việc khác, ghi ra giấy rồi làm tiếp; (2) Gấp vở lại rồi viết ra những gì mình nhớ · Giảng bài cho em nhỏ, chỗ vấp là chỗ cần học lại; (3) Nghĩ mãi không ra tên bài hát, đang tắm thì nhớ ra · Bí bài toán tối qua, sáng nay thử lại thì giải ra; (4) Ôn 20 phút mỗi tối trong ba tối · Trộn ba dạng toán trong một buổi ôn.
  - Slides updated to match: expert-round list, Vòng 2 Q3, giải lao text, ghép thẻ wrap-up, Tòa án case 3 reveal, Chung kết Q1, the wheel, and the cheat sheet hack box (card 3 icon is now a moon, card 4 a calendar).
  - Not updated: `ToPrint.html` and `InteractiveSlides.html` (old versions), and cô Tươi's plan deck (claude.ai artifact).

- **Cheat sheet (slide 53):**
  - Print-friendly: 4 boxes with thin light borders, all-caps section bars and line icons, all body text at 24px, no footer.
  - Title "Hết bài · Nhớ lâu · Hiểu kỹ".
  - Stairs sit on the box edge. The AI section is a plain Nên / Không nên list.
  - The Canva checklist is one 7-item list in two columns.
- **Ladder steps 3–4** renamed **Tự chế** and **Tương tác** (from Tự làm / Cùng nhau).
- **Đua ghép thẻ and Dùng AI** split into two sections, each with its own results page.
- **Round 2:** the whole team discusses; the hack name is hidden; scenarios were rewritten to differ from the reading cards.
- **No Wayground:** team A–D cards, with answers recorded and scored on the slides.
- **Question slides:** options on the left, team column on the right; only the team's chosen letter pulses.
- **Other changes:**
  - Grid view (G) and jump-by-number added.
  - The rules slide shows only general rules; each round's rules appear when the round starts.
  - Gift message moved to the end.
  - Chuyên gia: 2 min per expert including Q&A. Bài 20/11: 15 min.
  - Văn hóa đọc review: an individual hand-raise checklist, ticked when more than half the class raises a hand.
- **Earlier (10–11 Nov):**
  - No fixed roles; a rotation rule instead.
  - The unlock puzzle was removed.
  - Questions test application, not recall.
  - The Thẻ 3 spacing claim was corrected (Cepeda 2006). Thẻ 2 explains why teaching helps (Nestojko 2014).
  - Huy Dũng rejected re-planning for 90 minutes, then accepted the stretch that came from his own changes.
