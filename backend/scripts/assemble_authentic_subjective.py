import json
import os
import sys

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from subjective_banking import get_banking_subjective_questions
from subjective_it import get_it_subjective_questions

banking_qs = get_banking_subjective_questions()
it_qs = get_it_subjective_questions()

print(f"Loaded {len(banking_qs)} Banking Subjective Questions")
print(f"Loaded {len(it_qs)} Technical IT Subjective Questions")

all_new_subjective = banking_qs + it_qs
print(f"Total authentic subjective questions ready to assemble: {len(all_new_subjective)}")

output_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), "authentic_subjective_batch.json")
with open(output_file, "w", encoding="utf-8") as f:
    json.dump(all_new_subjective, f, ensure_ascii=False, indent=2)

print(f"Saved {len(all_new_subjective)} questions to {output_file}")
