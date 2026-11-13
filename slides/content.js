/* Học cách học · 6B0 — everything the class sees: teams, scoring rules and all slides.
 *
 * Edit this file to change text, questions or layout. The engine is in app.js.
 *
 * Every slide sits on a 1920 × 1080 stage. x, y, w, h are in pixels from the top left.
 * Keep content above y ≈ 1000; the footer sits below that.
 *
 * Slide:  { id, nav, tag, bg, noFooter, blocks: [...] }
 *   id        unique, used in the address bar (#id) and to store edits
 *   nav       short name shown in the footer and the grid view (G)
 *   tag       optional pill in the top right
 *   bg        "red" or "cream" (default white)
 *
 * Block helpers:
 *   text(html, x, y, w, h, style)   style: h1 h2 big lead body small note card divnum divt
 *   title(html, options)            slide heading at the top left; options override x/y/w/h/style
 *   widget(kind, x, y, w, h, opts)  interactive block; kinds are listed in app.js (WIDGETS)
 */
"use strict";

/* ---------- Teams and scoring ---------- */

const TEAMS = [
  { key: "R", name: "Đỏ", color: "#D32F2F" },
  { key: "B", name: "Xanh dương", color: "#1E63C6" },
  { key: "G", name: "Xanh lá", color: "#2E8B47" },
  { key: "Y", name: "Vàng", color: "#F2B705" },
];

const POINTS_RANKED = [4, 3, 2, 2]; // place 1, 2, 3, 4. Ties share the higher place.
const POINTS_FINAL = [8, 6, 4, 4];
const SHIELD_MAX = 3;

// "rank" rounds turn a place into points. "points" rounds give each team its own score, up to max.
const ROUNDS = [
  { id: "thiviet", name: "Vòng 1 · Thi viết", kind: "rank", points: POINTS_RANKED, rule: "Xếp theo tổng số dòng đúng" },
  { id: "chuyengia", name: "Vòng 2 · Chuyên gia", kind: "rank", points: POINTS_RANKED, rule: "Xếp theo số câu đúng của đội (4 câu)" },
  { id: "ghepthe", name: "Đua ghép thẻ", kind: "rank", points: POINTS_RANKED, rule: "Xếp theo số thẻ đúng; bằng nhau thì rung chuông trước xếp trên" },
  { id: "toaan", name: "Vòng 3 · Tòa án AI", kind: "points", max: 4, rule: "Đúng kết cục 2 · lý do 1 · kháng cáo 1" },
  { id: "nhom", name: "Vòng 4 · Bài nhóm", kind: "rank", points: POINTS_RANKED, rule: "Xếp theo số điểm checklist đạt" },
  { id: "chungket", name: "Chung kết ×2", kind: "rank", points: POINTS_FINAL, rule: "Xếp theo số câu đúng của đội (3 câu)" },
  { id: "thang", name: "Chung kết · giải thích hack", kind: "points", max: 2, rule: "Giải thích đúng 1 · ví dụ riêng 1" },
];

/* ---------- Shared content ---------- */

const HACKS = ["Tập trung rồi nghỉ", "Tự đố, tự giảng", "Rải đều, ngủ đủ", "Luyện nhiều chỗ yếu"];

// Tòa án AI. part1 is shown first; outcome and why are revealed after the teams vote.
const CASES = [
  {
    part1: "Tối trước ngày kiểm tra, bạn ấy nhờ Gemini đố 30 câu từ vựng liền trong một tiếng và được điểm 8.",
    outcome: "Nhớ một phần. Hai tuần sau còn nhớ khoảng một nửa số từ.",
    why: "Tự đố là đúng, nhưng nên rải ra: mỗi tối 10 câu, ba tối.",
  },
  {
    part1: "Cô giao quan sát 5 loài cây quanh nhà rồi xếp nhóm. Bạn ấy ngại ra vườn, nhờ Gemini viết hộ, chép vào vở và được cô khen.",
    outcome: "Quên. Bạn ấy chưa từng thấy cây dương xỉ thật nên không trả lời được.",
    why: "Chép bài AI viết là bậc 1. Tự ra vườn quan sát mới là bậc 3.",
  },
  {
    part1: "Viết xong bài văn, bạn ấy nhờ Gemini chỉ ra ba chỗ yếu nhưng không sửa hộ, rồi tự sửa. Mất thêm 20 phút.",
    outcome: "Nhớ. Bài văn tuần sau, bạn ấy tự tránh được đúng những lỗi đó.",
    why: "AI chỉ chỗ yếu, bạn vẫn là người làm: bậc 3 và Luyện nhiều chỗ yếu.",
  },
  {
    part1: "Tìm hiểu về Hà Nội, bạn ấy hỏi Gemini ba thông tin chính, chép vào bài, ghi nguồn là Gemini, không kiểm tra lại.",
    outcome: "Điểm thấp. Hai trong ba thông tin Gemini đưa ra đã cũ.",
    why: "AI có thể dùng thông tin cũ. Số liệu phải kiểm tra lại hoặc hỏi cô.",
  },
];

// Văn hóa đọc review. The cheat sheet has a short version of the same 7 points.
const CHECKLIST = [
  "Cả nhóm thống nhất <b>dàn ý</b> trước khi làm slide.",
  "Mỗi bạn có <b>một phần nội dung</b> riêng, tự viết bằng lời của mình.",
  "Có <b>bảng phân công</b>: ai làm gì, hạn khi nào, cả nhóm cùng thấy.",
  "Không chép nguyên văn từ mạng hay AI; có <b>ghi nguồn</b>.",
  "Mỗi slide <b>một ý chính</b>, chữ ít và đủ to.",
  "Có một bạn <b>kiểm tra</b> thông tin và chính tả trước khi nộp.",
  "Cả nhóm <b>tập nói</b>, ai cũng trình bày được phần mình.",
];

