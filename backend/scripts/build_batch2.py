import json
import os
import sys

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from generate_unit4 import get_unit4_questions
from generate_unit5 import get_unit5_questions
from generate_unit6 import get_unit6_questions

u4 = get_unit4_questions()
u5 = get_unit5_questions()
u6 = get_unit6_questions()

total_questions = u4 + u5 + u6

print(f"✅ Generated Unit 4: {len(u4)} questions")
print(f"✅ Generated Unit 5: {len(u5)} questions")
print(f"✅ Generated Unit 6: {len(u6)} questions")
print(f"🎯 Total Batch 2 Questions: {len(total_questions)}")

output_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "batch2_questions.json")
with open(output_path, "w", encoding="utf-8") as f:
    json.dump(total_questions, f, ensure_ascii=False, indent=2)

print(f"💾 Saved to {output_path} (size: {os.path.getsize(output_path)} bytes)")
