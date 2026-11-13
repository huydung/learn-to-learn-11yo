<!doctype html>
<!-- Tình huống 4 · Giáo dục địa phương: AI dùng số liệu cũ về Hà Nội → C (điểm thấp). Edit this, then: python3 ../tools/build.py case4 -->
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1920, height=1080" />
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.15.0/dist/gsap.min.js"></script>
    <style>
{{raw:base.css}}
      .facts { list-style: none; }
      .facts li { margin-top: 16px; font-size: 34px; line-height: 1.4; }
      .poster { position: absolute; background: #fffdf2; border: 6px solid var(--line); border-radius: 12px; box-shadow: 0 16px 40px rgba(0,0,0,.25);
        font-family: "Patrick Hand", cursive; color: #33446b; }
      .poster h2 { font-family: "Merriweather", serif; font-weight: 900; color: var(--red); }
      .poster .src { color: #6a6a6a; }
      .mark { position: absolute; font-family: "Patrick Hand", cursive; font-size: 80px; line-height: 1; }
      .news { position: absolute; left: 380px; top: 40px; width: 1000px; background: #fff; border: 6px solid var(--line); border-radius: 16px;
        box-shadow: 0 16px 40px rgba(0,0,0,.25); padding: 26px 40px; font-size: 38px; line-height: 1.45; }
      .news .tag { font-size: 26px; font-weight: 700; color: #fff; background: var(--red); display: inline-block; padding: 4px 16px; border-radius: 8px; margin-bottom: 10px; }
      .note.wide { width: 380px; }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="main" data-start="0" data-duration="{{total}}" data-width="1920" data-height="1080">
      <div id="bg"></div>

      <!-- CLASS: the task (0 → end of s1) -->
      <div id="class0" class="clip scene" data-start="0" data-duration="{{s1.start+s1.dur}}" data-track-index="1">
        <div class="cam" id="cam0">
          <div class="full">{{inc:classroom|c0}}</div>
          <div class="at" style="left:200px; top:300px; width:300px">{{inc:kid|m0}}</div>
          <div class="at" style="left:140px; top:690px; width:420px">{{inc:classdesk|e01}}</div>
          <div class="at girl" style="left:620px; top:150px; width:440px">{{inc:kid|k0}}</div>
          <div class="at" style="left:540px; top:740px; width:600px">{{inc:classdesk|e02}}</div>
          <div class="at" style="left:1420px; top:120px; width:560px">{{inc:teacher|t0}}</div>
        </div>
        <div class="ribbon" id="ttl"><span>Tình huống 4</span></div>
        <div class="paper" id="sheet1" style="left:960px; top:110px; width:880px; opacity:0">
          <div class="tag">GIÁO DỤC ĐỊA PHƯƠNG · HÀ NỘI</div>
          Tìm hiểu về Hà Nội: diện tích, các đơn vị hành chính, các thành phố trực thuộc trung ương.<br>
          <b>Dùng số liệu mới nhất, ghi rõ nguồn.</b>
        </div>
      </div>

      <!-- TABLET: three facts (s2 + s3) -->
      <div id="tab" class="clip scene" data-start="{{s2.start}}" data-duration="{{s2.dur+s3.dur}}" data-track-index="1">
        <div class="full" style="filter: blur(10px) brightness(.6)">{{inc:room|r2}}</div>
        <div class="cam" id="cam2">
          <div class="tablet">
            <div class="screen">
              <div class="chathead"><svg class="spark" viewBox="0 0 24 24"><defs><linearGradient id="g1" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#4285f4"/><stop offset="1" stop-color="#9b72cb"/></linearGradient></defs><path fill="url(#g1)" d="M12 0C12 7 17 12 24 12C17 12 12 17 12 24C12 17 7 12 0 12C7 12 12 7 12 0Z"/></svg>Gemini</div>
              <div class="ask" id="ask"></div>
              <div class="msg ai"><svg class="spark" viewBox="0 0 24 24"><path fill="url(#g1)" d="M12 0C12 7 17 12 24 12C17 12 12 17 12 24C12 17 7 12 0 12C7 12 12 7 12 0Z"/></svg>
                <ul class="facts">
                  <li id="f0" style="opacity:0; margin-top:0">Đây là 3 thông tin chính về Hà Nội:</li>
                  <li id="f1" style="opacity:0"><b>1.</b> Hà Nội là thủ đô của Việt Nam, diện tích khoảng 3.360 km².</li>
                  <li id="f2" style="opacity:0"><b>2.</b> Hà Nội có 30 quận, huyện và thị xã.</li>
                  <li id="f3" style="opacity:0"><b>3.</b> Hà Nội là một trong 5 thành phố trực thuộc trung ương của cả nước.</li>
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

      <!-- HOME: copying onto the poster (s4) -->
      <div id="home2" class="clip scene" data-start="{{s4.start}}" data-duration="{{s4.dur}}" data-track-index="1">
        <div class="cam" id="cam3">
          <div class="full">{{inc:room|r3}}</div>
          <div class="at girl" style="left:520px; top:70px; width:480px">{{inc:kid|k3}}</div>
          <div class="at" style="left:-200px; top:690px; width:1920px">{{inc:desk|d3}}</div>
        </div>
        <div class="poster" id="poster1" style="left:1060px; top:80px; width:780px; padding:24px 40px; font-size:38px; line-height:1.45; opacity:0">
          <h2 style="font-size:60px">HÀ NỘI</h2>
          <div id="pl1" style="opacity:0">1. Thủ đô, rộng khoảng 3.360 km².</div>
          <div id="pl2" style="opacity:0">2. Có 30 quận, huyện, thị xã.</div>
          <div id="pl3" style="opacity:0">3. Một trong 5 thành phố trực thuộc trung ương.</div>
          <div class="src" id="pl4" style="opacity:0">Nguồn: Gemini</div>
        </div>
      </div>

      <!-- VOTE (s5): this case asks about the score -->
      <div id="vote" data-hold class="clip scene" data-start="{{s5.start}}" data-duration="{{s5.dur}}" data-track-index="1">
        <div class="at girl" style="left:120px; top:330px; width:560px">{{inc:kid|k5}}</div>
        <div class="bubble" id="vb1" style="opacity:0; left:600px; top:470px; width:70px; height:60px"></div>
        <div class="bubble" id="vb2" style="opacity:0; left:660px; top:400px; width:100px; height:86px"></div>
        <div class="cloud" id="vcloud" style="opacity:0">Một tuần sau bạn ấy lên thuyết trình, chuyện gì sẽ xảy ra? Vì sao?</div>
        <div class="note" id="na" style="opacity:0; left:780px; top:640px; background:#fff6c9; transform:rotate(-3deg); width:480px; font-family:'Patrick Hand', cursive; font-weight:400; font-size:54px">Đoán: …</div>
        <div class="note" id="nb" style="opacity:0; left:1320px; top:660px; background:#e3f0ff; transform:rotate(2deg); width:480px; font-family:'Patrick Hand', cursive; font-weight:400; font-size:54px">Vì sao: …</div>
        <div class="stop" id="stop" style="opacity:0"><span>Dừng video · Các đội đoán và giải thích vì sao</span></div>
      </div>

      <!-- CALENDAR (s6) -->
      <div id="week" data-hold class="clip scene" data-start="{{s6.start}}" data-duration="{{s6.dur}}" data-track-index="1">
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

      <!-- CLASS: the presentation (s7 → s11) -->
      <div id="present" class="clip scene" data-start="{{s7.start}}" data-duration="{{s7.dur+s8.dur+s9.dur+s10.dur+s11.dur}}" data-track-index="1">
        <div class="cam" id="cam7">
          <div class="full">{{inc:classroom|c7}}</div>
          <div class="at" style="left:900px; top:320px; width:300px">{{inc:kid|m7}}</div>
          <div class="at" style="left:840px; top:700px; width:420px">{{inc:classdesk|e71}}</div>
          <div class="at girl" style="left:620px; top:420px; width:280px">{{inc:kid|m8}}</div>
          <div class="at" style="left:560px; top:760px; width:400px">{{inc:classdesk|e72}}</div>
          <div class="at girl" style="left:110px; top:170px; width:360px">{{inc:kid|k7}}</div>
          <div class="poster" id="poster2" style="left:70px; top:470px; width:440px; padding:14px 22px; font-size:26px; line-height:1.4; transform:rotate(-2deg)">
            <h2 style="font-size:40px">HÀ NỘI</h2>
            <div>1. Thủ đô, rộng khoảng 3.360 km².</div>
            <div>2. Có 30 quận, huyện, thị xã.</div>
            <div>3. Một trong 5 thành phố trực thuộc trung ương.</div>
          </div>
          <div class="at" style="left:1480px; top:120px; width:420px">{{inc:teacher|t7}}</div>
        </div>
        <div class="say" id="ask2" style="left:1000px; top:110px; width:560px; opacity:0">Hà Nội bây giờ đâu còn quận, huyện nữa?</div>
        <div class="news" id="news" style="opacity:0">
          <div class="tag">SỐ LIỆU MỚI</div>
          <div id="n1">Từ 1/7/2025, Hà Nội không còn quận, huyện. Thành phố có <b>126 xã, phường</b>.</div>
          <div id="n2" style="opacity:0">Từ 30/4/2026, cả nước có <b>7 thành phố trực thuộc trung ương</b>: Hà Nội, TP.HCM, Hải Phòng, Đà Nẵng, Cần Thơ, Huế, Đồng Nai.</div>
        </div>
        <div class="poster" id="poster3" style="left:820px; top:90px; width:1040px; padding:28px 44px; font-size:44px; line-height:1.55; opacity:0">
          <h2 style="font-size:64px">HÀ NỘI</h2>
          <div>1. Thủ đô, rộng khoảng 3.360 km².</div>
          <div>2. Có 30 quận, huyện, thị xã.</div>
          <div>3. Một trong 5 thành phố trực thuộc trung ương.</div>
          <div class="src">Nguồn: Gemini</div>
          <span class="mark" data-layout-allow-overlap data-layout-allow-occlusion data-layout-allow-overflow id="mk1" style="left:930px; top:112px; color:#2e8b47; opacity:0">✓</span>
          <span class="mark" data-layout-allow-overlap data-layout-allow-occlusion data-layout-allow-overflow id="mk2" style="left:930px; top:180px; color:#d32f2f; opacity:0">✗</span>
          <span class="mark" data-layout-allow-overlap data-layout-allow-occlusion data-layout-allow-overflow id="mk3" style="left:930px; top:248px; color:#d32f2f; opacity:0">✗</span>
          <span class="mark" data-layout-allow-overlap data-layout-allow-occlusion data-layout-allow-overflow id="mk4" style="left:780px; top:-10px; color:#d32f2f; font-size:150px; opacity:0">4</span>
        </div>
        <div class="stamp" id="stamp" style="opacity:0; left:1000px; top:560px; font-size:100px">Điểm thấp</div>
        <div class="credit" id="credit" style="opacity:0">Nhạc: “Carefree”, Kevin MacLeod (incompetech.com), CC BY 4.0 · Âm thanh lật trang: flag2 (freesound.org), CC BY 4.0</div>
      </div>

      {{captions}}
      {{narration}}

      <audio id="music" class="clip" src="assets/music/carefree.mp3" data-start="0" data-duration="{{total}}" data-media-start="120" data-volume="0.13" data-fade-in="1" data-fade-out="2.5" data-track-index="4"></audio>
      <audio id="x1" class="clip" src="assets/sfx/whoosh-short.m4a" data-start="0.05" data-duration="0.57" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x2" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s1.vstart+1.2}}" data-duration="0.95" data-volume="0.6" data-track-index="5"></audio>
      <audio id="x3" class="clip" src="assets/sfx/whoosh-short.m4a" data-start="{{s2.start}}" data-duration="0.57" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x4" class="clip" src="assets/sfx/typing.m4a" data-start="{{s2.start+0.7}}" data-duration="1.5" data-volume="0.4" data-track-index="5"></audio>
      <audio id="x5" class="clip" src="assets/sfx/typing.m4a" data-start="{{s2.start+2.2}}" data-duration="1.5" data-volume="0.4" data-track-index="5"></audio>
      <audio id="x6" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.vstart+0.2}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x7" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.vstart+1.4}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x8" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.vstart+2.6}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x9" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s3.vstart+3.8}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x10" class="clip" src="assets/sfx/whoosh.m4a" data-start="{{s4.start}}" data-duration="0.57" data-volume="0.3" data-track-index="5"></audio>
      <audio id="x11" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s4.start+0.7}}" data-duration="1.07" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x12" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s4.start+1.9}}" data-duration="1.07" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x13" class="clip" src="assets/sfx/pop.m4a" data-start="{{s5.start+0.6}}" data-duration="0.72" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x14" class="clip" src="assets/sfx/pop.m4a" data-start="{{s5.vstart+s5.vdur-0.5}}" data-duration="0.72" data-volume="0.35" data-track-index="7"></audio>
      <audio id="x15" class="clip" src="assets/sfx/pop.m4a" data-start="{{s5.vstart+s5.vdur-0.1}}" data-duration="0.72" data-volume="0.35" data-track-index="8"></audio>
      <audio id="x17" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s6.start+0.4}}" data-duration="0.95" data-volume="0.5" data-track-index="8"></audio>
      <audio id="x18" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s6.start+1.12}}" data-duration="0.95" data-volume="0.5" data-track-index="9"></audio>
      <audio id="x19" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s6.start+1.84}}" data-duration="0.95" data-volume="0.5" data-track-index="10"></audio>
      <audio id="x20" class="clip" src="assets/sfx/whoosh.m4a" data-start="{{s7.start}}" data-duration="0.57" data-volume="0.3" data-track-index="5"></audio>
      <audio id="x21" class="clip" src="assets/sfx/pop.m4a" data-start="{{s7.vstart+2.4}}" data-duration="0.72" data-volume="0.4" data-track-index="6"></audio>
      <audio id="x22" class="clip" src="assets/sfx/whoosh-short.m4a" data-start="{{s8.start+0.2}}" data-duration="0.57" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x23" class="clip" src="assets/sfx/pop.m4a" data-start="{{s9.start+0.2}}" data-duration="0.72" data-volume="0.4" data-track-index="6"></audio>
      <audio id="x24" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s10.start+0.4}}" data-duration="1.07" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x25" class="clip" src="assets/sfx/pop.m4a" data-start="{{s10.vstart+2.2}}" data-duration="0.72" data-volume="0.4" data-track-index="7"></audio>
      <audio id="x26" class="clip" src="assets/sfx/stamp.m4a" data-start="{{s11.vstart+0.88}}" data-duration="1.12" data-volume="0.9" data-track-index="5"></audio>
      <audio id="x27" class="clip" src="assets/sfx/impact-bass-1.m4a" data-start="{{s11.vstart+0.88}}" data-duration="2.1" data-volume="0.45" data-track-index="6"></audio>
    </div>
    <script>
{{raw:rig.js}}
      // ---------- CLASS: task ----------
      tl.fromTo("#ttl span", { y: -200 }, { y: 0, duration: 0.5, ease: "back.out(1.6)" }, 0);
      tl.to("#ttl span", { y: -260, duration: 0.4, ease: "power2.in" }, 2.0);
      breathe("k0", 0, {{s1.start+s1.dur}}); mood("m0", "calm", 0);
      blink("k0", [1.0, 4.2, 8.0]); blink("m0", [2.2, 6.4]);
      pose("t0", "Give", {{s1.start}}); mood("t0", "happy", {{s1.start}});
      look("k0", {{s1.start}}, 12);
      slideUp("#sheet1", {{s1.vstart+1.2}});
      mood("k0", "curious", {{s1.vstart+1.4}});

      // ---------- TABLET ----------
      tl.fromTo("#cam2", { y: 300, rotation: 3 }, { y: 0, rotation: 0, duration: 0.6, ease: "power3.out", immediateRender: false }, {{s2.start}});
      const ask = "Cho mình 3 thông tin chính về Hà Nội để làm bài nhé.";
      count("#ask", ask, {{s2.start}} + 0.7, {{s2.vdur}} + 0.4);
      [0, 1, 2, 3].forEach((i) => tl.fromTo(`#f${i}`, { opacity: 0, y: 14 }, { opacity: 1, y: 0, duration: 0.3, immediateRender: false }, {{s3.vstart}} + 0.2 + i * 1.2));
      push("#cam2", {{s3.vstart}}, {{s3.dur}} - 0.35, 1.04, 0, -30);

      // ---------- HOME: poster ----------
      pose("k3", "Write", {{s4.start}} - 0.05); mood("k3", "happy", {{s4.start}}); look("k3", {{s4.start}}, 12);
      writeLoop("k3", {{s4.start}} + 0.2, 2.4);
      tl.fromTo("#poster1", { opacity: 0, y: 200, rotation: 5 }, { opacity: 1, y: 0, rotation: -2, duration: 0.45, ease: "power3.out", immediateRender: false }, {{s4.start}} + 0.3);
      ["#pl1", "#pl2", "#pl3", "#pl4"].forEach((s, i) => tl.to(s, { opacity: 1, duration: 0.25 }, {{s4.start}} + 0.8 + i * 0.6));
      pose("k3", "Desk", {{s4.start}} + 3.0);
      [0, 1, 2, 3, 4].forEach((i) => { tl.to("#k3_mO", { opacity: i % 2 ? 0 : 1, duration: 0.08 }, {{s4.start}} + 3.2 + i * 0.3); tl.to("#k3_mSmile", { opacity: i % 2 ? 1 : 0, duration: 0.08 }, {{s4.start}} + 3.2 + i * 0.3); });
      blink("k3", [{{s4.start}} + 1.5, {{s4.start}} + 4.2]);
      push("#cam3", {{s4.start}}, {{s4.dur}}, 1.05, 30, 20);

      // ---------- VOTE ----------
      pose("k5", "Chin", {{s5.start}}); mood("k5", "curious", {{s5.start}}); look("k5", {{s5.start}}, 10);
      breathe("k5", {{s5.start}}, {{s5.dur}}); blink("k5", [{{s5.start}} + 1.4, {{s5.start}} + 4.2]);
      pop("#vb1", {{s5.start}} + 0.2); pop("#vb2", {{s5.start}} + 0.4); pop("#vcloud", {{s5.start}} + 0.6);
      pop("#na", {{s5.vstart+s5.vdur-0.5}}); pop("#nb", {{s5.vstart+s5.vdur-0.1}});
      tl.fromTo("#stop", { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.3, immediateRender: false }, {{s5.vstart+s5.vdur+0.3}});

      // ---------- CALENDAR ----------
      flipPages(["#p1", "#p2", "#p3", "#p4", "#p5", "#p6"], {{s6.start}} + 0.4, 0.36);
      tl.fromTo("#wk span", { scale: 0.5, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.4, ease: "back.out(2)", immediateRender: false }, {{s6.start}} + 2.7);

      // ---------- CLASS: presentation ----------
      const P = {{s7.dur+s8.dur+s9.dur+s10.dur+s11.dur}};
      pose("k7", "Poster", {{s7.start}} - 0.05); pose("m7", "Desk", {{s7.start}} - 0.05);
      mood("k7", "happy", {{s7.start}}); mood("m7", "calm", {{s7.start}}); mood("m8", "calm", {{s7.start}});
      breathe("k7", {{s7.start}}, P); breathe("m8", {{s7.start}} + 0.5, P - 0.5);
      look("m7", {{s7.start}}, -10); look("m8", {{s7.start}}, -10);
      pose("m7", "Raise", {{s7.vstart+2.0}}); mood("m7", "curious", {{s7.vstart+2.0}});
      pop("#ask2", {{s7.vstart+2.4}});
      look("k7", {{s7.vstart+2.4}}, 12); mood("k7", "curious", {{s7.vstart+2.6}});
      // the teacher explains
      fade("#ask2", {{s8.start}}, 0, 0.2); pose("m7", "Desk", {{s8.start}});
      pose("t7", "Point", {{s8.start}} + 0.1); mood("t7", "calm", {{s8.start}});
      tl.fromTo("#news", { opacity: 0, y: -60 }, { opacity: 1, y: 0, duration: 0.4, ease: "power3.out", immediateRender: false }, {{s8.start}} + 0.2);
      tl.to("#n2", { opacity: 1, duration: 0.3 }, {{s9.start}} + 0.2);
      mood("k7", "worried", {{s9.vstart+1.0}});
      // the poster gets marked
      fade("#news", {{s10.start}}, 0, 0.3);
      tl.fromTo("#poster3", { opacity: 0, scale: 0.6, rotation: -6 }, { opacity: 1, scale: 1, rotation: -2, duration: 0.45, ease: "back.out(1.4)", immediateRender: false }, {{s10.start}} + 0.2);
      tick("#mk1", {{s10.vstart+0.6}}); tick("#mk2", {{s10.vstart+1.1}}); tick("#mk3", {{s10.vstart+1.6}});
      tick("#mk4", {{s10.vstart+2.2}});
      tl.to("#poster3", { x: -420, y: 40, scale: 0.8, duration: 0.5, ease: "power2.inOut" }, {{s11.start}});
      mood("k7", "worried", {{s11.start}});
      blink("k7", [{{s7.start}} + 1.0, {{s8.start}} + 1.6, {{s9.start}} + 2.0, {{s11.start}} + 1.0]);
      stampIn("#stamp", {{s11.vstart+0.6}});
      tl.fromTo("#cam7", { x: 0 }, { x: 10, duration: 0.05, yoyo: true, repeat: 3, immediateRender: false }, {{s11.vstart+0.9}});
      fade("#credit", {{s11.vstart+s11.vdur+0.3}}, 1, 0.4);

      window.__timelines["main"] = tl;
    </script>
  </body>
</html>