/* ---------- Block helpers ---------- */

const text = (html, x, y, w, h, style = "body") => ({ type: "text", style, html, x, y, w, h });
const title = (html, options = {}) => ({ type: "text", style: "h2", html, x: 120, y: 78, w: 1300, h: 120, ...options });
const widget = (kind, x, y, w, h, opts = {}) => ({ type: "widget", kind, x, y, w, h, opts });

const divider = (id, number, heading, sub) => ({
  id, bg: "red", nav: "Phần " + number,
  blocks: [
    text(String(number), 96, 90, 620, 900, "divnum"),
    text(heading, 760, 250, 1040, 340, "divt"),
    text(sub, 760, 640, 1040, 220, "lead"),
  ],
});

// Round 2 puts the whole question in the slide title. The final puts it inside the quiz box.
// Tòa án AI videos (built in ../video-src). pauseAt = seconds where the video stops for the vote.
const VIDEOS = [
  { src: "videos/case1.mp4", pauseAt: 35.2 },
  { src: "videos/case2.mp4", pauseAt: 51.3 },
  { src: "videos/case3.mp4", pauseAt: 45.6 },
  { src: "videos/case4.mp4", pauseAt: 39.5 },
];
const quizSlide = ({ id, nav, tag, heading, round, question, options, answer, questionInTitle }) => ({
  id, nav, tag,
  blocks: questionInTitle
    ? [
        title(question, { w: 1480, h: 210, style: "h2 qtitle" }),
        widget("quiz", 120, 300, 1680, 690, { round, options, answer }),
      ]
    : [
        title(heading),
        widget("quiz", 120, 190, 1680, 800, { round, question, options, answer }),
      ],
});

const caseSlide = (n) => ({
  id: "case" + n, nav: "Tình huống " + n,
  judgedBy: { wheel: "boc-toaan", slot: n - 1 }, // tag shows "Đội X xử" once the wheel has picked
  blocks: [
    title("Tình huống " + n),
    widget("video", 120, 220, 1000, 560, { label: `Video ${n} · phần 1 và phần 2`, ...VIDEOS[n - 1] }),
    text(`<b>Phần 1</b><br>${CASES[n - 1].part1}`, 1180, 220, 620, 400, "card"),
    widget("reveal", 1180, 650, 620, 320, {
      label: "Phần 2 · một tuần sau (bấm hoặc R)",
      html: `<b>${CASES[n - 1].outcome}</b><br><span class="small">${CASES[n - 1].why}</span>`,
    }),
    text(`Đoán: ${n === 1 ? "hai tuần" : "một tuần"} sau chuyện gì xảy ra? Vì sao?`, 120, 820, 1000, 80, "note"),
  ],
});

/* ---------- Big HTML pieces ---------- */

const LADDER_HTML = `<div class="ladder">
  <div class="st" style="min-height:380px"><div class="n">1</div><div class="nm">Nhận vào</div><div class="ex">Xem người khác chơi. Nghe giảng, đọc lại bài.</div></div>
  <div class="st" style="min-height:470px"><div class="n">2</div><div class="nm">Làm theo</div><div class="ex">Bắt chước y hệt video. Chép lời giải.</div></div>
  <div class="st" style="min-height:560px"><div class="n">3</div><div class="nm">Tự chế</div><div class="ex">Vào trận, tự nghĩ nước đi. Giải thích bằng lời của mình.</div></div>
  <div class="st" style="min-height:650px"><div class="n">4</div><div class="nm">Tương tác</div><div class="ex">Cả đội bàn chiến thuật. Giảng cho bạn, tranh luận.</div></div>
</div>`;

// Line icons for the cheat sheet (24 × 24, stroke only).
const ICONS = {
  stairs: '<path d="M3 21h5v-5h5v-5h5V6h3"/>',
  bot: '<rect x="3" y="8" width="18" height="12" rx="2"/><path d="M12 8V4H8M2 14h2M20 14h2M15 13v2M9 13v2"/>',
  clip: '<rect x="8" y="2" width="8" height="4" rx="1"/><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"/><path d="m9 14 2 2 4-4"/>',
  zap: '<path d="M13 2 3 14h9l-1 8 10-12h-9l1-8z"/>',
  timer: '<path d="M10 2h4M12 14l3-3"/><circle cx="12" cy="14" r="8"/>',
  ask: '<path d="M7.9 20A9 9 0 1 0 4 16.1L2 22Z"/><path d="M9.1 9a3 3 0 0 1 5.8 1c0 2-3 3-3 3M12 17h.01"/>',
  cal: '<rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18M8 14h.01M12 14h.01M16 14h.01M8 18h.01M12 18h.01"/>',
  target: '<circle cx="12" cy="12" r="10"/><circle cx="12" cy="12" r="6"/><circle cx="12" cy="12" r="2"/>',
};
const icon = (name, cls = "") =>
  `<svg class="ic ${cls}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">${ICONS[name]}</svg>`;

