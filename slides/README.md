# Học cách học · slides for 6B0

## Run it
Double-click `index.html`. It opens in your browser and works with no internet. Chrome works best.

Take the whole `slides` folder to the class laptop, not only `index.html`.

## Files
| File | What is in it | When you open it |
|---|---|---|
| `content.js` | Teams, scoring rules, questions and all 52 slides, in order | To change any text, question, answer or layout |
| `app.js` | How the deck works: widgets, scores, edit mode, keys | Only to change how something behaves |
| `style.css` | Colours, fonts, sizes | To change the look |
| `index.html` | Loads the three files above | Rarely |
| `fonts/` | Merriweather and Be Vietnam Pro, so it looks right offline | Never |
| `videos/` | Put the Tòa án AI videos here | Before class |

## Two ways to edit
1. **In the browser.** Press `E` on a slide. Click text to type. Drag ✥ to move a box and ⇲ to resize it. Every change saves at once; `Xong` or `Esc` just leaves edit mode. **Bỏ thay đổi** puts the slide back to how it was when you pressed `E`. The edit is saved in this browser on this computer only. In the grid view (`G`), slides edited this way say *đã sửa*.
2. **In `content.js`.** Open it in any text editor and change the text. The change goes everywhere the folder goes. Use this for anything you want to keep.

Every slide is a list of boxes. `text("…", x, y, width, height, "body")` is a text box on a 1920 × 1080 page. Quiz answers are letters, for example `answer: "B"`.

## What survives a reload
Everything. Each change is saved the moment you make it: scores, team answers, card counts, bell order, shields, Vòng 1 numbers, wheel results (saved before the wheel stops), running timers (they keep counting), Văn hóa đọc ticks, revealed answers, slide edits, the slide you were on, and whether the leaderboard was open.

If the deck is open in two tabs, each tab picks up the other's changes, so one cannot wipe out the other.

Data is lost only if:
- you open the deck in a **different browser** or a **private/incognito window** (a red bar at the top warns you when the browser cannot save);
- someone **clears the browser's data**.

So make a backup file before class and after each round you care about (below).

A slide edited in the browser replaces that slide from `content.js`. If you later change the same slide in `content.js`, press `E` → **Về bản gốc** on it to see the file version.

## Moving scores or browser edits to another computer
Press `?` and click **Sao lưu ra file**. On the other computer, open the deck, press `?` and click **Khôi phục từ file**.

## Videos for Tòa án AI
1. Copy the video file into `videos/`.
2. Open the case slide, press `E`, click the video box, then click **Gắn video** and pick the same file.

## Before class
Open the leaderboard (`L`) and click **Xóa điểm, đáp án và bốc thăm…** twice. It clears scores, team answers, round 1 numbers and wheel results. Your slide edits stay.

## Keys
`→` / `Space` next · `←` back · `L` leaderboard · `S` small score strip · `T` timer · `R` reveal answer · `E` edit · `G` all slides · type a number and `Enter` to jump · `F` fullscreen · `?` help
