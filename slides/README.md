# Học cách học · slides for 6B0

## Run it
Double-click `6B0slides.html`. It opens in your browser and works with no internet. Chrome works best.

Take the whole `slides` folder to the class laptop, not only `6B0slides.html`.

## Files
| File | What is in it | When you open it |
|---|---|---|
| `6B0slides.html` | All 57 slides in order, plus teams and scoring rules | To change any text, question, answer or layout |
| `app.js` | How the deck works: widgets, scores, edit mode, keys | Only to change how something behaves |
| `style.css` | Colours, fonts, sizes | To change the look |
| `fonts/` | Merriweather and Be Vietnam Pro, so it looks right offline | Never |
| `videos/` | Put the Dùng AI videos here | Before class |
| `map/` | Map background, 8 landmark pictures and 4 team explorers (WebP) | To swap a picture: keep the same file name |

## Two ways to edit
1. **In the browser.** Press `E` on a slide. Click text to type. Drag ✥ to move a box and ⇲ to resize it. Every change is kept in this browser at once; `Xong` or `Esc` just leaves edit mode. **Bỏ thay đổi** puts the slide back to how it was when you pressed `E`. In the grid view (`G`), slides edited this way say *đã sửa*.
   Then press **Ctrl+S** (or **Lưu vào 6B0slides.html** in the edit bar, or in `?`). The first time, Chrome asks where to save: pick `6B0slides.html` in this `slides` folder and confirm you want to replace it. After that, Ctrl+S writes straight to the same file until you close the tab. Other browsers download a new `6B0slides.html`; drag it over the old one.
2. **In `6B0slides.html`.** Open it in any text editor. Each `<section>` is one slide and each `<div>` inside it is one box. The comment above the slides explains the format.

Each box has `data-box="x y width height"` in pixels on a 1920 × 1080 page. Quiz answers are letters, for example `"answer":"B"`.

The folder is a git repo, so after each save `git diff` shows exactly which lines changed.

## What survives a reload
Everything. Each change is saved the moment you make it: scores, team answers, card counts, bell order, shields, wheel results (saved before the wheel stops), running timers (they keep counting), Văn hóa đọc ticks, revealed answers, slide edits, the slide you were on, and whether the leaderboard was open.

If the deck is open in two tabs, each tab picks up the other's changes, so one cannot wipe out the other.

Data is lost only if:
- you open the deck in a **different browser** or a **private/incognito window** (a red bar at the top warns you when the browser cannot save);
- someone **clears the browser's data**.

So make a backup file before class and after each round you care about (below).

Until you press Ctrl+S, a slide edited in the browser replaces that slide from `6B0slides.html`. If you change the same slide in `6B0slides.html` by hand, press `E` → **Về bản gốc** on it to see the file version. Once `6B0slides.html` contains your edit, the browser copy is dropped on the next reload.

## The session map (M)
The deck opens on a map of the session. Each stop is one part of the class; the four team explorers stand at the current stop, the leading team wears a crown, and the HUD at the top shows the scores.
- Click a stop, or press `→`, to open its slides as a panel over the map. `Esc` or **Về bản đồ** goes back to the map.
- After the last slide of a stop, `→` closes the panel and the teams walk to the next stop.
- **Bảng điểm** in the HUD opens the full leaderboard.
- `M` switches between the map and plain full-screen slides.
- The stops are the `STOPS` list near the top of `6B0slides.html`: `from` is the first slide of the stop, `x` and `y` place it on the map.

## Reveal order (one idea per → press)
Each box can have `data-step="n"`: it appears at the n-th press of `→`. Boxes with the same number appear together; boxes with no `data-step` are there from the start. Add `data-each` to a box with a list to show its lines one per press, starting at its `data-step`.
In the browser: press `E`, click a box, and change **Hiện ở bước** or tick **Từng dòng**. The yellow number on each box is its step. Then Ctrl+S as usual.
`←` hides the last step; at the first step it goes to the previous slide.

## Moving scores to another computer
Press `?` and click **Sao lưu ra file**. On the other computer, open the deck, press `?` and click **Khôi phục từ file**.

## Videos for Dùng AI
1. Copy the video file into `videos/`.
2. Open the case slide, press `E`, click the video box, then click **Gắn video** and pick the same file.

## Before class
Open the leaderboard (`L`) and click **Xóa điểm, đáp án và bốc thăm…** twice. It clears scores, team answers and wheel results. Your slide edits stay.

## Keys
`→` / `Space` next idea, then next slide · `←` back · `M` map · `L` leaderboard · `S` small score strip · `T` timer · `R` reveal answer · `E` edit · `G` all slides · type a number and `Enter` to jump · `F` fullscreen · `?` help
