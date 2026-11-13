<!doctype html>
<!-- Tình huống 3 · Ngữ văn: AI chỉ lỗi, mình tự sửa → A. Edit this, then: python3 ../tools/build.py case3 -->
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1920, height=1080" />
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.15.0/dist/gsap.min.js"></script>
    <style>
{{raw:base.css}}
      .essay { position: absolute; left: 1010px; top: 70px; width: 840px; background: #fffdf2; border: 6px solid var(--line); border-radius: 12px;
        box-shadow: 0 16px 40px rgba(0,0,0,.25); padding: 26px 40px 30px; font-family: "Patrick Hand", cursive; font-size: 40px; line-height: 1.5; color: #33446b; }
      .essay h4 { font-family: "Be Vietnam Pro", sans-serif; font-size: 28px; color: var(--red); letter-spacing: .04em; margin-bottom: 6px; }
      .rat { position: relative; }
      .rat s { text-decoration: none; position: relative; }
      .rat .x { position: absolute; left: -4px; right: -4px; top: 50%; height: 5px; background: #d32f2f; transform-origin: 0 50%; }
      .fix { color: #d32f2f; }
      .points { list-style: none; }
      .points li { margin-top: 14px; font-size: 32px; line-height: 1.4; }
      .check { position: absolute; left: 1060px; top: 50px; width: 780px; background: #fff; border: 6px solid var(--line); border-radius: 40px;
        padding: 30px 44px; font-size: 40px; font-weight: 600; }
      .check div { display: flex; gap: 20px; align-items: center; margin: 8px 0; }
      .box { width: 52px; height: 52px; border: 5px solid var(--line); border-radius: 10px; position: relative; flex: none; }
      .box b { position: absolute; left: 4px; top: -18px; font-size: 64px; color: #2e8b47; }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="main" data-start="0" data-duration="{{total}}" data-width="1920" data-height="1080">
      <div id="bg"></div>

      <!-- HOME: essay finished (0 → end of s1) -->
      <div id="home1" class="clip scene" data-start="0" data-duration="{{s1.start+s1.dur}}" data-track-index="1">
        <div class="cam" id="cam1">
          <div class="full">{{inc:room|r1}}</div>
          <div class="at" style="left:720px; top:70px; width:480px">{{inc:kid|k1}}</div>
          <div class="at" style="left:0; top:690px; width:1920px">{{inc:desk|d1}}</div>
        </div>
        <div class="ribbon" id="ttl"><span>Tình huống 3</span></div>
        <div class="essay" id="essay1" style="opacity:0">
          <h4>BÀI VĂN · KỂ LẠI MỘT TRẢI NGHIỆM</h4>
          Chuyến về quê ngoại<br>
          Hè vừa rồi em được về quê. Quê em rất đẹp, rất yên bình. Bà em rất hiền, nấu ăn rất ngon…
        </div>
      </div>

      <!-- TABLET: ask for weak spots (s2 + s3) -->
      <div id="tab" class="clip scene" data-start="{{s2.start}}" data-duration="{{s2.dur+s3.dur}}" data-track-index="1">
        <div class="full" style="filter: blur(10px) brightness(.6)">{{inc:room|r2}}</div>
        <div class="cam" id="cam2">
          <div class="tablet">
            <div class="screen">
              <div class="chathead"><svg class="spark" viewBox="0 0 24 24"><defs><linearGradient id="g1" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#4285f4"/><stop offset="1" stop-color="#9b72cb"/></linearGradient></defs><path fill="url(#g1)" d="M12 0C12 7 17 12 24 12C17 12 12 17 12 24C12 17 7 12 0 12C7 12 12 7 12 0Z"/></svg>Gemini</div>
              <div class="ask" id="ask"></div>
              <div class="msg ai"><svg class="spark" viewBox="0 0 24 24"><path fill="url(#g1)" d="M12 0C12 7 17 12 24 12C17 12 12 17 12 24C12 17 7 12 0 12C7 12 12 7 12 0Z"/></svg>
                <ul class="points">
                  <li id="pt0" style="opacity:0; margin-top:0">Bài của bạn có ba chỗ nên sửa:</li>
                  <li id="pt1" style="opacity:0"><b>1.</b> Mở bài dài sáu câu, chưa vào thẳng câu chuyện.</li>
                  <li id="pt2" style="opacity:0"><b>2.</b> Chữ “rất” lặp lại chín lần.</li>
                  <li id="pt3" style="opacity:0"><b>3.</b> Kết bài chưa nói em cảm thấy thế nào.</li>
                  <li id="pt4" style="opacity:0">Bạn thử tự sửa nhé!</li>
                </ul>
              </div>
            </div>
          </div>
          <svg class="full" viewBox="0 0 1920 1080">
            <g stroke="#3a2e2a" stroke-linecap="round" fill="none">
              <path d="M150 1100 L215 790" stroke-width="80"/><path d="M150 1100 L215 790" stroke="#f4c9a3" stroke-width="68"/>
              <path d="M1770 1100 L1705 790" stroke-width="80"/><path d="M1770 1100 L1705 790" stroke="#f4c9a3" stroke-width="68"/>
            </g>
            <ellipse cx="226" cy="760" rx="46" ry="60" fill="#f4c9a3" stroke="#3a2e2a" stroke-width="6"/>
            <ellipse cx="1694" cy="760" rx="46" ry="60" fill="#f4c9a3" stroke="#3a2e2a" stroke-width="6"/>
          </svg>
        </div>
      </div>

      <!-- HOME: fixing it himself (s4) -->
      <div id="home2" class="clip scene" data-start="{{s4.start}}" data-duration="{{s4.dur}}" data-track-index="1">
        <div class="cam" id="cam3">
          <div class="full">{{inc:room|r3}}</div>
          <div class="at" style="left:560px; top:70px; width:480px">{{inc:kid|k3}}</div>
          <div class="at" style="left:-160px; top:690px; width:1920px">{{inc:desk|d3}}</div>
          <div class="doodle" id="forty" style="left:1260px; top:110px; opacity:0">+20 phút</div>
        </div>
        <div class="essay" id="essay2" style="opacity:0; top:320px">
          <h4>SỬA BÀI</h4>
          Quê em <span class="rat"><s>rất</s><span class="x" data-layout-allow-occlusion id="sx1"></span></span> đẹp<span class="fix" id="f1" style="opacity:0">, cánh đồng lúa xanh mướt</span>. Bà em <span class="rat"><s>rất</s><span class="x" data-layout-allow-occlusion id="sx2"></span></span> hiền<span class="fix" id="f2" style="opacity:0">, lúc nào cũng cười</span>…
        </div>
      </div>

      <!-- CLASS: praised (s5) -->
      <div id="class1" class="clip scene" data-start="{{s5.start}}" data-duration="{{s5.dur}}" data-track-index="1">
        <div class="cam" id="cam4">
          <div class="full">{{inc:classroom|c4}}</div>
          <div class="at girl" style="left:180px; top:300px; width:300px">{{inc:kid|m4}}</div>
          <div class="at" style="left:120px; top:690px; width:420px">{{inc:classdesk|e41}}</div>
          <div class="at" style="left:600px; top:150px; width:440px">{{inc:kid|k4}}</div>
          <div class="at" style="left:520px; top:740px; width:600px">{{inc:classdesk|e42}}</div>
          <div class="at" style="left:1420px; top:120px; width:560px">{{inc:teacher|t4}}</div>
        </div>
        <div class="tickcard" id="tickcard" style="opacity:0">
          <div class="hand">…Chia tay bà, em thấy nhớ<br>quê ngay từ lúc lên xe.</div>
          <svg viewBox="0 0 600 400" style="position:absolute; inset:0"><path id="tickpath" d="M60 250 L120 310 L240 170" fill="none" stroke="#bd0129" stroke-width="18" stroke-linecap="round" stroke-linejoin="round" stroke-dasharray="320" stroke-dashoffset="320"/></svg>
          <div class="doodle" id="praise" style="left:270px; top:220px; font-size:52px; opacity:0">Kết bài cảm động!</div>
        </div>
      </div>

      <!-- VOTE (s6) -->
      <div id="vote" data-hold class="clip scene" data-start="{{s6.start}}" data-duration="{{s6.dur}}" data-track-index="1">
        <div class="at" style="left:120px; top:330px; width:560px">{{inc:kid|k5}}</div>
        <div class="bubble" id="vb1" style="opacity:0; left:600px; top:470px; width:70px; height:60px"></div>
        <div class="bubble" id="vb2" style="opacity:0; left:660px; top:400px; width:100px; height:86px"></div>
        <div class="cloud" id="vcloud" style="opacity:0">Tuần sau viết bài mới, chuyện gì sẽ xảy ra? Vì sao?</div>
        <div class="note" id="na" style="opacity:0; left:780px; top:640px; background:#fff6c9; transform:rotate(-3deg); width:480px; font-family:'Patrick Hand', cursive; font-weight:400; font-size:54px">Đoán: …</div>
        <div class="note" id="nb" style="opacity:0; left:1320px; top:660px; background:#e3f0ff; transform:rotate(2deg); width:480px; font-family:'Patrick Hand', cursive; font-weight:400; font-size:54px">Vì sao: …</div>
        <div class="stop" id="stop" style="opacity:0"><span>Dừng video · Các đội đoán và giải thích vì sao</span></div>
      </div>

      <!-- CALENDAR (s7) -->
      <div id="week" data-hold class="clip scene" data-start="{{s7.start}}" data-duration="{{s7.dur}}" data-track-index="1">
        <div class="full">{{inc:room|r6}}</div>
        <div class="cal" data-layout-allow-overlap data-layout-allow-occlusion>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p7"><b>Thứ Hai</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p6"><b>Chủ nhật</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p5"><b>Thứ Bảy</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p4"><b>Thứ Sáu</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p3"><b>Thứ Năm</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p2"><b>Thứ Tư</b></div>
          <div class="page" data-layout-allow-occlusion data-layout-allow-overlap id="p1"><b>Thứ Ba</b></div>
        </div>
        <div class="ribbon" id="wk" style="top:820px"><span style="opacity:0">Một tuần sau</span></div>
      </div>

      <!-- CLASS: new essay in class (s8 → s10) -->
      <div id="class2" class="clip scene" data-start="{{s8.start}}" data-duration="{{s8.dur+s9.dur+s10.dur}}" data-track-index="1">
        <div class="cam" id="cam7">
          <div class="full">{{inc:classroom|c7}}</div>
          <div class="at girl" style="left:60px; top:300px; width:300px">{{inc:kid|m7}}</div>
          <div class="at" style="left:0px; top:690px; width:420px">{{inc:classdesk|e71}}</div>
          <div class="at" style="left:440px; top:150px; width:440px">{{inc:kid|k7}}</div>
          <div class="at" style="left:360px; top:740px; width:600px">{{inc:classdesk|e72}}</div>
        </div>
        <div class="bubble" id="tb1" style="opacity:0; left:880px; top:300px; width:60px; height:50px"></div>
        <div class="bubble" id="tb2" style="opacity:0; left:950px; top:220px; width:90px; height:76px"></div>
        <div class="check" id="check" style="opacity:0">
          <div><span class="box" data-layout-allow-overflow><b id="c1" style="opacity:0">✓</b></span>Mở bài ngắn</div>
          <div><span class="box" data-layout-allow-overflow><b id="c2" style="opacity:0">✓</b></span>Bớt chữ “rất”</div>
          <div><span class="box" data-layout-allow-overflow><b id="c3" style="opacity:0">✓</b></span>Kết bài có cảm xúc</div>
        </div>
        <div class="stamp green" id="stamp" style="opacity:0; left:1100px; top:520px">Nhớ</div>
        <div class="credit" id="credit" style="opacity:0">Nhạc: “Carefree”, Kevin MacLeod (incompetech.com), CC BY 4.0 · Âm thanh lật trang: flag2 (freesound.org), CC BY 4.0</div>
      </div>

      {{captions}}
      {{narration}}

      <audio id="music" class="clip" src="assets/music/carefree.mp3" data-start="0" data-duration="{{total}}" data-media-start="80" data-volume="0.13" data-fade-in="1" data-fade-out="2.5" data-track-index="4"></audio>
      <audio id="x1" class="clip" src="assets/sfx/whoosh-short.m4a" data-start="0.05" data-duration="0.57" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x2" class="clip" src="assets/sfx/pencil.m4a" data-start="0.4" data-duration="1.07" data-volume="0.45" data-track-index="6"></audio>
      <audio id="x3" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s1.vstart+1.0}}" data-duration="0.95" data-volume="0.5" data-track-index="5"></audio>
      <audio id="x4" class="clip" src="assets/sfx/whoosh-short.m4a" data-start="{{s2.start}}" data-duration="0.57" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x5" class="clip" src="assets/sfx/typing.m4a" data-start="{{s2.start+0.7}}" data-duration="1.5" data-volume="0.4" data-track-index="5"></audio>
      <audio id="x6" class="clip" src="assets/sfx/typing.m4a" data-start="{{s2.start+2.2}}" data-duration="1.5" data-volume="0.4" data-track-index="5"></audio>
      <audio id="x7" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.vstart+0.2}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x8" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.vstart+1.4}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x9" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.vstart+2.6}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x10" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.vstart+3.8}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x11" class="clip" src="assets/sfx/whoosh.m4a" data-start="{{s4.start}}" data-duration="0.57" data-volume="0.3" data-track-index="5"></audio>
      <audio id="x12" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s4.start+0.7}}" data-duration="1.07" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x13" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s4.start+2.0}}" data-duration="1.07" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x14" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s4.start+3.3}}" data-duration="1.07" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x15" class="clip" src="assets/sfx/clock.m4a" data-start="{{s4.start+0.5}}" data-duration="{{s4.dur-0.7}}" data-volume="0.2" data-fade-out="0.4" data-track-index="11"></audio>
      <audio id="x16" class="clip" src="assets/sfx/whoosh-short.m4a" data-start="{{s5.start}}" data-duration="0.57" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x17" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s5.vstart+1.2}}" data-duration="1.07" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x18" class="clip" src="assets/sfx/sparkle.m4a" data-start="{{s5.vstart+1.8}}" data-duration="1.8" data-volume="0.3" data-track-index="7"></audio>
      <audio id="x19" class="clip" src="assets/sfx/pop.m4a" data-start="{{s6.start+0.6}}" data-duration="0.72" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x20" class="clip" src="assets/sfx/pop.m4a" data-start="{{s6.vstart+s6.vdur-0.5}}" data-duration="0.72" data-volume="0.35" data-track-index="7"></audio>
      <audio id="x21" class="clip" src="assets/sfx/pop.m4a" data-start="{{s6.vstart+s6.vdur-0.1}}" data-duration="0.72" data-volume="0.35" data-track-index="8"></audio>
      <audio id="x23" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s7.start+0.4}}" data-duration="0.95" data-volume="0.5" data-track-index="8"></audio>
      <audio id="x24" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s7.start+1.12}}" data-duration="0.95" data-volume="0.5" data-track-index="9"></audio>
      <audio id="x25" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s7.start+1.84}}" data-duration="0.95" data-volume="0.5" data-track-index="10"></audio>
      <audio id="x26" class="clip" src="assets/sfx/whoosh.m4a" data-start="{{s8.start}}" data-duration="0.57" data-volume="0.3" data-track-index="5"></audio>
      <audio id="x27" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s8.start+0.4}}" data-duration="1.07" data-volume="0.4" data-track-index="11"></audio>
      <audio id="x28" class="clip" src="assets/sfx/pop.m4a" data-start="{{s8.vstart+1.4}}" data-duration="0.72" data-volume="0.4" data-track-index="6"></audio>
      <audio id="x29" class="clip" src="assets/sfx/pop.m4a" data-start="{{s8.vstart+3.0}}" data-duration="0.72" data-volume="0.4" data-track-index="7"></audio>
      <audio id="x30" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s9.start+0.2}}" data-duration="1.07" data-volume="0.4" data-track-index="11"></audio>
      <audio id="x31" class="clip" src="assets/sfx/pop.m4a" data-start="{{s9.vstart+2.0}}" data-duration="0.72" data-volume="0.4" data-track-index="6"></audio>
      <audio id="x32" class="clip" src="assets/sfx/sparkle.m4a" data-start="{{s9.vstart+2.2}}" data-duration="1.8" data-volume="0.3" data-track-index="8"></audio>
      <audio id="x33" class="clip" src="assets/sfx/stamp.m4a" data-start="{{s10.vstart+0.88}}" data-duration="1.12" data-volume="0.9" data-track-index="5"></audio>
    </div>
    <script>
{{raw:rig.js}}
      // ---------- HOME: essay done ----------
      tl.fromTo("#ttl span", { y: -200 }, { y: 0, duration: 0.5, ease: "back.out(1.6)" }, 0);
      tl.to("#ttl span", { y: -260, duration: 0.4, ease: "power2.in" }, 2.0);
      pose("k1", "Write", -0.01); mood("k1", "calm", 0);
      writeLoop("k1", 0.1, {{s1.vstart+1.0}});
      breathe("k1", 0, {{s1.start+s1.dur}});
      [1, 2, 3].forEach((i) => tl.to(`#d1_w${i}`, { opacity: 1, duration: 0.2 }, 0.3 + i * 0.6));
      tl.fromTo("#essay1", { opacity: 0, y: 220, rotation: 6 }, { opacity: 1, y: 0, rotation: -2, duration: 0.5, ease: "power3.out", immediateRender: false }, {{s1.vstart+1.0}});
      pose("k1", "Desk", {{s1.vstart+1.2}}); mood("k1", "happy", {{s1.vstart+1.4}});
      blink("k1", [1.2, 4.6, 7.8]);
      push("#cam1", 0, {{s1.start+s1.dur}}, 1.05, -30, 20);

      // ---------- TABLET ----------
      tl.fromTo("#cam2", { y: 300, rotation: 3 }, { y: 0, rotation: 0, duration: 0.6, ease: "power3.out", immediateRender: false }, {{s2.start}});
      const ask = "Đọc bài văn của mình và chỉ ra 3 chỗ còn yếu. Đừng viết lại hộ mình nhé.";
      count("#ask", ask, {{s2.start}} + 0.7, {{s2.vdur}} + 0.6);
      [0, 1, 2, 3, 4].forEach((i) => tl.fromTo(`#pt${i}`, { opacity: 0, y: 14 }, { opacity: 1, y: 0, duration: 0.3, immediateRender: false }, {{s3.vstart}} + 0.2 + i * 1.2 - (i === 4 ? 0.6 : 0)));
      push("#cam2", {{s3.vstart}}, {{s3.dur}} - 0.35, 1.04, 0, -30);

      // ---------- HOME: fixing ----------
      pose("k3", "Write", {{s4.start}} - 0.05); mood("k3", "worried", {{s4.start}}); look("k3", {{s4.start}}, 12);
      writeLoop("k3", {{s4.start}} + 0.2, {{s4.dur}} - 0.4);
      tl.fromTo("#essay2", { opacity: 0, y: 200 }, { opacity: 1, y: 0, duration: 0.45, ease: "power3.out", immediateRender: false }, {{s4.start}} + 0.3);
      tl.fromTo("#sx1", { scaleX: 0 }, { scaleX: 1, duration: 0.3, immediateRender: true }, {{s4.start}} + 0.9);
      fade("#f1", {{s4.start}} + 1.3, 1, 0.4);
      tl.fromTo("#sx2", { scaleX: 0 }, { scaleX: 1, duration: 0.3, immediateRender: true }, {{s4.start}} + 2.3);
      fade("#f2", {{s4.start}} + 2.7, 1, 0.4);
      tl.fromTo("#r3_min", { rotation: 0 }, { rotation: 120, duration: 3.2, ease: "steps(8)", svgOrigin: "0 0", immediateRender: false }, {{s4.start}} + 0.5);
      tl.fromTo("#r3_hour", { rotation: 0 }, { rotation: 10, duration: 3.2, ease: "none", svgOrigin: "0 0", immediateRender: false }, {{s4.start}} + 0.5);
      pop("#forty", {{s4.vstart+2.0}});
      tl.fromTo("#k3_head", { y: 0 }, { y: 10, duration: 0.4, yoyo: true, repeat: 1, ease: "sine.inOut", immediateRender: false }, {{s4.vstart+3.0}});
      mood("k3", "calm", {{s4.vstart+3.8}});
      blink("k3", [{{s4.start}} + 1.5, {{s4.start}} + 4.2]);

      // ---------- CLASS: praised ----------
      breathe("k4", {{s5.start}}, {{s5.dur}}); mood("m4", "calm", {{s5.start}});
      pose("t4", "Give", {{s5.start}} + 0.3); mood("t4", "happy", {{s5.start}} + 0.3);
      tl.fromTo("#tickcard", { opacity: 0, scale: 0.7, rotation: -6 }, { opacity: 1, scale: 1, rotation: -3, duration: 0.45, ease: "back.out(1.6)", immediateRender: false }, {{s5.start}} + 0.7);
      tl.to("#tickpath", { strokeDashoffset: 0, duration: 0.5, ease: "power2.inOut" }, {{s5.vstart+1.2}});
      pop("#praise", {{s5.vstart+1.8}});
      mood("k4", "happy", {{s5.vstart+1.8}});
      tl.fromTo("#k4", { y: 0 }, { y: -18, duration: 0.18, yoyo: true, repeat: 1, ease: "power2.out", immediateRender: false }, {{s5.vstart+1.9}});

      // ---------- VOTE ----------
      pose("k5", "Chin", {{s6.start}}); mood("k5", "curious", {{s6.start}}); look("k5", {{s6.start}}, 10);
      breathe("k5", {{s6.start}}, {{s6.dur}}); blink("k5", [{{s6.start}} + 1.4, {{s6.start}} + 4.2]);
      pop("#vb1", {{s6.start}} + 0.2); pop("#vb2", {{s6.start}} + 0.4); pop("#vcloud", {{s6.start}} + 0.6);
      pop("#na", {{s6.vstart+s6.vdur-0.5}}); pop("#nb", {{s6.vstart+s6.vdur-0.1}});
      tl.fromTo("#stop", { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.3, immediateRender: false }, {{s6.vstart+s6.vdur+0.3}});

      // ---------- CALENDAR ----------
      flipPages(["#p1", "#p2", "#p3", "#p4", "#p5", "#p6"], {{s7.start}} + 0.4, 0.36);
      tl.fromTo("#wk span", { scale: 0.5, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.4, ease: "back.out(2)", immediateRender: false }, {{s7.start}} + 2.7);

      // ---------- CLASS: new essay ----------
      const R = {{s8.dur+s9.dur+s10.dur}};
      pose("k7", "Write", {{s8.start}} - 0.05); pose("m7", "Write", {{s8.start}} - 0.05);
      writeLoop("k7", {{s8.start}} + 0.1, R - 0.3); writeLoop("m7", {{s8.start}} + 0.2, R - 0.4);
      mood("k7", "calm", {{s8.start}}); mood("m7", "calm", {{s8.start}});
      pop("#tb1", {{s8.start}} + 0.4); pop("#tb2", {{s8.start}} + 0.6); pop("#check", {{s8.start}} + 0.8);
      tick("#c1", {{s8.vstart+1.4}}); tick("#c2", {{s8.vstart+3.0}});
      tick("#c3", {{s9.vstart+2.0}});
      mood("k7", "happy", {{s9.vstart+2.0}});
      blink("k7", [{{s8.start}} + 1.0, {{s9.start}} + 0.8, {{s10.start}} + 1.0]);
      push("#cam7", {{s8.start}}, R, 1.06, -40, 20);
      stampIn("#stamp", {{s10.vstart+0.6}});
      fade("#credit", {{s10.vstart+s10.vdur+0.3}}, 1, 0.4);

      window.__timelines["main"] = tl;
    </script>
  </body>
</html>