const CHEAT_SHEET_HTML = `<div class="cheat">
 <section class="box"><div class="bh">${icon("stairs")}Chiếc thang học tập<small>Leo càng cao, não càng phải tự làm. Thấy khó một chút là đang học.</small></div>
  <div class="bb ladb"><div class="g4 lad"><div class="cap">Dở → Tập → Giỏi → Thích</div>
   <div class="st"><b>1 · Nhận vào</b><span>Nghe giảng, đọc lại bài</span></div>
   <div class="st"><b>2 · Làm theo</b><span>Bắt chước, chép lời giải</span></div>
   <div class="st"><b>3 · Tự chế</b><span>Giải thích bằng lời mình, tự đặt câu hỏi</span></div>
   <div class="st"><b>4 · Tương tác</b><span>Bạn nói một ý, mình nghĩ tiếp; tranh luận, sửa cho nhau</span></div></div></div></section>
 <div class="g4 midrow">
  <section class="box"><div class="bh">${icon("bot")}Dùng AI</div>
   <div class="bb g2"><div class="pan up"><h4>Nên</h4><ul class="li yes"><li>Nhờ AI đố mình</li><li>Nhờ AI chỉ chỗ yếu, rồi tự sửa</li><li>Giảng cho AI nghe, cãi khi nó sai</li><li>Hỏi lại thầy cô khi cần chắc</li></ul></div>
   <div class="pan dn"><h4>Không nên</h4><ul class="li nope"><li>Chép lời giải của AI</li><li>Học thuộc tóm tắt của AI</li><li>Nhờ AI làm hộ phần của mình</li><li>Tin AI mọi lúc</li></ul></div></div></section>
  <section class="box"><div class="bh">${icon("clip")}Slide nhóm trên Canva</div>
   <div class="bb"><ol class="li chk"><li>Thống nhất dàn ý trước</li><li>Mỗi bạn một phần, tự viết</li><li>Bảng phân công có tên và hạn</li><li>Không chép; có ghi nguồn</li><li>Mỗi slide một ý, chữ ít và to</li><li>Có người kiểm tra thông tin, chính tả</li><li>Cả nhóm tập nói, ai cũng nói được phần mình</li></ol></div></section>
 </div>
 <section class="box"><div class="bh">${icon("zap")}Bốn hack</div>
  <div class="bb g4 hks">
   <div class="hk">${icon("timer", "hi")}<h4>1 · Tập trung rồi nghỉ</h4><p>Một việc một lúc, điện thoại để phòng khác. Học 25 phút, nghỉ 5 phút.</p></div>
   <div class="hk">${icon("ask", "hi")}<h4>2 · Tự đố, tự giảng</h4><p>Gấp vở, tự viết ra những gì nhớ, rồi mở ra so. Giảng lại cho bạn, bố mẹ.</p></div>
   <div class="hk">${icon("cal", "hi")}<h4>3 · Rải đều, ngủ đủ</h4><p>Bắt đầu sớm vài ngày, mỗi tối ôn một ít. Ngủ đủ, không thức khuya học dồn.</p></div>
   <div class="hk">${icon("target", "hi")}<h4>4 · Luyện nhiều chỗ yếu</h4><p>Dành nhiều thời gian nhất cho dạng bài hay sai. Trộn nhiều dạng khi ôn.</p></div></div></section>
</div>`;

/* ---------- Slides, in order ---------- */

