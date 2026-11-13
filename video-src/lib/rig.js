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
      const POSES = ["Desk", "Head", "Write", "Chin", "Hold", "Side", "Down", "Give", "Point", "Raise", "Poster"];
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

      
      // Shared scene beats.
      const stampIn = (sel, at, base) => {
        tl.fromTo(sel, { opacity: 0, scale: 2.4, rotation: -14 }, { opacity: 1, scale: 1, rotation: -8, duration: 0.3, ease: "power4.in", immediateRender: false }, at);
      };
      const flipPages = (ids, at, step) => ids.forEach((s, i) =>
        tl.to(s, { rotationX: -100, opacity: 0, duration: Math.min(0.32, step * 0.9), ease: "power2.in" }, at + i * step));
      const tick = (sel, at) => tl.fromTo(sel, { opacity: 0, scale: 2 }, { opacity: 1, scale: 1, duration: 0.3, ease: "back.out(2)", immediateRender: false }, at);
