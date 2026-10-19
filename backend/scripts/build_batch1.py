import json
import os
import sys

# Add scripts directory to path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from generate_unit1 import get_unit1_questions
from generate_unit2 import get_unit2_questions
from generate_unit3 import get_unit3_questions

u1 = get_unit1_questions()
u2 = get_unit2_questions()
u3 = get_unit3_questions()

total_questions = u1 + u2 + u3

print(f"✅ Generated Unit 1: {len(u1)} questions")
print(f"✅ Generated Unit 2: {len(u2)} questions")
print(f"✅ Generated Unit 3: {len(u3)} questions")
print(f"🎯 Total Batch 1 Questions: {len(total_questions)}")

output_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "batch1_questions.json")
with open(output_path, "w", encoding="utf-8") as f:
    json.dump(total_questions, f, ensure_ascii=False, indent=2)

print(f"💾 Saved to {output_path} (size: {os.path.getsize(output_path)} bytes)")
