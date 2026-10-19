import json
import os
import sys

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from subjective_banking import get_banking_subjective_questions
from subjective_it import get_it_subjective_questions
from generate_full_authentic_subjective import generate_authentic_subjective_suite

# Combine all newly authored comprehensive subjective questions
new_subjective = (
    get_banking_subjective_questions() +
    get_it_subjective_questions() +
    generate_authentic_subjective_suite()
)

print(f"Total newly authored high-yield subjective model Q&As: {len(new_subjective)}")

# Load existing assets/data/questions.json
seed_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "assets", "data", "questions.json")
with open(seed_path, "r", encoding="utf-8") as f:
    existing_questions = json.load(f)

print(f"Current total questions in seed: {len(existing_questions)}")

# Filter out repetitive loop template questions
clean_questions = []
removed_count = 0
for q in existing_questions:
    ans_np = q.get("answer_nepali") or ""
    if "सम्बन्धी लोकसेवा आयोगको सम्भावित प्रश्न" in ans_np or "का लागि अपरिहार्य कानुनी तथा प्राविधिक स्तम्भ हो" in ans_np:
        removed_count += 1
    else:
        clean_questions.append(q)

print(f"Purged {removed_count} template placeholder questions.")
print(f"Retained {len(clean_questions)} verified genuine questions (MCQs & original Subjective).")

# Merge new authentic subjective questions by ID
q_map = {q["id"]: q for q in clean_questions}
for q in new_subjective:
    q_map[q["id"]] = q

final_questions = list(q_map.values())
print(f"🎯 Final High-Yield Master Question Bank Count: {len(final_questions)}")

mcq_count = sum(1 for q in final_questions if q.get("type") == "mcq")
subj_count = sum(1 for q in final_questions if q.get("type") == "subjective")
print(f"   - MCQs: {mcq_count}")
print(f"   - Subjective with Full Model Answers: {subj_count}")

# Save to assets/data/questions.json
with open(seed_path, "w", encoding="utf-8") as f:
    json.dump(final_questions, f, ensure_ascii=False, indent=2)

print(f"💾 Updated {seed_path} successfully!")

# Also dump clean batch for Node.js MongoDB Atlas sync
clean_export = os.path.join(os.path.dirname(os.path.abspath(__file__)), "master_clean_questions.json")
with open(clean_export, "w", encoding="utf-8") as f:
    json.dump(final_questions, f, ensure_ascii=False, indent=2)

print(f"📦 Exported {clean_export} for MongoDB Atlas update.")
