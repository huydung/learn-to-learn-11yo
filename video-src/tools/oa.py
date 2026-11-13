"""OpenAI helpers for the Tòa án AI videos. Needs OPENAI_API_KEY in the environment.

  python3 tools/oa.py tts  "<text>" out.mp3 [voice]
  python3 tools/oa.py img  "<prompt>" out.png [ref1.png ref2.png ...]
"""
import base64, os, sys, requests

KEY = os.environ["OPENAI_API_KEY"]
H = {"Authorization": f"Bearer {KEY}"}
VOICE_STYLE = (
    "Đọc bằng tiếng Việt, giọng miền Bắc (Hà Nội), chuẩn dấu. Ấm áp, rõ ràng, tốc độ vừa phải, "
    "như cô giáo kể một câu chuyện ngắn cho học sinh lớp 6. Không cường điệu."
)
STYLE = (
    "Flat 2D children's picture-book illustration, clean soft shapes, gentle shading, warm limited palette "
    "(cream #F8F7D0, deep red #BD0129, muted navy, soft wood tones). Vietnamese setting. "
    "Absolutely no text, letters, numbers or writing anywhere: paper, books, boards and screens are blank. "
)
IMAGE_MODEL = os.environ.get("IMAGE_MODEL", "gpt-image-2")


def tts(text, out, voice="coral"):
    r = requests.post("https://api.openai.com/v1/audio/speech", headers=H, timeout=120, json={
        "model": "gpt-4o-mini-tts", "voice": voice, "input": text,
        "instructions": VOICE_STYLE, "response_format": out.rsplit(".", 1)[-1]})
    r.raise_for_status()
    open(out, "wb").write(r.content)


def img(prompt, out, *refs):
    data = {"model": IMAGE_MODEL, "prompt": STYLE + prompt, "size": "1536x1024", "quality": "high"}
    if refs:
        files = [("image[]", (os.path.basename(p), open(p, "rb"), "image/png")) for p in refs]
        r = requests.post("https://api.openai.com/v1/images/edits", headers=H, data=data, files=files, timeout=600)
    else:
        r = requests.post("https://api.openai.com/v1/images/generations", headers=H, json=data, timeout=600)
    if not r.ok:
        sys.exit(f"{r.status_code}: {r.text[:500]}")
    open(out, "wb").write(base64.b64decode(r.json()["data"][0]["b64_json"]))


if __name__ == "__main__":
    {"tts": tts, "img": img}[sys.argv[1]](*sys.argv[2:])
    print("wrote", sys.argv[3])
