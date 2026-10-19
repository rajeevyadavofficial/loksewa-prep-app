# -*- coding: utf-8 -*-
"""
Shared base utility for generating authentic Lok Sewa Subjective Questions.
Enforces the 4-tier Lok Sewa answer structure:
1. Introduction & Theoretical Foundation (१. परिचय तथा सैद्धान्तिक अवधारणा)
2. Core Technical/Legal Principles, Structures & Tables (२. मुख्य प्राविधिक/कानुनी व्यवस्था र संरचना)
3. Operational Bottlenecks, Risks & Challenges (३. कार्यान्वयनका चुनौती र समस्याहरू)
4. Practical Conclusion & Actionable Recommendations (४. निष्कर्ष तथा व्यावहारिक सुझावहरू)
"""

import json
import os

def create_subjective_q(
    q_id,
    paper,
    section,
    unit_number,
    unit_title,
    marks,
    years_asked,
    question_english,
    question_nepali,
    intro_english,
    intro_nepali,
    core_english,
    core_nepali,
    challenges_english,
    challenges_nepali,
    conclusion_english,
    conclusion_nepali
):
    ans_en = (
        f"1. Introduction & Theoretical Foundation:\n{intro_english.strip()}\n\n"
        f"2. Core Technical/Legal Principles & Structures:\n{core_english.strip()}\n\n"
        f"3. Operational Challenges & Bottlenecks:\n{challenges_english.strip()}\n\n"
        f"4. Conclusion & Actionable Recommendations:\n{conclusion_english.strip()}"
    )

    ans_np = (
        f"१. परिचय तथा सैद्धान्तिक अवधारणा:\n{intro_nepali.strip()}\n\n"
        f"२. मुख्य प्राविधिक/कानुनी व्यवस्था र संरचना:\n{core_nepali.strip()}\n\n"
        f"३. कार्यान्वयनका चुनौती र समस्याहरू:\n{challenges_nepali.strip()}\n\n"
        f"४. निष्कर्ष तथा व्यावहारिक सुझावहरू:\n{conclusion_nepali.strip()}"
    )

    return {
        "id": q_id,
        "exam_id": "rbb_it_5",
        "paper": paper,
        "section": section,
        "unit_number": unit_number,
        "unit_title": unit_title,
        "marks": marks,
        "type": "subjective",
        "years_asked": [years_asked] if isinstance(years_asked, str) else years_asked,
        "question_nepali": question_nepali.strip(),
        "question_english": question_english.strip(),
        "answer_nepali": ans_np,
        "answer_english": ans_en,
        "is_premium": False
    }

def save_batch_json(questions, filename):
    out_dir = os.path.dirname(os.path.abspath(__file__))
    file_path = os.path.join(out_dir, filename)
    with open(file_path, "w", encoding="utf-8") as f:
        json.dump(questions, f, ensure_ascii=False, indent=2)
    print(f" Saved {len(questions)} subjective questions to {file_path}")
    return file_path

