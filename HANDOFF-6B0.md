# 6B0 "Học cách học": handoff for a new session

Last updated: 14 Nov 2026 (Hanoi), hack cards restructured. Author of the session: Huy Dũng (always write the name with diacritics).

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
    2. Tự đố, tự giảng
    3. Nghỉ đúng, ngủ đủ
    4. Rải đều, trộn bài
  - Card text lives in `Tai-lieu-in-6B0.docx` pages 2–5. `The-hack-ban-moi.md` is a plain-text copy for review; regenerate it from the docx after edits.
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
| B | **A4 printables** (20 pages) | `Tai-lieu-in-6B0.docx` (edit and print in Word). Older online copy: https://claude.ai/artifact/AR2vJGv2TKAzz5LM2Wgv76 | `Tai-lieu-in-6B0.docx`. `ToPrint.html` is the old HTML version. |
| C | Plan deck for cô Tươi (Slides type, 28 pages) | claude.ai artifact https://claude.ai/artifact/KFFwru2snypPApxmFKyrEx | Not a file. Edit it in the claude.ai Slides editor, or export to PDF/PPTX from there. |

The claude.ai Project "6B0 Teaching" holds the same two sources and a status doc.

### Running locally (since 11 Nov 2026)
- **Slides:** double-click `slides/6B0slides.html`. Fonts are in `slides/fonts/`, so it works offline. Scores, wheel results and in-browser edits save to the browser's `localStorage` (prefix `hch-6b0-v2-`; the old `hch-6b0-` keys are ignored). Press `?` → **Sao lưu ra file** / **Khôi phục từ file** to move them to another computer.
- **Videos:** copy files into `slides/videos/`, then edit mode → **Gắn video**.
- **Printables:** open `Tai-lieu-in-6B0.docx` in Word. Fonts used: Merriweather and Be Vietnam Pro (copies in `slides/fonts/`; install them on the printing computer, or Word substitutes).

---

## 3. Session flow (about 90 minutes, 57 slides)

| Phút | Phần | Slides |
|---|---|---|
| 0–9 | Chặng 1 · Khởi động: Clash Royale, ba câu hỏi, chiếc thang, lập đội, luật chung, tín hiệu khiên | 1–8 |
| 9–19 | Chặng 2 · Chuẩn bị: wheel gives each team one hack (1 min), everyone reads that card (4 min), team prepares the talk (5 min) | 9–12 |
| 19–38 | Chặng 3 · Giảng giỏi: rules, then per hack 1→4: team teaches the class (3 min incl. Q&A), the 3 listening teams answer that hack's question (1 min); results; wrap-up | 13–25 |
| 31–36 | Giải lao (5 min) | 22 |
| 36–42 | Chặng 4 · Đúng chỗ: đua ghép thẻ trên sàn (3 min) and results | 23–26 |
| 42–50 | Chặng 5 · Dùng AI: a wheel assigns teams to 4 video cases; each video stops and the team says what happens next and why (no A/B/C) | 27–35 |
| 50–73 | Chặng 6 · Làm Slides: why cô assigns it → helps vs hurts → Văn hóa đọc hand-raise checklist (no points) → bài 20/11 outline and task split (15 min, scored) → Canva demo | 36–41 |
| 73–85 | Chặng 7 · Chung kết: 5 questions on the whole session, easy to hard, ×2 (3 are ordering questions, 90 s each), then a wheel gives each team one hack to explain in its own words | 42–50 |
| 85–90 | Chặng 8 · Về đích: bảng xếp hạng, chọn quà, lời kết, cẩm nang, hỏi đáp | 51–54 |

**Open timing issue:**
- The school break at 11:00 falls around minute 45, during Dùng AI, while the slides have their own giải lao at minute 31.
- This has not been reconciled. Decide whether to move giải lao onto the school break or drop it.

---

## 4. Scoring (locked)

- **Ranked rounds give 4 · 3 · 2 · 2:** 3rd and 4th get the same. Ties share the higher place.
- **Correct beats fast.** Speed only breaks ties.

| Round | How | Points |
|---|---|---|
| Giảng giỏi | per question: each listening team right +2; the teaching team +1 per listening team right (it does not answer its own hack); total of 4 questions ranked | 4·3·2·2 |
| Đua ghép thẻ | correct cards (of 8); the bell order breaks ties | 4·3·2·2 |
| Dùng AI | right outcome 2 + reason 1 + accepted appeal 1 (teams answer in their own words) | up to 4 (raw) |
| Slide nhóm 20/11 | checklist points the team sheet covers | 4·3·2·2 |
| Chung kết | number of the 5 questions correct, double points | 8·6·4·4 |
| Giải thích một hack | a hack other than the one the team taught; correct explanation 1 + own example 1 | up to 2 |
| Khiên ✋ | quietest team when chú raises a hand | +1, max 3 |
| Phạt | running or pushing in the card race | −1 |

- **All questions are answered by the team** with one coloured A/B/C/D card (printables pages 14–17). **No Wayground.** The team discusses for 1 minute (90 s in Chung kết).
- **Leaderboard display modes:** full scores, ranks only, or hidden.
- **Gifts:** "Every kid gets a gift; winning only means choosing first" is said **only at the end** (bangdiem slide), never up front. Gifts: 40 items, 2 per kid, two picking rounds in rank order.

