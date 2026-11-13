"""Vietnamese narration with VieNeu-TTS (free, runs on this Mac).
  .venv/bin/python tools/vieneu_tts.py list
  .venv/bin/python tools/vieneu_tts.py say "<text>" out.wav "<voice>"
  .venv/bin/python tools/vieneu_tts.py batch case1/script.json case1/assets/voice "<voice>"
"""
import json, os, sys
import huggingface_hub

# New onnxruntime refuses model weights reached through the Hugging Face cache's symlinks,
# so every download goes to plain files in ~/.cache/vieneu-local instead.
_dl = huggingface_hub.hf_hub_download
def _plain(repo_id, filename, **kw):
    kw.setdefault("local_dir", os.path.expanduser(f"~/.cache/vieneu-local/{repo_id}"))
    return _dl(repo_id, filename, **kw)
huggingface_hub.hf_hub_download = _plain

from vieneu import Vieneu

tts = Vieneu()
cmd = sys.argv[1]
if cmd == "list":
    for label, vid in tts.list_preset_voices():
        print(label, "|", vid)
elif cmd == "say":
    tts.save(tts.infer(sys.argv[2], voice=sys.argv[4]), sys.argv[3])
elif cmd == "batch":
    for line in json.load(open(sys.argv[2])):
        tts.save(tts.infer(line["say"], voice=sys.argv[4]), f"{sys.argv[3]}/{line['id']}.wav")
        print("wrote", line["id"])
