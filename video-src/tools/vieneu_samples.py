"""Same sentence in several voices, to choose one by ear.  .venv/bin/python tools/vieneu_samples.py"""
import os, sys, time
sys.argv = [sys.argv[0], "noop"]
exec(open(os.path.join(os.path.dirname(__file__), "vieneu_tts.py")).read().split("cmd = sys.argv[1]")[0])
TEXT = "Tối thứ Hai, bạn ấy ngồi làm bài tập Toán. Bài số năm là một dạng bài mới, bạn ấy chưa gặp bao giờ."
os.makedirs("voice-test", exist_ok=True)
for v in ["Ngọc Linh", "Quỳnh Anh", "Trúc Ly", "Ngọc Huyền", "Thiện Minh", "Thanh Bình"]:
    t = time.time()
    tts.save(tts.infer(TEXT, voice=v), f"voice-test/{v}.wav")
    print(f"{v}: {time.time() - t:.1f}s")