const SLIDES = [
  { id: "bia", bg: "red", nav: "Bìa", blocks: [
    text("LỚP 6B0 · THỨ BA 17/11/2026", 120, 250, 1500, 60, "small"),
    text("Học cách học", 120, 330, 1600, 160, "h1"),
    text("Hết bài · Nhớ lâu · Hiểu kỹ", 120, 520, 1600, 90, "lead"),
    text("Chú Huy Dũng · làm game ở Gameloft Hà Nội", 120, 820, 1500, 60, "small"),
  ]},

  /* ===== Phần 1 · Khởi động ===== */
  divider("p1", 1, "Khởi động", "Dở → Tập → Giỏi → Thích, chiếc thang học tập, và luật chơi"),

  { id: "clash", nav: "Clash Royale", blocks: [
    title("Chú từng chơi Clash Royale rất dở"),
    text(`<ol><li>Thua suốt, nên không thích.</li><li>Xem một video dạy dùng lá Mega Minion, thử, thắng vài trận.</li><li>Càng chơi hay càng thích. Giờ nhớ tương tác của hơn một trăm lá bài.</li></ol>`, 120, 250, 1680, 330, "lead"),
    text("Dở → Tập → Giỏi → Thích", 120, 640, 1680, 150, "big"),
    text("Mình thường thích một thứ <i>sau khi</i> giỏi nó, không phải trước.", 120, 820, 1680, 70, "small"),
  ]},

  { id: "bacau", nav: "Ba câu hỏi", blocks: [
    title("Ba câu hỏi cho cả lớp"),
    text(`<h3>1</h3>Bạn đang giỏi gì mà hồi đầu rất dở?`, 120, 260, 520, 420, "card"),
    text(`<h3>2</h3>Cờ vua khi chỉ biết luật có vui không? Khi nào mới vui?`, 700, 260, 520, 420, "card"),
    text(`<h3>3</h3>Biết tiếng Anh giúp bạn làm được gì thêm?`, 1280, 260, 520, 420, "card"),
    text("Làm bạn cũng là thứ học được: rủ bạn chơi, xin lỗi, làm đồng đội tốt.", 120, 760, 1680, 90, "note"),
  ]},

  { id: "thang", nav: "Chiếc thang", blocks: [
    title("Chiếc thang học tập"),
    text("Leo càng cao, não càng phải tự làm, và mình học càng sâu. Mệt hơn một chút chính là lúc đang học.", 120, 200, 1680, 110, "body"),
    widget("html", 120, 320, 1680, 660, { html: LADDER_HTML }),
  ]},

  { id: "lapdoi", nav: "Lập đội", tag: "2 phút", blocks: [
    title("Bốn đội, bốn màu"),
    widget("teams", 120, 230, 1680, 250),
    text(`<ol><li>Mỗi đội bốc bốn thẻ hack đang úp. Bốc thẻ nào, bạn là <b>chuyên gia</b> của thẻ đó.</li><li><b>Luật xoay vòng:</b> mỗi lần đội cần một người lên bảng, phát biểu hay đọc kết quả, cử một bạn chưa lên lần nào.</li></ol>`, 120, 540, 1680, 380, "body"),
  ]},

  { id: "luat", nav: "Luật tính điểm", tag: "Đọc kỹ trước khi chơi", blocks: [
    title("Luật tính điểm"),
    text(`<h3>Mỗi vòng xếp hạng</h3>Hạng 1: <b>4 điểm</b><br>Hạng 2: <b>3 điểm</b><br>Hạng 3 và 4: <b>2 điểm</b>`, 120, 240, 520, 340, "card"),
    text(`<h3>Đúng hơn nhanh</h3>Làm đúng mới được điểm. Nhanh chỉ dùng để phân thắng khi bằng điểm.`, 700, 240, 520, 340, "card"),
    text(`<h3>Chung kết</h3>Điểm <b>gấp đôi</b>. Đội đang xếp sau vẫn còn cơ hội.`, 1280, 240, 520, 340, "card"),
    text(`Khiên ✋ +1, tối đa 3 · Chạy hoặc chen lấn −1 · Cô Tươi là trọng tài cuối cùng.<br><span class="small">Luật riêng của từng vòng: chú nói khi vòng đó bắt đầu.</span>`, 120, 640, 1680, 170, "note"),
  ]},

  { id: "khien", nav: "Tín hiệu khiên", blocks: [
    title("Tín hiệu khiên ✋"),
    text("Chú giơ tay → cả lớp giơ tay và im lặng.", 120, 280, 1680, 120, "lead"),
    text("Đội trật tự nhanh nhất được <b>+1 điểm khiên</b>.<br>Mỗi đội được tối đa <b>3 điểm khiên</b> cả buổi.", 120, 440, 1680, 200, "note"),
  ]},

  /* ===== Phần 2 · Bốn hack ===== */
  divider("p2", 2, "Bốn hack", "Đọc thẻ, thi viết, và làm chuyên gia giảng cho đội"),

  { id: "doc", nav: "Đọc im lặng", tag: "4 phút", blocks: [
    title("Đọc im lặng"),
    text(`<ul><li>Đọc hết thẻ của mình. Không nói chuyện.</li><li>Gạch chân <b>3 ý</b> bạn sẽ giảng, có ít nhất một ví dụ.</li><li>Lát nữa bạn là chuyên gia, phải giảng thẻ này cho cả đội.</li></ul>`, 120, 240, 1000, 500, "lead"),
    widget("timer", 1180, 260, 620, 300, { seconds: 240 }),
    text("Đội im lặng trọn 4 phút: <b>+1 khiên</b>.", 1180, 620, 620, 200, "note"),
  ]},

  { id: "thiviet", nav: "Vòng 1", tag: "Vòng 1", blocks: [
    title("Vòng 1 · Thi viết"),
    text(`<h3>Cách A · từng việc một</h3>Viết hết dòng chữ, rồi hết dòng số. Xong thì làm lại ở hai dòng mới.`, 120, 230, 820, 330, "card"),
    text(`<h3>Cách B · xen kẽ</h3>H ở dòng trên, 1 ở dòng dưới, O ở dòng trên, 4 ở dòng dưới, cứ thế.`, 980, 230, 820, 330, "card"),
    text(`<span class="sequence">H O C C A C H H O C</span><br><span class="sequence numbers">1 4 7 10 13 16 19 22 25 28</span>`, 120, 600, 1000, 200, "body"),
    widget("timer", 1180, 600, 620, 240, { seconds: 120 }),
    text("Mỗi đội: 1 bạn cách A, 1 bạn cách B. Hai bạn còn lại làm trọng tài cho đội kế bên.", 120, 880, 1680, 70, "small"),
  ]},

  { id: "thiviet-kq", nav: "Vòng 1 · kết quả", tag: "Vòng 1", blocks: [
    title("Vòng 1 · Kết quả"),
    widget("thiviet", 120, 220, 1680, 560),
    text("Cùng 2 phút, cùng nội dung. Mỗi lần chuyển từ chữ sang số, não phải tìm lại chỗ mình đang làm. Vừa làm bài vừa nhắn tin chính là cách B.", 120, 810, 1680, 160, "note"),
  ]},

  { id: "chuyengia", nav: "Vòng 2", tag: "Vòng 2", blocks: [
    title("Vòng 2 · Chuyên gia"),
    text(`<ol><li>Theo thứ tự thẻ 1 → 4, mỗi chuyên gia có <b>2 phút</b>: giảng và trả lời câu hỏi.</li><li>Đội hỏi bao nhiêu câu cũng được, miễn trong 2 phút.</li><li>Chuyên gia được nhìn thẻ. Ba bạn nghe thì không.</li></ol>`, 120, 230, 1060, 520, "lead"),
    widget("timer", 1240, 240, 560, 280, { seconds: 120 }),
    text(HACKS.map((h, i) => `${i + 1} · ${h}`).join("<br>"), 1240, 560, 560, 330, "note"),
  ]},

  { id: "tra-loi-theo-doi", nav: "Trả lời theo đội", tag: "Vòng 2", blocks: [
    title("Vòng 2 · Cả đội cùng trả lời"),
    text(`<ol><li>Cả lớp úp thẻ hack.</li><li>Mỗi câu là một tình huống mới. Cả đội bàn trong <b>30 giây</b>.</li><li>Hết giờ, cả đội giơ <b>một thẻ A, B, C hoặc D</b>.</li></ol>`, 120, 240, 1680, 460, "lead"),
    text("Câu hỏi không nói đó là hack nào. Đội nghe giảng kỹ sẽ nhận ra. Xếp hạng theo số câu đúng.", 120, 740, 1680, 160, "note"),
  ]},

  quizSlide({
    id: "v2-cau1", nav: "Câu 1", tag: "Vòng 2 · câu 1", round: "chuyengia", questionInTitle: true,
    question: "Minh vừa làm bài Toán vừa nghe bạn bên cạnh kể chuyện. Minh bảo: “Mình vẫn làm được mà.” Điều nào đúng nhất?",
    options: [
      "Minh nói đúng, vì Minh đâu cần quay sang nhìn bạn.",
      "Minh sẽ chậm và dễ sai hơn, vì đầu phải chia chỗ cho câu chuyện, bớt chỗ cho bài toán.",
      "Nghe chuyện giúp não thư giãn, nên Minh sẽ nghĩ ra cách giải nhanh hơn.",
      "Chỉ ảnh hưởng nếu câu chuyện buồn hoặc quá hay.",
    ],
    answer: "B",
  }),
  quizSlide({
    id: "v2-cau2", nav: "Câu 2", tag: "Vòng 2 · câu 2", round: "chuyengia", questionInTitle: true,
    question: "Thứ Sáu bạn phải thuyết trình 2 phút về cây lúa trước lớp, không được nhìn giấy. Chuẩn bị thế nào là tốt nhất?",
    options: [
      "Đọc đi đọc lại bài viết cho đến khi thấy quen.",
      "Chép bài viết ra giấy ba lần cho nhớ.",
      "Tập nói to trước gương, không nhìn giấy; quên chỗ nào thì xem lại chỗ đó rồi nói lại từ đầu.",
      "Nhờ bạn đọc bài cho mình nghe thật nhiều lần.",
    ],
    answer: "C",
  }),
  quizSlide({
    id: "v2-cau3", nav: "Câu 3", tag: "Vòng 2 · câu 3", round: "chuyengia", questionInTitle: true,
    question: "Lan muốn đánh thuộc một bài piano để biểu diễn sau 2 tuần, và có tổng cộng khoảng 3 tiếng để tập. Chia thế nào là tốt nhất?",
    options: [
      "Tập liền 3 tiếng vào ngày cuối, để bài còn mới khi biểu diễn.",
      "Tập 3 tiếng ngay ngày đầu tiên cho thuộc sớm, rồi nghỉ.",
      "Tập hai buổi cuối tuần, mỗi buổi 1,5 tiếng, thức khuya cho xong.",
      "Mỗi ngày tập khoảng 15 phút, rồi đi ngủ đúng giờ.",
    ],
    answer: "D",
  }),
  quizSlide({
    id: "v2-cau4", nav: "Câu 4", tag: "Vòng 2 · câu 4", round: "chuyengia", questionInTitle: true,
    question: "Bạn nghe tiếng Anh khá tốt nhưng viết hay sai chính tả. Tuần sau thi cả nghe và viết. Mỗi tối có 30 phút ôn, cách nào tốt nhất?",
    options: [
      "Dành phần lớn thời gian luyện viết, xen vào vài bài nghe.",
      "Luyện nghe thật nhiều, vì đó là phần chắc chắn được điểm.",
      "Chia đều mỗi tối: 15 phút nghe, 15 phút viết.",
      "Đọc lại các bài viết mẫu cho đến khi thuộc lòng.",
    ],
    answer: "A",
  }),

  { id: "kq2", nav: "Vòng 2 · kết quả", tag: "Vòng 2", blocks: [
    title("Vòng 2 · Kết quả"),
    widget("tally", 120, 200, 1680, 780, { round: "chuyengia", questions: ["v2-cau1", "v2-cau2", "v2-cau3", "v2-cau4"] }),
  ]},

  { id: "chot2", nav: "Vòng 2 · chốt", tag: "Vòng 2", blocks: [
    title("Ai là người học nhiều nhất?"),
    text("Lúc nghe bạn giảng: <b>bậc 1</b>.<br>Lúc tự giảng và trả lời câu hỏi: <b>bậc 4</b>.", 120, 260, 1680, 240, "lead"),
    text("Câu nào đội mình nhận ra hack nhờ nghe bạn giảng, chứ không phải nhờ đọc thẻ? 🙋", 120, 560, 1680, 170, "note"),
    text("Muốn nhớ bài thì hãy làm người giảng: giảng cho bạn, cho em, cho bố mẹ.", 120, 760, 1680, 120, "body"),
  ]},

  { id: "nghi", bg: "red", nav: "Giải lao", tag: "Giải lao", blocks: [
    text("Giải lao", 120, 240, 1600, 170, "h1"),
    text("Lúc nghỉ là lúc chế độ thả lỏng của não làm việc. Nghỉ thật thoải mái nhé.", 120, 450, 1500, 150, "lead"),
    widget("timer", 120, 680, 620, 240, { seconds: 300 }),
  ]},

  /* ===== Phần 3 · Đua ghép thẻ ===== */
  divider("p3", 3, "Đua ghép thẻ", "Không nhìn thẻ, cả đội tự nhớ lại bốn hack"),

  { id: "ghepthe", nav: "Đua ghép thẻ", tag: "Đua ghép thẻ", blocks: [
    title("Đua ghép thẻ trên sàn"),
    text(`<ol><li>Lật 8 thẻ màu đội. <b>Không nhìn thẻ hack.</b></li><li>Mang từng thẻ ra đặt vào đúng ô hack trên sàn.</li><li>Đủ 8 thẻ thì một bạn rung chuông. Đã rung là không được sửa.</li><li>Đi, không chạy. Chạy hoặc chen lấn: −1 điểm.</li></ol>`, 120, 220, 1060, 560, "body"),
    widget("timer", 1240, 230, 560, 280, { seconds: 180 }),
    text("Xếp hạng theo <b>số thẻ đúng</b>.<br>Bằng nhau thì đội rung chuông trước xếp trên.", 1240, 560, 560, 300, "note"),
  ]},

  { id: "kq-ghep", nav: "Ghép thẻ · kết quả", tag: "Đua ghép thẻ", blocks: [
    title("Đua ghép thẻ · Kết quả"),
    widget("roundres", 120, 200, 1680, 780, { round: "ghepthe", label: "Số thẻ đúng", max: 8 }),
  ]},

  { id: "ghepthe-chot", nav: "Ghép thẻ · chốt", tag: "Đua ghép thẻ", blocks: [
    title("Vừa nghỉ xong, vẫn tự nhớ ra"),
    text("Không nhìn thẻ mà vẫn tự lấy được kiến thức ra: đó là <b>bậc 3</b>.", 120, 260, 1680, 200, "lead"),
    text(`Hai hack vừa dùng: <b>${HACKS[1]}</b> và <b>${HACKS[2]}</b>.`, 120, 520, 1680, 150, "note"),
  ]},

  /* ===== Phần 4 · Tòa án AI ===== */
  divider("p3b", 4, "Tòa án AI", "Dùng AI thế nào thì lên thang, thế nào thì tụt xuống"),

  { id: "toaan", nav: "Vòng 3", tag: "Vòng 3", blocks: [
    title("Vòng 3 · Tòa án AI"),
    text(`<ol><li>Xem phần 1: một bạn dùng Gemini và bài xong ngay.</li><li>Đội thẩm phán đoán chuyện gì xảy ra sau đó.</li><li>Đội nói rõ cả dự đoán và lý do vì sao.</li><li>Xem phần 2. Đội khác được kháng cáo nếu thấy lý do còn thiếu.</li></ol>`, 120, 220, 1100, 640, "body"),
    text(`<b>Điểm thẩm phán</b><br>Đúng kết cục: 2<br>Lý do gắn với hack hoặc bậc thang: 1<br><br><b>Kháng cáo</b> được chánh án chấp nhận: 1<br><span class="small">Chánh án: cô Tươi</span>`, 1280, 220, 520, 560, "note"),
  ]},

  { id: "boc-toaan", nav: "Bốc thăm tình huống", tag: "Vòng 3", blocks: [
    title("Bốc thăm tình huống"),
    widget("wheel", 120, 220, 1680, 760, {
      items: TEAMS.map((t) => "Đội " + t.name),
      colors: TEAMS.map((t) => t.color),
      slots: ["Tình huống 1", "Tình huống 2", "Tình huống 3", "Tình huống 4"],
    }),
  ]},

  caseSlide(1),
  caseSlide(2),
  caseSlide(3),
  caseSlide(4),

  { id: "kq-toaan", nav: "Vòng 3 · kết quả", tag: "Vòng 3", blocks: [
    title("Tòa án AI · Kết quả"),
    widget("roundres", 120, 200, 1680, 780, { round: "toaan", label: "Điểm thẩm phán + kháng cáo", max: 4 }),
  ]},

  { id: "toaan-chot", nav: "Vòng 3 · chốt", tag: "Vòng 3", blocks: [
    title("AI kéo xuống hay đẩy lên?"),
    text(`<table class="t"><tr><th>Cách dùng AI</th><th>Bậc</th></tr>
      <tr><td>Đọc bản tóm tắt AI viết sẵn</td><td>1 · kéo xuống</td></tr>
      <tr><td>Chép lời giải của AI</td><td>1 · kéo xuống</td></tr>
      <tr><td>Nhờ AI đố mình, chỉ ra chỗ yếu</td><td>3 · đẩy lên</td></tr>
      <tr><td>Giảng cho AI nghe, cãi lại khi nó sai</td><td>4 · đẩy lên</td></tr></table>`, 120, 220, 1100, 560, "body"),
    text("Bài đều xong cả. Khác nhau là một tuần sau còn nhớ hay không, và điều đó tùy ai là người nghĩ. AI cũng có lúc sai: việc quan trọng thì kiểm tra lại với sách hoặc thầy cô.", 1280, 220, 520, 700, "note"),
  ]},

  /* ===== Phần 5 · Làm slide nhóm ===== */
  divider("p4", 5, "Làm slide nhóm", "Vì sao cô giao bài nhóm, nhìn lại bài cũ, và bắt đầu bài 20/11"),

  { id: "vi-sao", nav: "Vì sao làm slide nhóm", tag: "Vòng 4", blocks: [
    title("Vì sao cô giao bài slide nhóm?"),
    text(`<h3>Tự tìm hiểu</h3>Đọc, chọn ý, viết lại bằng lời của mình. Đó là bậc 3.`, 120, 240, 520, 330, "card"),
    text(`<h3>Giảng cho người khác</h3>Thuyết trình và trả lời câu hỏi của cả lớp. Đó là bậc 4.`, 700, 240, 520, 330, "card"),
    text(`<h3>Làm việc cùng nhau</h3>Chia việc, giữ hạn, nhắc nhau, góp ý cho nhau.`, 1280, 240, 520, 330, "card"),
    text("Đây là những việc người lớn làm hằng ngày ở công ty: tìm hiểu, cùng nhau làm một sản phẩm, rồi trình bày cho người khác hiểu. Slide chỉ là cái vỏ; phần học nằm ở cách cả nhóm làm ra nó.", 120, 620, 1680, 260, "note"),
  ]},

  { id: "nhom", nav: "Giúp hay cản", tag: "Vòng 4", blocks: [
    title("Slide nhóm: giúp học hay cản trở?"),
    text(`<h3>Giúp học khi…</h3><ul><li>Cả nhóm dựng dàn ý trước.</li><li>Mỗi bạn tự tìm hiểu, tự viết phần mình (bậc 3).</li><li>Chia việc rõ, có hạn, nhắc nhau.</li><li>Tập nói, giảng phần mình, góp ý cho nhau (bậc 4).</li></ul>`, 120, 240, 820, 640, "card"),
    text(`<h3>Cản trở khi…</h3><ul><li>Phần lớn thời gian chọn màu, phông, hiệu ứng.</li><li>Chép chữ, ảnh từ mạng hoặc AI (bậc 1–2).</li><li>Một bạn làm hết, các bạn khác ngồi xem.</li><li>Làm cho có, ghép vội phút cuối.</li></ul>`, 980, 240, 820, 640, "card"),
  ]},

  { id: "vanhoadoc", nav: "Nhìn lại Văn hóa đọc", tag: "Vòng 4 · không tính điểm", blocks: [
    title("Nhìn lại bài “Văn hóa đọc”"),
    text("Mỗi bạn tự nghĩ về nhóm mình. Chú đọc từng điểm: nhóm bạn đã làm được thì giơ tay. Quá nửa lớp giơ tay thì chú đánh dấu ✓.", 120, 190, 1680, 120, "body"),
    widget("checkstep", 120, 330, 1680, 650, { items: CHECKLIST }),
  ]},

  { id: "bai2011", nav: "Bài 20/11", tag: "Vòng 4 · 15 phút", blocks: [
    title("Bài 20/11: dựng dàn ý và chia việc"),
    text(`<ol><li>Cùng thống nhất dàn ý: ý chính, thứ tự các slide.</li><li>Mỗi bạn nhận <b>1 phần nội dung</b> và <b>1 việc chung</b>: tạo file và gửi link · slide bìa và kết luận · kiểm tra và chính tả · dẫn buổi tập nói.</li><li>Ghi hạn cạnh tên. Hạn kiểm tra phải sau hạn làm slide.</li><li>Chọn ngày cả nhóm tập nói.</li></ol>`, 120, 220, 1100, 720, "body"),
    widget("timer", 1280, 230, 520, 260, { seconds: 900 }),
    text("Xếp hạng theo <b>số điểm checklist</b> phiếu của đội lo được. Không tính nhanh hay chậm.", 1280, 540, 520, 330, "note"),
  ]},

  { id: "canva", nav: "Demo Canva", tag: "Vòng 4", blocks: [
    title("Làm chung trên Canva"),
    text(`<ol><li>Một file chung cho cả nhóm, gửi link bằng nút <b>Chia sẻ</b>.</li><li>Slide thứ hai là <b>bảng phân công</b>.</li><li>Slide cuối là <b>bảng tiến độ</b>: Cần làm · Đang làm · Xong. Xóa trước khi nộp.</li><li>Chọn một mẫu có sẵn và giữ nguyên. Thời gian để cho nội dung.</li></ol>`, 120, 220, 1680, 560, "lead"),
    text("Canva chỉ là nơi làm chung. Leo được lên bậc nào là do cách cả nhóm chia việc và cố gắng.", 120, 810, 1680, 140, "note"),
  ]},

  /* ===== Phần 6 · Chung kết ===== */
  divider("p5", 6, "Chung kết", "Ba câu khó điểm gấp đôi, rồi mỗi đội tự giải thích một hack"),

  { id: "ck-luat", nav: "Chung kết · luật", tag: "Chung kết", blocks: [
    title("Chung kết · điểm gấp đôi"),
    text(`<ol><li><b>3 câu khó</b>, mỗi câu dùng nhiều hack cùng lúc. Cả đội bàn 30 giây rồi giơ một thẻ A, B, C hoặc D.</li><li>Xếp hạng theo số câu đúng: <b>8 · 6 · 4 · 4</b>.</li><li>Sau đó mỗi đội bốc thăm một hack và <b>tự giải thích</b> hack đó giúp mình leo thang thế nào.</li></ol>`, 120, 240, 1680, 520, "lead"),
  ]},

  quizSlide({
    id: "ck-cau1", nav: "Chung kết 1", tag: "Chung kết · câu 1", heading: "Câu 1", round: "chungket",
    question: "Hôm nay là thứ Bảy. Thứ Tư tuần sau kiểm tra Sinh học. Kế hoạch nào dùng đúng cả bốn hack?",
    options: [
      "Tối thứ Ba ôn ba lượt 25 phút, điện thoại để phòng khác, gấp vở tự đố mình, ôn kỹ câu đã sai.",
      "Bảy, Chủ nhật, thứ Hai mỗi tối 25 phút, điện thoại để phòng khác, gấp vở tự đố mình, ôn kỹ câu đã sai.",
      "Bảy, Chủ nhật, thứ Hai mỗi tối 25 phút, điện thoại để phòng khác, đọc thuộc bản tóm tắt của Gemini.",
      "Bảy, Chủ nhật, thứ Hai mỗi tối 25 phút, điện thoại để phòng khác, gấp vở tự đố, đố lại câu đã thuộc.",
    ],
    answer: "B",
  }),
  quizSlide({
    id: "ck-cau2", nav: "Chung kết 2", tag: "Chung kết · câu 2", heading: "Câu 2", round: "chungket",
    question: "Nhóm bạn làm bài thuyết trình về một loài vật. Cách dùng Gemini nào giúp bạn học được nhiều nhất?",
    options: [
      "Nhờ Gemini viết sẵn phần của mình, rồi sửa vài chữ cho khác đi.",
      "Đọc bản tóm tắt Gemini viết, rồi chép những ý hay vào slide.",
      "Tự viết phần của mình trước, rồi nhờ Gemini hỏi lại 3 câu khó để kiểm tra.",
      "Nhờ Gemini chọn hình đẹp và hiệu ứng để slide nổi bật hơn.",
    ],
    answer: "C",
  }),
  quizSlide({
    id: "ck-cau3", nav: "Chung kết 3", tag: "Chung kết · câu 3", heading: "Câu 3", round: "chungket",
    question: "An và Bình cùng ôn 30 phút. An đọc lại vở rất kỹ và thấy dễ hiểu. Bình gấp vở tự viết ra, thấy khó và sai nhiều chỗ. Một tuần sau, điều nào nhiều khả năng xảy ra nhất?",
    options: [
      "Bình nhớ nhiều hơn, vì lúc thấy khó và sai chính là lúc não đang học.",
      "An nhớ nhiều hơn, vì lúc ôn An thấy bài dễ hiểu hơn.",
      "Hai bạn nhớ như nhau, vì cùng ôn trong 30 phút.",
      "An nhớ nhiều hơn, vì An không bị nhớ nhầm những chỗ đã sai.",
    ],
    answer: "A",
  }),

  { id: "kqck", nav: "Chung kết · kết quả", tag: "Chung kết", blocks: [
    title("Chung kết · Kết quả"),
    widget("tally", 120, 200, 1680, 780, { round: "chungket", questions: ["ck-cau1", "ck-cau2", "ck-cau3"] }),
  ]},

  { id: "datthang", nav: "Giải thích một hack", tag: "Chung kết", blocks: [
    title("Mỗi đội giải thích một hack"),
    widget("wheel", 120, 200, 1100, 780, {
      items: HACKS,
      colors: ["#8E011F", "#BD0129", "#51000C", "#A3485A"],
      slots: TEAMS.map((t) => "Đội " + t.name),
    }),
    text(`<b>30 giây chuẩn bị, 1 phút nói</b><br>Hack này giúp mình leo thang thế nào? Cho một ví dụ của chính các bạn.<br><br><b>Điểm</b><br>Giải thích đúng: 1<br>Có ví dụ của riêng đội: 1`, 1260, 200, 540, 620, "note"),
  ]},

  /* ===== Kết thúc ===== */
  { id: "bangdiem", nav: "Bảng xếp hạng", tag: "Kết quả", blocks: [
    title("Bảng xếp hạng cuối cùng"),
    widget("standings", 120, 240, 1680, 520),
    text("Ai cũng có quà. Thắng chỉ là được chọn trước.", 120, 820, 1680, 100, "note"),
  ]},

  { id: "qua", nav: "Chọn quà", tag: "Quà", blocks: [
    title("Chọn quà"),
    text(`<ol><li>Lượt 1: đội hạng nhất lên chọn, mỗi bạn một món, rồi đến các đội sau.</li><li>Lượt 2: làm lại theo đúng thứ tự đó.</li><li>Trong lúc chờ, viết vào phiếu và mang về nhà:</li></ol>`, 120, 230, 1680, 420, "lead"),
    text("Một môn mình chưa thích: ……………………<br>Hack mình sẽ thử với môn đó trong 7 ngày: ……………………", 120, 680, 1680, 200, "note"),
  ]},

  { id: "camnang", nav: "Cẩm nang mang về", noFooter: true, blocks: [
    text("Hết bài · Nhớ lâu · Hiểu kỹ", 120, 48, 1680, 90, "h2 cst"),
    widget("html", 100, 145, 1720, 850, { html: CHEAT_SHEET_HTML }),
  ]},

  { id: "loiket", bg: "red", nav: "Lời kết", blocks: [
    text("Dở → Tập → Giỏi → Thích", 120, 260, 1680, 160, "big"),
    text("Môn bạn vừa viết có thể đang ở đoạn “dở”. Bốn hack hôm nay giúp bạn đi qua đoạn đó nhanh hơn.", 160, 470, 1600, 180, "lead"),
    text("Hôm nay mới là màn hướng dẫn. Phần còn lại của bản đồ là của các bạn.", 160, 700, 1600, 140, "lead"),
  ]},

  { id: "hoidap", bg: "cream", nav: "Hỏi đáp", blocks: [
    text("Hỏi chú bất cứ điều gì", 120, 320, 1680, 160, "h2"),
    text("Làm game, học, AI, hay chuyện đi làm…", 120, 520, 1680, 100, "lead"),
  ]},
];