### Questions (answers spread A–D)
- **Giảng giỏi** (one per hack, in card order; quiz `data-opts.teach` links each to the `boc-hack` wheel so the teaching team is shown and skipped):** new scenarios, deliberately unlike the card examples. The hack name is not shown.
  1. Minh does maths while a friend tells a story → **B** (slower, more mistakes).
  2. 2-minute talk about rice with no notes → **C** (practise aloud, check, repeat).
  3. Nam has been stuck on a maths problem for 30 min → **D** (stand up and walk a few minutes, or switch subject, then come back). Replaced the Lan piano question on 14 Nov so each question maps to one card.
  4. Good at English listening, weak at spelling → **A** (mostly writing, with some listening mixed in).
- **Chung kết:**
  Five questions on the whole session, easy to hard. Q1, Q2 and Q4 are ordering questions: each card A–D is one ordering.
  1. Lan learns piano, put the four stages in order → **D** (④ → ② → ③ → ①: dở, tập, giỏi, thích). A and C put "thích" before "giỏi".
  2. Order four ways of learning from the lowest ladder step to the highest → **C** (③ watch a video → ① redo the worked example → ④ close the notebook and write it out → ② teach a friend).
  3. Which kids use AI to move up the ladder → **B** (An, Bình, Dũng). Chi learns a Gemini summary by heart; Dũng argues with Gemini and checks the textbook.
  4. Order the group-slide steps on Canva → **A** (② outline → ④ task table → ① each writes their part → ③ one person checks facts and spelling).
  5. Which statements are true → **C** (① texting while working is slower, ③ hard and wrong means learning). ② scrolling the phone is not a real break; ④ cramming is not as good as spacing.

### Group-slide checklist (7 points)
1. Thống nhất dàn ý trước
2. Mỗi bạn một phần, tự viết
3. Bảng phân công có tên và hạn
4. Không chép; có ghi nguồn
5. Mỗi slide một ý, chữ ít và to
6. Có người kiểm tra thông tin, chính tả
7. Cả nhóm tập nói

---

## 5. How the slides work (`slides/`)

`slides/README.md` explains running and editing. In short:
- `6B0slides.html` (was `index.html` until 14 Nov) holds everything the class sees. `TEAMS`, `ROUNDS`, `POINTS_RANKED`, `POINTS_FINAL` and `SHIELD_MAX` are in a small `<script>`. The 57 slides are `<section>` elements in `<div id="slides">`; each box is a `<div data-box="x y w h">`, and widgets add `data-widget` and `data-opts` (JSON). Quiz answers are letters (`"answer":"B"`).
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
| 6–9 | matching cards, 8 per team colour |
| 10–13 | floor signs for the 4 hacks |
| 14–17 | A/B/C/D answer cards, one page per team colour |
| 18 | team sheet: bài 20/11 outline and task split |
| 19 | take-home slips (8 per page) |
| 20 | scoring poster |

**Regenerate the PDF with Playwright:**
```js
const {chromium}=require('playwright');(async()=>{const b=await chromium.launch();const p=await b.newPage();
const h=require('fs').readFileSync('tai-lieu-in-6b0.html','utf8');
await p.setContent(`<!doctype html><html><head><meta charset=utf8></head><body>${h}</body></html>`,{waitUntil:'networkidle'});
await p.pdf({path:'Tai-lieu-in-6B0.pdf',format:'A4',printBackground:true,preferCSSPageSize:true});await b.close()})();
```
Check the PDF afterwards: it should be exactly 20 pages in Word (LibreOffice shows 21: card 4's source line spills onto its own page), with no blank ones.

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
4. Print everything (see printables page 1 for copies), and cut the matching cards and A–D cards.
5. Optional:
   - an A4 print version of the cheat sheet (page 50 is a 16:9 slide);
   - put "Mình nghĩ trước, AI hỏi sau" back as the first "Nên" item on the cheat sheet (it was removed with the subtitle);
   - number the 7 tick boxes on the cheat sheet.
6. Before class: clear all test scores, wheel results and team answers.

---

## 10. Decisions log (most recent first)

- **Team teaching replaces the experts and Viết nhanh (14 Nov):**
  - Viết nhanh (thi viết A/B) removed: it gave hack 1 a live demo the other hacks did not get, pre-empted the card-1 expert and made the hack-1 question a free point. Writing sheets removed from the printables.
  - Each team gets one hack from a wheel (`boc-hack`), reads it together and teaches it to the whole class. Reason: one randomly chosen reader no longer decides a team's score, and the whole team works at bậc 3–4 while preparing.
  - Scoring chosen over dot voting: dots reward popularity and invite tactical votes. Listeners right +2, teaching team +1 per listener right, so answering wrong on purpose always costs the saboteur more than the teaching team. Totals ranked 4·3·2·2.
  - The final "giải thích một hack" wheel never gives a team the hack it taught (`"avoid":"boc-hack"`).
  - Map stop 2 is now "Chuẩn bị" (still 8 stops). Card footer reads "Gợi ý khi cả đội giảng cho lớp (3 phút…)".
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
