import json
import os
import sys

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from generate_batch3 import get_batch3_questions

questions = get_batch3_questions()
print(f"🎯 Total Batch 3 Questions: {len(questions)}")

output_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "batch3_questions.json")
with open(output_path, "w", encoding="utf-8") as f:
    json.dump(questions, f, ensure_ascii=False, indent=2)

print(f"💾 Saved to {output_path} (size: {os.path.getsize(output_path)} bytes)")
