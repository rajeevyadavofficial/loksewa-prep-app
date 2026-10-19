import json
import os

questions = []

def add_mcq(q_id, unit_num, unit_title, q_en, q_np, opts, correct_idx, expl_en, expl_np, years):
    explanation = f"{expl_en}\n\nनेपाली व्याख्या: {expl_np}"
    questions.append({
        "id": q_id,
        "exam_id": "rbb_it_5",
        "paper": "paper1",
        "section": "sectionB",
        "unit_number": unit_num,
        "unit_title": unit_title,
        "marks": 1,
        "type": "mcq",
        "years_asked": years,
        "question_nepali": q_np,
        "question_english": q_en,
        "options": opts,
        "correct_option_index": correct_idx,
        "explanation": explanation,
        "is_premium": False
    })

print("Starting generation of Batch 1 (250 MCQs)...")
