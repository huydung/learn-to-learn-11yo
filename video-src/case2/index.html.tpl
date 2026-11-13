<!doctype html>
<!-- Source file. Edit this, then run: python3 ../tools/build.py case1  (writes index.html).
     Drawings come from ../lib/*.svg via the inc tag (see tools/build.py); timings from script.json + the voice files. -->
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1920, height=1080" />
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.15.0/dist/gsap.min.js"></script>
    <style>
      @font-face { font-family: "Merriweather"; src: url("assets/fonts/Merriweather-Black.ttf"); font-weight: 900; }
      @font-face { font-family: "Be Vietnam Pro"; src: url("assets/fonts/BeVietnamPro-Regular.ttf"); font-weight: 400; }
      @font-face { font-family: "Be Vietnam Pro"; src: url("assets/fonts/BeVietnamPro-SemiBold.ttf"); font-weight: 600; }
      @font-face { font-family: "Be Vietnam Pro"; src: url("assets/fonts/BeVietnamPro-Bold.ttf"); font-weight: 700; }
      @font-face { font-family: "Patrick Hand"; src: url("assets/fonts/PatrickHand-Regular.ttf"); }
      :root { --red: #bd0129; --deep: #8e011f; --dark: #51000c; --cream: #f8f7d0; --ink: #1d1d1d; --line: #3a2e2a; }
      * { margin: 0; padding: 0; box-sizing: border-box; }
      html, body { width: 1920px; height: 1080px; overflow: hidden; background: var(--cream); }
      #root { width: 100%; height: 100%; font-family: "Be Vietnam Pro", sans-serif; color: var(--ink); }
      #bg { position: absolute; inset: 0; background: var(--cream); }
      .scene { position: absolute; inset: 0; overflow: hidden; }
      .cam { position: absolute; inset: 0; }
      .full { position: absolute; inset: 0; width: 1920px; height: 1080px; }
      .full > svg { width: 100%; height: 100%; display: block; }
      .at { position: absolute; }
      .at > svg { width: 100%; height: auto; display: block; overflow: visible; }
      .girl [id$="_hairShort"], .girl .ear { display: none; }
      .girl [id$="_hairLong"], .girl [id$="_hairLongBack"] { opacity: 1; }
      .hand { font-family: "Patrick Hand", cursive; }

      .paper { position: absolute; background: #fffdf2; border: 5px solid var(--line); border-radius: 10px;
        box-shadow: 0 18px 40px rgba(0,0,0,.25); padding: 36px 46px; font-size: 40px; line-height: 1.42; }
      .paper .tag { font-size: 27px; font-weight: 700; color: var(--red); letter-spacing: .05em; margin-bottom: 12px; }
      .paper b { color: var(--deep); }
      .bubble { position: absolute; background: #fff; border: 6px solid var(--line); border-radius: 50%;
        display: flex; align-items: center; justify-content: center; }
      .doodle { position: absolute; font-family: "Patrick Hand", cursive; color: var(--red); font-size: 64px; }

      .tablet { position: absolute; left: 230px; top: 50px; width: 1460px; height: 860px; background: #23232b;
        border: 8px solid var(--line); border-radius: 56px; padding: 34px; }
      .screen { width: 100%; height: 100%; background: #fff; border-radius: 26px; padding: 24px 50px; overflow: hidden; }
      .chathead { display: flex; align-items: center; gap: 14px; font-size: 34px; font-weight: 600; color: #444;
        padding-bottom: 14px; border-bottom: 2px solid #eee; margin-bottom: 20px; }
      .spark { width: 40px; height: 40px; flex: none; }
      .ask { margin-left: auto; width: 1060px; background: #e9eef6; border-radius: 30px 30px 6px 30px;
        padding: 18px 30px; font-size: 32px; line-height: 1.4; min-height: 96px; }
      .reply { margin-top: 20px; display: flex; gap: 18px; font-size: 30px; }
      table.t { border-collapse: collapse; width: 1180px; }
      .t td, .t th { border: 2px solid #d9dee8; padding: 8px 16px; text-align: left; line-height: 1.3; }
      .t th { background: #f1f4fa; font-weight: 700; }

      .tickcard { position: absolute; left: 900px; top: 50px; width: 600px; height: 400px; background: #fff;
        border: 5px solid var(--line); border-radius: 10px; box-shadow: 0 16px 40px rgba(0,0,0,.25); }
      .tickcard .hand { position: absolute; left: 34px; top: 24px; font-size: 32px; color: #33446b; line-height: 1.45; }

      .cloud { position: absolute; left: 700px; top: 90px; width: 1120px; height: 470px; background: #fff;
        border: 7px solid var(--line); border-radius: 240px; display: flex; align-items: center; justify-content: center;
        padding: 0 100px; text-align: center; font-family: "Merriweather", serif; font-weight: 900; font-size: 64px;
        line-height: 1.28; color: var(--dark); }
      .note { position: absolute; width: 330px; height: 150px; display: flex; align-items: center; justify-content: center;
        gap: 18px; font-size: 48px; font-weight: 700; border: 5px solid var(--line); box-shadow: 0 10px 24px rgba(0,0,0,.18); white-space: nowrap; }
      .note span { width: 72px; height: 72px; line-height: 72px; text-align: center; border-radius: 50%; background: var(--red); color: var(--cream); }
      .stop { position: absolute; left: 700px; right: 0; top: 920px; text-align: center; }
      .stop span { display: inline-block; font-size: 40px; font-weight: 600; color: #fff; background: var(--dark); padding: 16px 40px; border-radius: 999px; }

      .cal { position: absolute; left: 610px; top: 150px; width: 700px; height: 640px; perspective: 1600px; }
      .page { position: absolute; inset: 0; background: #fff; border: 7px solid var(--line); border-radius: 18px;
        display: flex; flex-direction: column; align-items: center; justify-content: center; transform-origin: 50% 0; }
      .page::before { content: ""; position: absolute; left: 0; right: 0; top: 0; height: 120px; background: var(--red); border-radius: 10px 10px 0 0; }
      .page b { font-family: "Merriweather", serif; font-weight: 900; font-size: 92px; color: var(--dark); margin-top: 80px; }

      .lens { position: absolute; left: 990px; top: 30px; width: 470px; height: 470px; }
      .memory { position: absolute; left: 140px; top: 40px; width: 600px; height: 260px; background: #fff;
        border: 6px solid var(--line); border-radius: 130px; display: flex; align-items: center; justify-content: center; }
      .memory .row { font-family: "Patrick Hand", cursive; font-size: 40px; color: #33446b; }
      .stamp { position: absolute; left: 1060px; top: 110px; padding: 26px 50px; border: 12px solid var(--red); border-radius: 22px;
        color: var(--red); font-family: "Merriweather", serif; font-weight: 900; font-size: 120px; background: rgba(255,255,255,.9); }
      .ribbon { position: absolute; left: 0; right: 0; top: 60px; text-align: center; }
      .ribbon span { display: inline-block; background: var(--red); color: var(--cream); font-family: "Merriweather", serif; font-weight: 900;
        font-size: 84px; padding: 18px 70px; border-radius: 14px; border: 6px solid var(--line); }
      .credit { position: absolute; left: 40px; top: 24px; font-size: 22px; color: #3a4a2a; }

      .cap { position: absolute; left: 140px; right: 140px; top: 948px; height: 100px; display: flex; align-items: center; justify-content: center; text-align: center; }
      .cap span { display: inline-block; background: rgba(29,29,29,.88); color: #fff; font-size: 40px; line-height: 1.35; padding: 12px 34px; border-radius: 18px; }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="main" data-start="0" data-duration="{{total}}" data-width="1920" data-height="1080">
      <div id="bg"></div>

      <!-- CLASS 0: the homework is given (0 → end of s1) -->
      <div id="class0" class="clip scene" data-start="0" data-duration="{{s1.start+s1.dur}}" data-track-index="1">
        <div class="cam" id="cam0">
          <div class="full">{{inc:classroom|c0}}</div>
          <div class="at girl" style="left:200px; top:300px; width:300px">{{inc:kid|m0}}</div>
          <div class="at" style="left:140px; top:690px; width:420px">{{inc:classdesk|e0}}</div>
          <div class="at" style="left:620px; top:150px; width:440px">{{inc:kid|k0}}</div>
          <div class="at" style="left:540px; top:740px; width:600px">{{inc:classdesk|e01}}</div>
          <div class="at" style="left:1420px; top:120px; width:560px">{{inc:teacher|t0}}</div>
        </div>
        <div class="ribbon" id="ttl"><span>Tình huống 2</span></div>
        <div class="paper" id="sheet1" style="left:980px; top:120px; width:860px; opacity:0">
          <div class="tag">BÀI TẬP VỀ NHÀ · KHOA HỌC TỰ NHIÊN 6</div>
          Quan sát <b>5 loài cây</b> quanh nhà. Mỗi cây ghi: thân gỗ hay thân cỏ, có hoa không, hạt nằm ở đâu.<br>
          Xếp vào nhóm: <b>rêu, dương xỉ, hạt trần, hạt kín</b>.
        </div>
      </div>

      <!-- HOME 1: lazy afternoon (s2) -->
      <div id="home1" class="clip scene" data-start="{{s2.start}}" data-duration="{{s2.dur}}" data-track-index="1">
        <div class="cam" id="cam1">
          <div class="full">{{inc:room_day|r1}}</div>
          <div class="at" style="left:720px; top:70px; width:480px">{{inc:kid|k1}}</div>
          <div class="at" style="left:0; top:690px; width:1920px">{{inc:desk|d1}}</div>
          <div class="doodle" id="hot" style="left:640px; top:60px; opacity:0">Nắng quá…</div>
        </div>
      </div>

      <!-- TABLET: ask Gemini (s3 + s4) -->
      <div id="tab" class="clip scene" data-start="{{s3.start}}" data-duration="{{s3.dur+s4.dur}}" data-track-index="1">
        <div class="full" style="filter: blur(10px) brightness(.75)">{{inc:room_day|r2}}</div>
        <div class="cam" id="cam2">
          <div class="tablet">
            <div class="screen">
              <div class="chathead"><svg class="spark" viewBox="0 0 24 24"><defs><linearGradient id="g1" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#4285f4"/><stop offset="1" stop-color="#9b72cb"/></linearGradient></defs><path fill="url(#g1)" d="M12 0C12 7 17 12 24 12C17 12 12 17 12 24C12 17 7 12 0 12C7 12 12 7 12 0Z"/></svg>Gemini</div>
              <div class="ask" id="ask"></div>
              <div class="reply"><svg class="spark" viewBox="0 0 24 24"><path fill="url(#g1)" d="M12 0C12 7 17 12 24 12C17 12 12 17 12 24C12 17 7 12 0 12C7 12 12 7 12 0Z"/></svg>
                <table class="t">
                  <tr id="row0" style="opacity:0"><th>Cây</th><th>Đặc điểm</th><th>Nhóm</th></tr>
                  <tr id="row1" style="opacity:0"><td>Rêu trên tường</td><td>Nhỏ, mọc chỗ ẩm, chưa có rễ thật</td><td>Rêu</td></tr>
                  <tr id="row2" style="opacity:0"><td>Dương xỉ</td><td>Lá non cuộn tròn, mặt dưới lá có túi bào tử</td><td>Dương xỉ</td></tr>
                  <tr id="row3" style="opacity:0"><td>Thông</td><td>Lá hình kim, hạt nằm lộ trên lá noãn</td><td>Hạt trần</td></tr>
                  <tr id="row4" style="opacity:0"><td>Bưởi</td><td>Thân gỗ, có hoa, hạt nằm trong quả</td><td>Hạt kín</td></tr>
                  <tr id="row5" style="opacity:0"><td>Lúa</td><td>Thân cỏ, có hoa, hạt nằm trong quả</td><td>Hạt kín</td></tr>
                </table>
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

      <!-- HOME 2: copying (s5) -->
      <div id="home2" class="clip scene" data-start="{{s5.start}}" data-duration="{{s5.dur}}" data-track-index="1">
        <div class="cam" id="cam3">
          <div class="full">{{inc:room_day|r3}}</div>
          <div class="at" style="left:720px; top:70px; width:480px">{{inc:kid|k3}}</div>
          <div class="at" style="left:0; top:690px; width:1920px">{{inc:desk|d3}}</div>
          <div class="doodle" id="ten1" style="left:1290px; top:110px; opacity:0">10 phút. Xong!</div>
        </div>
      </div>

      <!-- CLASS 1: praised on Monday (s6) -->
      <div id="class1" class="clip scene" data-start="{{s6.start}}" data-duration="{{s6.dur}}" data-track-index="1">
        <div class="cam" id="cam4">
          <div class="full">{{inc:classroom|c1}}</div>
          <div class="at girl" style="left:180px; top:300px; width:300px">{{inc:kid|m1}}</div>
          <div class="at" style="left:120px; top:690px; width:420px">{{inc:classdesk|e1}}</div>
          <div class="at" style="left:600px; top:150px; width:440px">{{inc:kid|k4}}</div>
          <div class="at" style="left:520px; top:740px; width:600px">{{inc:classdesk|e2}}</div>
          <div class="at" style="left:1420px; top:120px; width:560px">{{inc:teacher|t1}}</div>
        </div>
        <div class="tickcard" id="tickcard" style="opacity:0">
          <div class="hand">Rêu – Rêu<br>Dương xỉ – Dương xỉ<br>Thông – Hạt trần<br>Bưởi, Lúa – Hạt kín</div>
          <svg viewBox="0 0 600 400" style="position:absolute; inset:0"><path id="tickpath" d="M380 250 L440 310 L560 170" fill="none" stroke="#bd0129" stroke-width="18" stroke-linecap="round" stroke-linejoin="round" stroke-dasharray="320" stroke-dashoffset="320"/></svg>
          <div class="doodle" id="ten" style="left:420px; top:40px; font-size:110px; opacity:0">10</div>
        </div>
      </div>

      <!-- VOTE (s7) -->
      <div id="vote" data-hold class="clip scene" data-start="{{s7.start}}" data-duration="{{s7.dur}}" data-track-index="1">
        <div class="at" style="left:120px; top:330px; width:560px">{{inc:kid|k5}}</div>
        <div class="bubble" id="vb1" style="opacity:0; left:600px; top:470px; width:70px; height:60px"></div>
        <div class="bubble" id="vb2" style="opacity:0; left:660px; top:400px; width:100px; height:86px"></div>
        <div class="cloud" id="vcloud" style="opacity:0">Một tuần sau, chuyện gì sẽ xảy ra với bài quan sát này? Vì sao?</div>
        <div class="note" id="na" style="opacity:0; left:780px; top:640px; background:#fff6c9; transform:rotate(-3deg); width:480px; font-family:'Patrick Hand', cursive; font-weight:400; font-size:54px">Đoán: …</div>
        <div class="note" id="nb" style="opacity:0; left:1320px; top:660px; background:#e3f0ff; transform:rotate(2deg); width:480px; font-family:'Patrick Hand', cursive; font-weight:400; font-size:54px">Vì sao: …</div>
        <div class="stop" id="stop" style="opacity:0"><span>Dừng video · Các đội đoán và giải thích vì sao</span></div>
      </div>

      <!-- CALENDAR (s8) -->
      <div id="week" data-hold class="clip scene" data-start="{{s8.start}}" data-duration="{{s8.dur}}" data-track-index="1">
        <div class="full">{{inc:room_day|r5}}</div>
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

      <!-- GARDEN: the fern (s9 → s11) -->
      <div id="garden" class="clip scene" data-start="{{s9.start}}" data-duration="{{s9.dur+s10.dur+s11.dur}}" data-track-index="1">
        <div class="cam" id="cam6">
          <div class="full">{{inc:garden|g6}}</div>
          <div class="at girl" style="left:1060px; top:410px; width:210px">{{inc:kid|m6}}</div>
          <div class="at" style="left:560px; top:430px; width:210px">{{inc:kid|m7}}</div>
          <div class="at" style="left:760px; top:450px; width:660px">{{inc:fern|fn}}</div>
          <div class="at" style="left:290px; top:290px; width:340px">{{inc:kid|k6}}</div>
          <div class="at" style="left:1500px; top:150px; width:390px">{{inc:teacher|t6}}</div>
          <div class="bubble" id="q2" style="left:640px; top:170px; width:170px; height:150px; opacity:0"><span class="hand" style="font-size:110px; color:var(--red)">?</span></div>
          <div class="bubble" id="q3" style="left:790px; top:300px; width:130px; height:115px; opacity:0"><span class="hand" style="font-size:80px; color:var(--red)">?</span></div>
        </div>
        <svg class="lens" id="lens" viewBox="0 0 470 470" style="opacity:0">
          <defs><clipPath id="lensclip"><circle cx="200" cy="200" r="180"/></clipPath></defs>
          <path d="M330 330 L450 450" stroke="#3a2e2a" stroke-width="44" stroke-linecap="round"/><path d="M330 330 L450 450" stroke="#8a5a33" stroke-width="30" stroke-linecap="round"/>
          <circle cx="200" cy="200" r="180" fill="#e9f6dd"/>
          <g clip-path="url(#lensclip)">
            <path d="M10 210 Q200 150 400 230" stroke="#5a7f2a" stroke-width="12" fill="none"/>
            <g fill="#4f9a45" stroke="#3a2e2a" stroke-width="4">
              <ellipse cx="80" cy="150" rx="70" ry="28" transform="rotate(-30 80 150)"/><ellipse cx="190" cy="120" rx="70" ry="28" transform="rotate(-20 190 120)"/>
              <ellipse cx="300" cy="140" rx="70" ry="28" transform="rotate(-10 300 140)"/><ellipse cx="90" cy="270" rx="70" ry="28" transform="rotate(25 90 270)"/>
              <ellipse cx="200" cy="260" rx="70" ry="28" transform="rotate(15 200 260)"/><ellipse cx="310" cy="285" rx="70" ry="28" transform="rotate(10 310 285)"/>
            </g>
            <g fill="#8a4a1c" stroke="#3a2e2a" stroke-width="2">
              <circle cx="60" cy="150" r="9"/><circle cx="95" cy="140" r="9"/><circle cx="170" cy="122" r="9"/><circle cx="205" cy="115" r="9"/>
              <circle cx="285" cy="140" r="9"/><circle cx="318" cy="136" r="9"/><circle cx="75" cy="268" r="9"/><circle cx="110" cy="278" r="9"/>
              <circle cx="185" cy="258" r="9"/><circle cx="222" cy="264" r="9"/><circle cx="296" cy="283" r="9"/><circle cx="330" cy="288" r="9"/>
            </g>
          </g>
          <circle cx="200" cy="200" r="180" fill="none" stroke="#3a2e2a" stroke-width="14"/>
        </svg>
        <div class="paper" id="ask3" style="left:500px; top:30px; width:460px; font-size:38px; opacity:0"><div class="tag">CÔ HỎI</div>Đây là cây gì?<br>Có đặc điểm gì?<br>Thuộc loại nào?</div>
        <div class="memory" id="memory" style="opacity:0"><div class="row" id="memrow">Dương xỉ – lá non cuộn tròn – Dương xỉ</div></div>
        <div class="stamp" id="stamp" style="opacity:0">Quên</div>
        <div class="credit" id="credit" style="opacity:0">Nhạc: “Carefree”, Kevin MacLeod (incompetech.com), CC BY 4.0 · Âm thanh lật trang: flag2 (freesound.org), CC BY 4.0</div>
      </div>

      <!-- Captions (none on the vote: the cloud already asks the question) -->
      <div id="cap1" class="clip cap" data-start="{{s1.vstart}}" data-duration="{{s1.cdur}}" data-track-index="2"><span>{{s1.say}}</span></div>
      <div id="cap2" class="clip cap" data-start="{{s2.vstart}}" data-duration="{{s2.cdur}}" data-track-index="2"><span>{{s2.say}}</span></div>
      <div id="cap3" class="clip cap" data-start="{{s3.vstart}}" data-duration="{{s3.cdur}}" data-track-index="2"><span>{{s3.say}}</span></div>
      <div id="cap4" class="clip cap" data-start="{{s4.vstart}}" data-duration="{{s4.cdur}}" data-track-index="2"><span>{{s4.say}}</span></div>
      <div id="cap5" class="clip cap" data-start="{{s5.vstart}}" data-duration="{{s5.cdur}}" data-track-index="2"><span>{{s5.say}}</span></div>
      <div id="cap6" class="clip cap" data-start="{{s6.vstart}}" data-duration="{{s6.cdur}}" data-track-index="2"><span>{{s6.say}}</span></div>
      <div id="cap8" class="clip cap" data-start="{{s8.vstart}}" data-duration="{{s8.cdur}}" data-track-index="2"><span>{{s8.say}}</span></div>
      <div id="cap9" class="clip cap" data-start="{{s9.vstart}}" data-duration="{{s9.cdur}}" data-track-index="2"><span>{{s9.say}}</span></div>
      <div id="cap10" class="clip cap" data-start="{{s10.vstart}}" data-duration="{{s10.cdur}}" data-track-index="2"><span>{{s10.say}}</span></div>
      <div id="cap11" class="clip cap" data-start="{{s11.vstart}}" data-duration="{{s11.cdur}}" data-track-index="2"><span>{{s11.say}}</span></div>

      <!-- Narration -->
      <audio id="v1" class="clip" src="assets/voice/s1.m4a" data-start="{{s1.vstart}}" data-duration="{{s1.vdur}}" data-volume="1" data-track-index="3"></audio>
      <audio id="v2" class="clip" src="assets/voice/s2.m4a" data-start="{{s2.vstart}}" data-duration="{{s2.vdur}}" data-volume="1" data-track-index="3"></audio>
      <audio id="v3" class="clip" src="assets/voice/s3.m4a" data-start="{{s3.vstart}}" data-duration="{{s3.vdur}}" data-volume="1" data-track-index="3"></audio>
      <audio id="v4" class="clip" src="assets/voice/s4.m4a" data-start="{{s4.vstart}}" data-duration="{{s4.vdur}}" data-volume="1" data-track-index="3"></audio>
      <audio id="v5" class="clip" src="assets/voice/s5.m4a" data-start="{{s5.vstart}}" data-duration="{{s5.vdur}}" data-volume="1" data-track-index="3"></audio>
      <audio id="v6" class="clip" src="assets/voice/s6.m4a" data-start="{{s6.vstart}}" data-duration="{{s6.vdur}}" data-volume="1" data-track-index="3"></audio>
      <audio id="v7" class="clip" src="assets/voice/s7.m4a" data-start="{{s7.vstart}}" data-duration="{{s7.vdur}}" data-volume="1" data-track-index="3"></audio>
      <audio id="v8" class="clip" src="assets/voice/s8.m4a" data-start="{{s8.vstart}}" data-duration="{{s8.vdur}}" data-volume="1" data-track-index="3"></audio>
      <audio id="v9" class="clip" src="assets/voice/s9.m4a" data-start="{{s9.vstart}}" data-duration="{{s9.vdur}}" data-volume="1" data-track-index="3"></audio>
      <audio id="v10" class="clip" src="assets/voice/s10.m4a" data-start="{{s10.vstart}}" data-duration="{{s10.vdur}}" data-volume="1" data-track-index="3"></audio>
      <audio id="v11" class="clip" src="assets/voice/s11.m4a" data-start="{{s11.vstart}}" data-duration="{{s11.vdur}}" data-volume="1" data-track-index="3"></audio>

      <!-- Music bed: quiet under the voice -->
      <audio id="music" class="clip" src="assets/music/carefree.mp3" data-start="0" data-duration="{{total}}" data-volume="0.13" data-fade-in="1" data-fade-out="2.5" data-track-index="4"></audio>

      <!-- Sound effects. Each has a cause on screen. Same-track clips never overlap. -->
      <audio id="x1" class="clip" src="assets/sfx/whoosh-short.m4a" data-start="0.05" data-duration="0.57" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x2" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s1.vstart+1.2}}" data-duration="0.95" data-volume="0.6" data-track-index="5"></audio>
      <audio id="x3" class="clip" src="assets/sfx/whoosh.m4a" data-start="{{s2.start}}" data-duration="0.57" data-volume="0.3" data-track-index="5"></audio>
      <audio id="x4" class="clip" src="assets/sfx/birds.m4a" data-start="{{s2.start}}" data-duration="{{s2.dur}}" data-volume="0.12" data-fade-in="0.5" data-fade-out="0.5" data-track-index="11"></audio>
      <audio id="x5" class="clip" src="assets/sfx/pop.m4a" data-start="{{s2.vstart+1.5}}" data-duration="0.72" data-volume="0.35" data-track-index="6"></audio>
      <audio id="x6" class="clip" src="assets/sfx/whoosh-short.m4a" data-start="{{s3.start}}" data-duration="0.57" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x7" class="clip" src="assets/sfx/typing.m4a" data-start="{{s3.start+0.7}}" data-duration="1.5" data-volume="0.4" data-track-index="5"></audio>
      <audio id="x8" class="clip" src="assets/sfx/typing.m4a" data-start="{{s3.start+2.2}}" data-duration="1.5" data-volume="0.4" data-track-index="5"></audio>
      <audio id="x9" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s4.vstart+0.4}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x10" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s4.vstart+0.9}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x11" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s4.vstart+1.4}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x12" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s4.vstart+1.9}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x13" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s4.vstart+2.4}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x14" class="clip" src="assets/sfx/click-soft.m4a" data-start="{{s4.vstart+2.9}}" data-duration="0.36" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x15" class="clip" src="assets/sfx/whoosh.m4a" data-start="{{s5.start}}" data-duration="0.57" data-volume="0.3" data-track-index="5"></audio>
      <audio id="x16" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s5.start+0.3}}" data-duration="1.07" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x17" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s5.start+1.45}}" data-duration="1.07" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x18" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s5.start+2.6}}" data-duration="1.07" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x19" class="clip" src="assets/sfx/sparkle.m4a" data-start="{{s5.vstart+2.6}}" data-duration="1.8" data-volume="0.3" data-track-index="7"></audio>
      <audio id="x20" class="clip" src="assets/sfx/whoosh-short.m4a" data-start="{{s6.start}}" data-duration="0.57" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x21" class="clip" src="assets/sfx/pencil.m4a" data-start="{{s6.vstart+1.6}}" data-duration="1.07" data-volume="0.5" data-track-index="6"></audio>
      <audio id="x22" class="clip" src="assets/sfx/sparkle.m4a" data-start="{{s6.vstart+2.1}}" data-duration="1.8" data-volume="0.3" data-track-index="7"></audio>
      <audio id="x23" class="clip" src="assets/sfx/pop.m4a" data-start="{{s7.start+0.6}}" data-duration="0.72" data-volume="0.35" data-track-index="5"></audio>
      <audio id="x24" class="clip" src="assets/sfx/pop.m4a" data-start="{{s7.vstart+s7.vdur-0.5}}" data-duration="0.72" data-volume="0.35" data-track-index="7"></audio>
      <audio id="x25" class="clip" src="assets/sfx/pop.m4a" data-start="{{s7.vstart+s7.vdur-0.1}}" data-duration="0.72" data-volume="0.35" data-track-index="8"></audio>
      <audio id="x27" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s8.start+0.4}}" data-duration="0.95" data-volume="0.5" data-track-index="8"></audio>
      <audio id="x28" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s8.start+0.76}}" data-duration="0.95" data-volume="0.5" data-track-index="9"></audio>
      <audio id="x29" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s8.start+1.12}}" data-duration="0.95" data-volume="0.5" data-track-index="10"></audio>
      <audio id="x30" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s8.start+1.48}}" data-duration="0.95" data-volume="0.5" data-track-index="8"></audio>
      <audio id="x31" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s8.start+1.84}}" data-duration="0.95" data-volume="0.5" data-track-index="9"></audio>
      <audio id="x32" class="clip" src="assets/sfx/pageflip.m4a" data-start="{{s8.start+2.2}}" data-duration="0.95" data-volume="0.5" data-track-index="10"></audio>
      <audio id="x33" class="clip" src="assets/sfx/whoosh.m4a" data-start="{{s9.start}}" data-duration="0.57" data-volume="0.3" data-track-index="5"></audio>
      <audio id="x34" class="clip" src="assets/sfx/birds.m4a" data-start="{{s9.start}}" data-duration="7.1" data-volume="0.25" data-fade-in="0.6" data-fade-out="0.6" data-track-index="11"></audio>
      <audio id="x35" class="clip" src="assets/sfx/birds.m4a" data-start="{{s9.start+6.6}}" data-duration="7.1" data-volume="0.25" data-fade-in="0.6" data-fade-out="0.6" data-track-index="12"></audio>
      <audio id="x36" class="clip" src="assets/sfx/birds.m4a" data-start="{{s9.start+13.2}}" data-duration="{{s9.dur+s10.dur+s11.dur-13.2}}" data-volume="0.25" data-fade-in="0.6" data-fade-out="1" data-track-index="11"></audio>
      <audio id="x37" class="clip" src="assets/sfx/pop.m4a" data-start="{{s9.vstart+2.2}}" data-duration="0.72" data-volume="0.35" data-track-index="6"></audio>
      <audio id="x38" class="clip" src="assets/sfx/pop.m4a" data-start="{{s10.vstart+0.3}}" data-duration="0.72" data-volume="0.35" data-track-index="6"></audio>
      <audio id="x39" class="clip" src="assets/sfx/pop.m4a" data-start="{{s10.vstart+s10.vdur}}" data-duration="0.72" data-volume="0.35" data-track-index="7"></audio>
      <audio id="x40" class="clip" src="assets/sfx/pop.m4a" data-start="{{s10.vstart+s10.vdur+0.4}}" data-duration="0.72" data-volume="0.35" data-track-index="8"></audio>
      <audio id="x41" class="clip" src="assets/sfx/stamp.m4a" data-start="{{s11.vstart+0.88}}" data-duration="1.12" data-volume="0.9" data-track-index="5"></audio>
      <audio id="x42" class="clip" src="assets/sfx/impact-bass-1.m4a" data-start="{{s11.vstart+0.88}}" data-duration="2.1" data-volume="0.45" data-track-index="6"></audio>
    </div>
    <script>
      const tl = gsap.timeline({ paused: true });
      const C = "50% 50%";
      const fade = (sel, at, to = 1, d = 0.3) => tl.to(sel, { opacity: to, duration: d, ease: "power2.out" }, at);
      const pop = (sel, at) => tl.fromTo(sel, { opacity: 0, scale: 0.6 }, { opacity: 1, scale: 1, duration: 0.35, ease: "back.out(2)", immediateRender: false }, at);
      const slideUp = (sel, at) => tl.fromTo(sel, { opacity: 0, y: 260, rotation: 6 }, { opacity: 1, y: 0, rotation: -2, duration: 0.5, ease: "power3.out", immediateRender: false }, at);
      const push = (sel, at, dur, scale, x = 0, y = 0) => tl.to(sel, { scale, x, y, duration: dur, ease: "sine.inOut", transformOrigin: C }, at);
      const count = (sel, text, at, dur) => {
        const o = { n: 0 }, el = document.querySelector(sel);
        tl.fromTo(o, { n: 0 }, { n: text.length, duration: dur, ease: "none", immediateRender: false,
          onUpdate: () => (el.textContent = text.slice(0, Math.round(o.n))) }, at);
      };

      // Character controls. k = the prefix the drawing was included with.
      const MOUTHS = ["mFlat", "mSmile", "mFrown", "mO"];
      const MOODS = {
        calm:    { m: "mFlat",  bl: 0,   br: 0,   by: 0,   sweat: 0, blush: 0.45, lids: 0 },
        curious: { m: "mO",     bl: 0,   br: 0,   by: -8,  sweat: 0, blush: 0.45, lids: 0 },
        bored:   { m: "mFlat",  bl: 0,   br: 0,   by: 6,   sweat: 0, blush: 0.3,  lids: 1 },
        worried: { m: "mFrown", bl: -14, br: 14,  by: 0,   sweat: 1, blush: 0.2,  lids: 0 },
        happy:   { m: "mSmile", bl: 0,   br: 0,   by: -6,  sweat: 0, blush: 0.7,  lids: 0 },
        blank:   { m: "mO",     bl: 8,   br: -8,  by: -12, sweat: 1, blush: 0.1,  lids: 0 },
      };
      const mood = (k, name, at) => {
        const s = MOODS[name];
        MOUTHS.forEach((m) => tl.to(`#${k}_${m}`, { opacity: m === s.m ? 1 : 0, duration: 0.12 }, at));
        tl.to(`#${k}_browL`, { rotation: s.bl, y: s.by, duration: 0.25, transformOrigin: C }, at);
        tl.to(`#${k}_browR`, { rotation: s.br, y: s.by, duration: 0.25, transformOrigin: C }, at);
        tl.to(`#${k}_sweat`, { opacity: s.sweat, duration: 0.25 }, at);
        tl.to(`#${k}_blush`, { opacity: s.blush, duration: 0.25 }, at);
        tl.to(`#${k}_lids`, { opacity: s.lids, duration: 0.2 }, at);
      };
      const POSES = ["Desk", "Head", "Write", "Chin", "Hold", "Side", "Down", "Give", "Point"];
      const pose = (k, name, at) => {
        POSES.filter((p) => document.getElementById(`${k}_arms${p}`)).forEach((p) =>
          tl.to(`#${k}_arms${p}`, { opacity: p === name ? 1 : 0, duration: 0.1 }, at + 0.08));
      };
      const blink = (k, times) => times.forEach((t) =>
        tl.fromTo(`#${k}_eyes`, { scaleY: 1 }, { scaleY: 0.1, duration: 0.07, yoyo: true, repeat: 1, transformOrigin: C, immediateRender: false }, t));
      const breathe = (k, at, dur) => tl.fromTo(`#${k}_head`, { y: 0 }, { y: -5, duration: 1.1, yoyo: true,
        repeat: Math.max(1, Math.floor(dur / 1.1) - 1), ease: "sine.inOut", immediateRender: false }, at);
      const look = (k, at, x) => tl.to(`#${k}_eyeL, #${k}_eyeR`, { x, duration: 0.2 }, at);
      // The writing arm swings a few degrees around its shoulder (288 380); the other arm and the body stay still.
      const writeLoop = (k, at, dur) => tl.fromTo(`#${k}_hand`, { rotation: -2 }, { rotation: 3, duration: 0.18, yoyo: true,
        repeat: Math.floor(dur / 0.18), ease: "sine.inOut", svgOrigin: "288 380", immediateRender: false }, at);

      // ---------- CLASS 0: homework given ----------
      tl.fromTo("#ttl span", { y: -200 }, { y: 0, duration: 0.5, ease: "back.out(1.6)" }, 0);
      tl.to("#ttl span", { y: -260, duration: 0.4, ease: "power2.in" }, 2.0);
      breathe("k0", 0, {{s1.start+s1.dur}}); mood("m0", "calm", 0);
      blink("k0", [1.0, 4.2, 8.0]); blink("m0", [2.2, 6.4]);
      pose("t0", "Give", {{s1.start}});
      mood("t0", "happy", {{s1.start}});
      look("k0", {{s1.start}}, 12);
      slideUp("#sheet1", {{s1.vstart+1.2}});
      mood("k0", "curious", {{s1.vstart+1.4}});

      // ---------- HOME 1: lazy ----------
      pose("k1", "Chin", {{s2.start}} - 0.05);
      mood("k1", "bored", {{s2.start}});
      look("k1", {{s2.start}} + 0.3, -12);
      breathe("k1", {{s2.start}}, {{s2.dur}});
      pop("#hot", {{s2.vstart+1.5}});
      tl.fromTo("#k1_mO", { opacity: 0, scale: 1 }, { opacity: 1, scale: 1.7, duration: 0.5, yoyo: true, repeat: 1, transformOrigin: C, immediateRender: false }, {{s2.vstart+2.4}});
      look("k1", {{s2.vstart+s2.vdur+0.3}}, 12);
      push("#cam1", {{s2.start}}, {{s2.dur}}, 1.06, 40, 20);

      // ---------- TABLET ----------
      tl.fromTo("#cam2", { y: 300, rotation: 3 }, { y: 0, rotation: 0, duration: 0.6, ease: "power3.out", immediateRender: false }, {{s3.start}});
      const ask = "Viết giúp mình bài quan sát 5 loài cây quanh nhà, có đặc điểm và xếp nhóm (rêu, dương xỉ, hạt trần, hạt kín).";
      count("#ask", ask, {{s3.start}} + 0.7, {{s3.vdur}} + 0.8);
      [0, 1, 2, 3, 4, 5].forEach((i) => tl.fromTo(`#row${i}`, { opacity: 0 }, { opacity: 1, duration: 0.25, immediateRender: false }, {{s4.vstart}} + 0.4 + i * 0.5));
      push("#cam2", {{s4.vstart}}, {{s4.dur}} - 0.35, 1.04, 0, -30);

      // ---------- HOME 2: copying ----------
      pose("k3", "Write", {{s5.start}} - 0.05);
      mood("k3", "happy", {{s5.start}});
      look("k3", {{s5.start}}, 12);
      tl.to("#d3_tabFlat", { opacity: 0, duration: 0.05 }, {{s5.start}});
      tl.to("#d3_tabUp", { opacity: 1, duration: 0.05 }, {{s5.start}});
      writeLoop("k3", {{s5.start}} + 0.2, {{s5.dur}} - 0.4);
      [1, 2, 3, 4, 5].forEach((i) => tl.to(`#d3_w${i}`, { opacity: 1, duration: 0.2 }, {{s5.start}} + 0.4 + i * 0.6));
      tl.fromTo("#r3_min", { rotation: 0 }, { rotation: 60, duration: 2.8, ease: "steps(10)", svgOrigin: "0 0", immediateRender: false }, {{s5.start}} + 0.3);
      tl.fromTo("#r3_hour", { rotation: 0 }, { rotation: 5, duration: 2.8, ease: "none", svgOrigin: "0 0", immediateRender: false }, {{s5.start}} + 0.3);
      pop("#ten1", {{s5.vstart+2.6}});
      blink("k3", [{{s5.start}} + 1.5, {{s5.start}} + 4]);
      push("#cam3", {{s5.start}}, {{s5.dur}}, 1.08, 0, 30);

      // ---------- CLASS 1: praised ----------
      breathe("k4", {{s6.start}}, {{s6.dur}});
      mood("m1", "calm", {{s6.start}});
      pose("t1", "Give", {{s6.start}} + 0.4);
      mood("t1", "happy", {{s6.start}} + 0.4);
      tl.fromTo("#tickcard", { opacity: 0, scale: 0.7, rotation: -6 }, { opacity: 1, scale: 1, rotation: -3, duration: 0.45, ease: "back.out(1.6)", immediateRender: false }, {{s6.start}} + 0.9);
      tl.to("#tickpath", { strokeDashoffset: 0, duration: 0.5, ease: "power2.inOut" }, {{s6.vstart+1.6}});
      pop("#ten", {{s6.vstart+2.1}});
      mood("k4", "happy", {{s6.vstart+2.1}});
      tl.fromTo("#k4", { y: 0 }, { y: -18, duration: 0.18, yoyo: true, repeat: 1, ease: "power2.out", immediateRender: false }, {{s6.vstart+2.2}});
      blink("k4", [{{s6.start}} + 0.8, {{s6.start}} + 3.4]);

      // ---------- VOTE ----------
      pose("k5", "Chin", {{s7.start}});
      mood("k5", "curious", {{s7.start}});
      look("k5", {{s7.start}}, 10);
      breathe("k5", {{s7.start}}, {{s7.dur}});
      blink("k5", [{{s7.start}} + 1.4, {{s7.start}} + 4.2, {{s7.start}} + 6.5]);
      pop("#vb1", {{s7.start}} + 0.2); pop("#vb2", {{s7.start}} + 0.4); pop("#vcloud", {{s7.start}} + 0.6);
      pop("#na", {{s7.vstart+s7.vdur-0.5}}); pop("#nb", {{s7.vstart+s7.vdur-0.1}});
      tl.fromTo("#stop", { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.3, immediateRender: false }, {{s7.vstart+s7.vdur+0.3}});

      // ---------- CALENDAR ----------
      ["#p1", "#p2", "#p3", "#p4", "#p5", "#p6"].forEach((s, i) =>
        tl.to(s, { rotationX: -100, opacity: 0, duration: 0.32, ease: "power2.in" }, {{s8.start}} + 0.4 + i * 0.36));
      tl.fromTo("#wk span", { scale: 0.5, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.4, ease: "back.out(2)", immediateRender: false }, {{s8.start+2.7}});

      // ---------- GARDEN ----------
      const G = {{s9.dur+s10.dur+s11.dur}};
      pose("k6", "Side", {{s9.start}} - 0.05); pose("m6", "Side", {{s9.start}} - 0.05); pose("m7", "Side", {{s9.start}} - 0.05);
      mood("m6", "calm", {{s9.start}}); mood("m7", "calm", {{s9.start}});
      breathe("k6", {{s9.start}}, G); breathe("m6", {{s9.start}} + 0.4, G - 0.4);
      [0, 1, 2, 3, 4, 5].forEach((i) => tl.fromTo(`#fn_f${i}`, { rotation: -1.5 }, { rotation: 1.5, duration: 1.6 + i * 0.13, yoyo: true,
        repeat: Math.floor(G / (1.6 + i * 0.13)), ease: "sine.inOut", svgOrigin: "300 500", immediateRender: false }, {{s9.start}}));
      pose("t6", "Point", {{s9.vstart+0.4}});
      look("k6", {{s9.vstart+0.6}}, 12);
      mood("k6", "curious", {{s9.vstart+0.6}});
      pop("#ask3", {{s9.vstart+1.6}});
      pop("#lens", {{s9.vstart+2.2}});
      push("#cam6", {{s9.start}}, {{s9.dur}}, 1.06, -40, 0);
      // s10: he wrote it down, but cannot recognise it
      fade("#lens", {{s10.start}}, 0, 0.3); fade("#ask3", {{s10.start}}, 0, 0.3);
      look("k6", {{s10.vstart}}, 0);
      mood("k6", "blank", {{s10.vstart+0.3}});
      pop("#memory", {{s10.vstart+0.3}});
      tl.fromTo("#memrow", { opacity: 1, filter: "blur(0px)" }, { opacity: 0.15, filter: "blur(9px)", duration: 2.4, ease: "power1.in", immediateRender: false }, {{s10.vstart+1.6}});
      [0, 1, 2].forEach((i) => look("k6", {{s10.vstart+2.2}} + i * 0.55, i % 2 ? -10 : 10));
      pop("#q2", {{s10.vstart+s10.vdur}}); pop("#q3", {{s10.vstart+s10.vdur+0.4}});
      push("#cam6", {{s10.start}}, 2.5, 1.12, 110, 60);
      blink("k6", [{{s9.start}} + 1.2, {{s10.vstart}} + 1.0, {{s11.start}} + 0.6]);
      // s11: verdict
      fade("#memory", {{s11.start}}, 0, 0.3); fade("#q2", {{s11.start}}, 0, 0.2); fade("#q3", {{s11.start}}, 0, 0.2);
      mood("k6", "worried", {{s11.start+0.2}});
      tl.fromTo("#stamp", { opacity: 0, scale: 2.4, rotation: -14 }, { opacity: 1, scale: 1, rotation: -8, duration: 0.3, ease: "power4.in", immediateRender: false }, {{s11.vstart+0.6}});
      tl.fromTo("#cam6", { x: 110 }, { x: 122, duration: 0.05, yoyo: true, repeat: 3, immediateRender: false }, {{s11.vstart+0.9}});
      fade("#credit", {{s11.vstart+s11.vdur+0.3}}, 1, 0.4);

      window.__timelines["main"] = tl;
    </script>
  </body>
</html>
