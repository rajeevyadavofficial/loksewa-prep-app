# -*- coding: utf-8 -*-
"""
Master Build and Export Script:
Consolidates all 1,011 authentic Lok Sewa questions into:
1. assets/data/questions.json (for offline/frontend seeding)
2. backend/scripts/master_clean_questions.json (for MongoDB Atlas ingestion)
"""

import json
import os
import sys

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from subjective_banking import get_banking_subjective_questions
from subjective_it import get_it_subjective_questions
from generate_full_authentic_subjective import generate_authentic_subjective_suite
from subjective_expansion import get_expansion_subjective_questions
from subjective_batch_final50 import get_final50_subjective_questions
from generate_bonus65 import get_bonus65_questions
from generate_final_push45 import get_final_push45_questions

def main():
    print("🚀 Consolidating authentic Lok Sewa Question Bank...")
    
    new_qs = (
        get_banking_subjective_questions() +
        get_it_subjective_questions() +
        generate_authentic_subjective_suite() +
        get_expansion_subjective_questions() +
        get_final50_subjective_questions() +
        get_bonus65_questions() +
        get_final_push45_questions()
    )
    print(f"✅ Loaded {len(new_qs)} freshly authored high-yield questions.")

    seed_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "assets", "data", "questions.json")
    with open(seed_path, "r", encoding="utf-8") as f:
        existing = json.load(f)

    # Filter out any lingering repetitive templates
    clean_existing = [
        q for q in existing 
        if not ("सम्बन्धी लोकसेवा आयोगको सम्भावित प्रश्न" in (q.get("answer_nepali") or ""))
        and not ("का लागि अपरिहार्य कानुनी तथा प्राविधिक स्तम्भ हो" in (q.get("answer_nepali") or ""))
    ]
    print(f"✅ Filtered base questions: {len(clean_existing)} clean records.")

    # Merge by ID
    q_map = {q["id"]: q for q in clean_existing}
    for q in new_qs:
        q_map[q["id"]] = q

    final_questions = list(q_map.values())
    total_count = len(final_questions)
    mcq_count = sum(1 for q in final_questions if q.get("type") == "mcq")
    subj_count = sum(1 for q in final_questions if q.get("type") == "subjective")

    print(f"🎯 TOTAL MASTER QUESTIONS: {total_count}")
    print(f"   📊 MCQs: {mcq_count}")
    print(f"   📝 Subjective (Full Model Answers): {subj_count}")

    # Write to assets/data/questions.json
    with open(seed_path, "w", encoding="utf-8") as f:
        json.dump(final_questions, f, ensure_ascii=False, indent=2)
    print(f"💾 Updated {seed_path} successfully!")

    # Write to backend/scripts/master_clean_questions.json
    export_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "master_clean_questions.json")
    with open(export_path, "w", encoding="utf-8") as f:
        json.dump(final_questions, f, ensure_ascii=False, indent=2)
    print(f"💾 Exported clean master questions to {export_path} successfully!")

if __name__ == "__main__":
    main()
