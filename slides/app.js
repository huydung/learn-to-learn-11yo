/* Học cách học · 6B0 — slide engine: rendering, widgets, scores, edit mode, keys.
 *
 * Slides, teams and scoring rules are in 6B0slides.html. Styles are in style.css.
 * Everything the deck remembers is saved in this browser's localStorage under "hch-6b0-v2-".
 *
 * Sections: slide file · storage · state · scoring · rendering · widgets · leaderboard · edit mode · grid view · navigation · save · boot
 */
(() => {
"use strict";

const $ = (selector, root = document) => root.querySelector(selector);
const $$ = (selector, root = document) => [...root.querySelectorAll(selector)];
const esc = (s) => String(s).replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" })[c]);
const clone = (value) => JSON.parse(JSON.stringify(value));
const LETTERS = "ABCD";

/* ================= Slide file =================
 * Every slide is a <section> inside <div id="slides"> in 6B0slides.html. Each child is one box:
 *   <div class="lead" data-box="x y w h">text</div>                    a text box; data-size="44" = font size set with A+/A−
 *   <div data-widget="timer" data-box="x y w h" data-opts='{...}'>…</div>  an interactive block; any inner HTML becomes opts.html
 * "Lưu vào 6B0slides.html" (Ctrl+S) writes the deck back in this same format, browser edits included.
 */

// 6B0slides.html as it was before this script touched the page, with a marker where the slides go.
const fileTemplate = (() => {
  const doc = document.documentElement.cloneNode(true);
  $("#slides", doc).innerHTML = "\n@@SLIDES@@\n";
  return "<!doctype html>\n" + doc.outerHTML + "\n";
})();

const text = (html, x, y, w, h, style = "body") => ({ type: "text", style, html, x, y, w, h });

// Reveal order: data-step="2" shows the box at the 2nd press of → (no data-step = shown from the start).
// data-each on a box with a list shows its lines one press at a time, starting at data-step.
function readReveal(el, block) {
  if (Number(el.dataset.step) > 0) block.step = Number(el.dataset.step);
  if (el.hasAttribute("data-each")) block.each = true;
  return block;
}

function readBlock(el) {
  const [x, y, w, h] = el.dataset.box.split(" ").map(Number);
  if (el.dataset.widget) {
    const opts = JSON.parse(el.dataset.opts || "{}");
    if (el.innerHTML) opts.html = el.innerHTML;
    return readReveal(el, { type: "widget", kind: el.dataset.widget, x, y, w, h, opts });
  }
  const block = text(el.innerHTML, x, y, w, h, el.className);
  if (el.dataset.size) block.fontSize = Number(el.dataset.size);
  return readReveal(el, block);
}

const SLIDES = $$("#slides > section").map((sec) => ({
  id: sec.dataset.id,
  nav: sec.dataset.nav,
  tag: sec.dataset.tag,
  bg: sec.dataset.bg,
  noFooter: sec.hasAttribute("data-no-footer"),
  judgedBy: sec.dataset.judgedBy && JSON.parse(sec.dataset.judgedBy),
  blocks: [...sec.children].map(readBlock),
}));
$("#slides").remove();

const json = (value) => "'" + JSON.stringify(value).replace(/&/g, "&amp;").replace(/'/g, "&#39;") + "'";

function writeBlock(b) {
  const box = ` data-box="${b.x} ${b.y} ${b.w} ${b.h}"` + (b.step ? ` data-step="${b.step}"` : "") + (b.each ? " data-each" : "");
  if (b.type === "widget") {
    const { html = "", ...opts } = b.opts || {};
    return `  <div data-widget="${b.kind}"${box}${Object.keys(opts).length ? " data-opts=" + json(opts) : ""}>${html}</div>`;
  }
  return `  <div class="${esc(b.style || "")}"${box}${b.fontSize ? ` data-size="${b.fontSize}"` : ""}>${b.html}</div>`;
}

function writeSlide(s) {
  const attrs = [`data-id="${esc(s.id)}"`];
  for (const k of ["nav", "tag", "bg"]) if (s[k]) attrs.push(`data-${k}="${esc(s[k])}"`);
  if (s.noFooter) attrs.push("data-no-footer");
  if (s.judgedBy) attrs.push("data-judged-by=" + json(s.judgedBy));
  return `<section ${attrs.join(" ")}>\n${s.blocks.map(writeBlock).join("\n")}\n</section>`;
}

/* ================= Storage ================= */

// Every change is written at once, so a reload or a closed tab loses nothing.
const STORE_PREFIX = "hch-6b0-v2-";  // v2 since 14 Nov: the deck was renamed and old browser edits no longer apply
const store = {
  failed: false,
  get(key, fallback) {
    try { const v = localStorage.getItem(STORE_PREFIX + key); return v ? JSON.parse(v) : fallback; }
    catch { return fallback; }
  },
  set(key, value) {
    try {
      localStorage.setItem(STORE_PREFIX + key, JSON.stringify(value));
      if (store.failed) { store.failed = false; warn(""); }
    } catch {
      store.failed = true;
      warn("Không lưu được vào trình duyệt. Thay đổi mới sẽ mất khi tải lại trang. Bấm ? → Sao lưu ra file ngay.");
    }
  },
};

// A red bar at the top that stays until the problem is gone.
function warn(message) {
  const bar = $("#warn");
  bar.textContent = message;
  bar.hidden = !message;
}

/* ================= State ================= */

const byTeam = (fn) => Object.fromEntries(TEAMS.map((t) => [t.key, fn(t.key)]));
const teamName = (key) => TEAMS.find((t) => t.key === key).name;
const roundById = (id) => ROUNDS.find((r) => r.id === id);

const emptyBoard = () => ({
  scores: {},                 // { roundId: { R: points } } — what counts toward the totals
  shields: byTeam(() => 0),   // khiên ✋, capped at SHIELD_MAX
  adjustments: [],            // [{ team, delta }] manual +1 / −1, undoable
  display: "full",            // leaderboard shows "full" scores, "rank" only, or "none"
  log: [],                    // [{ at, msg }] last 30 actions
  answers: {},                // { quizSlideId: { R: optionIndex } } — the card each team raised
  raw: {},                    // { roundId: { R: count } } — counts typed on result slides
  bell: {},                   // { roundId: { R: 1..4 } } — bell order in the card race
});
const emptyThiviet = () => byTeam(() => ({ A: "", B: "" }));

// Class state during the session. Cleared by "Xóa điểm, đáp án và bốc thăm…".
const emptySession = () => ({
  timers: {},    // { blockKey: { total, left, endsAt } } — endsAt is set while running, so it survives a reload
  steps: {},     // checkstep progress { blockKey: { shown, ok: { index: true } } }
  revealed: {},  // { blockKey or quizSlideId: true } — answer shown
  reveal: {},    // { slideId: n } — how many → presses of data-step boxes are shown on that slide
});

let board, thiviet, wheels, edits, session;
function loadState({ withEdits = true } = {}) {
  board = { ...emptyBoard(), ...store.get("board", {}) };
  thiviet = { ...emptyThiviet(), ...store.get("thiviet", {}) };
  wheels = store.get("wheels", {});      // { slideId: [itemIndex, ...] } one pick per slot, in order
  session = { ...emptySession(), ...store.get("session", {}) };
  if (withEdits) edits = store.get("edits", {});  // { slideId: { blocks, savedAt } } — replaces that slide's blocks
}
loadState();

const saveBoard = () => store.set("board", board);
const saveThiviet = () => store.set("thiviet", thiviet);
const saveWheels = () => store.set("wheels", wheels);
const saveEdits = () => store.set("edits", edits);
const saveSession = () => store.set("session", session);

// Where you are in the deck. Restored when you open 6B0slides.html again without a #page in the address.
const view = { current: 0, boardOpen: false, showStrip: false, mapMode: true, slideOpen: false, ...store.get("view", {}) };
const saveView = () => store.set("view", { current, boardOpen, showStrip, mapMode, slideOpen });

let current = view.current;
let boardOpen = view.boardOpen, showStrip = view.showStrip, spinning = false;
let mapMode = view.mapMode, slideOpen = view.slideOpen;  // map mode: slides open as a panel over the session map
let editing = false, draft = null, selected = null, editStart = null;  // draft = blocks of the slide being edited
let keyActions = {};  // { T: fn, R: fn } registered by widgets on the current slide

const slides = () => SLIDES.map((s) => (edits[s.id] ? { ...s, blocks: edits[s.id].blocks } : s));

function logAction(msg) {
  board.log = board.log.slice(-29);
  board.log.push({ msg, at: new Date().toLocaleTimeString("vi-VN", { hour: "2-digit", minute: "2-digit" }) });
}

/* ================= Scoring ================= */

// Place of each team, 0 = first. A team's place is how many teams beat it, so ties share the higher place.
function places(beats) {
  return byTeam((k) => TEAMS.filter((o) => o.key !== k && beats(o.key, k)).length);
}
const byValue = (values) => (a, b) => values[a] > values[b];
const rankPoints = (values, points) => {
  const place = places(byValue(values));
  return byTeam((k) => points[place[k]]);
};

function totals() {
  const sum = byTeam(() => 0);
  for (const round of ROUNDS) {
    for (const t of TEAMS) {
      const v = Number(board.scores[round.id]?.[t.key]);
      if (Number.isFinite(v)) sum[t.key] += v;
    }
  }
  for (const t of TEAMS) sum[t.key] += Math.min(SHIELD_MAX, board.shields[t.key] || 0);
  for (const a of board.adjustments) sum[a.team] += a.delta;
  return sum;
}

function recordRound(roundId, points, message) {
  board.scores[roundId] = points;
  logAction(message);
  saveBoard();
  flash("Đã ghi điểm");
  render();
}

// Index of the right option on a quiz slide, or null.
function answerOf(slideId) {
  const quiz = slides().find((s) => s.id === slideId)?.blocks.find((b) => b.kind === "quiz");
  return quiz ? LETTERS.indexOf(quiz.opts.answer) : null;
}

/* ================= Rendering ================= */

const stage = $("#stage");

// In map mode the slide is a panel below the HUD: 85% size, pushed 50 map-pixels down.
const PANEL = 0.85, PANEL_DY = 50;
function fitStage() {
  const fit = Math.min(innerWidth / 1920, innerHeight / 1080);
  const scale = mapMode ? fit * PANEL : fit;
  stage.style.transform = `translate(-50%, calc(-50% + ${mapMode ? PANEL_DY * fit : 0}px)) scale(${scale})`;
  stage.dataset.scale = scale;
  for (const layer of [$("#map .mp"), $("#hud .hi")]) if (layer) layer.style.transform = `translate(-50%,-50%) scale(${fit})`;
}


/* Reveal steps: each → press shows the next group of boxes (or the next line of a data-each box). */
const lineCount = (b) => (b.each && b.type === "text" ? (b.html.match(/<li[\s>]/g) || []).length : 0);
const lastStep = (b) => (b.step || 0) + Math.max(0, lineCount(b) - 1);
const maxStep = (slide) => Math.max(0, ...slide.blocks.map(lastStep));
// A slide you have not stepped through yet (after a reload or a jump by #id) shows everything.
const revealOf = (slide) => Math.min(session.reveal[slide.id] ?? Infinity, maxStep(slide));

// Hides what is not revealed yet and animates what the last → press showed.
function applyReveal(blk, inner, block, shown, anim) {
  const s = block.step || 0;
  if (s > shown) return blk.classList.add("rv-hide");
  if (lineCount(block)) {
    $$("li", inner).forEach((li, k) => {
      if (s + k > shown) li.classList.add("rv-hide");
      else if (s + k === anim) li.classList.add("rv-in");
    });
    if (s === anim && s > 0 && !$("li", inner)) blk.classList.add("rv-in");
  } else if (s === anim) blk.classList.add("rv-in");
}

// Builds one slide as a detached element. Used for the live stage and for grid thumbnails.
// shown = how many reveal steps are visible (Infinity = all); anim = the step to animate in.
function buildSlide(index, onKey, shown = Infinity, anim = null) {
  const list = slides();
  const slide = list[index];
  const blocks = editing && index === current ? draft : slide.blocks;

  const el = document.createElement("div");
  el.className = `sl bg-${slide.bg || "paper"}${editing ? " edit" : ""}`;
  el.innerHTML = `<div class="frame"></div>`
    // The map HUD says where we are in the session, so the footer is only the page number.
    + (slide.noFooter ? "" : `<div class="foot">${index + 1} / ${list.length}</div>`)
    + `<img class="logo" src="images/hdi.webp" alt="HDI">`;

  blocks.forEach((block, i) => {
    const blk = document.createElement("div");
    blk.className = "blk";
    blk.dataset.i = i;
    blk.style.cssText = `left:${block.x}px;top:${block.y}px;width:${block.w}px;height:${block.h}px`;
    if (editing && i === selected) blk.classList.add("sel");

    const inner = document.createElement("div");
    inner.className = "in " + (block.style || "");
    if (block.fontSize) inner.style.fontSize = block.fontSize + "px";
    if (block.type === "text") {
      inner.innerHTML = block.html;
      if (editing) inner.contentEditable = "true";
    } else {
      WIDGETS[block.kind](inner, block.opts || {}, { key: `${slide.id}-${i}`, slideId: slide.id, onKey });
    }
    blk.append(inner);
    if (!editing) applyReveal(blk, inner, block, shown, anim);
    if (editing) blk.insertAdjacentHTML("beforeend", `<div class="hd mv" title="Kéo để di chuyển">✥</div><div class="hd rs" title="Kéo để đổi cỡ">⇲</div>`
      + `<div class="stepb" title="Hiện ở lần bấm → thứ mấy">${block.step || 0}${block.each ? " · từng dòng" : ""}</div>`);
    el.append(blk);
  });
  return el;
}

function render(anim = null) {
  const list = slides();
  current = Math.max(0, Math.min(current, list.length - 1));
  keyActions = {};
  const shown = editing ? Infinity : revealOf(list[current]);
  const el = buildSlide(current, (key, fn) => { keyActions[key] ??= fn; }, shown, anim);  // first widget on the slide wins
  if (showStrip) el.append(scoreStrip());
  if (boardOpen) el.append(leaderboard());
  stage.replaceChildren(el);
  $("#nNum").textContent = `${current + 1}/${list.length}`;
  try { history.replaceState(null, "", "#" + list[current].id); } catch {}
  saveView();
  renderEditBar();
  updateMap();
}

function scoreStrip() {
  const t = totals();
  const el = document.createElement("div");
  el.className = "strip";
  el.innerHTML = TEAMS.map((tm) => `<span class="c-${tm.key}">${tm.name}${board.display === "full" ? " · " + t[tm.key] : ""}</span>`).join("");
  return el;
}

const teamChip = (t) => `<span class="chip mini c-${t.key}">${t.name}</span>`;

// Team score cards, shared by the standings slide and the leaderboard overlay.
function teamCards(teams, withActions) {
  const t = totals();
  const place = places(byValue(t));
  const max = Math.max(1, ...Object.values(t));
  return `<div class="teams show-${board.display}">${teams.map((tm) => `
    <div class="tm c-${tm.key}">
      <div class="rk">#${place[tm.key] + 1}</div><div class="nm">${tm.name}</div><div class="tot">${t[tm.key]}</div>
      <div class="bar"><i style="width:${Math.round((100 * t[tm.key]) / max)}%"></i></div>
      ${withActions ? `<div class="act">
        <button data-a="shield" data-k="${tm.key}" title="Điểm khiên, tối đa ${SHIELD_MAX}">✋ +1 (${Math.min(SHIELD_MAX, board.shields[tm.key] || 0)}/${SHIELD_MAX})</button>
        <button data-a="minus" data-k="${tm.key}">−1 phạt</button>
        <button data-a="plus" data-k="${tm.key}">+1</button></div>` : ""}
    </div>`).join("")}</div>`;
}

/* ================= Widgets =================
 * Each widget fills `el` from its opts. ctx = { key, slideId, onKey }.
 * Widgets change state, save it, then call render(); they never patch the DOM by hand.
 */

// A running timer stores the clock time it ends, so it keeps counting through slide changes and reloads.
const secondsLeft = (t) => (t.endsAt ? Math.max(0, Math.ceil((t.endsAt - Date.now()) / 1000)) : t.left);

function drawTimer(box, t) {
  const left = secondsLeft(t);
  box.querySelector(".tv").textContent = `${Math.floor(left / 60)}:${String(left % 60).padStart(2, "0")}`;
  const go = box.querySelector('[data-a="go"]');  // compact timers have no buttons
  if (go) go.textContent = t.endsAt ? "Tạm dừng" : "Bắt đầu";
  box.classList.toggle("long", left >= 600);
  box.classList.toggle("run", !!t.endsAt);
  box.classList.toggle("done", left <= 0);
}

setInterval(() => {
  for (const [key, t] of Object.entries(session.timers)) {
    if (!t.endsAt) continue;
    if (secondsLeft(t) === 0) { t.left = 0; t.endsAt = null; saveSession(); }
    const box = stage.querySelector(`.timer[data-key="${CSS.escape(key)}"]`);
    if (box) drawTimer(box, t);
  }
}, 250);

const WIDGETS = {
  html(el, o) {
    el.innerHTML = o.html || "";
  },

  teams(el) {
    el.innerHTML = `<div class="chips">${TEAMS.map((t, i) => `<div class="chip c-${t.key}">Đội ${t.name}<small>Đội ${i + 1}</small></div>`).join("")}</div>`;
  },

  timer(el, o, ctx) {
    const seconds = o.seconds || 60;
    const t = (session.timers[ctx.key] ??= { total: seconds, left: seconds, endsAt: null });
    if (t.total !== seconds) Object.assign(t, { total: seconds, left: seconds, endsAt: null });  // length was edited
    // compact: digits only, for corners of busy slides. Click starts/pauses, double-click resets.
    el.innerHTML = o.compact
      ? `<div class="timer mini" role="timer" data-key="${esc(ctx.key)}" title="Bấm: chạy / dừng · bấm đúp: đặt lại"><div class="tv"></div></div>`
      : `<div class="timer" role="timer" data-key="${esc(ctx.key)}"><div class="tv"></div>
      <div class="tb"><button data-a="go"></button><button data-a="reset">Đặt lại</button>
      <div class="nudge"><button data-a="minus">−30s</button><button data-a="plus">+30s</button></div></div></div>`;
    const box = el.firstElementChild;
    box.ondblclick = () => { if (!editing && o.compact) { t.endsAt = null; t.left = t.total; update(); } };
    const update = () => { saveSession(); drawTimer(box, t); };
    const toggle = () => {
      if (t.endsAt) { t.left = secondsLeft(t); t.endsAt = null; }  // pause
      else { if (t.left === 0) t.left = t.total; t.endsAt = Date.now() + t.left * 1000; }  // start
      update();
    };
    box.onclick = (e) => {
      if (editing) return;
      const a = e.target.dataset.a;
      if (a === "minus" || a === "plus") {
        const delta = a === "plus" ? 30 : -30;
        if (t.endsAt) t.endsAt = Math.max(Date.now(), t.endsAt + delta * 1000);
        else t.left = Math.max(0, t.left + delta);
      } else if (a === "reset") { t.endsAt = null; t.left = t.total; }
      else return toggle();  // click anywhere else on the timer
      update();
    };
    ctx.onKey("T", toggle);
    drawTimer(box, t);
  },

  reveal(el, o, ctx) {
    el.innerHTML = `<div class="reveal${session.revealed[ctx.key] ? " open" : ""}"><div class="lab">${o.label || "Bấm để mở"}</div><div class="ans">${o.html || ""}</div></div>`;
    const toggle = () => { session.revealed[ctx.key] = !session.revealed[ctx.key]; saveSession(); render(); };
    el.firstElementChild.onclick = () => { if (!editing) toggle(); };
    ctx.onKey("R", toggle);
  },

  video(el, o) {
    el.innerHTML = o.src
      ? `<div class="vid"><video src="${esc(o.src)}" controls preload="metadata"></video></div>`
      : `<div class="vid"><div class="vl">${esc(o.label || "Video")}</div>
         <div class="vs">Chưa gắn video. Kể phần 1 bằng lời, hoặc gắn video:<br>chép file vào thư mục <b>videos</b>, bật chế độ Sửa (E), chọn ô này, bấm “Gắn video”.</div></div>`;
    // pauseAt: stop once at the vote card between part 1 and part 2; Play continues.
    const v = el.querySelector("video");
    if (v && o.pauseAt) {
      let last = 0;
      v.ontimeupdate = () => { if (last < o.pauseAt && v.currentTime >= o.pauseAt) v.pause(); last = v.currentTime; };
    }
  },

  thiviet(el) {
    const num = (v) => { const n = parseInt(v, 10); return Number.isFinite(n) ? n : null; };
    const total = (k) => (num(thiviet[k].A) ?? 0) + (num(thiviet[k].B) ?? 0);
    const cell = (t, way) => `<td><input inputmode="numeric" aria-label="Cách ${way} đội ${t.name}" data-k="${t.key}" data-way="${way}" value="${esc(thiviet[t.key][way])}"></td>`;
    el.innerHTML = `<div class="tv-w"><div>
      <table class="t"><tr><th>Đội</th><th>Cách A</th><th>Cách B</th><th>Tổng</th></tr>
      ${TEAMS.map((t) => `<tr><td>${teamChip(t)}</td>${cell(t, "A")}${cell(t, "B")}<td class="sum" data-k="${t.key}"></td></tr>`).join("")}</table>
      <div class="actions"><button class="btn" data-a="score">Ghi điểm thi viết theo tổng</button></div></div>
      <div class="avg"><div>Trung bình cách A<b data-avg="A">–</b></div><div>Trung bình cách B<b data-avg="B">–</b></div></div></div>`;

    const average = (way) => {
      const vals = TEAMS.map((t) => num(thiviet[t.key][way])).filter((v) => v !== null);
      return vals.length ? (vals.reduce((a, b) => a + b, 0) / vals.length).toFixed(1).replace(".", ",") : "–";
    };
    const update = () => {
      for (const t of TEAMS) $(`.sum[data-k="${t.key}"]`, el).textContent = total(t.key);
      for (const way of "AB") $(`[data-avg="${way}"]`, el).textContent = average(way);
    };
    $$("input", el).forEach((input) => input.addEventListener("input", () => {
      thiviet[input.dataset.k][input.dataset.way] = input.value.replace(/[^0-9]/g, "");
      saveThiviet();  // every keystroke, so a reload never drops a number
      update();
    }));
    $('[data-a="score"]', el).onclick = () => {
      if (editing) return;
      saveThiviet();
      recordRound("thiviet", rankPoints(byTeam(total), roundById("thiviet").points), "Thi viết: ghi điểm theo tổng số dòng");
    };
    update();
  },

  wheel(el, o, ctx) {
    const picks = wheels[ctx.slideId] || [];
    const left = o.items.map((_, i) => i).filter((i) => !picks.includes(i));
    const done = left.length === 0 || picks.length >= o.slots.length;
    el.innerHTML = `<div class="wh">
      <div class="wh-l"><div class="wh-pin"></div><canvas width="700" height="700" aria-label="Vòng quay bốc thăm"></canvas></div>
      <div class="wh-r">${o.slots.map((slot, k) => `<div class="wh-row${picks[k] !== undefined ? " on" : ""}"><span>${esc(slot)}</span><b>${picks[k] !== undefined ? esc(o.items[picks[k]]) : "?"}</b></div>`).join("")}
        <div class="row"><button class="btn" data-a="spin"${done ? " disabled" : ""}>${done ? "Đã bốc xong" : "Quay cho " + esc(o.slots[picks.length])}</button>
        <button class="btn ghost" data-a="restart">Quay lại từ đầu</button></div></div></div>`;

    const canvas = $("canvas", el);
    drawWheel(canvas, o, left);
    $('[data-a="restart"]', el).onclick = () => {
      if (editing || spinning) return;
      wheels[ctx.slideId] = [];
      saveWheels();
      render();
    };
    $('[data-a="spin"]', el).onclick = () => {
      if (editing || spinning || done) return;
      const segment = (2 * Math.PI) / left.length;
      const j = Math.floor(Math.random() * left.length);
      // Save the result before the animation, so a reload mid-spin keeps it.
      wheels[ctx.slideId] = picks.concat(left[j]);
      saveWheels();
      spinning = true;
      const jitter = (Math.random() - 0.5) * segment * 0.6;
      canvas.style.transition = "transform 4s cubic-bezier(.15,.7,.2,1)";
      canvas.style.transform = `rotate(${6 * 2 * Math.PI - (j + 0.5) * segment + jitter}rad)`;
      setTimeout(() => { spinning = false; render(); }, 4200);
    };
  },

  quiz(el, o, ctx) {
    const qid = ctx.slideId;
    const correct = LETTERS.indexOf(o.answer);
    const picks = board.answers[qid] || {};
    const options = o.options || [];
    el.innerHTML = `<div class="quiz${session.revealed[qid] ? " open" : ""}">
      ${o.question ? `<div class="qq">${o.question}</div>` : ""}
      <div class="qb">
        <div class="qo">${options.map((txt, i) => `<div class="op${i === correct ? " ok" : ""}"><b>${LETTERS[i]}</b><span>${txt}</span></div>`).join("")}</div>
        <div class="qt">${TEAMS.map((t) => {
          const pick = picks[t.key];
          const mark = pick === undefined ? "–" : pick === correct ? "✓" : "✗";
          const buttons = options.map((_, i) => `<button data-k="${t.key}" data-v="${i}" class="${pick === i ? "on " + (i === correct ? "ok" : "bad") : ""}" aria-label="Đội ${t.name} chọn ${LETTERS[i]}">${LETTERS[i]}</button>`).join("");
          return `<div class="qtm c-${t.key}${pick !== undefined ? " picked" : ""}"><span class="qn">${t.name}</span>${buttons}<em>${mark}</em></div>`;
        }).join("")}
          <button class="btn ghost qr">Hiện đáp án (R)</button></div>
      </div></div>`;
    if (editing) $$(".qq, .op span", el).forEach((x) => (x.contentEditable = "true"));

    const toggle = () => { session.revealed[qid] = !session.revealed[qid]; saveSession(); render(); };
    ctx.onKey("R", toggle);
    el.onclick = (e) => {
      const button = e.target.closest("button");
      if (editing || !button) return;
      if (button.classList.contains("qr")) return toggle();
      const team = button.dataset.k, choice = Number(button.dataset.v);
      const teamPicks = (board.answers[qid] ??= {});
      if (teamPicks[team] === choice) delete teamPicks[team];  // click again to undo
      else teamPicks[team] = choice;
      saveBoard();
      render();
    };
  },

  // Results of a quiz round: which teams got which question right.
  tally(el, o) {
    const round = roundById(o.round);
    const isRight = (q, k) => board.answers[q]?.[k] !== undefined && board.answers[q][k] === answerOf(q);
    const correctCount = byTeam((k) => o.questions.filter((q) => isRight(q, k)).length);
    const points = rankPoints(correctCount, round.points);
    const recorded = board.scores[o.round] || {};
    el.innerHTML = `<table class="t tally">
      <tr><th>Đội</th>${o.questions.map((_, i) => `<th>Câu ${i + 1}</th>`).join("")}<th>Số câu đúng</th><th>Điểm vòng</th></tr>
      ${TEAMS.map((t) => `<tr><td>${teamChip(t)}</td>
        ${o.questions.map((q) => {
          const pick = board.answers[q]?.[t.key];
          return `<td>${pick === undefined ? "–" : (isRight(q, t.key) ? "✓" : "✗") + ` <small>${LETTERS[pick]}</small>`}</td>`;
        }).join("")}
        <td><b>${correctCount[t.key]}</b></td>
        <td><b>${points[t.key]}</b>${recorded[t.key] !== undefined ? ` <small>(đã ghi ${recorded[t.key]})</small>` : ""}</td></tr>`).join("")}
      </table>
      <div class="actions"><button class="btn" data-a="record">Ghi điểm vào bảng</button>
      <span class="small">Bằng số câu đúng thì cùng hạng cao hơn. Đáp án các đội chọn ở từng trang câu hỏi.</span></div>`;
    $('[data-a="record"]', el).onclick = () => { if (!editing) recordRound(o.round, points, round.name + " ghi điểm theo số câu đúng"); };
  },

  // Results typed by hand: a count per team (card race) or points per team (Tòa án).
  roundres(el, o) {
    const round = roundById(o.round);
    const ranked = round.kind === "rank";
    const raw = board.raw[o.round] || {};
    const bell = board.bell[o.round] || {};
    const value = (k) => Number(raw[k] || 0);
    const beats = (a, b) => value(a) > value(b) || (ranked && value(a) === value(b) && bell[a] && bell[b] && bell[a] < bell[b]);
    const place = places(beats);
    const points = byTeam((k) => (ranked ? round.points[place[k]] : Math.min(round.max, value(k))));
    const recorded = board.scores[o.round] || {};
    el.innerHTML = `<table class="t tally">
      <tr><th>Đội</th><th>${esc(o.label)}</th>${ranked ? "<th>Rung chuông</th>" : ""}<th>Hạng</th><th>Điểm vòng</th></tr>
      ${TEAMS.map((t) => `<tr><td>${teamChip(t)}</td>
        <td><span class="stepper"><button data-a="minus" data-k="${t.key}" aria-label="Bớt">−</button><b>${value(t.key)}</b><button data-a="plus" data-k="${t.key}" aria-label="Thêm">+</button></span></td>
        ${ranked ? `<td><select data-k="${t.key}" aria-label="Thứ tự rung chuông đội ${t.name}"><option value="">–</option>${[1, 2, 3, 4].map((n) => `<option ${bell[t.key] == n ? "selected" : ""}>${n}</option>`).join("")}</select></td>` : ""}
        <td><b>#${place[t.key] + 1}</b></td>
        <td><b>${points[t.key]}</b>${recorded[t.key] !== undefined ? ` <small>(đã ghi ${recorded[t.key]})</small>` : ""}</td></tr>`).join("")}
      </table>
      <div class="actions"><button class="btn" data-a="record">Ghi điểm vào bảng</button>
      <span class="small">${ranked ? `Xếp theo số thẻ đúng; bằng nhau thì đội rung chuông trước xếp trên. Điểm ${round.points.join(" · ")}.` : `Mỗi đội được đúng số điểm của mình, tối đa ${round.max}.`}</span></div>`;

    el.onclick = (e) => {
      const button = e.target.closest("button");
      if (editing || !button) return;
      if (button.dataset.a === "record") return recordRound(o.round, points, round.name + " ghi điểm");
      const counts = (board.raw[o.round] ??= {});
      const k = button.dataset.k;
      counts[k] = Math.max(0, Math.min(o.max ?? 99, (counts[k] || 0) + (button.dataset.a === "plus" ? 1 : -1)));
      saveBoard();
      render();
    };
    el.onchange = (e) => {
      const order = (board.bell[o.round] ??= {});
      if (e.target.value) order[e.target.dataset.k] = Number(e.target.value);
      else delete order[e.target.dataset.k];
      saveBoard();
      render();
    };
  },

  // Văn hóa đọc: show one point at a time (R), click a point to tick it.
  checkstep(el, o, ctx) {
    const items = o.items || [];
    const st = (session.steps[ctx.key] ??= { shown: 0, ok: {} });
    const ticked = Object.values(st.ok).filter(Boolean).length;
    el.innerHTML = `<div class="cs-w">
      <ol class="cs-l">${items.slice(0, st.shown).map((txt, i) => `<li class="${st.ok[i] ? "ok" : ""}" data-i="${i}"><span class="bx">${st.ok[i] ? "✓" : ""}</span><span>${txt}</span></li>`).join("")}</ol>
      <div class="cs-b"><button class="btn"${st.shown >= items.length ? " disabled" : ""}>Điểm tiếp theo (R)</button>
      <span>Đã đọc ${st.shown}/${items.length} · quá nửa lớp làm được: ${ticked}</span></div></div>`;
    const next = () => { if (st.shown < items.length) { st.shown++; saveSession(); render(); } };
    ctx.onKey("R", next);
    el.onclick = (e) => {
      if (editing) return;
      if (e.target.closest(".btn")) return next();
      const li = e.target.closest("li");
      if (li) { st.ok[li.dataset.i] = !st.ok[li.dataset.i]; saveSession(); render(); }
    };
  },

  standings(el) {
    const t = totals();
    el.innerHTML = teamCards([...TEAMS].sort((a, b) => t[b.key] - t[a.key]), false);
  },
};

function drawWheel(canvas, o, left) {
  const g = canvas.getContext("2d");
  const radius = 340;
  const segment = (2 * Math.PI) / Math.max(1, left.length);
  const isLight = (hex) => {
    const n = parseInt(hex.slice(1), 16);
    return 0.299 * (n >> 16) + 0.587 * ((n >> 8) & 255) + 0.114 * (n & 255) > 160;
  };
  g.translate(350, 350);
  if (!left.length) { g.fillStyle = "#EEE"; g.beginPath(); g.arc(0, 0, radius, 0, 2 * Math.PI); g.fill(); }
  left.forEach((item, j) => {
    const start = -Math.PI / 2 + j * segment;
    const color = o.colors?.[item] || "#8E011F";
    g.fillStyle = color;
    g.beginPath(); g.moveTo(0, 0); g.arc(0, 0, radius, start, start + segment); g.closePath(); g.fill();
    g.strokeStyle = "#fff"; g.lineWidth = 6; g.stroke();
    g.save();
    g.rotate(start + segment / 2);
    g.fillStyle = isLight(color) ? "#2B2100" : "#fff";
    g.textAlign = "right"; g.textBaseline = "middle";
    let size = 36;
    do { g.font = `800 ${size}px 'Be Vietnam Pro', Arial, sans-serif`; size -= 2; }
    while (g.measureText(o.items[item]).width > 260 && size > 18);
    g.fillText(o.items[item], radius - 26, 0);
    g.restore();
  });
  g.fillStyle = "#fff"; g.beginPath(); g.arc(0, 0, 46, 0, 2 * Math.PI); g.fill();
}

/* ================= Leaderboard overlay (L) ================= */

function leaderboard() {
  const el = document.createElement("div");
  el.id = "board";
  // Rank rounds store points, so "Hạng 3" and "Hạng 4" share a value; the select shows the first match.
  const options = (round) => `<option value="">—</option>` + (round.kind === "rank"
    ? round.points.map((p, i) => `<option value="${p}">Hạng ${i + 1} · ${p}đ</option>`).join("")
    : Array.from({ length: round.max + 1 }, (_, i) => `<option value="${i}">${i} điểm</option>`).join(""));
  const segButton = (value, label) => `<button data-display="${value}" class="${board.display === value ? "on" : ""}">${label}</button>`;

  el.innerHTML = `<div class="bd-top"><h2>Bảng điểm</h2>
      <div class="seg" role="group" aria-label="Hiển thị">${segButton("full", "Hiện điểm")}${segButton("rank", "Chỉ thứ hạng")}${segButton("none", "Che hết")}</div>
      <button class="btn ghost" data-a="close">Đóng (L)</button></div>
    ${teamCards(TEAMS, true)}
    <table class="grid"><tr><th>Vòng</th>${TEAMS.map((t) => `<th>${t.name}</th>`).join("")}</tr>
      ${ROUNDS.map((r) => `<tr><td>${r.name}<span class="rule">${r.rule}</span></td>${TEAMS.map((t) => `<td><select data-r="${r.id}" data-k="${t.key}" aria-label="${r.name} đội ${t.name}">${options(r)}</select></td>`).join("")}</tr>`).join("")}
    </table>
    <div class="bd-bottom">
      <div class="log">${board.log.slice().reverse().map((l) => `${l.at} · ${esc(l.msg)}`).join("<br>") || "Chưa có thay đổi."}</div>
      <div class="row"><button class="btn ghost" data-a="undo">Hoàn tác điểm cộng/trừ cuối</button><button class="btn ghost" data-a="wipe">Xóa điểm, đáp án và bốc thăm…</button></div>
    </div>`;

  $$("select", el).forEach((sel) => { sel.value = String(board.scores[sel.dataset.r]?.[sel.dataset.k] ?? ""); });

  el.onchange = (e) => {
    const { r, k } = e.target.dataset;
    const scores = (board.scores[r] ??= {});
    if (e.target.value === "") delete scores[k];
    else scores[k] = Number(e.target.value);
    logAction(`${roundById(r).name}: ${teamName(k)} ${e.target.value === "" ? "xóa" : e.target.value + "đ"}`);
    saveBoard();
    render();
  };

  el.onclick = (e) => {
    const button = e.target.closest("button");
    if (!button) return;
    const { a, k, display } = button.dataset;
    if (display) board.display = display;
    else if (a === "close") { boardOpen = false; return render(); }
    else if (a === "shield") {
      if ((board.shields[k] || 0) >= SHIELD_MAX) return flash(`Đội này đã đủ ${SHIELD_MAX} điểm khiên`);
      board.shields[k] = (board.shields[k] || 0) + 1;
      logAction(`Khiên +1: ${teamName(k)}`);
    } else if (a === "minus" || a === "plus") {
      const delta = a === "plus" ? 1 : -1;
      board.adjustments.push({ team: k, delta });
      logAction(`${delta > 0 ? "+1" : "−1"}: ${teamName(k)}`);
    } else if (a === "undo") {
      const last = board.adjustments.pop();
      if (!last) return flash("Không có gì để hoàn tác");
      logAction(`Hoàn tác ${last.delta > 0 ? "+1" : "−1"} của ${teamName(last.team)}`);
    } else if (a === "wipe") {
      if (button.dataset.sure !== "1") {  // ask twice
        button.dataset.sure = "1";
        button.textContent = "Bấm lần nữa để xóa hết";
        setTimeout(() => { button.dataset.sure = ""; button.textContent = "Xóa điểm, đáp án và bốc thăm…"; }, 4000);
        return;
      }
      wipeClassData();
      return;
    }
    saveBoard();
    render();
  };
  return el;
}

// Before class: clears scores, team answers, round 1 inputs and wheel results. Slide edits stay.
function wipeClassData() {
  board = emptyBoard();
  thiviet = emptyThiviet();
  wheels = {};
  session = emptySession();
  logAction("Xóa toàn bộ điểm, đáp án và bốc thăm");
  saveBoard(); saveThiviet(); saveWheels(); saveSession();
  render();
}

/* ================= Edit mode (E) =================
 * Every change is saved at once: typing, moving, resizing and each toolbar button.
 * "Bỏ thay đổi" puts the slide back to how it was when you pressed E.
 */

const currentSlide = () => slides()[current];
const sameBlocks = (a, b) => JSON.stringify(a) === JSON.stringify(b);

function startEdit() {
  if (!$("#ov").hidden) closeGrid();
  editing = true;
  selected = null;
  draft = clone(currentSlide().blocks);
  editStart = clone(draft);
  render();
}

// Copies typed text from the page back into the draft.
function syncDraft() {
  if (!draft) return;
  $$(".blk", stage).forEach((blk) => {
    const block = draft[blk.dataset.i];
    if (block?.type === "text") block.html = $(".in", blk).innerHTML;
    if (block?.kind === "quiz") {
      const q = $(".qq", blk);
      if (q) block.opts.question = q.innerHTML;
      block.opts.options = $$(".op span", blk).map((x) => x.innerHTML);
    }
  });
}

// Writes the draft to storage if it changed. Returns true when something was saved.
function saveDraft() {
  if (!draft) return false;
  const id = currentSlide().id;
  if (sameBlocks(draft, currentSlide().blocks)) return false;
  if (sameBlocks(draft, SLIDES[current].blocks)) delete edits[id];
  else edits[id] = { blocks: clone(draft), savedAt: new Date().toISOString() };
  saveEdits();
  return true;
}

function stopEdit() {
  syncDraft();
  saveDraft();
  editing = false;
  draft = editStart = null;
  selected = null;
  render();
}

function renderEditBar() {
  const bar = $("#bar");
  bar.hidden = !editing;
  if (!editing) return;
  const block = selected !== null ? draft[selected] : null;
  const styles = ["h1", "h2", "big", "lead", "body", "small", "note", "card"];
  bar.innerHTML = `<span>Đang sửa trang ${current + 1} · tự lưu</span>
    <button data-a="cancel">Bỏ thay đổi</button>
    <button data-a="add">+ Ô chữ</button>
    ${block ? `<button data-a="delete">Xóa ô</button>` : ""}
    ${block?.type === "text" ? `<select data-a="style" aria-label="Kiểu chữ">${styles.map((c) => `<option ${block.style === c ? "selected" : ""}>${c}</option>`).join("")}</select>
      <button data-a="smaller">A−</button><button data-a="bigger">A+</button>` : ""}
    ${block?.kind === "video" ? `<button data-a="video">Gắn video</button>` : ""}
    ${block?.kind === "timer" ? `<label>Phút <input type="number" min="0.5" step="0.5" data-a="minutes" value="${(block.opts.seconds || 60) / 60}"></label>` : ""}
    ${block ? `<label title="0 = có sẵn khi mở trang; 1 = hiện ở lần bấm → đầu tiên; cùng số = hiện cùng lúc">Hiện ở bước <input type="number" min="0" step="1" data-a="step" value="${block.step || 0}"></label>` : ""}
    ${block?.type === "text" && /<li[\s>]/.test(block.html) ? `<label><input type="checkbox" data-a="each" ${block.each ? "checked" : ""}> Từng dòng</label>` : ""}
    ${edits[currentSlide().id] ? `<button data-a="original">Về bản gốc</button>` : ""}
    <button data-a="savefile">Lưu vào 6B0slides.html (Ctrl+S)</button>
    <button class="pri" data-a="done">Xong</button><span class="msg" id="msg"></span>`;
}

$("#bar").addEventListener("click", (e) => {
  const action = e.target.closest("button")?.dataset.a;
  if (!action) return;
  syncDraft();
  const block = selected !== null ? draft[selected] : null;
  let message = "";
  switch (action) {
    case "cancel": draft = clone(editStart); selected = null; message = "Đã bỏ thay đổi"; break;
    case "add": draft.push(text("Chữ mới", 200, 200, 800, 120)); selected = draft.length - 1; break;
    case "delete": draft.splice(selected, 1); selected = null; break;
    case "smaller":
    case "bigger": {
      const base = block.fontSize || parseInt(getComputedStyle($(`.blk[data-i="${selected}"] .in`, stage)).fontSize, 10) || 38;
      block.fontSize = base + (action === "bigger" ? 4 : -4);
      break;
    }
    case "video": return pickVideo(block);
    case "savefile": return saveFile();
    case "original":
      draft = clone(SLIDES[current].blocks);
      selected = null;
      message = "Đã về bản gốc";
      break;
    case "done": return stopEdit();
  }
  saveDraft();
  render();
  if (message) flash(message);
});

$("#bar").addEventListener("change", (e) => {
  if (selected === null) return;
  syncDraft();
  const block = draft[selected];
  if (e.target.dataset.a === "minutes") {
    const minutes = parseFloat(e.target.value);
    if (minutes > 0) block.opts.seconds = Math.round(minutes * 60);
  }
  if (e.target.dataset.a === "style") block.style = e.target.value;
  if (e.target.dataset.a === "step") {
    const n = parseInt(e.target.value, 10);
    if (n > 0) block.step = n; else delete block.step;
  }
  if (e.target.dataset.a === "each") { if (e.target.checked) block.each = true; else delete block.each; }
  saveDraft();
  render();
});

// Videos are played from the "videos" folder next to 6B0slides.html.
function pickVideo(block) {
  const input = document.createElement("input");
  input.type = "file";
  input.accept = "video/*";
  input.onchange = () => {
    const file = input.files[0];
    if (!file) return;
    block.opts.src = "videos/" + file.name;
    saveDraft();
    render();
    flash(`Đã gắn videos/${file.name}. File phải nằm trong thư mục videos.`);
  };
  input.click();
}

// Drag ✥ to move, ⇲ to resize. Positions snap to 10 px.
let drag = null;
stage.addEventListener("pointerdown", (e) => {
  if (!editing) return;
  const blk = e.target.closest(".blk");
  if (!blk) return;
  const i = Number(blk.dataset.i);
  if (selected !== i) {
    syncDraft();
    selected = i;
    $$(".blk.sel", stage).forEach((x) => x.classList.remove("sel"));
    blk.classList.add("sel");
    renderEditBar();
  }
  const handle = e.target.closest(".hd");
  if (!handle) return;
  e.preventDefault();
  syncDraft();
  const b = draft[i];
  drag = { block: b, el: blk, resize: handle.classList.contains("rs"), x0: e.clientX, y0: e.clientY, start: { ...b }, scale: Number(stage.dataset.scale) || 1 };
  handle.setPointerCapture(e.pointerId);
});
stage.addEventListener("pointermove", (e) => {
  if (!drag) return;
  const snap = (v) => Math.round(v / 10) * 10;
  const dx = (e.clientX - drag.x0) / drag.scale, dy = (e.clientY - drag.y0) / drag.scale;
  const b = drag.block, s = drag.start;
  if (drag.resize) { b.w = Math.max(80, snap(s.w + dx)); b.h = Math.max(40, snap(s.h + dy)); }
  else { b.x = snap(s.x + dx); b.y = snap(s.y + dy); }
  Object.assign(drag.el.style, { left: b.x + "px", top: b.y + "px", width: b.w + "px", height: b.h + "px" });
});
stage.addEventListener("pointerup", () => { if (drag) saveDraft(); drag = null; });
stage.addEventListener("input", () => { if (editing) { syncDraft(); saveDraft(); } });  // typing

/* ================= Grid view (G) ================= */

const grid = $("#ov");

function openGrid() {
  if (editing) return flash("Bấm Xong để thoát chế độ sửa trước");
  const list = slides();
  grid.innerHTML = `<div class="ovh"><b>${list.length} trang</b>
      <label>Đến trang <input type="number" min="1" max="${list.length}" inputmode="numeric" aria-label="Số trang"></label>
      <button data-a="go">Đi</button><button data-a="close">Đóng (G / Esc)</button></div>
    <div class="ovg">${list.map((s, i) => `<div class="th${i === current ? " cur" : ""}" role="button" tabindex="0" aria-label="Trang ${i + 1}" data-i="${i}">
      <div class="box"></div><span class="cap"><b>${i + 1}</b> · ${esc(s.nav || "")}${edits[s.id] ? " · <i>đã sửa</i>" : ""}</span></div>`).join("")}</div>`;
  $$(".th .box", grid).forEach((box, i) => box.append(buildSlide(i, () => {})));
  grid.hidden = false;
  sizeGrid();
  const cur = $(".th.cur", grid);
  cur?.scrollIntoView({ block: "center" });
  cur?.focus({ preventScroll: true });
}

function sizeGrid() {
  if (grid.hidden) return;
  $$(".th .box", grid).forEach((box) => { box.firstElementChild.style.transform = `scale(${box.clientWidth / 1920})`; });
}

function closeGrid() {
  grid.hidden = true;
  grid.innerHTML = "";
}

function jump(n) {
  const page = parseInt(n, 10);
  if (!(page >= 1 && page <= slides().length)) return flash("Không có trang " + (n || ""));
  closeGrid();
  go(page - 1);
}

grid.addEventListener("click", (e) => {
  const thumb = e.target.closest(".th");
  if (thumb) { closeGrid(); return go(Number(thumb.dataset.i)); }
  const action = e.target.closest("button")?.dataset.a;
  if (action === "close") closeGrid();
  if (action === "go") jump($("input", grid).value);
});
grid.addEventListener("keydown", (e) => {
  if (e.key !== "Enter") return;
  if (e.target.tagName === "INPUT") jump(e.target.value);
  else if (e.target.classList.contains("th")) { e.stopPropagation(); closeGrid(); go(Number(e.target.dataset.i)); }
});

/* ================= Session map (M) =================
 * The session as a journey: one landmark per stop (STOPS in 6B0slides.html), the four teams walking the trail,
 * scores in a HUD on top. Slides open as a panel over the map; finishing a stop's last slide walks to the next stop.
 */

const mapEl = $("#map"), hud = $("#hud");
const stopStart = (s) => Math.max(0, SLIDES.findIndex((sl) => sl.id === STOPS[s].from));
function stopOf(index) {
  let s = 0;
  STOPS.forEach((_, i) => { if (stopStart(i) <= index) s = i; });
  return s;
}
const stopEnd = (s) => (s + 1 < STOPS.length ? stopStart(s + 1) - 1 : SLIDES.length - 1);

// Smooth trail through the stops (Catmull-Rom turned into cubic Béziers).
function trailPath() {
  const p = STOPS.map((s) => [s.x, s.y]);
  let d = `M${p[0][0]},${p[0][1]}`;
  for (let i = 0; i < p.length - 1; i++) {
    const a = p[i - 1] || p[i], b = p[i], c = p[i + 1], e = p[i + 2] || c;
    d += ` C${b[0] + (c[0] - a[0]) / 6},${b[1] + (c[1] - a[1]) / 6} ${c[0] - (e[0] - b[0]) / 6},${c[1] - (e[1] - b[1]) / 6} ${c[0]},${c[1]}`;
  }
  return d;
}

let trail = null, stopLen = [], tokenAt = null, travel = null;  // tokenAt = trail length where the teams stand

function buildMap() {
  mapEl.innerHTML = `<div class="mp">
    <img class="mbg" src="${MAP_ART.background}" alt="">
    <svg class="trail" viewBox="0 0 1920 1080" aria-hidden="true">
      <path class="tr-edge" d="${trailPath()}"/><path class="tr-base" d="${trailPath()}"/><path class="tr-done" d="${trailPath()}"/>
    </svg>
    ${STOPS.map((s, i) => `<button class="lm" data-s="${i}" style="left:${s.x}px;top:${s.y}px" aria-label="Chặng ${i + 1}: ${esc(s.name)}">
      <img src="${s.art}" alt=""><span class="lb"><b>${i + 1}</b>${esc(s.name)}</span></button>`).join("")}
    <div class="toks">${TEAMS.map((t) => `<div class="tok" data-k="${t.key}"><img src="${MAP_ART.team(t.key)}" alt="Đội ${t.name}"></div>`).join("")}</div>
  </div>`;
  hud.innerHTML = `<div class="hi"></div>`;
  trail = $(".tr-done", mapEl);
  const total = trail.getTotalLength();
  // Trail length at each stop: the sampled point nearest to it.
  stopLen = STOPS.map((s) => {
    let best = 0, dist = Infinity;
    for (let l = 0; l <= total; l += 4) {
      const pt = trail.getPointAtLength(l), d = (pt.x - s.x) ** 2 + (pt.y - s.y) ** 2;
      if (d < dist) { dist = d; best = l; }
    }
    return best;
  });
  for (const p of $$("path", mapEl)) p.style.strokeDasharray = p.classList.contains("tr-done") ? `0 ${total}` : "";
  mapEl.onclick = (e) => {
    const lm = e.target.closest(".lm");
    if (lm) return openStop(Number(lm.dataset.s));
    if (slideOpen || boardOpen) closePanel();  // click outside the panel
  };
  hud.onclick = (e) => {
    const a = e.target.closest("button")?.dataset.a;
    if (a === "map") return slideOpen || boardOpen ? closePanel() : openStop(stopOf(current));
    if (a === "board") { boardOpen = !boardOpen; render(); }
    if (a === "classic") toggleMapMode();
  };
}

// Places the four tokens in one row at a point on the trail, in leaderboard order: 1st on the left, 4th on the right.
// STOPS[i].team says where the row stands: "below" the landmark (default), or to its "left" or "right".
function placeTokens(len) {
  const pt = trail.getPointAtLength(len);
  const place = places(byValue(totals()));
  const order = TEAMS.map((tm) => tm.key).sort((a, b) => place[a] - place[b]);  // ties keep the TEAMS order
  const where = STOPS[stopOf(current)].team || "below";
  order.forEach((k, i) => {
    const cx = where === "left" ? pt.x - 110 - (3 - i) * 50 : where === "right" ? pt.x + 110 + i * 50 : pt.x + (i - 1.5) * 50;
    const top = where === "below" ? pt.y + 60 : pt.y - 110;
    $(`.tok[data-k="${k}"]`, mapEl).style.transform = `translate(${cx - 36}px, ${top}px)`;
  });
}

// Walks the tokens along the trail from where they stand to `to` (a trail length).
function walkTo(to) {
  cancelAnimationFrame(travel);
  const from = tokenAt ?? to, dist = Math.abs(to - from);
  if (dist < 1) { tokenAt = to; trail.style.strokeDasharray = `${to} 99999`; return placeTokens(to); }
  const ms = Math.min(4000, 900 + dist * 1.6), t0 = performance.now();
  mapEl.classList.add("walking");
  const step = (now) => {
    const k = Math.min(1, (now - t0) / ms), ease = k < 0.5 ? 2 * k * k : 1 - (-2 * k + 2) ** 2 / 2;
    tokenAt = from + (to - from) * ease;
    placeTokens(tokenAt);
    trail.style.strokeDasharray = `${tokenAt} 99999`;
    if (k < 1) travel = requestAnimationFrame(step);
    else mapEl.classList.remove("walking");
  };
  travel = requestAnimationFrame(step);
}

function teamHud() {
  const t = totals(), place = places(byValue(t));
  const anyScore = Object.values(t).some((v) => v > 0);
  return TEAMS.map((tm) => {
    const value = board.display === "full" ? t[tm.key] : board.display === "rank" ? `#${place[tm.key] + 1}` : "";
    return `<div class="hc c-${tm.key}${anyScore && place[tm.key] === 0 && board.display !== "none" ? " top" : ""}">
      <img src="${MAP_ART.team(tm.key)}" alt=""><span class="hn">${tm.name}</span><b>${value}</b></div>`;
  }).join("");
}

function updateMap() {
  document.body.classList.toggle("mapmode", mapMode);
  document.body.classList.toggle("panel", mapMode && (slideOpen || boardOpen || editing));
  mapEl.hidden = hud.hidden = !mapMode;
  hud.style.visibility = editing ? "hidden" : "";  // the edit bar sits where the HUD is
  if (!mapMode) return;
  if (!trail) { buildMap(); fitStage(); }
  const s = stopOf(current);
  $$(".lm", mapEl).forEach((lm, i) => {
    lm.classList.toggle("done", i < s);
    lm.classList.toggle("here", i === s);
  });
  walkTo(stopLen[s]);
  const open = slideOpen || boardOpen;
  const page = current - stopStart(s) + 1, pages = stopEnd(s) - stopStart(s) + 1;
  $(".hi", hud).innerHTML = `<div class="hs"><span class="hsn">Chặng ${s + 1}/${STOPS.length}${open ? ` · trang ${page}/${pages}` : ""}</span><b>${esc(STOPS[s].name)}</b></div>
    <div class="hteams">${teamHud()}</div>
    <div class="hb"><button data-a="board" class="${boardOpen ? "on" : ""}">🏆 Bảng điểm</button>
      <button data-a="map">${open ? "🗺 Về bản đồ" : "▶ Vào chặng"}</button></div>`;
}

function openStop(s) {
  if (stopOf(current) !== s) {
    current = stopStart(s);
    session.reveal[slides()[current].id] = 0;
    saveSession();
  }
  slideOpen = true;
  boardOpen = false;
  render();
}

function closePanel() {
  if (editing) return flash("Bấm Xong để thoát chế độ sửa trước");
  slideOpen = false;
  boardOpen = false;
  render();
}

// Called by next(): leaving a stop in map mode closes the panel and walks the teams on.
function mapLeave(index) {
  if (!mapMode || !slideOpen || stopOf(index) === stopOf(current)) return false;
  current = index;
  session.reveal[slides()[index].id] = 0;
  saveSession();
  slideOpen = false;
  render();
  return true;
}

function toggleMapMode() {
  if (editing) return flash("Bấm Xong để thoát chế độ sửa trước");
  mapMode = !mapMode;
  slideOpen = !mapMode ? false : slideOpen;
  fitStage();
  render();
}

// Keys that mean something else on the map. Returns true when handled.
function mapKey(e) {
  if (!mapMode) return false;
  const k = e.key;
  if (k === "Escape" && (slideOpen || boardOpen)) { closePanel(); return true; }
  if (slideOpen || boardOpen) return false;
  if (["ArrowRight", "PageDown", " ", "Enter"].includes(k)) { e.preventDefault(); openStop(stopOf(current)); return true; }
  if (k === "ArrowLeft" || k === "PageUp") {
    e.preventDefault();
    const s = stopOf(current);
    if (s > 0) { current = stopStart(s - 1); render(); }
    return true;
  }
  return false;
}

/* ================= Navigation, keys, messages ================= */

// Opens a slide. Coming from the slide after it (back = true) shows it fully; otherwise it starts at step 0.
function go(index, back = false) {
  if (editing) return flash("Bấm Xong để thoát chế độ sửa trước");
  const list = slides();
  index = Math.max(0, Math.min(index, list.length - 1));
  session.reveal[list[index].id] = back ? maxStep(list[index]) : 0;
  saveSession();
  current = index;
  if (mapMode) slideOpen = true;
  render();
}

// → : show the next reveal step; when the slide is complete, move on.
function next() {
  if (editing) return;
  if (mapMode && !slideOpen && !boardOpen) return openStop(stopOf(current));
  const slide = currentSlide(), shown = revealOf(slide);
  if (shown < maxStep(slide)) {
    session.reveal[slide.id] = shown + 1;
    saveSession();
    return render(shown + 1);
  }
  if (current >= slides().length - 1) return;
  if (mapLeave(current + 1)) return;  // map mode: finishing a stop walks back to the map
  go(current + 1);
}

// ← : hide the last reveal step; at step 0, go to the previous slide, fully shown.
function prev() {
  if (editing) return;
  if (mapMode && !slideOpen && !boardOpen) return;
  const slide = currentSlide(), shown = revealOf(slide);
  if (shown > 0) {
    session.reveal[slide.id] = shown - 1;
    saveSession();
    return render();
  }
  if (current > 0) go(current - 1, true);
}

// Short message: in the edit bar while editing, otherwise in place of the page number.
function flash(message) {
  const target = editing ? $("#msg") : $("#nNum");
  if (!target) return;
  target.textContent = message;
  clearTimeout(flash.timer);
  flash.timer = setTimeout(() => {
    if ($("#msg")) $("#msg").textContent = "";
    $("#nNum").textContent = `${current + 1}/${slides().length}`;
  }, 2500);
}

function toggleFullscreen() {
  if (document.fullscreenElement) document.exitFullscreen();
  else document.documentElement.requestFullscreen().catch(() => {});
}

const help = $("#help");
$("#nPrev").onclick = prev;
$("#nNext").onclick = next;
$("#nBoard").onclick = () => { boardOpen = !boardOpen; render(); };
$("#nEdit").onclick = () => (editing ? stopEdit() : startEdit());
$("#nFull").onclick = toggleFullscreen;
$("#nGrid").onclick = () => (grid.hidden ? openGrid() : closeGrid());
$("#nHelp").onclick = () => { help.hidden = false; };
$("#helpClose").onclick = () => { help.hidden = true; };
$("#helpSave").onclick = saveFile;
$("#helpBackup").onclick = backup;
$("#helpRestore").onclick = restore;

let typedNumber = "", typedTimer = null;  // type a page number, then Enter

document.addEventListener("keydown", (e) => {
  if (e.target.isContentEditable || /INPUT|SELECT|TEXTAREA/.test(e.target.tagName)) return;
  const k = e.key;
  if (!help.hidden) { if (k === "Escape" || k === "?") help.hidden = true; return; }
  if (editing) { if (k === "Escape") stopEdit(); return; }

  if (/^[0-9]$/.test(k)) {
    typedNumber = (typedNumber + k).slice(-3);
    $("#nNum").textContent = "→ " + typedNumber;
    clearTimeout(typedTimer);
    typedTimer = setTimeout(() => { typedNumber = ""; $("#nNum").textContent = `${current + 1}/${slides().length}`; }, 2500);
    return;
  }
  if (k === "Enter" && typedNumber) { const n = typedNumber; typedNumber = ""; clearTimeout(typedTimer); return jump(n); }
  if (!grid.hidden) { if (k === "Escape" || k.toLowerCase() === "g") closeGrid(); return; }
  if (mapKey(e)) return;

  switch (k.length === 1 ? k.toLowerCase() : k) {
    case "ArrowRight": case "PageDown": case " ": e.preventDefault(); next(); break;
    case "ArrowLeft": case "PageUp": e.preventDefault(); prev(); break;
    case "Home": go(0); break;
    case "End": go(slides().length - 1); break;
    case "g": openGrid(); break;
    case "l": boardOpen = !boardOpen; render(); break;
    case "s": showStrip = !showStrip; render(); break;
    case "m": toggleMapMode(); break;
    case "e": startEdit(); break;
    case "f": toggleFullscreen(); break;
    case "t": keyActions.T?.(); break;
    case "r": keyActions.R?.(); break;
    case "?": help.hidden = false; break;
  }
});

let touchX = null;
stage.addEventListener("touchstart", (e) => { touchX = e.touches[0].clientX; }, { passive: true });
stage.addEventListener("touchend", (e) => {
  if (touchX === null || editing || boardOpen) return;
  const dx = e.changedTouches[0].clientX - touchX;
  if (Math.abs(dx) > 60) (dx < 0 ? next : prev)();
  touchX = null;
});

/* ================= Save slides to 6B0slides.html ================= */

// Chrome and Edge write straight into the file you pick (asked once per session).
// Other browsers download 6B0slides.html; drag it over the old one.
let fileHandle = null;
async function saveFile() {
  if (editing) { syncDraft(); saveDraft(); }
  const html = fileTemplate.replace("@@SLIDES@@", () => slides().map(writeSlide).join("\n\n"));
  if (window.showSaveFilePicker) {
    try {
      fileHandle ??= await showSaveFilePicker({ suggestedName: "6B0slides.html", types: [{ description: "HTML", accept: { "text/html": [".html"] } }] });
      const out = await fileHandle.createWritable();
      await out.write(html);
      await out.close();
      return flash("Đã lưu vào " + fileHandle.name);
    } catch (e) {
      fileHandle = null;
      if (e.name === "AbortError") return;
    }
  }
  const link = document.createElement("a");
  link.href = URL.createObjectURL(new Blob([html], { type: "text/html" }));
  link.download = "6B0slides.html";
  link.click();
  URL.revokeObjectURL(link.href);
  flash("Đã tải 6B0slides.html về. Chép đè lên file cũ trong thư mục slides.");
}

document.addEventListener("keydown", (e) => {
  if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === "s") { e.preventDefault(); saveFile(); }
});

/* ================= Backup (move scores and edits to another computer) ================= */

function backup() {
  const data = { app: "hoc-cach-hoc-6b0", savedAt: new Date().toISOString(), board, thiviet, wheels, edits, session };
  const link = document.createElement("a");
  link.href = URL.createObjectURL(new Blob([JSON.stringify(data, null, 1)], { type: "application/json" }));
  link.download = `hoc-cach-hoc-6b0-${data.savedAt.slice(0, 16).replace(/[:T]/g, "-")}.json`;
  link.click();
  URL.revokeObjectURL(link.href);
}

function restore() {
  const input = document.createElement("input");
  input.type = "file";
  input.accept = ".json,application/json";
  input.onchange = async () => {
    try {
      const data = JSON.parse(await input.files[0].text());
      if (data.app !== "hoc-cach-hoc-6b0") throw new Error("not a backup");
      board = { ...emptyBoard(), ...data.board };
      thiviet = { ...emptyThiviet(), ...data.thiviet };
      wheels = data.wheels || {};
      edits = data.edits || {};
      session = { ...emptySession(), ...data.session };
      saveBoard(); saveThiviet(); saveWheels(); saveEdits(); saveSession();
      help.hidden = true;
      render();
      flash("Đã khôi phục");
    } catch {
      flash("File này không phải bản sao lưu của bài giảng");
    }
  };
  input.click();
}

/* ================= Boot ================= */

// Check that this browser really keeps data (it does not in a private window or when storage is blocked).
try {
  localStorage.setItem(STORE_PREFIX + "check", "1");
  if (localStorage.getItem(STORE_PREFIX + "check") !== "1") throw new Error();
} catch {
  warn("Trình duyệt này không lưu được dữ liệu (cửa sổ ẩn danh?). Điểm sẽ mất khi tải lại trang. Hãy mở bằng Chrome ở cửa sổ thường.");
}

// If the deck is open in two tabs, each tab picks up the other's changes instead of overwriting them.
addEventListener("storage", (e) => {
  if (!e.key?.startsWith(STORE_PREFIX) || e.key === STORE_PREFIX + "view") return;
  loadState({ withEdits: !editing });
  if (!spinning) render();
});

// Typing #slide-id in the address bar jumps there.
addEventListener("hashchange", () => {
  const i = SLIDES.findIndex((s) => s.id === location.hash.slice(1));
  if (i >= 0 && i !== current && !editing) { current = i; if (mapMode) slideOpen = true; render(); }
});

// A browser edit that 6B0slides.html already contains (saved with Ctrl+S) is no longer needed.
for (const s of SLIDES) if (edits[s.id] && sameBlocks(edits[s.id].blocks, s.blocks)) delete edits[s.id];
saveEdits();

const fromHash = SLIDES.findIndex((s) => s.id === location.hash.slice(1));
if (fromHash >= 0 && fromHash !== current) { current = fromHash; if (mapMode) slideOpen = true; }
addEventListener("resize", () => { fitStage(); sizeGrid(); });
// The corner buttons stay hidden until the mouse is in the bottom 90px of the screen.
const nav = document.getElementById("nav");
addEventListener("mousemove", (e) => nav.classList.toggle("show", e.clientY > innerHeight - 90));
document.documentElement.addEventListener("mouseleave", () => nav.classList.remove("show"));
fitStage();
render();
document.fonts.ready.then(render);  // wheel labels are measured on a canvas, so redraw once fonts load
})();
