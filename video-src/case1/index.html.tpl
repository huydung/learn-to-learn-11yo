<!doctype html>
<!-- Tình huống 1 · Tiếng Anh: tự đố nhưng dồn một tối → B. Edit this, then: python3 ../tools/build.py case1 -->
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1920, height=1080" />
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.15.0/dist/gsap.min.js"></script>
    <style>
{{raw:base.css}}
      .words { position: absolute; left: 960px; top: 70px; width: 880px; height: 700px; background: #fffdf2; border: 6px solid var(--line);
        border-radius: 14px; box-shadow: 0 16px 40px rgba(0,0,0,.25); padding: 30px 44px; display: grid; grid-template-columns: 1fr 1fr; gap: 6px 30px; align-content: start; }
      .words h3 { grid-column: 1 / 3; font-size: 32px; color: var(--red); letter-spacing: .04em; margin-bottom: 10px; }
      .w { font-size: 40px; font-weight: 600; color: #5e5e5e; display: flex; justify-content: space-between; padding: 6px 12px; border-radius: 10px; }
      .w i { font-style: normal; font-family: "Patrick Hand", cursive; }
      .clockbadge { position: absolute; left: 60px; top: 30px; font-family: "Patrick Hand", cursive; font-size: 64px; color: var(--red); background: #fff;
        border: 5px solid var(--line); border-radius: 20px; padding: 6px 26px; }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="main" data-start="0" data-duration="{{total}}" data-width="1920" data-height="1080">
      <div id="bg"></div>

      <!-- HOME: 9 pm, nothing studied (0 → end of s1) -->
      <div id="home1" class="clip scene" data-start="0" data-duration="{{s1.start+s1.dur}}" data-track-index="1">
        <div class="cam" id="cam1">
          <div class="full">{{inc:room|r1}}</div>
          <div class="at girl" style="left:720px; top:70px; width:480px">{{inc:kid|k1}}</div>
          <div class="at" style="left:0; top:690px; width:1920px">{{inc:desk|d1}}</div>
        </div>
        <div class="ribbon" id="ttl"><span>Tình huống 1</span></div>
        <div class="note-y" id="memo" style="left:1240px; top:150px; width:560px; font-size:48px; line-height:1.3; opacity:0">
          Mai: kiểm tra từ vựng<br><b style="color:var(--red)">Unit 4 · My neighbourhood</b><br>Chưa ôn!</div>
      </div>

      <!-- TABLET: Gemini quiz (s2 + s3) -->
      <div id="tab" class="clip scene" data-start="{{s2.start}}" data-duration="{{s2.dur+s3.dur}}" data-track-index="1">
        <div class="full" style="filter: blur(10px) brightness(.6)">{{inc:room|r2}}</div>
        <div class="cam" id="cam2">
          <div class="tablet">
            <div class="screen">
              <div class="chathead"><svg class="spark" viewBox="0 0 24 24"><defs><linearGradient id="g1" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#4285f4"/><stop offset="1" stop-color="#9b72cb"/></linearGradient></defs><path fill="url(#g1)" d="M12 0C12 7 17 12 24 12C17 12 12 17 12 24C12 17 7 12 0 12C7 12 12 7 12 0Z"/></svg>Gemini</div>
              <div class="ask" id="ask"></div>
              <div class="msg ai" id="m1" style="opacity:0"><svg class="spark" viewBox="0 0 24 24"><path fill="url(#g1)" d="M12 0C12 7 17 12 24 12C17 12 12 17 12 24C12 17 7 12 0 12C7 12 12 7 12 0Z"/></svg>Câu 1/30: “narrow” nghĩa là gì?</div>
              <div class="msg me" id="m2" style="opacity:0">yên tĩnh</div>
              <div class="msg ai" id="m3" style="opacity:0"><svg class="spark" viewBox="0 0 24 24"><path fill="url(#g1)" d="M12 0C12 7 17 12 24 12C17 12 12 17 12 24C12 17 7 12 0 12C7 12 12 7 12 0Z"/></svg>Chưa đúng. Thử lại nhé!</div>
              <div class="msg me" id="m4" style="opacity:0">hẹp</div>
              <div class="msg ai" id="m5" style="opacity:0"><svg class="spark" viewBox="0 0 24 24"><path fill="url(#g1)" d="M12 0C12 7 17 12 24 12C17 12 12 17 12 24C12 17 7 12 0 12C7 12 12 7 12 0Z"/></svg>Đúng rồi!</div>
              <div class="msg ai" id="m6" style="opacity:0"><svg class="spark" viewBox="0 0 24 24"><path fill="url(#g1)" d="M12 0C12 7 17 12 24 12C17 12 12 17 12 24C12 17 7 12 0 12C7 12 12 7 12 0Z"/></svg><span id="qtext">Câu 2/30: “noisy” nghĩa là gì?</span></div>
            </div>
          </div>
          <div class="counter" id="counter" style="opacity:0">1/30</div>
          <svg class="full" viewBox="0 0 1920 1080">
            <g stroke="#3a2e2a" stroke-linecap="round" fill="none">
              <path d="M150 1100 L215 790" stroke-width="80"/><path d="M150 1100 L215 790" stroke="#f4c9a3" stroke-width="68"/>
              <path d="M1770 1100 L1705 790" stroke-width="80"/><path d="M1770 1100 L1705 790" stroke="#f4c9a3" stroke-width="68"/>
            </g>
            <ellipse cx="226" cy="760" rx="46" ry="60" fill="#f4c9a3" stroke="#3a2e2a" stroke-width="6"/>
            <ellipse cx="1694" cy="760" rx="46" ry="60" fill="#f4c9a3" stroke="#3a2e2a" stroke-width="6"/>
          </svg>
        </div>
        <div class="clockbadge" id="clk" style="opacity:0">9:00</div>
      </div>

      <!-- CLASS: the test, 8 points (s4) -->
      <div id="class1" class="clip scene" data-start="{{s4.start}}" data-duration="{{s4.dur}}" data-track-index="1">
        <div class="cam" id="cam4">
          <div class="full">{{inc:classroom|c4}}</div>
          <div class="at" style="left:180px; top:300px; width:300px">{{inc:kid|m4}}</div>
          <div class="at" style="left:120px; top:690px; width:420px">{{inc:classdesk|e41}}</div>
          <div class="at girl" style="left:600px; top:150px; width:440px">{{inc:kid|k4}}</div>
          <div class="at" style="left:520px; top:740px; width:600px">{{inc:classdesk|e42}}</div>
          <div class="at" style="left:1420px; top:120px; width:560px">{{inc:teacher|t4}}</div>
        </div>
        <div class="tickcard" id="tickcard" style="opacity:0">
          <div class="hand">KIỂM TRA TỪ VỰNG · UNIT 4<br>1. narrow – hẹp<br>2. noisy – ồn ào<br>3. cathedral – nhà thờ lớn</div>
          <svg viewBox="0 0 600 400" style="position:absolute; inset:0"><path id="tickpath" d="M380 270 L440 330 L560 190" fill="none" stroke="#bd0129" stroke-width="18" stroke-linecap="round" stroke-linejoin="round" stroke-dasharray="320" stroke-dashoffset="320"/></svg>
          <div class="doodle" id="eight" style="left:440px; top:20px; font-size:120px; opacity:0">8</div>
        </div>
      </div>

      <!-- VOTE (s5) -->
      <div id="vote" data-hold class="clip scene" data-start="{{s5.start}}" data-duration="{{s5.dur}}" data-track-index="1">
        <div class="at girl" style="left:120px; top:330px; width:560px">{{inc:kid|k5}}</div>
        <div class="bubble" id="vb1" style="opacity:0; left:600px; top:470px; width:70px; height:60px"></div>
        <div class="bubble" id="vb2" style="opacity:0; left:660px; top:400px; width:100px; height:86px"></div>
        <div class="cloud" id="vcloud" style="opacity:0">Hai tuần sau, chuyện gì sẽ xảy ra với những từ này? Vì sao?</div>
        <div class="note" id="na" style="opacity:0; left:780px; top:640px; background:#fff6c9; transform:rotate(-3deg); width:480px; font-family:'Patrick Hand', cursive; font-weight:400; font-size:54px">Đoán: …</div>
        <div class="note" id="nb" style="opacity:0; left:1320px; top:660px; background:#e3f0ff; transform:rotate(2deg); width:480px; font-family:'Patrick Hand', cursive; font-weight:400; font-size:54px">Vì sao: …</div>
        <div class="stop" id="stop" style="opacity:0"><span>Dừng video · Các đội đoán và giải thích vì sao</span></div>
      </div>

      <!-- CALENDAR: two weeks (s6) -->
      <div id="week" data-hold class="clip scene" data-start="{{s6.start}}" data-duration="{{s6.dur}}" data-track-index="1">
        <div class="full">{{inc:room|r6}}</div>
        <div class="cal" data-layout-allow-overlap data-layout-allow-occlusion>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p14"><b>Thứ Sáu</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p13"><b>Thứ Năm</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p12"><b>Thứ Tư</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p11"><b>Thứ Ba</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p10"><b>Thứ Hai</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p9"><b>Chủ nhật</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p8"><b>Thứ Bảy</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p7"><b>Thứ Sáu</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p6"><b>Thứ Năm</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p5"><b>Thứ Tư</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p4"><b>Thứ Ba</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p3"><b>Thứ Hai</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p2"><b>Chủ nhật</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p1"><b>Thứ Bảy</b></div>
        </div>
        <div class="ribbon" id="wk" style="top:820px"><span style="opacity:0">Hai tuần sau</span></div>
      </div>

      <!-- CLASS: exam review (s7 → s9) -->
      <div id="review" class="clip scene" data-start="{{s7.start}}" data-duration="{{s7.dur+s8.dur+s9.dur}}" data-track-index="1">
        <div class="cam" id="cam7">
          <div class="full">{{inc:classroom|c7}}</div>
          <div class="at girl" style="left:340px; top:150px; width:440px">{{inc:kid|k7}}</div>
          <div class="at" style="left:260px; top:740px; width:600px">{{inc:classdesk|e7}}</div>
        </div>
        <div class="words" id="words" style="opacity:0">
          <h3>ÔN THI HỌC KỲ · UNIT 4</h3>
          <div class="w" id="w1">narrow <i id="i1" style="opacity:0">✓</i></div><div class="w" id="w2">cathedral <i id="i2" style="opacity:0">?</i></div>
          <div class="w" id="w3">noisy <i id="i3" style="opacity:0">✓</i></div><div class="w" id="w4">convenient <i id="i4" style="opacity:0">?</i></div>
          <div class="w" id="w5">peaceful <i id="i5" style="opacity:0">✓</i></div><div class="w" id="w6">historic <i id="i6" style="opacity:0">?</i></div>
          <div class="w" id="w7">crowded <i id="i7" style="opacity:0">✓</i></div><div class="w" id="w8">railway station <i id="i8" style="opacity:0">?</i></div>
          <div class="w" id="w9">modern <i id="i9" style="opacity:0">✓</i></div><div class="w" id="w10">square <i id="i10" style="opacity:0">?</i></div>
          <div class="w" id="w11">temple <i id="i11" style="opacity:0">✓</i></div><div class="w" id="w12">memorial <i id="i12" style="opacity:0">?</i></div>
        </div>
        <div class="stamp amber" id="stamp" style="opacity:0; left:900px; top:600px; font-size:96px">Nhớ một phần</div>
        <div class="credit" id="credit" style="opacity:0">Nhạc: “Carefree”, Kevin MacLeod (incompetech.com), CC BY 4.0 · Âm thanh lật trang: flag2 (freesound.org), CC BY 4.0</div>
      </div>

      {{captions}}
      {{narration}}

      <audio id="music" class="clip" src="assets/music/carefree.mp3" data-start="0" data-duration="{{total}}" data-media-start="40" data-volume="0.13" data-fade-in="1" data-fade-out="2.5" data-track-index="4"></audio>
      <audio id="x1" class="clip" src="assets/sfx/whoosh-short.m4a" data-start="0.05" data-duration="0.57" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x2" class="clip" src="assets/sfx/pop.m4a" data-start="{{s1.vstart+1.2}}" data-duration="0.72" data-volume="0.4" data-track-index="5"></audio>
      <audio id="x3" class="clip" src="assets/sfx/clock.m4a" data-start="0.6" data-duration="{{s1.start+s1.dur-0.8}}" data-volume="0.18" data-fade-out="0.4" data-track-index="11"></audio>
      <audio id="x4" class="clip" src="assets/sfx/whoosh-short.m4a" data-start="{{s2.start}}" data-duration="0.57" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x5" class="clip" src="assets/sfx/typing.m4a" data-start="{{s2.start+0.7}}" data-duration="1.5" data-volume="0.4" data-track-index="5"></audio>
      <audio id="x6" class="clip" src="assets/sfx/typing.m4a" data-start="{{s2.start+2.2}}" data-duration="1.5" data-volume="0.4" data-track-index="5"></audio>
      <audio id="x7" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.start+0.2}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x8" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.start+0.9}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x9" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.start+1.6}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x10" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.start+2.3}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x11" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.start+3.0}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x12" class="clip" src="assets/sfx/sparkle.m4a" data-start="{{s3.vstart+s3.vdur+0.6}}" data-duration="1.8" data-volume="0.3" data-track-index="7"></audio>
      <audio id="x13" class="clip" src="assets/sfx/whoosh-short.m4a" data-start="{{s4.start}}" data-duration="0.57" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x14" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s4.vstart+1.4}}" data-duration="1.07" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x15" class="clip" src="assets/sfx/sparkle.m4a" data-start="{{s4.vstart+1.9}}" data-duration="1.8" data-volume="0.3" data-track-index="7"></audio>
      <audio id="x16" class="clip" src="assets/sfx/pop.m4a" data-start="{{s5.start+0.6}}" data-duration="0.72" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x17" class="clip" src="assets/sfx/pop.m4a" data-start="{{s5.vstart+s5.vdur-0.5}}" data-duration="0.72" data-volume="0.35" data-track-index="7"></audio>
      <audio id="x18" class="clip" src="assets/sfx/pop.m4a" data-start="{{s5.vstart+s5.vdur-0.1}}" data-duration="0.72" data-volume="0.35" data-track-index="8"></audio>
      <audio id="x20" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s6.start+0.3}}" data-duration="0.95" data-volume="0.5" data-track-index="8"></audio>
      <audio id="x21" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s6.start+1.0}}" data-duration="0.95" data-volume="0.5" data-track-index="9"></audio>
      <audio id="x22" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s6.start+1.7}}" data-duration="0.95" data-volume="0.5" data-track-index="10"></audio>
      <audio id="x23" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s6.start+2.4}}" data-duration="0.95" data-volume="0.5" data-track-index="8"></audio>
      <audio id="x24" class="clip" src="assets/sfx/whoosh.m4a" data-start="{{s7.start}}" data-duration="0.57" data-volume="0.3" data-track-index="5"></audio>
      <audio id="x25" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s7.vstart+0.6}}" data-duration="0.36" data-volume="0.45" data-track-index="6"></audio>
      <audio id="x26" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s7.vstart+1.1}}" data-duration="0.36" data-volume="0.45" data-track-index="6"></audio>
      <audio id="x27" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s7.vstart+1.6}}" data-duration="0.36" data-volume="0.45" data-track-index="6"></audio>
      <audio id="x28" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s8.vstart+0.3}}" data-duration="1.07" data-volume="0.45" data-track-index="6"></audio>
      <audio id="x29" class="clip" src="assets/sfx/stamp.m4a" data-start="{{s9.vstart+0.88}}" data-duration="1.12" data-volume="0.9" data-track-index="5"></audio>
    </div>
    <script>
{{raw:rig.js}}
      // ---------- HOME ----------
      tl.fromTo("#ttl span", { y: -200 }, { y: 0, duration: 0.5, ease: "back.out(1.6)" }, 0);
      tl.to("#ttl span", { y: -260, duration: 0.4, ease: "power2.in" }, 2.0);
      tl.fromTo("#r1_min", { rotation: 0 }, { rotation: 18, duration: {{s1.start+s1.dur}}, ease: "steps(6)", svgOrigin: "0 0" }, 0);
      breathe("k1", 0, {{s1.start+s1.dur}});
      blink("k1", [1.0, 4.4, 7.5]);
      mood("k1", "calm", 0);
      tl.fromTo("#memo", { opacity: 0, y: 200, rotation: 8 }, { opacity: 1, y: 0, rotation: -3, duration: 0.5, ease: "back.out(1.4)", immediateRender: false }, {{s1.vstart+1.2}});
      look("k1", {{s1.vstart+1.4}}, 12);
      pose("k1", "Head", {{s1.vstart+s1.vdur-1.2}});
      mood("k1", "worried", {{s1.vstart+s1.vdur-1.2}});
      push("#cam1", 0, {{s1.start+s1.dur}}, 1.06, -40, 20);

      // ---------- TABLET ----------
      tl.fromTo("#cam2", { y: 300, rotation: 3 }, { y: 0, rotation: 0, duration: 0.6, ease: "power3.out", immediateRender: false }, {{s2.start}});
      const ask = "Đố mình 30 câu từ vựng Unit 4 My neighbourhood, mỗi lần một câu nhé.";
      count("#ask", ask, {{s2.start}} + 0.7, {{s2.vdur}} + 0.4);
      fade("#clk", {{s2.start}} + 0.6);
      ["#m1", "#m2", "#m3", "#m4", "#m5"].forEach((s, i) => tl.fromTo(s, { opacity: 0, y: 16 }, { opacity: 1, y: 0, duration: 0.25, immediateRender: false }, {{s3.start}} + 0.2 + i * 0.7));
      fade("#counter", {{s3.start}} + 3.4); fade("#m6", {{s3.start}} + 3.4, 1, 0.2);
      const words = ["noisy", "crowded", "peaceful", "modern", "temple", "square", "historic", "convenient", "cathedral", "memorial"];
      { const o = { n: 2 }, c = document.querySelector("#counter"), q = document.querySelector("#qtext"), k = document.querySelector("#clk");
        tl.fromTo(o, { n: 2 }, { n: 30, duration: {{s3.dur}} - 3.8, ease: "none", immediateRender: false, onUpdate: () => {
          const n = Math.round(o.n); c.textContent = n + "/30";
          q.textContent = `Câu ${n}/30: “${words[n % words.length]}” nghĩa là gì?`;
          const m = Math.round((n - 1) / 29 * 60); k.textContent = m >= 60 ? "10:00" : "9:" + String(m).padStart(2, "0"); } }, {{s3.start}} + 3.4); }
      push("#cam2", {{s3.start}}, {{s3.dur}} - 0.35, 1.04, 0, -30);

      // ---------- CLASS: 8 ----------
      breathe("k4", {{s4.start}}, {{s4.dur}}); mood("m4", "calm", {{s4.start}});
      pose("t4", "Give", {{s4.start}} + 0.3); mood("t4", "happy", {{s4.start}} + 0.3);
      tl.fromTo("#tickcard", { opacity: 0, scale: 0.7, rotation: -6 }, { opacity: 1, scale: 1, rotation: -3, duration: 0.45, ease: "back.out(1.6)", immediateRender: false }, {{s4.start}} + 0.7);
      tl.to("#tickpath", { strokeDashoffset: 0, duration: 0.5, ease: "power2.inOut" }, {{s4.vstart+1.4}});
      pop("#eight", {{s4.vstart+1.9}});
      mood("k4", "happy", {{s4.vstart+1.9}});
      tl.fromTo("#k4", { y: 0 }, { y: -18, duration: 0.18, yoyo: true, repeat: 1, ease: "power2.out", immediateRender: false }, {{s4.vstart+2.0}});

      // ---------- VOTE ----------
      pose("k5", "Chin", {{s5.start}}); mood("k5", "curious", {{s5.start}}); look("k5", {{s5.start}}, 10);
      breathe("k5", {{s5.start}}, {{s5.dur}}); blink("k5", [{{s5.start}} + 1.4, {{s5.start}} + 4.2]);
      pop("#vb1", {{s5.start}} + 0.2); pop("#vb2", {{s5.start}} + 0.4); pop("#vcloud", {{s5.start}} + 0.6);
      pop("#na", {{s5.vstart+s5.vdur-0.5}}); pop("#nb", {{s5.vstart+s5.vdur-0.1}});
      tl.fromTo("#stop", { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.3, immediateRender: false }, {{s5.vstart+s5.vdur+0.3}});

      // ---------- CALENDAR ----------
      flipPages(["#p1", "#p2", "#p3", "#p4", "#p5", "#p6", "#p7", "#p8", "#p9", "#p10", "#p11", "#p12", "#p13"], {{s6.start}} + 0.3, 0.2);
      tl.fromTo("#wk span", { scale: 0.5, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.4, ease: "back.out(2)", immediateRender: false }, {{s6.start}} + 3.0);

      // ---------- REVIEW ----------
      const R = {{s7.dur+s8.dur+s9.dur}};
      breathe("k7", {{s7.start}}, R); mood("k7", "curious", {{s7.start}}); look("k7", {{s7.start}}, 12);
      tl.fromTo("#words", { opacity: 0, scale: 0.8, rotation: -4 }, { opacity: 1, scale: 1, rotation: -1, duration: 0.45, ease: "back.out(1.4)", immediateRender: false }, {{s7.start}} + 0.3);
      [1, 3, 5, 7, 9, 11].forEach((n, i) => {
        tl.to(`#w${n}`, { color: "#1d6b33", backgroundColor: "#dff3e3", duration: 0.25 }, {{s7.vstart}} + 0.6 + i * 0.25);
        tl.fromTo(`#i${n}`, { opacity: 0 }, { opacity: 1, duration: 0.2, immediateRender: false }, {{s7.vstart}} + 0.6 + i * 0.25);
      });
      [2, 4, 6, 8, 10, 12].forEach((n, i) => {
        tl.fromTo(`#i${n}`, { opacity: 0 }, { opacity: 1, duration: 0.2, immediateRender: false }, {{s7.vstart}} + 2.3 + i * 0.15);
        tl.to(`#w${n}`, { color: "#7a7a7a", duration: 0.25 }, {{s7.vstart}} + 2.3 + i * 0.15);
      });
      mood("k7", "worried", {{s7.vstart}} + 2.6);
      pose("k7", "Write", {{s8.start}});
      writeLoop("k7", {{s8.start}} + 0.2, {{s8.dur+s9.dur}} - 0.4);
      blink("k7", [{{s7.start}} + 1.0, {{s8.start}} + 1.0, {{s9.start}} + 1.2]);
      stampIn("#stamp", {{s9.vstart+0.6}});
      tl.fromTo("#cam7", { x: 0 }, { x: 10, duration: 0.05, yoyo: true, repeat: 3, immediateRender: false }, {{s9.vstart+0.9}});
      fade("#credit", {{s9.vstart+s9.vdur+0.3}}, 1, 0.4);

      window.__timelines["main"] = tl;
    </script>
  </body>
</html>