def create_domain_batch(domain_prefix, paper, section, unit_num, unit_title, domain_topics, output_filename):
    qs = []
    for item in domain_topics:
        q_id = f"{domain_prefix}_{item[0]}"
        marks = item[1]
        yr = item[2]
        title_en = item[3]
        title_np = item[4]
        subtopics = item[5]

        q_en = f"Elaborate on {title_en}. Explain its theoretical foundations, architectural mechanisms, and implementation guidelines in enterprise Lok Sewa / banking systems."
        q_np = f"{title_np} बारे सविस्तार व्याख्या गर्नुहोस्। यसको सैद्धान्तिक आधार, संरचनात्मक कार्यप्रणाली र आधुनिक बैंकिङ तथा लोकसेवा प्रणालीमा यसको व्यावहारिक उपयोगिता प्रष्ट पार्नुहोस्।"

        intro_en = (
            f"{title_en} represents a foundational pillar in this technical domain. "
            f"It establishes the operational standards, formal architectures, and regulatory or technical mechanisms required for resilient, high-integrity enterprise systems."
        )
        intro_np = (
            f"{title_np} यस प्राविधिक/व्यवस्थापकीय विधाको एक प्रमुख आधारस्तम्भ हो। "
            f"यसले आधुनिक संगठन, सुरक्षित डिजिटल बैंकिङ र लोकसेवा प्रशासनका लागि आवश्यक प्राविधिक मापदण्ड, कानुनी आधार र कार्यप्रणालीको जग निर्माण गर्दछ।"
        )

        core_en = (
            f"1. Core Mechanisms & Internal Architecture:\n"
            f"   - Structural Foundations: Centered around {subtopics}.\n"
            f"   - Execution & Protocols: Operates via standardized workflows, deterministic protocols, and structured models ensuring high availability and fault containment.\n"
            f"   - Specifications: Enforces rigorous verification, error control, and boundary handling across all participating components.\n"
            f"2. Banking & Public Administration Utility:\n"
            f"   - Directly implemented within mission-critical Core Banking Systems (CBS) and public sector IT infrastructures.\n"
            f"   - Guarantees transactional consistency, regulatory auditability, and operational transparency."
        )
        core_np = (
            f"१. मुख्य प्राविधिक/व्यवस्थापकीय संरचना तथा कार्यविधि:\n"
            f"   - आधारभूत अवयवहरू: मुख्यतया {subtopics} मा आधारित रहेको छ।\n"
            f"   - कार्यप्रवाह र प्रोटोकल: अन्तर्राष्ट्रिय मापदण्ड, निश्चित कार्यविधि र स्वचालित संयन्त्र मार्फत त्रुटिरहित सञ्चालन।\n"
            f"   - प्राविधिक विवरण: प्रणालीका हरेक तहमा कडा नियमन, प्रमाणीकरण र सुरक्षात्मक नियन्त्रणको व्यवस्था।\n"
            f"२. बैंकिङ तथा सार्वजनिक प्रशासनमा उपयोगिता:\n"
            f"   - कोर बैंकिङ सफ्टवेयर (CBS) र सरकारी डिजिटल प्रणालीहरूमा सेवा प्रवाहलाई प्रभावकारी बनाउन प्रयोग।\n"
            f"   - पारदर्शिता, कानुनी पालना, अडिट योग्यता र डाटा शुद्धता कायम राख्ने मूल आधार।"
        )

        chal_en = (
            f"1. Scalability bottlenecks and resource constraints during peak concurrent transactional spikes.\n"
            f"2. Complexity of ongoing maintenance, legacy interoperability, and continuous security patching.\n"
            f"3. Strict regulatory compliance oversight, skill gap challenges, and failover synchronization overheads."
        )
        chal_np = (
            f"१. अत्यधिक कार्यचाप हुँदा प्रणालीको गति सुस्त हुने र स्रोत व्यवस्थापनमा देखिने जटिलता।\n"
            f"२. पुराना प्रणालीसँग नयाँ प्रविधि जोड्दा (Legacy Integration) र सुरक्षा अद्यावधिक गर्दा आउने प्राविधिक चुनौती।\n"
            f"३. कडा नीतिगत नियमन पालना, दक्ष जनशक्तिको अभाव र विपद् व्यवस्थापन (Disaster Recovery) मा लाग्ने लागत।"
        )

        concl_en = (
            f"In conclusion, comprehensive mastery over {title_en} empowers IT officers and banking leaders to design robust, compliant, and future-proof systems delivering exceptional public and financial value."
        )
        concl_np = (
            f"निष्कर्षमा, {title_np} को पूर्ण सैद्धान्तिक र व्यावहारिक ज्ञानले बैंक तथा सरकारी निकायका अधिकृतहरूलाई सुरक्षित, भरपर्दो र समयसापेक्ष प्रणाली निर्माण तथा सञ्चालन गर्न पूर्ण सक्षम बनाउँछ।"
        )

        qs.append(create_subjective_q(
            q_id, paper, section, unit_num, unit_title,
            marks, yr, q_en, q_np, intro_en, intro_np, core_en, core_np, chal_en, chal_np, concl_en, concl_np
        ))

    save_batch_json(qs, output_filename)
    return len(qs)

