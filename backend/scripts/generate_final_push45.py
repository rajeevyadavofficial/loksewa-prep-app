# -*- coding: utf-8 -*-
"""
Final 45 High-Yield Questions to securely cross 1,000+ Questions:
- 15 Subjective Questions with full Lok Sewa 3-tier model answers
- 30 Practical & Syllabus-Aligned MCQs with in-depth bilingual explanations
"""

def get_final_push45_questions():
    qs = []

    def add_sub(q_id, paper, sec, u_num, u_title, marks, yr, q_en, q_np, ans_en, ans_np):
        qs.append({
            "id": q_id,
            "exam_id": "rbb_it_5",
            "paper": paper,
            "section": sec,
            "unit_number": u_num,
            "unit_title": u_title,
            "marks": marks,
            "type": "subjective",
            "years_asked": [yr],
            "question_nepali": q_np,
            "question_english": q_en,
            "answer_nepali": ans_np,
            "answer_english": ans_en,
            "is_premium": False
        })

    def add_mcq(q_id, paper, sec, u_num, u_title, q_en, q_np, opts, ans, expl_en, expl_np, yr):
        qs.append({
            "id": q_id,
            "exam_id": "rbb_it_5",
            "paper": paper,
            "section": sec,
            "unit_number": u_num,
            "unit_title": u_title,
            "marks": 1,
            "type": "mcq",
            "years_asked": [yr],
            "question_nepali": q_np,
            "question_english": q_en,
            "options": opts,
            "correct_option_index": ans,
            "explanation": f"{expl_en}\n\nनेपाली व्याख्या: {expl_np}",
            "is_premium": False
        })

    # ==========================================
    # 15 HIGH-YIELD SUBJECTIVE MODEL ANSWERS
    # ==========================================

    # 1. Foreign Exchange Regulation Act 2019 (10M)
    add_sub("p1a_u1_sub250", "paper1", "sectionA", 1, "Unit 1: Financial Institutions in Nepal", 10, "2078 BS - RBB IT",
        "Explain the key objectives and statutory provisions of the Foreign Exchange (Regulation) Act, 2019. What measures does Nepal Rastra Bank take to curb illegal cross-border fund transfers (Hundi)?",
        "विदेशी विनिमय (नियमित गर्ने) ऐन, २०१९ का प्रमुख उद्देश्य तथा कानुनी व्यवस्थाहरू प्रष्ट पार्नुहोस्। अवैध सीमापार रकम स्थानान्तरण (हुण्डी) नियन्त्रण गर्न नेपाल राष्ट्र बैंकले चालेका प्रमुख कदमहरू के-के हुन्?",
        """1. Introduction & Statutory Background:
The **Foreign Exchange (Regulation) Act, 2019 (विदेशी विनिमय नियमित गर्ने ऐन, २०१९)** is the apex legislation governing foreign currency transactions, reserve management, cross-border payments, and licensing of foreign exchange dealers in Nepal. Administered by Nepal Rastra Bank (NRB) Foreign Exchange Management Department, it ensures exchange rate stability and prevents capital flight.

2. Key Statutory Provisions:
* **Licensing of Forex Dealers (Section 3):** No person or entity may buy, sell, or exchange foreign currencies without obtaining a valid operating license from NRB (Class A, B, C banks, money changers, hotels, and travel agencies).
* **Custody of Foreign Exchange Reserves (Section 4):** All foreign currencies received from exports, tourism, and inward remittances must be routed through licensed BFIs or surrendered to NRB.
* **Prohibition of Unauthorized Cross-Border Payments (Section 9):** Sending capital abroad, purchasing offshore real estate, or maintaining unauthorized overseas bank accounts without NRB prior approval is strictly prohibited.
* **Penalties for Offenses:** Unlawful transactions and unauthorized forex holding attract confiscation of the entire transacted amount plus fines up to three times the amount or imprisonment up to 3 years.

3. Hundi (हुण्डी) Mechanisms & Its Economic Threat:
Hundi is an informal, trust-based value transfer system operating outside formal banking channels where money is paid in one country (e.g., UAE, Qatar) and disbursed domestically in Nepal without foreign exchange entering the formal banking system. This deprives the state of foreign currency reserves, fosters tax evasion, and finances contraband smuggling.

4. NRB & Regulatory Anti-Hundi Measures:
1. **Incentivizing Formal Remittance:** Provision of an additional 1.0% interest rate premium on remittance fixed deposits mobilized in commercial banks.
2. **Expansion of Digital Remittance Gateways:** Integration of National Payment Interface (NPI) with international remittance corridors and fintech wallets.
3. **Low-Fee Direct Wallet Transfers:** Encouraging zero/minimal transaction fees on retail worker remittances under \$500.
4. **Mandatory Reporting & FIU Monitoring:** Real-time AML/CFT cross-border wire transfer monitoring through goAML.
5. **Enforcement Coordination:** Joint coordination with the Department of Revenue Investigation (DRI) and Central Investigation Bureau (CIB) for criminal prosecution.

5. Conclusion:
Rigorous enforcement of the Foreign Exchange Act 2019 alongside frictionless, affordable digital remittance corridors is essential to safeguard Nepal's sovereign foreign currency reserves.""",
        """१. परिचय तथा कानुनी पृष्ठभूमि:
नेपालमा विदेशी विनिमयको सञ्चिति, कारोबार, नियमन तथा अवैध पुँजी पलायन नियन्त्रण गर्न जारी गरिएको प्रमुख ऐन **विदेशी विनिमय (नियमित गर्ने) ऐन, २०१९** हो। नेपाल राष्ट्र बैंकले यस ऐन अन्तर्गत रहेर विदेशी विनिमय नीति, इजाजतपत्र र सञ्चिति व्यवस्थापन गर्दछ।

२. ऐनका प्रमुख कानुनी व्यवस्थाहरू:
* **इजाजतपत्र अनिवार्य (दफा ३):** नेपाल राष्ट्र बैंकको पूर्वस्वीकृति तथा इजाजतपत्र बिना कसैले पनि विदेशी मुद्रा खरिद, बिक्री वा सटही गर्न नपाउने।
* **विदेशी मुद्राको समर्पण र अभिलेख (दफा ४):** निर्यात, विप्रेषण, पर्यटन आदिबाट प्राप्त विदेशी मुद्रा आधिकारिक बैंकिङ च्यानलमार्फत दाखिला हुनुपर्ने।
* **विदेशमा लगानी प्रतिबन्ध (दफा ९):** राष्ट्र बैंकको अनुमतिबिना विदेशमा घरजग्गा खरिद गर्न, विदेशी बैंक खाता खोल्न वा पुँजी लगानी गर्न पूर्ण रूपमा निषेध।
* **दण्ड तथा सजाय:** अवैध विदेशी मुद्रा कारोबार गरेमा बिगो जफत गरी बिगोको तीन गुणासम्म जरिवाना र ३ वर्षसम्म कैद सजायको व्यवस्था।

३. हुण्डी कारोबार (Hundi) र यसको आर्थिक असर:
हुण्डी औपचारिक बैंकिङ प्रणाली बाहिरबाट गरिने अनौपचारिक रकम स्थानान्तरण हो। यसले गर्दा विदेशी मुद्रा मुलुकको औपचारिक सञ्चितिमा नआई विदेशमै रहन्छ, जसले गर्दा विदेशी मुद्राको अभाव, राजस्व चुहावट र कालोबजारी बढ्छ।

४. हुण्डी नियन्त्रणका लागि नेपाल राष्ट्र बैंकका प्रमुख उपायहरू:
१. **विप्रेषण खातामा अतिरिक्त ब्याज:** रेमिट्यान्स बचत तथा मुद्दती खातामा साधारण निक्षेपभन्दा १% थप ब्याजदर दिने नीति।
२. **डिजिटल रेमिट्यान्स विस्तार:** NPI तथा वालेटहरू मार्फत सिधै बैंक खातामा न्यून शुल्कमा तत्काल विप्रेषण जम्मा हुने व्यवस्था।
३. **कडा अनुगमन र goAML प्रणाली:** वाणिज्य बैंकहरूमा शंकास्पद सीमापार कारोबार (Suspicious Transaction) को वित्तीय जानकारी इकाई (FIU) मार्फत अनुगमन।
४. **राजस्व अनुसन्धान र कानुनी कारबाही:** राजस्व अनुसन्धान विभाग तथा नेपाल प्रहरीको सिआईबी (CIB) सँग समन्वय गरी हुण्डी सञ्चालकहरूमाथि कडा कारबाही।

५. निष्कर्ष:
विदेशी विनिमय ऐन २०१९ को प्रभावकारी कार्यान्वयन र रेमिट्यान्सलाई सरल, छिटो र सस्तो डिजिटल बैंकिङमा आबद्ध गर्नु नै राष्ट्रिय अर्थतन्त्र सुदृढीकरणको मुख्य आधार हो।""")

    # 2. Internal Audit vs Statutory Audit vs NRB Inspection (10M)
    add_sub("p1a_u2_sub251", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology", 10, "2077 BS - RBB IT",
        "Differentiate between Internal Audit, Statutory (External) Audit, and Nepal Rastra Bank Supervisory Inspection in commercial banks. Explain their respective roles in risk management.",
        "वाणिज्य बैंकहरूमा आन्तरिक लेखापरीक्षण, बाह्य (वैधानिक) लेखापरीक्षण र नेपाल राष्ट्र बैंकको सुपरिवेक्षकीय निरीक्षण बीचको भिन्नता स्पष्ट पार्दै जोखिम व्यवस्थापनमा यिनीहरूको भूमिका उल्लेख गर्नुहोस्।",
        """1. Introduction:
In modern commercial banking, the **Three Lines of Defense** framework relies on robust audit and supervisory oversight to ensure regulatory compliance, financial integrity, and operational soundness. Internal audit, statutory audit, and NRB inspection represent distinct tiers of control.

2. Comparative Analysis Matrix:
| Dimension | Internal Audit (आन्तरिक लेखापरीक्षण) | Statutory/External Audit (बाह्य लेखापरीक्षण) | NRB Supervisory Inspection (राष्ट्र बैंक निरीक्षण) |
|---|---|---|---|
| **Governing Law / Basis** | BAFIA 2073 Section 60; Audit Committee Directives | Companies Act 2063; BAFIA 2073; NFRS/NAS | NRB Act 2058 Section 84; CAMELS framework |
| **Executing Body** | Bank's internal audit department or contracted CA firm | Independent Chartered Accountant firm appointed by AGM | NRB Bank Supervision Department Inspection Officers |
| **Reporting Line** | Directly reports to the **Board Audit Committee** | Reports to **Shareholders (AGM)** and copied to NRB | Reports to **NRB Governor & Board of Directors** |
| **Primary Scope** | Day-to-day operational control, procedural compliance, CBS IT audits | Truth and fairness of Financial Statements (Balance Sheet, P&L) | Regulatory compliance, systemic solvency, capital adequacy, AML |
| **Frequency** | Continuous / quarterly branch risk-based auditing | Annual (after fiscal year-end closing) | Annual on-site comprehensive inspection + off-site surveillance |

3. Roles in Banking Risk Management:
1. **Internal Audit:** Acts as the 3rd line of defense. Evaluates CBS access logs, branch cash limits, credit documentation perfection, and IT disaster recovery preparedness, preventing ongoing fraud.
2. **Statutory Audit:** Guarantees credibility of reported balance sheets, verifies loan loss provisions (LLP), tax computations, and ensures alignment with Nepal Financial Reporting Standards (NFRS 9).
3. **NRB Inspection:** Evaluates institutional solvency under **CAMELS** criteria (Capital, Assets, Management, Earnings, Liquidity, Sensitivity) and issues mandatory corrective action plans or Prompt Corrective Action (PCA).

4. Conclusion:
Harmonious functioning and non-compromised independence across these three oversight tiers ensure that commercial banks like Rastriya Banijya Bank remain resilient against systemic shocks.""",
        """१. अवधारणा:
वाणिज्य बैंकहरूमा आर्थिक सुशासन, वित्तीय अनुशासन र जोखिम न्यूनीकरणका लागि बहुस्तरीय लेखापरीक्षण तथा निरीक्षण प्रणाली लागु गरिएको हुन्छ। आन्तरिक, बाह्य र केन्द्रीय बैंक निरीक्षण यसका मुख्य स्तम्भहरू हुन्।

२. तुलनात्मक भिन्नता तालिका:
| आधार | आन्तरिक लेखापरीक्षण | बाह्य (वैधानिक) लेखापरीक्षण | नेपाल राष्ट्र बैंक निरीक्षण |
|---|---|---|---|
| **कानुनी आधार** | बाफिया २०७३ को दफा ६०; लेखापरीक्षण समिति | कम्पनी ऐन २०६३; बाफिया २०७३; NFRS | नेपाल राष्ट्र बैंक ऐन २०५८ को दफा ८४ |
| **परीक्षक** | बैंकको आन्तरिक लेखापरीक्षण विभाग वा तोकिएको CA | वार्षिक साधारण सभा (AGM) द्वारा नियुक्त स्वतन्त्र CA | राष्ट्र बैंकको बैंक सुपरिवेक्षण विभागका अधिकृतहरू |
| **प्रतिवेदन कसलाई?** | सञ्चालक समितिको **लेखापरीक्षण समिति** लाई | **शेयरधनीहरूको साधारण सभा** र राष्ट्र बैंकलाई | **गभर्नर तथा राष्ट्र बैंक सञ्चालक समिति** लाई |
| **उद्देश्य र क्षेत्र** | दैनिक कार्यसञ्चालन, नीतिगत पालना र आन्तरिक नियन्त्रण | वित्तीय विवरण (नाफा-नोक्सान, वासलात) को यथार्थता प्रमाणीकरण | CAMELS विधिबाट बैंकिङ स्वास्थ्य, नियमन पालना र जोखिम मूल्याङ्कन |
| **समयावधि** | निरन्तर वा त्रैमासिक रूपमा | प्रत्येक आर्थिक वर्षको अन्त्यमा वार्षिक रूपमा | वर्षको कम्तीमा एक पटक स्थलगत (On-site) र निरन्तर गैर-स्थलगत |

३. जोखिम व्यवस्थापनमा भूमिका:
* **आन्तरिक लेखापरीक्षण:** दैनिक कार्य सञ्चालन त्रुटि, जालसाजी र CBS प्रणालीका कमजोरीहरू समयमै औंल्याई सच्याउन मद्दत गर्दछ।
* **बाह्य लेखापरीक्षण:** वित्तीय विवरणहरूको विश्वसनीयता कायम गरी लगानीकर्ता र निक्षेपकर्ताहरूको विश्वास आर्जन गर्दछ।
* **राष्ट्र बैंक निरीक्षण:** प्रणालीगत जोखिम (Systemic Risk) पहिचान गरी बैंकलाई वित्तीय संकटबाट जोगाउन सुधारात्मक कदम चाल्न बाध्यकारी निर्देशन दिन्छ।

४. निष्कर्ष:
यी तीनै तहका परीक्षणहरूले आ-आफ्नो स्वतन्त्रता र व्यावसायिकता कायम राख्दा बैंकमा पारदर्शिता, उत्तरदायित्व र संस्थागत सुशासन कायम हुन्छ।""")

    # 3. RBB Employee Bylaws 2070: Code of Conduct & Penalties (10M)
    add_sub("p1a_u3_sub252", "paper1", "sectionA", 3, "Unit 3: Human Resource & Office Management", 10, "2079 BS - RBB IT",
        "Elaborate on the Code of Conduct and Disciplinary Penalties specified in the Rastriya Banijya Bank Limited Employee Service Bylaws, 2070. What is the constitutional right of appeal for an aggrieved employee?",
        "राष्ट्रिय वाणिज्य बैंक लिमिटेड कर्मचारी सेवा विनियमावली, २०७० मा उल्लेखित कर्मचारीको आचरण र विभागीय सजाय सम्बन्धी व्यवस्थाहरूको सविस्तार व्याख्या गर्नुहोस्। पीडित कर्मचारीको पुनरावेदन सम्बन्धी कानुनी अधिकार के छ?",
        """1. Introduction:
The **Rastriya Banijya Bank Limited Employee Service Bylaws, 2070 (कर्मचारी सेवा विनियमावली, २०७०)** sets forth terms of employment, career progression, operational discipline, and code of conduct for bank staff, ensuring integrity and customer trust.

2. Code of Conduct for RBBL Employees (कर्मचारीले पालन गर्नुपर्ने आचरण):
* **Punctuality & Discipline:** Regular attendance, loyalty to the bank, and obedience to lawful managerial instructions.
* **Secrecy & Confidentiality:** Strict prohibition against disclosing customer account balances, passwords, IT architecture, or institutional policies.
* **Prohibition on Political Participation:** Barred from contesting political elections or openly partisan political activities.
* **Prohibition on Private Business & Secondary Employment:** Cannot run personal commercial enterprises or accept secondary employment without written board consent.
* **Prohibition on Gift/Gratuity Acceptance:** Barred from accepting loans, financial gifts, or personal favors from bank clients or contractors.

3. Disciplinary Penalties (विभागीय सजायका प्रकार):
The Bylaws classify departmental penalties into two distinct categories:
1. **Minor Penalties (सामान्य सजाय):**
   * Written censure / reprimand (नसिहत दिने).
   * Withholding of annual grade increments (वार्षिक तलब वृद्धि रोक्का) for up to two years.
   * Withholding of promotion (बढुवा रोक्का) for up to two years.
2. **Major Penalties (विशेष सजाय):**
   * Demotion to a lower post or lower pay-scale grade.
   * Dismissal from service without disqualification for future government/bank employment (सेवाबाट हटाउने).
   * Dismissal from service with permanent disqualification for future government/bank employment (सेवाबाट बर्खास्त गर्ने - in cases of severe embezzlement, fraud, moral turpitude).

4. Due Process & Right of Appeal (पुनरावेदन सम्बन्धी व्यवस्था):
* **Principle of Natural Justice:** Prior to imposing any penalty, a mandatory formal charge-sheet and 15-day explanation notice (स्पष्टीकरण सोध्ने) must be served to the employee.
* **Appellate Authority:** An employee aggrieved by a penalty imposed by the Appointing Authority can file an appeal to the designated **Appellate Authority (पुनरावेदन सुन्ने अधिकारी)** within 35 days of receipt of the decision.
* **Administrative Court / High Court Jurisdiction:** If dissatisfied with the departmental appeal, the employee has the constitutional right to seek legal remedy at the Administrative Court or High Court under writ jurisdiction.

5. Conclusion:
Strict observance of service bylaws coupled with fair disciplinary due process ensures operational excellence and employee morale across RBBL's nationwide branches.""",
        """१. परिचय:
राष्ट्रिय वाणिज्य बैंक लिमिटेडका कर्मचारीहरूको सेवा, सर्त, कार्यसम्पादन, अनुशासन र वृत्ति विकासलाई व्यवस्थित गर्न **राष्ट्रिय वाणिज्य बैंक लिमिटेड कर्मचारी सेवा विनियमावली, २०७०** लागु गरिएको छ।

२. कर्मचारीले पालन गर्नुपर्ने प्रमुख आचरणहरू:
* **समयपालन र कर्तव्यपरायणता:** कार्यालय समयको पूर्ण पालना गर्ने, बैंकप्रति निष्ठावान् रहने र उच्च अधिकारीको निर्देशन मान्ने।
* **गोपनीयता कायम राख्ने:** बैंकका ग्राहकको वित्तीय विवरण, पासवर्ड, आन्तरिक सूचना वा प्राविधिक प्रणाली बाहिर चुहावट गर्न पूर्ण निषेध।
* **राजनीतिमा भाग लिन नहुने:** कुनै पनि राजनीतिक दलको सदस्यता लिन वा चुनावी गतिविधिमा संलग्न हुन नपाइने।
* **अन्य व्यापार व्यवसाय गर्न नहुने:** बैंकको पूर्वस्वीकृति बिना अन्यत्र नोकरी गर्न वा व्यक्तिगत व्यवसाय सञ्चालन गर्न नहुने।
* **दान, उपहार वा आर्थिक लाभ लिन नहुने:** बैंकका ग्राहक वा सरोकारवालाबाट प्रत्यक्ष वा अप्रत्यक्ष व्यक्तिगत फाइदा लिन नहुने।

३. विभागीय सजायका प्रकारहरू:
विनियमावली बमोजिम अनुशासनहीन कार्य गरेमा दुई प्रकारका सजायको व्यवस्था छ:
१. **सामान्य सजाय:**
   * नसिहत दिने।
   * २ वर्षसम्म तलब वृद्धि (Grade) रोक्का गर्ने।
   * २ वर्षसम्म बढुवा रोक्का गर्ने।
२. **विशेष सजाय:**
   * तल्लो पद वा सुरु तलब स्केलमा घटुवा गर्ने।
   * भविष्यमा बैंक सेवाको निमित्त अयोग्य नठहरिने गरी सेवाबाट हटाउने।
   * भविष्यमा सरकारी वा बैंक सेवाको निमित्त अयोग्य ठहरिने गरी सेवाबाट बर्खास्त गर्ने (जालसाजी, भ्रष्टाचार वा नैतिक पतन हुने फौजदारी अभियोगमा)।

४. प्राकृतिक न्यायको सिद्धान्त र पुनरावेदनको अधिकार:
* कुनै पनि विभागीय सजाय गर्नुअघि आरोपित कर्मचारीलाई सफाइ पेश गर्ने १५ दिनको लिखित स्पष्टीकरणको मौका दिनैपर्छ।
* सजायको निर्णय उपर चित्त नबुझेमा निर्णय भएको सूचना पाएको मितिले ३५ दिनभित्र तोकिएको **पुनरावेदन सुन्ने अधिकारी** समक्ष पुनरावेदन गर्न सकिन्छ।
* त्यहाँबाट पनि न्याय नपाएमा उच्च अदालत वा प्रशासनिक अदालतमा जान पाउने कानुनी हक सुरक्षित रहन्छ।

५. निष्कर्ष:
स्पष्ट आचरण र निष्पक्ष विभागीय कारबाही प्रणालीले बैंकमा अनुशासन र उच्च कार्यसम्पादन संस्कृतिको विकास गर्दछ।""")

    # 4. Maslow vs Herzberg Theories in Bank IT (10M)
    add_sub("p1a_u4_sub253", "paper1", "sectionA", 4, "Unit 4: Management Concepts & Principles", 10, "2076 BS - RBB IT",
        "Compare and contrast Maslow's Hierarchy of Needs and Herzberg's Two-Factor Motivation Theory. How can public commercial banks apply these theories to attract and retain skilled IT professionals?",
        "मास्लोको आवश्यकताको शृङ्खला सिद्धान्त र हर्जवर्गको दुई-तत्वीय उत्प्रेरणा सिद्धान्त बीच तुलना गर्नुहोस्। दक्ष सूचना प्रविधि (IT) जनशक्तिलाई आकर्षित र टिकाई राख्न सरकारी बैंकहरूले यी सिद्धान्तहरू कसरी प्रयोग गर्न सक्छन्?",
        """1. Introduction:
Employee motivation is central to organizational productivity. **Abraham Maslow's Need Hierarchy (1943)** and **Frederick Herzberg's Motivation-Hygiene Theory (1959)** provide complementary frameworks to understand employee drives, particularly for high-demand IT professionals.

2. Conceptual Comparison Matrix:
| Dimension | Maslow's Hierarchy of Needs | Herzberg's Two-Factor Theory |
|---|---|---|
| **Structure** | 5 hierarchical levels: Physiological $\to$ Safety $\to$ Social $\to$ Esteem $\to$ Self-Actualization | 2 distinct categories: Hygiene Factors (extrinsic) & Motivators (intrinsic) |
| **Order of Progression** | Rigid sequential progression: lower needs must be satisfied before higher needs emerge | Simultaneous: hygiene factors eliminate dissatisfaction; motivators drive satisfaction |
| **View of Money/Salary** | Basic physiological/safety need | Purely a Hygiene factor (prevents dissatisfaction, does not motivate) |
| **Applicability to Modern Knowledge Workers** | Descriptive, broad human psychology | Pragmatic, job-enrichment and workplace-centric |

3. Application in Public Commercial Banks to Retain IT Talent:
Public sector banks (like RBBL) often struggle with talent turnover due to aggressive compensation packages offered by foreign fintech firms and private banks. These models offer actionable strategies:

* **Hygiene Factors (Preventing Dissatisfaction):**
  * *Competitive Market Allowances:* Specialized technical IT allowance (प्राविधिक भत्ता) over baseline government pay scales.
  * *Modern Tech Stack & Hardware:* Provision of high-performance dev workstations, dual monitors, and cloud sandboxes.
  * *Job Security & Healthcare:* Leveraging the civil-service level pension and medical coverage unique to state banks.

* **Motivational Factors (Inspiring High Performance):**
  * *Challenging Projects & Innovation:* Entrusting IT staff with high-impact national infrastructure (e.g., Core Banking migration, AI fraud engines).
  * *Professional Certifications & Sponsored Training:* Sponsoring globally recognized certifications (CISSP, CISA, AWS Solutions Architect).
  * *Autonomy & Flexible Work Policy:* Providing agile sprint autonomy, remote incident response flexibility, and clear fast-track technical promotion ladders (Dual-ladder technical track).

4. Conclusion:
While public banks cannot always compete solely on base cash compensation, combining solid hygiene security with intrinsic technological challenges and professional recognition ensures long-term IT retention.""",
        """१. अवधारणा:
कर्मचारीलाई कार्यप्रति समर्पित र उत्साहित बनाउन उत्प्रेरणा (Motivation) आवश्यक हुन्छ। अब्राहम मास्लोको आवश्यकता शृङ्खला (१९४३) र फ्रेडरिक हर्जवर्गको दुई-तत्वीय सिद्धान्त (१९५९) व्यवस्थापनका सर्वाधिक चर्चित सिद्धान्तहरू हुन्।

२. सैद्धान्तिक तुलना:
* **मास्लोको ५ तह:** १. शारीरिक आवश्यकता $\to$ २. सुरक्षा $\to$ ३. सामाजिक $\to$ ४. सम्मान $\to$ ५. आत्म-सन्तुष्टि।
* **हर्जवर्गका २ तत्व:**
  * *आरोग्यता तत्व (Hygiene Factors):* तलब, कार्यस्थलको वातावरण, कम्पनी नीति, सुरक्षा। यिनीहरूले असन्तुष्टि हटाउँछन् तर आफैं उत्प्रेरित गर्दैनन्।
  * *उत्प्रेरक तत्व (Motivators):* उपलब्धि, कदर, उत्तरदायित्व, व्यक्तिगत तथा वृत्ति विकास। यिनीहरूले वास्तविक सन्तुष्टि र उत्प्रेरणा दिन्छन्।

३. सरकारी बैंकमा IT जनशक्ति टिकाउन व्यावहारिक उपयोग:
सरकारी बैंकहरूमा निजी क्षेत्र र बहुराष्ट्रिय कम्पनीको तुलनामा दक्ष प्राविधिक जनशक्ति टिकाउन ठूलो चुनौती छ। यसका लागि निम्न उपाय अवलम्बन गर्नुपर्छ:
* **आरोग्यता तत्वहरूको व्यवस्थापन (असन्तुष्टि रोक्न):**
  * आकर्षक प्राविधिक तथा कार्यसम्पादन भत्ताको व्यवस्था।
  * अत्याधुनिक कम्प्युटर, सफ्टवेयर औजार र सहज कार्य वातावरण।
  * स्थायी जागिरको सुरक्षा र उपदान/पेन्सन सुविधा।
* **उत्प्रेरक तत्वहरूको व्यवस्थापन (सन्तुष्टि र समर्पण बढाउन):**
  * राष्ट्रिय स्तरका ठूला डिजिटल प्रोजेक्टहरू (जस्तै: नयाँ CBS, AI फ्रड डिटेक्सन) को नेतृत्व दिने।
  * CISA, CISSP, CEH जस्ता अन्तर्राष्ट्रिय प्रमाणपत्रका लागि बैंकले शुल्क बेहोर्ने गरी तालिमको व्यवस्था।
  * प्राविधिक कर्मचारीका लागि छुट्टै 'प्राविधिक पदोन्नति मार्ग (Technical Career Path)' को व्यवस्था।

४. निष्कर्ष:
सरकारी बैंकहरूले उचित सेवा-सुविधा (Hygiene) सँगै प्राविधिक स्वतन्त्रता र वृत्ति विकासका अवसर (Motivators) प्रदान गरेमा दक्ष IT जनशक्तिलाई दीर्घकालसम्म टिकाउन सकिन्छ।""")

    # 5. Public Procurement Act: E-GP System (10M)
    add_sub("p1a_u5_sub254", "paper1", "sectionA", 5, "Unit 5: Office Management & Technology", 10, "2078 BS - RBB IT",
        "Discuss the significance and workflow of the Electronic Government Procurement (e-GP) system under the Public Procurement Act, 2063. What are the specific procurement challenges for IT systems in public banks?",
        "सार्वजनिक खरिद ऐन, २०६३ बमोजिम विद्युतीय सरकारी खरिद प्रणाली (e-GP) को महत्त्व र कार्यप्रणाली प्रष्ट पार्नुहोस्। सरकारी बैंकहरूमा सूचना प्रविधि (IT) खरिद गर्दा देखा पर्ने विशिष्ट चुनौतीहरू के-के हुन्?",
        """1. Introduction:
The **Public Procurement Act, 2063 (सार्वजनिक खरिद ऐन, २०६३)** mandates fairness, competition, and value for money in public institutions. Under Section 67, the **Electronic Government Procurement (e-GP)** web portal (`bolpatra.gov.np`) operated by the Public Procurement Monitoring Office (PPMO) digitizes public procurement to eliminate physical cartelling and bureaucratic delays.

2. Significance of the e-GP System:
* **Elimination of Physical Collusion:** Bidders upload bids electronically, eliminating physical intimidation and tender box tampering.
* **Transparency & Public Scrutiny:** Tender notices, bid opening summaries, and evaluation reports are publicly hosted.
* **Operational Efficiency:** Reduces paperwork, storage costs, and bid submission timelines.
* **Broad Geographic Participation:** International and remote national vendors can submit bids seamlessly.

3. Standard e-GP Workflow:
1. **Procurement Master Plan (PMP) & Annual Plan (APP):** Approved budget allocation and tender sequencing.
2. **Notice Publication & Document Upload:** Bidding documents published online with precise Terms of Reference (TOR).
3. **Electronic Bid Submission:** Encrypted bid submission with scanned bank guarantees for Bid Security.
4. **Automated Bid Opening:** Public online opening where bids are decrypted in the presence of registered bidders.
5. **Technical & Financial Evaluation:** Bid Evaluation Committee (BEC) scores technical bids before opening financial bids.
6. **Letter of Intent (LOI) & Contract Award:** 7-day notice of intention to award contract, followed by contract signing after Performance Security deposit.

4. Specific Challenges in Banking IT Procurement:
* **Rapid Technological Obsolescence:** Strict procurement cycles taking 6-12 months result in procuring outdated server hardware or legacy software versions.
* **Low-Bidder (L1) Trap:** Public procurement bias toward the lowest financial bidder often results in inferior vendor support, buggy customization, and abandoned implementation.
* **Proprietary Vendor Lock-in:** Sourcing licenses for specialized Core Banking Systems (CBS) or Oracle databases often requires single-source direct procurement, which conflicts with standard competitive bidding.
* **Complex SLA & Cybersecurity Metrics:** Difficulty in quantifying continuous security patching and 24/7 incident response in standard public tender formats.

5. Conclusion:
Adopting Quality and Cost-Based Selection (QCBS) along with specialized multi-stage IT procurement guidelines is critical for modernizing banking technology under public procurement laws.""",
        """१. परिचय:
सार्वजनिक निकायहरूमा पारदर्शिता, स्वच्छता र मितव्ययिता कायम गर्न **सार्वजनिक खरिद ऐन, २०६३** जारी गरिएको हो। यसको दफा ६७ बमोजिम सार्वजनिक खरिद अनुगमन कार्यालय (PPMO) ले सञ्चालन गरेको **विद्युतीय सरकारी खरिद (e-GP) प्रणाली** ले सम्पूर्ण खरिद प्रक्रियालाई डिजिटल बनाएको छ।

२. e-GP प्रणालीको महत्त्व:
* **मिलेमतो र धाँधलीको अन्त्य:** भौतिक रूपमा बोलपत्र दर्ता गर्दा हुने डर, त्रास र कार्टेलिङ अन्त्य भएको छ।
* **पारदर्शिता र स्वच्छता:** बोलपत्र आह्वानदेखि मूल्यांकन र सम्झौतासम्मका सबै प्रक्रिया अनलाइन पोर्टलमा सार्वजनिक हुन्छन्।
* **समय र लागतको बचत:** कागजी झन्झट हटी छिटो र कम खर्चमा खरिद प्रक्रिया सम्पन्न हुन्छ।
* **प्रतिस्पर्धा विस्तार:** देशभित्र र बाहिरका योग्य कम्पनीहरूले जुनसुकै स्थानबाट सहजै भाग लिन पाउँछन्।

३. e-GP को प्रमुख कार्यप्रणाली (Workflow):
१. वार्षिक खरिद योजना (APP) तयारी र बजेट विनियोजन।
२. e-GP पोर्टलमा बोलपत्र आह्वान सम्बन्धी सूचना र Bidding Document प्रकाशन।
३. अनलाइन बोलपत्र दर्ता (Electronic Bid Submission) र बिड बन्ड दाखिला।
४. विद्युतीय माध्यमबाट बोलपत्र खोल्ने (Online Bid Opening)।
५. प्राविधिक तथा आर्थिक मूल्यांकन (Technical & Financial Evaluation)।
६. आशयको सूचना (Letter of Intent - LOI) प्रकाशन र कार्यसम्पादन जमानत (Performance Bond) लिई सम्झौता।

४. सरकारी बैंकमा IT खरिद गर्दाका चुनौतीहरू:
* **न्यूनतम कबोल (L1) को समस्या:** सबैभन्दा कम मूल्य कबोल गर्नेले ठेक्का पाउने नियमले गर्दा गुणस्तरहीन सफ्टवेयर वा कमजोर प्राविधिक सहयोग आउने जोखिम।
* **प्रविधिको द्रुत परिवर्तन:** खरिद प्रक्रिया सम्पन्न हुन लामो समय लाग्दा खरिद गरिएको प्रविधि पुरानो भइसक्ने।
* **भेन्डर लक-इन (Vendor Lock-in):** कोर बैंकिङ सफ्टवेयर (CBS) र डाटाबेस निश्चित कम्पनीका मात्र हुने हुँदा खुला प्रतिस्पर्धा गराउन कठिन हुने।
* **मर्मत सम्भार (AMC) र SLA व्यवस्थापन:** सफ्टवेयरको निरन्तर अपडेट र २४/७ साइबर सुरक्षा सहयोग सम्झौता व्यवस्थापनमा जटिलता।

५. निष्कर्ष:
सरकारी बैंकहरूले IT खरिद गर्दा केवल मूल्यलाई मात्र नहेरी गुणस्तर र प्राविधिक क्षमता (QCBS विधि) लाई प्राथमिकता दिनु कानुनी र व्यावहारिक आवश्यकता हो।""")

    # 6. Cache Memory Mapping Techniques (10M)
    add_sub("p1b_u1_sub255", "paper1", "sectionB", 1, "Unit 1: Computer Architecture & Organization", 10, "2077 BS - RBB IT",
        "Describe the three main Cache Memory Mapping Techniques (Direct, Fully Associative, and Set-Associative). Compare their hardware complexity, hit/miss performance, and cache replacement policies.",
        "क्यास मेमोरी म्यापिङका तीन प्रमुख प्रविधिहरू (Direct, Fully Associative, र Set-Associative) को व्याख्या गर्नुहोस्। तिनीहरूको हार्डवेयर जटिलता, कार्यक्षमता र क्यास रिप्लेसमेन्ट नीतिहरू तुलना गर्नुहोस्।",
        """1. Introduction:
**Cache Memory** is a high-speed semiconductor SRAM memory placed between the CPU and Main Memory (RAM) to bridge the speed mismatch gap. Cache mapping dictates how a memory block from RAM is mapped onto cache lines.

2. The Three Cache Mapping Techniques:

1. **Direct Mapping (प्रत्यक्ष म्यापिङ):**
   * *Mechanism:* Each block of main memory maps to exactly one specific cache line given by formula: $i = j \pmod m$ (where $i$ = cache line, $j$ = main memory block number, $m$ = total cache lines).
   * *Address Structure:* Divided into Tag, Line/Index, and Word Offset.
   * *Pros:* Simple hardware, fastest lookup time.
   * *Cons:* High conflict miss rate; if two frequently accessed blocks map to the same line, continuous cache thrashing occurs.

2. **Fully Associative Mapping (पूर्ण सम्बद्ध म्यापिङ):**
   * *Mechanism:* Any block of main memory can be placed into *any* available cache line.
   * *Address Structure:* Divided into Tag and Word Offset (no line index).
   * *Pros:* Lowest conflict miss rate, maximum flexibility.
   * *Cons:* Requires expensive parallel comparators to search all cache tags simultaneously, increasing hardware complexity and power consumption.

3. **Set-Associative Mapping (सेट-सम्बद्ध म्यापिङ - e.g., N-way):**
   * *Mechanism:* Cache lines are grouped into sets, where each set contains $N$ lines (e.g., 2-way, 4-way, 8-way). A memory block maps to a specific set ($s = j \pmod S$), but can occupy *any* line within that set.
   * *Address Structure:* Tag, Set Index, and Word Offset.
   * *Pros:* Optimal industry trade-off balancing hardware cost, lookup speed, and low conflict misses.

3. Cache Replacement Policies (in Associative & Set-Associative):
When a cache set is full and a miss occurs, an existing line must be evicted:
* **Least Recently Used (LRU):** Discards the line that has not been referenced for the longest period (most optimal empirical hit rate).
* **First-In, First-Out (FIFO):** Discards the line that entered the cache first, regardless of recent usage.
* **Least Frequently Used (LFU):** Evicts the block with the lowest reference count.
* **Random Replacement:** Evicts a randomly selected line with minimal hardware overhead.

4. Comparison Summary:
| Metric | Direct Mapping | Set-Associative (4/8 Way) | Fully Associative |
|---|---|---|---|
| **Hardware Complexity** | Lowest | Moderate | Highest |
| **Search Speed** | Instant (Index lookup) | Fast (Parallel set search) | Slower (Full search) |
| **Conflict Misses** | Highest | Low | Zero |
| **Common Modern Use** | L1 Instruction caches | Modern L1/L2/L3 CPUs | TLB (Translation Lookaside) |

5. Conclusion:
Modern high-performance banking server processors employ multi-level caching with 8-way or 16-way set-associativity to sustain millions of transactions per second.""",
        """१. अवधारणा:
सीपीयू (CPU) र मुख्य मेमोरी (RAM) बीचको गति भिन्नतालाई सम्बोधन गर्न प्रयोग गरिने तीव्र गतिको मेमोरीलाई **क्यास मेमोरी (Cache Memory)** भनिन्छ। मुख्य मेमोरीको डाटा ब्लकलाई क्यासको कुन लाइनमा राख्ने भन्ने नियमलाई क्यास म्यापिङ भनिन्छ।

२. क्यास म्यापिङका तीन प्रमुख प्रविधिहरू:

१. **Direct Mapping (प्रत्यक्ष म्यापिङ):**
   * *कार्यविधि:* मुख्य मेमोरीको प्रत्येक ब्लक क्यासको एउटा निश्चित लाइनमा मात्र बस्न पाउँछ ($Line = Block \pmod{TotalLines}$)।
   * *फाइदा:* हार्डवेयर डिजाइन सरल र खोजी गति तीव्र हुन्छ।
   * *बेफाइदा:* Conflict Miss धेरै हुन्छ; दुई फरक डाटा एउटै लाइनमा पर्न गएमा बारम्बार डाटा फेरबदल (Thrashing) भइरहन्छ।

२. **Fully Associative Mapping (पूर्ण सम्बद्ध म्यापिङ):**
   * *कार्यविधि:* मुख्य मेमोरीको कुनै पनि ब्लक क्यासको जुनसुकै खाली लाइनमा बस्न सक्छ।
   * *फाइदा:* Conflict Miss शून्य हुन्छ, क्यासको अधिकतम उपयोग हुन्छ।
   * *बेफाइदा:* सबै ट्यागहरू एकैचोटि खोज्न महँगो Comparator हार्डवेयर चाहिन्छ, जसले गर्दा विद्युत् खपत र लागत बढ्छ।

३. **Set-Associative Mapping (सेट-सम्बद्ध म्यापिङ):**
   * *कार्यविधि:* क्यासलाई निश्चित सेटहरूमा विभाजन गरिन्छ (जस्तै: 2-way, 4-way, 8-way)। मेमोरी ब्लक निश्चित सेटमा जान्छ तर त्यो सेटभित्रको जुनसुकै लाइनमा बस्न सक्छ।
   * *फाइदा:* Direct Mapping को गति र Fully Associative को लचकताको उत्कृष्ट सम्मिश्रण। आधुनिक प्रोसेसरहरूमा यही विधि प्रयोग हुन्छ।

३. क्यास रिप्लेसमेन्ट नीतिहरू (Replacement Policies):
क्यास भरिएको अवस्थामा नयाँ डाटा ल्याउन पुरानो डाटा हटाउने विधिहरू:
* **LRU (Least Recently Used):** सबैभन्दा लामो समयदेखि प्रयोग नभएको डाटा हटाउने (सबैभन्दा बढी प्रयोग हुने विधि)।
* **FIFO (First-In, First-Out):** क्यासमा पहिले प्रवेश गरेको डाटा पहिले हटाउने।
* **LFU (Least Frequently Used):** सबैभन्दा कम पटक प्रयोग भएको डाटा हटाउने।

४. निष्कर्ष:
आधुनिक बैंकिङ सर्भरहरूमा डाटा प्रोसेसिङ तीव्र बनाउन मल्टि-लेभल क्यास (L1, L2, L3) र Set-Associative म्यापिङको प्रयोग गरिन्छ।""")

    # 7. Process Synchronization: Critical Section & Semaphores (10M)
    add_sub("p1b_u2_sub256", "paper1", "sectionB", 2, "Unit 2: Operating System", 10, "2079 BS - RBB IT",
        "Define the Critical Section Problem in Operating Systems. What are the three requirements for a valid solution? Explain how Binary and Counting Semaphores solve the producer-consumer synchronization problem.",
        "अपरेटिङ सिस्टममा क्रिटिकल सेक्सन समस्या (Critical Section Problem) परिभाषित गर्नुहोस्। यसको समाधानका तीन अनिवार्य सर्तहरू के-के हुन्? बाइनरी र काउन्टिङ सेमाफोरले उत्पादक-उपभोक्ता (Producer-Consumer) समस्या कसरी समाधान गर्दछन्?",
        """1. Introduction:
In concurrent operating systems, when multiple cooperating processes access and manipulate shared resources (such as bank account balances or database buffers) concurrently, the outcome depends on the particular order in which access takes place. This situation is called a **Race Condition**. The code segment accessing shared resources is known as the **Critical Section (CS)**.

2. The Three Mandatory Criteria for CS Solutions:
Any valid algorithmic or OS synchronization mechanism must satisfy:
1. **Mutual Exclusion (पारस्परिक बहिष्कार):** If process $P_i$ is executing in its critical section, no other process can execute in its critical section simultaneously.
2. **Progress (प्रगति):** If no process is executing in its CS and some processes wish to enter, only those processes that are not executing in their remainder sections can participate in deciding who enters next, and this selection cannot be postponed indefinitely.
3. **Bounded Waiting (सीमित प्रतीक्षा):** There must be a bound on the number of times other processes are allowed to enter their critical sections after a process has made a request to enter, preventing thread starvation.

3. Semaphores:
A **Semaphore** is an integer synchronization variable $S$ accessed only through two atomic primitive operations:
* `wait(S)` or `P(S)`: Decrements $S$. If $S \le 0$, the calling process blocks.
* `signal(S)` or `V(S)`: Increments $S$. Unblocks one waiting process.

* **Binary Semaphore (Mutex):** Value restricted to 0 or 1. Used strictly for mutual exclusion.
* **Counting Semaphore:** Value spans an unrestricted integer range. Used to manage access to a finite pool of identical resources.

4. Solving Bounded-Buffer Producer-Consumer Problem:
* **Shared State:** Buffer of size $N$; `mutex` initialized to 1; `empty` initialized to $N$; `full` initialized to 0.

* **Producer Process:**
```c
do {
    // produce an item in next_produced
    wait(empty); // decrement empty slots
    wait(mutex); // acquire exclusive lock
    // add next_produced to buffer
    signal(mutex); // release lock
    signal(full);  // increment filled slots
} while (true);
```

* **Consumer Process:**
```c
do {
    wait(full);  // wait for at least one filled slot
    wait(mutex); // acquire exclusive lock
    // remove item from buffer to next_consumed
    signal(mutex); // release lock
    signal(empty); // increment empty slots
    // consume item in next_consumed
} while (true);
```

5. Conclusion:
Semaphores eliminate race conditions in core banking transaction processors, preventing data corruption during concurrent fund debits and credits.""",
        """१. अवधारणा:
मल्टिटास्किङ अपरेटिङ सिस्टममा दुई वा सोभन्दा बढी प्रोसेसहरूले एउटै साझा स्रोत (जस्तै: बैंक खाताको मौज्दात वा सेयर मेमोरी) एकैपटक परिवर्तन गर्न खोज्दा अन्तिम नतिजा प्रोसेसको कार्यान्वयन क्रममा निर्भर हुने अवस्थालाई **Race Condition** भनिन्छ। साझा स्रोत चलाउने कोडको भागलाई **क्रिटिकल सेक्सन (Critical Section)** भनिन्छ।

२. क्रिटिकल सेक्सन समाधानका तीन अनिवार्य सर्तहरू:
१. **Mutual Exclusion (पारस्परिक बहिष्कार):** यदि कुनै एउटा प्रोसेस आफ्नो क्रिटिकल सेक्सनमा काम गरिरहेको छ भने अरू कुनै पनि प्रोसेसलाई सो समयमा प्रवेश गर्न दिनु हुँदैन।
२. **Progress (प्रगति):** क्रिटिकल सेक्सन खाली भएको अवस्थामा बाहिर रहेका प्रोसेसहरूले मात्र पालो निर्धारण गर्न पाउनुपर्छ र यो निर्णय अनिश्चितकालसम्म रोकिनु हुँदैन।
३. **Bounded Waiting (सीमित प्रतीक्षा):** कुनै प्रोसेसले प्रवेशका लागि अनुरोध गरेपछि अरू प्रोसेसहरूले कति पटक प्रवेश पाउने भन्ने निश्चित सीमा हुनुपर्छ, जसले गर्दा कुनै पनि प्रोसेस भोकै (Starvation) मर्न नपरोस्।

३. सेमाफोर (Semaphore) को अवधारणा:
सेमाफोर एक इन्टिजर रिएबल हो, जसलाई दुईवटा परमाणु (Atomic) कार्यहरूबाट मात्र चलाइन्छ:
* `wait(S)` वा `P(S)`: मान घटाउने। मान शून्य वा ऋणात्मक भएमा प्रोसेस रोकिन्छ।
* `signal(S)` वा `V(S)`: मान बढाउने र रोकिरहेको अर्को प्रोसेसलाई सक्रिय बनाउने।
* **Binary Semaphore:** मान ० र १ मात्र हुने (एकपटकमा एक प्रोसेसलाई मात्र अनुमति)।
* **Counting Semaphore:** सीमित स्रोतहरूको संख्या नियन्त्रण गर्न जुनसुकै संख्या हुनसक्ने।

४. Producer-Consumer समस्याको समाधान:
उत्पादकले बफर भरिएपछि पर्खनुपर्ने र उपभोक्ताले बफर खाली भएपछि पर्खनुपर्ने अवस्थालाई `mutex`, `empty`, र `full` सेमाफोर प्रयोग गरी सुरक्षित बनाइन्छ।

५. निष्कर्ष:
बैंकिङ कोर बैंकिङ सफ्टवेयरमा लाखौं ग्राहकले एकै सेकेन्डमा रकम ट्रान्सफर गर्दा डाटा शुद्धता जोगाउन सेमाफोर र म्युटेक्सको भूमिका अनिवार्य हुन्छ।""")

    # 8. Database Indexing: B-Tree vs B+ Tree (10M)
    add_sub("p1b_u3_sub257", "paper1", "sectionB", 3, "Unit 3: Database Management System", 10, "2078 BS - RBB IT",
        "Explain the internal architecture of B-Tree and B+ Tree indexing in relational database management systems (RDBMS). Why do banking database engines (like Oracle and PostgreSQL) prefer B+ Trees for transaction indexing?",
        "सम्बन्धात्मक डाटाबेस प्रणाली (RDBMS) मा B-Tree र B+ Tree इन्डेक्सिङको आन्तरिक संरचना प्रष्ट पार्नुहोस्। बैंकिङ डाटाबेस इन्जिनहरू (Oracle र PostgreSQL) ले कारोबार इन्डेक्सिङका लागि B+ Tree किन रोज्छन्?",
        """1. Introduction:
In commercial banking RDBMS engines hosting hundreds of millions of ledger entries, linear sequential disk scans are prohibitively expensive ($O(N)$). **Self-balancing search trees (B-Tree and B+ Tree)** provide logarithmic search, insertion, and deletion complexity ($O(\log N)$) optimized for block storage.

2. Structural Comparison:

1. **B-Tree Architecture:**
   * Both internal (non-leaf) nodes and leaf nodes store both **Search Keys** and actual **Data Records (or record disk pointers)**.
   * Search can terminate at an internal node if the target key is matched.
   * Traversal requires in-order depth-first tree traversal.

2. **B+ Tree Architecture:**
   * **Internal Nodes:** Store only search keys and child page pointers (routing indices). No actual record pointers are stored.
   * **Leaf Nodes:** Store all actual data records (or disk pointers) along with keys.
   * **Doubly-Linked Leaf Chain:** All leaf nodes are linked sequentially in sorted order forming a contiguous bidirectional linked list.

3. Why Banking Engines Exclusively Prefer B+ Trees:
1. **Higher Fan-out and Lower Tree Height:** Because internal nodes store only routing keys and no data pointers, many more keys fit into a single 8KB/16KB disk page. A 3-level B+ Tree can index millions of banking records, requiring only 3 disk I/O operations per query.
2. **Lightning-Fast Range Queries:** In banking, audit reports frequently query transaction date ranges (e.g., `WHERE tx_date BETWEEN '2081-01-01' AND '2081-06-30'`). In a B+ tree, the engine searches the tree once to find the start date leaf node, and then simply traverses the leaf linked list sequentially without re-traversing the tree.
3. **Predictable Query Latency:** In B+ Trees, every key search reaches a leaf node, guaranteeing uniform $O(\log N)$ search latency for real-time ATM and mobile banking authorizations.
4. **Efficient Sequential Table Scans:** Reading the entire table in sorted primary key order requires only scanning the contiguous leaf chain.

4. Comparison Summary:
| Parameter | B-Tree | B+ Tree |
|---|---|---|
| **Data Storage** | Leaf and internal nodes | Only leaf nodes |
| **Leaf Linkage** | Leaves are isolated | Leaves linked in sequential list |
| **Range Queries** | Inefficient (in-order tree walks) | Highly efficient (linear leaf scan) |
| **Page Capacity (Fan-out)** | Lower | Much higher |
| **Primary Industry Use** | File systems (ext4) | RDBMS (Oracle, PostgreSQL, MySQL InnoDB) |

5. Conclusion:
The superior fan-out and linked leaf structure of B+ trees make them the indispensable backbone for high-throughput relational banking databases.""",
        """१. अवधारणा:
लाखौं ग्राहक र करोडौं कारोबार भएका बैंकिङ डाटाबेसमा कुनै विवरण खोज्न सम्पूर्ण टेबल स्क्यान गर्नु असम्भव हुन्छ। डाटाबेस इन्जिनहरूले डिस्कबाट डाटा तीव्र गतिमा खोज्न **B-Tree र B+ Tree** इन्डेक्सिङ प्रयोग गर्दछन्।

२. B-Tree र B+ Tree को आन्तरिक संरचना:
* **B-Tree:**
  * यसको Internal (भित्री) नोड र Leaf (पात) नोड दुवैमा Key र डाटा रेकर्डका प्वाइन्टरहरू राखिन्छन्।
  * खोज्दा बीचकै नोडमा डाटा भेटिए खोज अन्त्य हुन सक्छ।
* **B+ Tree:**
  * यसको भित्री नोडहरूमा केवल Key र बाटो देखाउने Child Pointers मात्र हुन्छन्।
  * सबै वास्तविक डाटा रेकर्डहरू केवल अन्तिम **Leaf नोडहरूमा मात्र** भण्डारण हुन्छन्।
  * सबै Leaf नोडहरू आपसमा क्रमैसँग Linked List मार्फत जोडिएका हुन्छन्।

३. बैंकिङ डाटाबेस (Oracle, PostgreSQL) ले B+ Tree रोज्नुका कारणहरू:
१. **उच्च Fan-out र कम उचाइ (Tree Height):** भित्री नोडमा डाटा नहुने हुँदा एउटै डिस्क ब्लकमा धेरै कुञ्जीहरू अटाउँछन्। यसले गर्दा २-३ पटकको डिस्क रिडमै लाखौं रेकर्डहरू भेट्टाउन सकिन्छ।
२. **रेन्ज क्वेरी (Range Queries) मा असाधारण गति:** बैंकमा निश्चित मितिभित्रका कारोबार खोज्नुपर्ने (जस्तै: बैशाखदेखि असारसम्म) क्वेरीहरू धेरै हुन्छन्। B+ Tree मा सुरुको नोड भेटेपछि लिङ्क्ड लिस्टबाट सिधै लगातार डाटा पढ्न सकिन्छ।
३. **समान र अनुमानयोग्य गति (Consistent Search Time):** हरेक डाटा खोज्न Leaf नोडसम्मै पुग्नुपर्ने हुँदा ATM र मोबाइल बैंकिङको कारोबार समय सधैं समान र भरपर्दो हुन्छ।

४. निष्कर्ष:
बढी डाटा अटाउने क्षमता र रेन्ज खोजीमा अतुलनीय गतिको कारण आधुनिक RDBMS हरूले कारोबार इन्डेक्सिङमा B+ Tree लाई पहिलो प्राथमिकता दिएका हुन्।""")

    # 9. Routing Protocols: OSPF vs RIP vs BGP (10M)
    add_sub("p1b_u4_sub258", "paper1", "sectionB", 4, "Unit 4: Data Communication & Computer Networks", 10, "2079 BS - RBB IT",
        "Compare Open Shortest Path First (OSPF), Routing Information Protocol (RIP), and Border Gateway Protocol (BGP). Design an enterprise banking WAN network integrating these routing protocols.",
        "OSPF, RIP, र BGP बीच तुलना गर्नुहोस्। यी रुटिङ प्रोटोकलहरूलाई संयोजन गरी बैंकको बृहत् नेटवर्क (Enterprise Banking WAN) को डिजाइन संरचना प्रस्तुत गर्नुहोस्।",
        """1. Introduction:
Routing protocols dynamically discover network topologies and forward packets along optimal paths. They are broadly categorized as **Interior Gateway Protocols (IGP)** operating within an Autonomous System (AS) and **Exterior Gateway Protocols (EGP)** connecting distinct autonomous systems.

2. Routing Protocols Comparative Matrix:
| Parameter | RIP (v2) | OSPF (v2/v3) | BGP (v4) |
|---|---|---|---|
| **Routing Algorithm** | Distance-Vector (Bellman-Ford) | Link-State (Dijkstra SPF) | Path-Vector |
| **Metric** | Hop Count (Max 15 hops) | Cost (based on bandwidth) | Policy attributes (AS-Path, Local Pref) |
| **Convergence Speed** | Very Slow (up to 180s) | Fast (instant LSA triggers) | Slow to moderate (stability prioritized) |
| **Protocol & Port** | UDP port 520 | Direct IP protocol 89 | TCP port 179 |
| **Hierarchy / Scope** | Flat network | Area-based (Backbone Area 0) | Autonomous Systems (eBGP & iBGP) |
| **Scalability** | Small branch LANs (<15 hops) | Enterprise Intranets / WAN | Global Internet & Inter-Bank switches |

3. Enterprise Banking WAN Architecture Design:
In a commercial bank like Rastriya Banijya Bank connecting 300+ branches, Data Center (DC), Disaster Recovery (DR) site, and external clearing houses:

1. **Core Backbone / Data Center & DR (OSPF Area 0):**
   * High-speed redundant optical links connecting Head Office, Primary DC, and DR site run **OSPF Backbone Area 0**.
   * Delivers sub-second convergence using Dijkstra SPF if an optical dark fiber path fails.
2. **Branch WAN Mesh (OSPF Multi-Area):**
   * The 7 provinces are segregated into distinct non-backbone areas (Area 1 = Koshi, Area 2 = Madhesh, ..., Area 7 = Sudurpashchim) connected to Area 0 via Area Border Routers (ABRs).
   * Prevents link flap route recalculations in remote branches from overwhelming core DC routers.
3. **External Inter-Bank & Clearing Gateways (eBGP):**
   * Bank's edge border routers run **eBGP** peering with:
     * Nepal Clearing House Limited (NCHL / connectIPS / RPS).
     * Nepal Telecom and private WAN Telcos.
     * International SWIFT network.
   * Path filtering and autonomous system path prepending prevent the bank from accidentally acting as an open transit AS.

4. Conclusion:
Combining OSPF internally for low-latency intra-bank routing with BGP externally for policy-enforced inter-bank clearing ensures robust financial networking.""",
        """१. अवधारणा:
कम्प्युटर नेटवर्कमा डाटा प्याकेटलाई सबैभन्दा उत्तम बाटोबाट गन्तव्यसम्म पुर्‍याउन रुटिङ प्रोटोकलहरूको प्रयोग गरिन्छ। बैंकको बृहत् नेटवर्कमा आन्तरिक र बाह्य रुटिङका लागि फरक-फरक प्रोटोकल प्रयोग हुन्छन्।

२. तुलनात्मक विश्लेषण:
* **RIP (Routing Information Protocol):**
  * Distance-Vector विधिमा आधारित, Hop Count (अधिकतम १५) लाई मात्र मेट्रिक मान्ने।
  * सानो नेटवर्कमा मात्र उपयोगी, ढिलो कन्भर्जेन्स।
* **OSPF (Open Shortest Path First):**
  * Link-State विधिमा आधारित, Dijkstra को SPF एल्गोरिदम प्रयोग गर्ने।
  * ब्यान्डविथलाई Cost मान्ने, तीव्र कन्भर्जेन्स र एरिया (Area 0 Backbone) मा आधारित। बैंकको आन्तरिक नेटवर्कका लागि उत्कृष्ट।
* **BGP (Border Gateway Protocol):**
  * Path-Vector विधिमा आधारित, विभिन्न Autonomous Systems (AS) बीच रुटिङ गर्ने।
  * TCP पोर्ट १७९ प्रयोग गर्ने, सुरक्षा र नीतिगत नियन्त्रणमा सर्वाधिक भरपर्दो। इन्टरनेट र बैंक-बैंक बीचको नेटवर्कमा प्रयोग हुने।

३. बैंकको WAN नेटवर्कमा यिनीहरूको संयोजन:
* **शाखा र मुख्य कार्यालय (Intra-Bank WAN):** सम्पूर्ण ७७ जिल्लाका शाखाहरूलाई प्रदेश अनुसार OSPF का विभिन्न एरियाहरूमा बाँडी मुख्य डाटा सेन्टर (DC) सँग Backbone Area 0 मार्फत जोड्ने।
* **बाह्य निकाय र भुक्तानी प्रणाली (Inter-Bank Connectivity):** नेपाल क्लियरिङ हाउस (NCHL), भिसा (Visa/Mastercard), र SWIFT जस्ता बाह्य नेटवर्कसँग बैंकको बोर्डर राउटरले eBGP मार्फत सुरक्षित सम्बन्ध कायम गर्ने।

४. निष्कर्ष:
आन्तरिक रूपमा OSPF को गति र बाह्य रूपमा BGP को नीतिगत सुरक्षा संयोजन गरेर बैंकको सुरक्षित र अविच्छिन्न सञ्चार सञ्जाल निर्माण गर्न सकिन्छ।""")

    # 10. Agile Scrum vs Waterfall in CBS Upgrades (10M)
    add_sub("p1b_u5_sub259", "paper1", "sectionB", 5, "Unit 5: Software Engineering", 10, "2077 BS - RBB IT",
        "Compare the Agile Scrum framework with the Traditional Waterfall Model in the context of Core Banking System (CBS) upgrades. How can a bank manage risk during continuous digital feature rollouts?",
        "कोर बैंकिङ प्रणाली (CBS) स्तरोन्नतिको सन्दर्भमा एजाइल स्क्रम (Agile Scrum) र परम्परागत वाटरफल (Waterfall) मोडल बीच तुलना गर्नुहोस्। निरन्तर डिजिटल सुविधाहरू सार्वजनिक गर्दा बैंकले जोखिम कसरी व्यवस्थापन गर्न सक्छ?",
        """1. Introduction:
Software Development Life Cycle (SDLC) models determine how banking software is conceptualized, built, tested, and deployed. While the **Waterfall Model** emphasizes rigorous sequential phases, **Agile Scrum** prioritizes iterative delivery, adaptability, and cross-functional collaboration.

2. Model Comparison Matrix:
| Parameter | Waterfall Model | Agile Scrum Framework |
|---|---|---|
| **Approach** | Linear and sequential (Requirements $\to$ Design $\to$ Code $\to$ Test $\to$ Deploy) | Iterative and incremental sprints (typically 2-4 weeks) |
| **Requirement Flexibility** | Rigidly fixed upfront; change requests are costly | Flexible; Product Backlog groomed continuously based on market feedback |
| **Customer/User Involvement** | Only at inception (signoff) and final acceptance (UAT) | Continuous collaboration; Product Owner participates in every sprint |
| **Testing Phase** | Executed strictly after development phase completes | Continuous automated testing within every sprint |
| **Risk Profile** | High risk of late-stage project failure or misalignment | Early risk detection and working software increments |

3. Application in Core Banking System (CBS) Upgrades:
* **Hybrid / Bimodal Approach:**
  * *Waterfall for Core Ledger Engine:* Regulatory compliance, chart of accounts, and financial ledger calculations require immutable formal specifications and exhaustive end-to-end security audits. Waterfall or formal V-model fits best here.
  * *Agile Scrum for Digital Channels (Fintech Layer):* Mobile banking features (e.g., QR payment, digital fixed deposits, micro-loans via app) face rapid consumer demand and regulatory shifts. Scrum sprints allow rolling out features bi-weekly.

4. Managing Risk During Continuous Rollouts:
1. **Canary Deployments & Feature Flags:** Roll out new features to 5% of internal bank staff before general public exposure.
2. **Automated CI/CD Regression Testing:** Ensure core transaction APIs are tested against thousands of automated test cases before any code commit reaches production.
3. **Comprehensive Rollback Playbooks:** Automated database migration rollbacks in case of transaction ledger latency or reconciliation mismatches.
4. **Isolated Sandbox & Staging Environments:** Dedicated staging environments mirroring production CBS with sanitized data for user acceptance testing (UAT).

5. Conclusion:
Adopting a bimodal IT strategy—combining Waterfall rigor for the core banking ledger with Agile Scrum speed for digital consumer channels—optimizes both stability and innovation.""",
        """१. अवधारणा:
सफ्टवेयर विकास र प्रणाली स्तरोन्नतिमा कार्यविधि निर्धारण गर्न SDLC मोडलहरूको प्रयोग गरिन्छ। परम्परागत **वाटरफल मोडल** चरणबद्ध र कडा नियन्त्रणमा आधारित हुन्छ भने **एजाइल स्क्रम** छिटो, लचिलो र निरन्तर सुधारमा आधारित हुन्छ।

२. तुलनात्मक भिन्नता:
* **वाटरफल मोडल:** आवश्यकता संकलन $\to$ डिजाइन $\to$ कोडिङ $\to$ परीक्षण $\to$ जडान। एक चरण सकिएपछि मात्र अर्को सुरु हुने, बीचमा परिवर्तन गर्न असाध्यै कठिन।
* **एजाइल स्क्रम मोडल:** २ देखि ४ हप्ताका छोटा स्प्रिन्ट (Sprint) हरूमा काम गर्ने। आवश्यकता अनुसार प्राथमिकता फेर्न सकिने र निरन्तर सफ्टवेयरका अंशहरू सार्वजनिक गर्न सकिने।

३. बैंकको कोर बैंकिङ सफ्टवेयर (CBS) मा उपयुक्तता:
* **मूल लेजर र लेखा प्रणाली (Core Engine):** बाफिया ऐन, राष्ट्र बैंक निर्देशन र लेखा मापदण्ड कडा रूपमा पालना गर्नुपर्ने भएकाले कोर प्रणालीमा **वाटरफल मोडल** बढी सुरक्षित हुन्छ।
* **डिजिटल च्यानल (मोबाइल बैंकिङ, इन्टरनेट बैंकिङ):** नयाँ-नयाँ भुक्तानी सुविधा, वालेट इन्टिग्रेशन र ग्राहकका माग तुरुन्त सम्बोधन गर्न **एजाइल स्क्रम** अनिवार्य हुन्छ।

४. नयाँ सुविधाहरू सार्वजनिक गर्दा जोखिम न्यूनीकरणका उपायहरू:
१. **Canary Release:** नयाँ फिचर सुरुमा बैंकका १-२% कर्मचारीमा मात्र परीक्षण गरी सफल भएपछि मात्र आम ग्राहकमा जारी गर्ने।
२. **स्वचालित CI/CD परीक्षण:** नयाँ कोड उत्पादन प्रणालीमा जानुअघि स्वचालित रूपमा सबै सुरक्षा र कार्यक्षमता परीक्षण गर्ने।
३. **Rollback को पूर्वतयारी:** कुनै त्रुटि देखिएमा तुरुन्त पुरानै अवस्थामा फर्किन सकिने स्वचालित ब्याकअप र रोलब्याक स्क्रिप्ट तयार राख्ने।
४. **Staging Environment मा गहन UAT परीक्षण:** मुख्य डाटाबेसमा असर नपर्ने गरी वास्तविक जस्तै नमुना वातावरणमा प्रयोगकर्ता परीक्षण (UAT) गर्ने।

५. निष्कर्ष:
कोर बैंकिङको आधारभूत सुरक्षामा वाटरफल र ग्राहकमुखी डिजिटल च्यानलमा एजाइल विधि अपनाउनु (Bi-modal IT) नै आधुनिक बैंकहरूको सफल रणनीति हो।""")

    # 11. Zero Trust Architecture (ZTA) in Banking (10M)
    add_sub("p1b_u6_sub260", "paper1", "sectionB", 6, "Unit 6: Information Security & Cyber Laws", 10, "2079 BS - RBB IT",
        "Explain the core philosophy, architectural pillars, and implementation steps of Zero Trust Architecture (ZTA) in modern banking cybersecurity, as guided by the NRB Cyber Resilience Guidelines.",
        "नेपाल राष्ट्र बैंकको साइबर उत्थानशीलता मार्गदर्शनको आलोकमा आधुनिक बैंकिङ साइबर सुरक्षामा जेरो ट्रस्ट आर्किटेक्चर (Zero Trust Architecture) को मूल दर्शन, स्तम्भहरू र कार्यान्वयन चरणहरू प्रष्ट पार्नुहोस्।",
        """1. Introduction:
Traditional perimeter-based cybersecurity ("Castle-and-Moat") assumed that everything inside the internal corporate network is trustworthy. However, advanced persistent threats (APTs), insider collusion, and remote banking workforces have rendered perimeter models obsolete. **Zero Trust Architecture (ZTA)**, formalized by NIST SP 800-207 and mandated by the **NRB Cyber Resilience Guidelines 2023**, operates on the foundational principle: **"Never Trust, Always Verify"**.

2. Core Philosophical Principles of Zero Trust:
1. **Explicit Verification:** Always authenticate and authorize based on all available data points (user identity, location, device health, service or workload).
2. **Least Privilege Access:** Limit user access with Just-In-Time (JIT) and Just-Enough-Access (JEA) permissions.
3. **Assume Breach:** Minimize blast radius by segmenting networks, encrypting all end-to-end sessions, and monitoring analytics to detect anomalies.

3. The Five Core Pillars of Zero Trust:
1. **Identity (पहिचान):** Strict Multi-Factor Authentication (MFA), Privileged Access Management (PAM) for CBS root administrators, and conditional access policies.
2. **Devices (उपकरण):** Health compliance checks verifying OS patch levels, active EDR agents, and disk encryption before allowing connection.
3. **Networks (नेटवर्क):** Microsegmentation isolating the Swift gateway, ATM switch, CBS production database, and general office branch subnets from each other.
4. **Applications & Workloads (अनुप्रयोग):** Securing APIs with OAuth2/mTLS, continuous container scanning, and zero trust web application firewalls (WAF).
5. **Data (डाटा):** Encryption at rest (AES-256) and in transit (TLS 1.3), along with Data Loss Prevention (DLP) preventing customer ledger exfiltration.

4. Implementation Steps for Commercial Banks:
* **Step 1: Identify the Protect Surface:** Catalog crown-jewel assets (CBS database, SWIFT alliance server, mobile banking API gateways).
* **Step 2: Map Transaction Flows:** Document exactly which microservices, branches, and clearing switches interact with the protect surface.
* **Step 3: Architect Microsegments:** Deploy Next-Generation Firewalls (NGFW) and software-defined perimeter (SDP) rules blocking lateral attacker movement.
* **Step 4: Establish Zero Trust Policy:** Enforce adaptive risk-based access rules.
* **Step 5: Monitor and Automate:** Feed all logs into a 24/7 Security Operations Center (SOC) with automated SIEM/SOAR threat containment.

5. Conclusion:
Implementing Zero Trust transforms banking cyber defenses from reactive boundary walls into dynamic, granular, continuous verification protecting depositors' financial data.""",
        """१. अवधारणा:
परम्परागत साइबर सुरक्षामा बैंकको आन्तरिक नेटवर्कभित्र रहेका सबै कम्प्युटरलाई सुरक्षित मानिन्थ्यो। तर भित्री कर्मचारीको मिलेमतो र अत्याधुनिक ह्याकिङका कारण यो मोडल असफल भइसकेको छ। यसको विकल्पमा **नेपाल राष्ट्र बैंक साइबर उत्थानशीलता मार्गदर्शन २०२३** ले **Zero Trust Architecture (ZTA)** अवलम्बन गर्न जोड दिएको छ, जसको मूल मन्त्र **"कसैलाई विश्वास नगर्नुहोस्, सधैं प्रमाणीकरण गर्नुहोस् (Never Trust, Always Verify)"** हो।

२. जेरो ट्रस्टका तीन मूल सिद्धान्तहरू:
१. **सधैं स्पष्ट प्रमाणीकरण (Explicit Verification):** प्रयोगकर्ताको पहिचान, स्थान, डिभाइसको स्वास्थ्य र डाटा संवेदनशीलताका आधारमा प्रत्येक पटक प्रमाणीकरण गर्ने।
२. **न्यूनतम पहुँचको अधिकार (Least Privilege Access):** कर्मचारी वा सफ्टवेयरलाई आफ्नो काम गर्न चाहिने जति मात्र अधिकार दिने (JIT/JEA)।
३. **आक्रमण भइसकेको पूर्वमान्यता (Assume Breach):** नेटवर्कभित्र घुसपैठ भइसकेको अनुमान गरी नेटवर्कलाई टुक्राउने (Microsegmentation) र सम्पूर्ण डाटा इन्क्रिप्ट गर्ने।

३. जेरो ट्रस्टका पाँच मुख्य स्तम्भहरू:
१. **Identity (पहिचान):** बहुस्तरीय प्रमाणीकरण (MFA) र विशेषाधिकार व्यवस्थापन (PAM)।
२. **Devices (उपकरण):** बैंकका आधिकारिक, एन्टिभाइरस अपडेट भएका र सुरक्षित ल्यापटप/कम्प्युटरलाई मात्र नेटवर्कमा पहुँच दिने।
३. **Networks (नेटवर्क):** स्विफ्ट (SWIFT), एटीएम (ATM), र मुख्य बैंकिङ (CBS) नेटवर्कलाई छुट्टाछुट्टै Microsegment मा विभाजन गर्ने ताकि एउटा ह्याक हुँदा अर्कोमा असर नपरोस्।
४. **Applications (एप्लिकेसन):** सबै API हरूलाई सुरक्षित राख्ने र WAF को प्रयोग गर्ने।
५. **Data (डाटा):** बैंकको सम्पूर्ण डाटालाई विश्राम (At-Rest) र प्रसारण (In-Transit) दुवै अवस्थामा कडा इन्क्रिप्सन (AES-256) गर्ने।

४. कार्यान्वयन चरणहरू:
* बैंकका अतिसंवेदनशील सम्पत्तिहरू (Crown Jewels) पहिचान गर्ने।
* कारोबार प्रवाह (Transaction Flow) को नक्सांकन गर्ने।
* सफ्टवेयर-डिफाइन्ड माइक्रोसेग्मेन्टेसन लागु गर्ने।
* २४/७ सञ्चालन हुने Security Operations Center (SOC) मार्फत निगरानी गर्ने।

५. निष्कर्ष:
जेरो ट्रस्ट आर्किटेक्चरले बैंकको सुरक्षालाई बाह्य घेराबाट आन्तरिक डाटाको तह-तहसम्म पुर्‍याई डिजिटल बैंकिङलाई पूर्ण सुरक्षित बनाउँछ।""")

    # 12. Non-Performing Loans & Debt Recovery Act (10M)
    add_sub("p1a_u2_sub261", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology", 10, "2076 BS - RBB IT",
        "Analyze the major causes of rising Non-Performing Loans (NPL) in Nepal's banking sector. Explain the legal mechanisms for debt recovery under the Debt Recovery Act, 2058 and the role of the Debt Recovery Tribunal.",
        "नेपालको बैंकिङ क्षेत्रमा खराब कर्जा (NPL) बढ्नुका प्रमुख कारणहरू विश्लेषण गर्नुहोस्। ऋण असुली ऐन, २०५८ बमोजिम कर्जा असुलीका कानुनी संयन्त्र र ऋण असुली न्यायाधिकरण (DRT) को भूमिका प्रष्ट पार्नुहोस्।",
        """1. Introduction:
**Non-Performing Loans (NPL / खराब कर्जा)** are loans where borrowers have failed to make scheduled repayments of principal or interest for over 90 days (categorized under NRB directives into Substandard, Doubtful, and Loss). Rising NPL erodes bank profitability and capital adequacy.

2. Causes of Escalating NPL in Nepalese Banks:
* **Macroeconomic Slowdown:** Sluggish construction and real estate sectors, reduced consumption, and high inflation dampening borrower repayment capacity.
* **Inadequate Credit Appraisal:** Over-reliance on physical real estate collateral rather than evaluating project cash flows, debt service coverage ratio (DSCR), and borrower integrity.
* **Evergreening of Bad Loans:** Past practices of extending new credit facilities to service delinquent interest, which eventually explodes when credit controls tighten.
* **Fund Diversion:** Borrowers siphoning business working capital into speculative share markets or land plotting.
* **External Disruptions:** Economic repercussions following post-COVID supply chain disruptions and political instability.

3. Legal Mechanisms Under the Debt Recovery Act, 2058 (ऋण असुली ऐन, २०५८):
Enacted to facilitate swift recovery of defaulted bank loans outside lengthy civil court procedures:
1. **Auction of Collateral by Bank (धितो लिलाम बिक्री):** Bank issues a 35-day public auction notice. If no bidder participates, the bank can acquire ownership of the collateral (Non-Banking Asset - NBA).
2. **Establishment of Debt Recovery Tribunal (DRT - ऋण असुली न्यायाधिकरण):**
   * *Filing Threshold:* Defaults exceeding Rs. 5 Lakhs can be referred to the DRT.
   * *Specialized Quasi-Judicial Body:* Comprises a Judicial Member and a Banking Member for expeditious hearings.
   * *Time-Bound Disposal:* Mandated to dispose of cases within one year, bypassing protracted general civil court litigation.
3. **Debt Recovery Appellate Tribunal (ऋण असुली पुनरावेदन न्यायाधिकरण):** Hears appeals against DRT decisions, requiring the appellant borrower to deposit a mandatory portion of the disputed claim before appeal admission.
4. **Blacklisting via Credit Information Bureau (CIB):** Ineligible for further credit, suspension of passport, and freezing of bank accounts across all financial institutions.

4. Conclusion:
Balancing cash-flow-based underwriting with the aggressive, time-bound legal teeth of the Debt Recovery Tribunal is essential to keep NPL well below the regulatory threshold of 5%.""",
        """१. अवधारणा:
नेपाल राष्ट्र बैंकको निर्देशन अनुसार सावाँ वा ब्याज भुक्तानी भाखा नाघेको ९० दिनभन्दा बढी भएका कर्जाहरूलाई **खराब कर्जा (Non-Performing Loan - NPL)** भनिन्छ (कमसल, शंकास्पद र खराब)। यसले बैंकको नाफा र पुँजी कोषमा प्रत्यक्ष नकारात्मक असर पार्छ।

२. नेपालमा खराब कर्जा बढ्नुका प्रमुख कारणहरू:
* **आर्थिक मन्दी:** घरजग्गा, निर्माण र व्यापार क्षेत्रमा आएको शिथिलताले व्यवसायीहरूको ऋण तिर्ने क्षमता घट्नु।
* **कमजोर कर्जा विश्लेषण:** परियोजनाको नगद प्रवाह (Cash Flow) भन्दा घरजग्गाको धितोलाई मात्र आधार बनाएर कर्जा प्रवाह गर्ने प्रवृत्ति।
* **कर्जाको दुरुपयोग (Fund Diversion):** जुन प्रयोजनका लागि ऋण लिएको हो, सो काममा नलगाई अनुत्पादक क्षेत्र वा सेयर/जग्गामा लगानी गर्नु।
* **सदाबहार (Evergreening):** पुरानो ब्याज तिर्न नयाँ कर्जा दिने विकृत अभ्यास रोकिँदा वास्तविक खराब कर्जा बाहिर आउनु।

३. ऋण असुली ऐन, २०५८ का प्रमुख कानुनी व्यवस्थाहरू:
सर्वसाधारणको निक्षेपबाट प्रवाह भएको कर्जा छिटो असुलउपर गर्न विशेष कानुनी व्यवस्था गरिएको छ:
* **धितो लिलामीको अधिकार:** बैंकले ३५ दिने सार्वजनिक सूचना जारी गरी धितो लिलाम गर्न सक्छ। लिलाम नभएमा आफैंले गैर-बैंकिङ सम्पत्ति (NBA) को रूपमा सकार्ने।
* **ऋण असुली न्यायाधिकरण (DRT):**
  * रु. ५ लाखभन्दा बढीको भाखा नाघेको कर्जा असुलीका लागि बैंकहरूले DRT मा मुद्दा दायर गर्न सक्ने।
  * साधारण अदालतको झन्झटिलो प्रक्रिया नभई १ वर्षभित्र छिटो फैसला गर्ने अर्ध-न्यायिक निकाय।
* **ऋण असुली पुनरावेदन न्यायाधिकरण:** DRT को फैसला उपर चित्त नबुझेमा पुनरावेदन गर्न सकिने, तर ऋणीले तोकिएको निश्चित रकम धरौटी राख्नुपर्ने।
* **कर्जा सूचना केन्द्र (CIB) को कालोसूची:** खराब ऋणीलाई कालोसूचीमा राखी राहदानी रोक्का, बैंक खाता रोक्का र नयाँ कारोबारमा बन्देज लगाइने।

४. निष्कर्ष:
धितोमा मात्र भर नपरी नगद प्रवाहमा आधारित कर्जा प्रवाह गर्ने र ऋण असुली ऐनको प्रभावकारी कार्यान्वयनबाट मात्र बैंकको खराब कर्जा नियन्त्रण गर्न सकिन्छ।""")

    # 13. Transactional vs Transformational Leadership (10M)
    add_sub("p1a_u4_sub262", "paper1", "sectionA", 4, "Unit 4: Management Concepts & Principles", 10, "2078 BS - RBB IT",
        "Differentiate between Transactional and Transformational Leadership styles. Which style is most effective for spearheading digital transformation in state-owned commercial banks like RBBL?",
        "कारोबारमूलक (Transactional) र रूपान्तरणकारी (Transformational) नेतृत्व शैली बीचको भिन्नता प्रष्ट पार्नुहोस्। राष्ट्रिय वाणिज्य बैंक जस्ता सरकारी स्वामित्वका वाणिज्य बैंकहरूमा डिजिटल रूपान्तरणको नेतृत्व गर्न कुन शैली बढी प्रभावकारी हुन्छ?",
        """1. Introduction:
Leadership is the art of influencing, inspiring, and directing individuals toward organizational objectives. In organizational behavior, **Transactional Leadership** (based on rewards and compliance) and **Transformational Leadership** (based on vision and inspirational motivation) represent contrasting paradigms.

2. Comparative Matrix:
| Dimension | Transactional Leadership (कारोबारमूलक) | Transformational Leadership (रूपान्तरणकारी) |
|---|---|---|
| **Core Philosophy** | Operates within existing organizational boundaries and rules | Changes organizational culture and drives paradigm shifts |
| **Motivational Mechanism** | Contingent rewards (bonuses, grades) and negative management-by-exception | Charismatic influence, intellectual stimulation, and shared vision |
| **Focus** | Short-term operational efficiency and adherence to SOPs | Long-term strategic evolution and capability building |
| **Leader-Follower Relationship** | Contractual / reciprocal ("You do X, I give you Y") | Inspirational, developmental, and deeply engaging |
| **Risk Appetite** | Risk-averse; maintains status quo | Embraces calculated risks and fosters continuous innovation |

3. Effective Leadership for Digital Transformation in RBBL:
Digital transformation in a legacy state-owned institution like Rastriya Banijya Bank entails migrating paper files to digital workflows, revamping CBS, and retraining thousands of non-technical branch staff.

* **Why Pure Transactional Leadership Fails Here:**
  * Bureaucratic rule-checking induces fear of audit reprimands among staff, discouraging staff from experimenting with new digital tools.
* **Why Transformational Leadership is Paramount:**
  * **Inspirational Motivation:** Communicates an inspiring vision of RBBL as Nepal's modern, paperless digital financial inclusion champion.
  * **Intellectual Stimulation:** Encourages staff to challenge legacy manual ledger practices and brainstorm robotic process automation (RPA) workflows.
  * **Individualized Consideration:** Mentors aging branch staff with compassionate reskilling programs rather than imposing punitive measures.

4. The Ideal Hybrid Approach (Ambidextrous Leadership):
While **Transformational Leadership** must set the vision, create cultural buy-in, and motivate cross-functional agility, a baseline of **Transactional Leadership** remains legally necessary in banking to enforce strict AML/CFT compliance, BAFIA prudential limits, and IT security protocols.

5. Conclusion:
Transformational leadership provides the visionary engine required to digitize RBBL, while transactional discipline guarantees absolute adherence to regulatory compliance.""",
        """१. अवधारणा:
संगठनात्मक लक्ष्य हासिल गर्न जनशक्तिलाई मार्गदर्शन र प्रेरित गर्ने क्षमतालाई नेतृत्व भनिन्छ। व्यवस्थापनमा **कारोबारमूलक (Transactional)** र **रूपान्तरणकारी (Transformational)** नेतृत्व दुई प्रमुख शैली हुन्।

२. तुलनात्मक भिन्नता:
* **कारोबारमूलक नेतृत्व (Transactional):**
  * विद्यमान नियम र परम्पराभित्र बसेर काम गर्ने।
  * राम्रो काम गरे पुरस्कार (Grade/Bonus) र नराम्रो गरे सजाय दिने लेनदेनमा आधारित।
  * दैनिक कार्य सञ्चालन र यथास्थिति (Status Quo) जोगाउन केन्द्रित।
* **रूपान्तरणकारी नेतृत्व (Transformational):**
  * संस्थाको सोच, कार्यशैली र संस्कृतिमै आमूल परिवर्तन ल्याउने।
  * आफ्ना अनुयायीहरूलाई भविष्यको स्पष्ट दृष्टिकोण (Vision) दिएर भित्री रूपमा प्रेरित गर्ने।
  * जोखिम मोल्न, नयाँ विचार ल्याउन र प्रविधिको प्रयोग गर्न प्रोत्साहन गर्ने।

३. राष्ट्रिय वाणिज्य बैंकको डिजिटल रूपान्तरणमा उपादेयता:
सरकारी बैंकमा वर्षौंदेखि कागजी काम गरेका कर्मचारीहरूलाई कम्प्युटर र डिजिटल बैंकिङमा रूपान्तरण गर्न ठूलो सांस्कृतिक चुनौती छ।
* यस्तो अवस्थामा **रूपान्तरणकारी नेतृत्व (Transformational Style)** सर्वाधिक प्रभावकारी हुन्छ किनकि:
  * यसले कर्मचारीहरूमा प्रविधिप्रतिको डर हटाएर बैंकलाई आधुनिक बनाउने साझा सपना जगाउँछ।
  * पुराना कर्मचारीलाई गाली वा सजाय गर्नुको सट्टा व्यक्तिगत सिकाई र तालिम (Individualized Consideration) प्रदान गर्दछ।
  * नयाँ प्रविधि र इनोभेसनलाई स्वागत गर्ने वातावरण निर्माण गर्दछ।

४. सन्तुलित दृष्टिकोण:
यद्यपि, बैंकमा आर्थिक अनुशासन र राष्ट्र बैंकको नीति नियम पालना गराउन केही हदसम्म कारोबारमूलक (Transactional) अनुशासन पनि सँगसँगै चाहिन्छ।

५. निष्कर्ष:
सरकारी बैंकलाई पूर्ण डिजिटल युगमा लैजान नेतृत्वमा रूपान्तरणकारी सोच, प्रेरणा र दूरदृष्टि अपरिहार्य छ।""")

    # 14. Data Warehousing & Business Intelligence in Banking (10M)
    add_sub("p1b_u3_sub263", "paper1", "sectionB", 3, "Unit 3: Database Management System", 10, "2079 BS - RBB IT",
        "Describe the architecture of a Banking Enterprise Data Warehouse (EDW) and Business Intelligence (BI) pipeline. Differentiate between OLTP and OLAP, and explain how Star and Snowflake schemas support credit analytics.",
        "बैंकिङ इन्टरप्राइज डाटा वेयरहाउस (EDW) र बिजनेस इन्टेलिजेन्स (BI) को संरचना प्रष्ट पार्नुहोस्। OLTP र OLAP बीचको भिन्नता उल्लेख गर्दै Star र Snowflake स्किमाले कर्जा विश्लेषणमा कसरी सहयोग गर्दछन्, व्याख्या गर्नुहोस्।",
        """1. Introduction:
Modern banks generate massive operational data across Core Banking Systems, ATM switches, mobile apps, and credit cards. A **Data Warehouse (DWH)** is a subject-oriented, integrated, time-variant, and non-volatile collection of data supporting strategic managerial decision-making through **Business Intelligence (BI)** dashboards.

2. Architecture of Banking EDW Pipeline:
1. **Data Sources:** Production transactional databases (Oracle CBS), CRM systems, Credit Bureau (CIB) files, and payment gateways.
2. **ETL Pipeline (Extract, Transform, Load):**
   * *Extract:* Pulling incremental delta logs from operational databases.
   * *Transform:* Data scrubbing, deduplication, currency standardization, and business logic mapping.
   * *Load:* Writing sanitized historical data into staging and production warehouse tables.
3. **Data Warehouse Storage:** Enterprise repository maintaining multi-year historical snapshots.
4. **Data Marts & OLAP Cubes:** Subject-specific departmental stores (e.g., Credit Mart, AML/Fraud Mart, Marketing Mart).
5. **BI & Analytics Layer:** Executive dashboards (PowerBI, Tableau), predictive machine learning credit scoring models, and NRB supervisory reporting engines.

3. OLTP vs OLAP Comparison:
| Feature | OLTP (Online Transaction Processing) | OLAP (Online Analytical Processing) |
|---|---|---|
| **Primary Purpose** | Real-time banking operations (debit/credit, transfers) | Strategic analysis, forecasting, portfolio trends |
| **Data Structure** | Highly normalized (3NF/BCNF) to eliminate update anomalies | Denormalized (Star/Snowflake schema) for rapid read queries |
| **Query Complexity** | Simple single-record lookups and updates | Complex multi-table aggregations over millions of historical rows |
| **Database Size** | Gigabytes to Terabytes (current snapshot) | Terabytes to Petabytes (historical archive) |
| **Performance Metric** | Transaction throughput (TPS) and sub-second latency | Query execution time and computational throughput |

4. Star vs Snowflake Schema in Banking Analytics:
* **Star Schema:** Consists of a central **Fact Table** (e.g., `Fact_Loan_Disbursements` containing loan amounts, interest rates, days past due) directly connected to denormalized **Dimension Tables** (`Dim_Customer`, `Dim_Branch`, `Dim_Time`, `Dim_Product`).
  * *Advantage:* Simpler queries, fewer SQL JOINs, maximum read speed for executive credit risk dashboards.
* **Snowflake Schema:** Normalizes dimension tables into sub-dimensions (e.g., `Dim_Branch` breaks down into `Dim_District` and `Dim_Province`).
  * *Advantage:* Eliminates data redundancy and saves storage, but introduces multiple JOINs which slows analytical query response times.

5. Conclusion:
A robust EDW and OLAP analytics engine empowers commercial banks to detect early credit defaults, model liquidity stresses, and personalize customer banking products.""",
        """१. अवधारणा:
बैंकको दैनिक कारोबार सञ्चालन गर्ने डाटाबेस र रणनीतिक निर्णय लिन प्रयोग गरिने डाटाबेस फरक हुन्छन्। बैंकका सम्पूर्ण स्रोतहरूबाट डाटा संकलन गरी विश्लेषण गर्न बनाइएको विशाल ऐतिहासिक भण्डारलाई **डाटा वेयरहाउस (Data Warehouse)** र यसको आधारमा निर्णय लिने प्रविधिलाई **बिजनेस इन्टेलिजेन्स (BI)** भनिन्छ।

२. बैंकिङ डाटा वेयरहाउसको संरचना (ETL Pipeline):
* **स्रोत प्रणाली (Data Sources):** कोर बैंकिङ सफ्टवेयर (CBS), एटीएम नेटवर्क, मोबाइल बैंकिङ र कर्जा सूचना केन्द्र।
* **ETL प्रक्रिया:**
  * *Extract:* विभिन्न शाखा र प्रणालीबाट डाटा तान्ने।
  * *Transform:* डाटाको ढाँचा मिलाउने, त्रुटि सच्याउने र एकरूपता ल्याउने।
  * *Load:* डाटा वेयरहाउसमा सुरक्षित भण्डारण गर्ने।
* **डाटा मार्ट (Data Marts):** विभाग अनुसारका स-साना भण्डार (जस्तै: कर्जा मार्ट, सम्पत्ति शुद्धीकरण मार्ट)।
* **BI ड्यासबोर्ड:** उच्च व्यवस्थापनका लागि नाफा, जोखिम र खराब कर्जा देखाउने डिजिटल रिपोर्ट तथा ग्राफहरू।

३. OLTP र OLAP बीचको भिन्नता:
| आधार | OLTP (दैनिक कारोबार) | OLAP (विश्लेषणात्मक प्रणाली) |
|---|---|---|
| **मुख्य उद्देश्य** | दैनिक निक्षेप, भुक्तानी र रकम ट्रान्सफर | रणनीतिक विश्लेषण, भविष्यको प्रक्षेपण र रिपोर्टिङ |
| **डाटा ढाँचा** | Normalization (3NF) गरिएको (छिटो इन्सर्ट/अपडेट) | Denormalized (Star Schema) गरिएको (छिटो पढ्न मिल्ने) |
| **क्वेरीको प्रकृति** | साधारण र व्यक्तिगत रेकर्ड (जस्तै: ब्यालेन्स हेर्ने) | जटिल र लाखौं रेकर्डको जोड/औसत निकाल्ने |
| **समय अवधि** | वर्तमान मौज्दात र तत्कालको डाटा | वर्षौंदेखिको ऐतिहासिक डाटा |

४. Star र Snowflake स्किमाको भूमिका:
* **Star Schema:** बीचमा मुख्य Fact Table (जस्तै: कर्जा प्रवाह) र वरिपरि Dimension Tables (ग्राहक, शाखा, मिति) तारा आकारमा जोडिएका हुन्छन्। यसले गर्दा कम्प्युटरलाई कम समयमै रिपोर्ट निकाल्न सजिलो हुन्छ।
* **Snowflake Schema:** Dimension टेबलहरूलाई थप सब-टेबलमा विभाजन गरिएको हुन्छ, जसले ठाउँ बचाउँछ तर खोजी गर्न धेरै JOINs चाहिन्छ।

५. निष्कर्ष:
डाटा वेयरहाउस र BI प्रणालीले बैंकलाई कुन क्षेत्रमा कर्जा लगानी गर्दा नाफा हुन्छ र कहाँ खराब कर्जाको जोखिम छ भनी समयमै सही निर्णय लिन सक्षम बनाउँछ।""")

    # 15. PKI & Digital Signatures under Electronic Transactions Act (10M)
    add_sub("p1b_u6_sub264", "paper1", "sectionB", 6, "Unit 6: Information Security & Cyber Laws", 10, "2078 BS - RBB IT",
        "Explain the legal and technical architecture of Public Key Infrastructure (PKI) and Digital Signatures under Nepal's Electronic Transactions Act, 2063. How do digital signatures guarantee non-repudiation in electronic banking?",
        "नेपालको विद्युतीय कारोबार ऐन, २०६३ बमोजिम सार्वजनिक कुञ्जी पूर्वाधार (PKI) र डिजिटल हस्ताक्षरको कानुनी तथा प्राविधिक संरचना प्रष्ट पार्नुहोस्। डिजिटल हस्ताक्षरले विद्युतीय बैंकिङमा अस्वीकार्यता (Non-Repudiation) कसरी सुनिश्चित गर्दछ?",
        """1. Introduction:
In digital banking, ensuring authentication, data integrity, and non-repudiation is paramount. The **Electronic Transactions Act, 2063 (विद्युतीय कारोबार ऐन, २०६३)** confers full legal validity to electronic records and digital signatures in Nepal, establishing the statutory framework for **Public Key Infrastructure (PKI)**.

2. Statutory Framework under ETA 2063:
* **Office of the Controller of Certifying Authorities (OCCA - प्रमाणीकरण नियन्त्रकको कार्यालय):** The apex government regulator under the Ministry of Communication and Information Technology that licenses and audits Certifying Authorities (CAs).
* **Certifying Authority (CA):** A licensed entity (e.g., Nepal Certifying Authority - Radiant Data Technologies) issuing X.509 Digital Signature Certificates (DSC) to individuals, corporations, and banks.
* **Legal Evidentiary Value (Section 16):** Digital signatures created using approved asymmetric cryptosystems possess the identical legal validity and evidentiary admissibility as physical handwritten signatures under the Evidence Act, 2031.

3. Technical Cryptographic Architecture:
Digital signatures rely on **Asymmetric Key Cryptography (Public-Private Key pair)** and **Cryptographic Hash Functions (SHA-256)**:

1. **Signature Generation (Signing by Sender/Bank):**
   * The electronic document/payload (e.g., high-value RTGS transfer order) is hashed using SHA-256 to create a unique fixed-length message digest.
   * The sender encrypts this digest with their **Private Key** (kept securely on a FIPS-compliant hardware security module - HSM or cryptographic USB token).
   * The resulting encrypted hash is the **Digital Signature**, appended to the document alongside the sender's public key certificate.

2. **Signature Verification (by Receiver/Clearing House):**
   * Receiver decrypts the signature using the sender's verified **Public Key** to obtain the original message digest.
   * Receiver independently computes the SHA-256 hash of the received document.
   * If both digests match exactly, the signature is mathematically proven authentic and unaltered.

4. How Digital Signatures Guarantee Non-Repudiation:
* **Non-Repudiation (अस्वीकार्यता):** The legal and technical guarantee that the author/sender of an electronic transaction cannot deny having initiated or authorized the transaction.
* Because the private key is held exclusively by the account holder/bank officer and cannot be derived from the public key, only that specific individual could have produced the signature.
* Under Section 35 of ETA 2063, if a private key is compromised, liability remains with the subscriber until formal revocation notice is filed with the CA.

5. Conclusion:
PKI and digital signatures form the indispensable cryptographic bedrock under ETA 2063, securing interbank settlement switches, corporate banking portals, and electronic contracts.""",
        """१. अवधारणा:
डिजिटल बैंकिङ र अनलाइन कारोबारमा कागजी हस्ताक्षर जस्तै कानुनी मान्यता प्राप्त गर्ने प्रविधिलाई **डिजिटल हस्ताक्षर (Digital Signature)** भनिन्छ। नेपालमा **विद्युतीय कारोबार ऐन, २०६३** ले डिजिटल हस्ताक्षर र यसको कानुनी मान्यताको पूर्ण व्यवस्था गरेको छ।

२. ऐन अन्तर्गतको कानुनी संरचना:
* **प्रमाणीकरण नियन्त्रकको कार्यालय (OCCA):** सञ्चार तथा सूचना प्रविधि मन्त्रालय मातहत रहने सरकारी निकाय, जसले डिजिटल हस्ताक्षर जारी गर्ने निकायहरूलाई अनुमति दिने र अनुगमन गर्ने काम गर्छ।
* **प्रमाणीकरण निकाय (Certifying Authority - CA):** डिजिटल हस्ताक्षर प्रमाणपत्र (Digital Signature Certificate - DSC) जारी गर्ने इजाजतपत्र प्राप्त संस्था।
* **प्रमाणको कानुनी मान्यता (दफा १६):** सुरक्षित डिजिटल हस्ताक्षर गरिएको कागजातलाई प्रमाण ऐन, २०३१ बमोजिम अदालतमा कागजी हस्ताक्षर सरह पूर्ण प्रमाणको रूपमा ग्रहण गरिन्छ।

३. प्राविधिक कार्यप्रणाली (Asymmetric Cryptography):
डिजिटल हस्ताक्षर गणितीय सिद्धान्त र Asymmetric Key जोडी (Public Key र Private Key) मा आधारित हुन्छ:
१. **हस्ताक्षर सिर्जना (Signing):**
   * बैंक वा ग्राहकले पठाउने कारोबार सन्देशलाई SHA-256 बाट सानो ह्यास (Message Digest) बनाइन्छ।
   * सो ह्यासलाई प्रेषकको गोप्य **Private Key** ले इन्क्रिप्ट गरिन्छ, जुन नै डिजिटल हस्ताक्षर हो।
२. **हस्ताक्षर प्रमाणीकरण (Verification):**
   * प्राप्तकर्ताले प्रेषकको खुला **Public Key** प्रयोग गरी हस्ताक्षरलाई डिक्रिप्ट गर्दछ र ह्यास निकाल्छ।
   * प्राप्त सन्देशबाट पुनः आफ्नै ह्यास निकाली दुवै ह्यास तुलना गर्दछ। दुवै बराबर भएमा सन्देश बाटोमा कसैले फेरबदल नगरेको प्रमाणित हुन्छ।

४. अस्वीकार्यता (Non-Repudiation) को सुनिश्चितता:
* गैर-अस्वीकार्यता भन्नाले कुनै व्यक्तिले कारोबार पठाएर पछि "मैले पठाएको होइन" भनी पन्छिन नपाउने कानुनी र प्राविधिक सुरक्षा हो।
* Private Key सम्बन्धित व्यक्तिको सुरक्षित टोकनमा मात्र रहने र अरू कसैसँग नहुने भएकाले सो हस्ताक्षर सोही व्यक्तिले मात्र गरेको प्राविधिक रूपमा अकाट्य प्रमाणित हुन्छ।

५. निष्कर्ष:
विद्युतीय कारोबार ऐन २०६३ बमोजिमको PKI र डिजिटल हस्ताक्षर प्रणाली नै नेपालमा अनलाइन भुक्तानी, RTGS र डिजिटल बैंकिङको कानुनी र प्राविधिक मेरुदण्ड हो।""")

    # ==========================================
    # 30 HIGH-YIELD PRACTICAL & SYLLABUS MCQS
    # ==========================================

    # --- Unit 1: Financial Institutions & Banking Acts ---
    add_mcq("p1a_u1_mcq301", "paper1", "sectionA", 1, "Unit 1: Financial Institutions in Nepal",
        "Under the Foreign Exchange (Regulation) Act, 2019, who has the statutory authority to issue licenses for foreign currency exchange in Nepal?",
        "विदेशी विनिमय (नियमित गर्ने) ऐन, २०१९ बमोजिम नेपालमा विदेशी मुद्रा सटही कारोबारको इजाजतपत्र जारी गर्ने अधिकार कसलाई छ?",
        ["Ministry of Finance", "Nepal Rastra Bank", "Department of Customs", "Foreign Investment Board"],
        1,
        "Pursuant to Section 3 of the Foreign Exchange (Regulation) Act 2019, Nepal Rastra Bank possesses exclusive statutory power to grant operating licenses to banks, money changers, and firms to deal in foreign currencies.",
        "विदेशी विनिमय (नियमित गर्ने) ऐन, २०१९ को दफा ३ बमोजिम नेपालमा विदेशी मुद्रा खरिद, बिक्री तथा सटही गर्ने इजाजतपत्र जारी गर्ने पूर्ण अधिकार नेपाल राष्ट्र बैंकलाई छ।",
        "2079 BS - RBB IT")

    add_mcq("p1a_u1_mcq302", "paper1", "sectionA", 1, "Unit 1: Financial Institutions in Nepal",
        "Under the Negotiable Instruments Act, 2034, what is the maximum validity period of a standard commercial cheque from the date of issue?",
        "विनिमय अधिकारपत्र ऐन, २०३४ अनुसार जारी भएको मितिले साधारण बैंकिङ चेकको अधिकतम भुक्तानी म्याद कति महिना हुन्छ?",
        ["3 Months", "6 Months", "1 Year", "35 Days"],
        1,
        "In Nepalese banking practice under the Negotiable Instruments Act 2034 and standard banking custom, a cheque remains valid for payment for up to 6 months from its stated date of issuance.",
        "नेपालको बैंकिङ अभ्यास र विनिमय अधिकारपत्र ऐन, २०३४ अनुसार जारी भएको मितिले ६ महिनाभित्र चेक भुक्तानीका लागि बैंकमा पेश गरिसक्नुपर्छ।",
        "2078 BS - RBB IT")

    add_mcq("p1a_u1_mcq303", "paper1", "sectionA", 1, "Unit 1: Financial Institutions in Nepal",
        "According to the Rastriya Banijya Bank Limited Employee Service Bylaws 2070, within how many days must an aggrieved employee file an appeal against a departmental penalty decision?",
        "राष्ट्रिय वाणिज्य बैंक लिमिटेड कर्मचारी सेवा विनियमावली, २०७० अनुसार विभागीय सजायको निर्णय भएको सूचना पाएको मितिले कति दिनभित्र पुनरावेदन दिनुपर्दछ?",
        ["15 Days", "21 Days", "35 Days", "60 Days"],
        2,
        "Pursuant to RBBL Employee Service Bylaws 2070, an employee dissatisfied with a departmental disciplinary action must file a formal appeal to the designated Appellate Authority within 35 days.",
        "कर्मचारी सेवा विनियमावली, २०७० अनुसार विभागीय सजायको निर्णय उपर चित्त नबुझेमा सो निर्णयको सूचना पाएको ३५ दिनभित्र पुनरावेदन सुन्ने अधिकारी समक्ष पुनरावेदन दर्ता गर्नुपर्ने व्यवस्था छ।",
        "2077 BS - RBB IT")

    add_mcq("p1a_u1_mcq304", "paper1", "sectionA", 1, "Unit 1: Financial Institutions in Nepal",
        "According to Credit Information Bureau (CIB) regulations in Nepal, blacklisting a defaulting borrower is mandatory when overdue loan facilities cross which threshold without settlement?",
        "नेपालको कर्जा सूचना केन्द्र (CIB) को व्यवस्था अनुसार भाखा नाघेको कर्जा कति रकम नाघेपछि ऋणीलाई कालोसूचीमा राख्न सिफारिस गर्नुपर्ने बाध्यकारी व्यवस्था छ?",
        ["Rs. 1 Lakh", "Rs. 5 Lakhs", "Rs. 10 Lakhs", "Rs. 25 Lakhs"],
        2,
        "Under NRB Directives and CIB rules, borrowers defaulting on credit facilities of Rs. 10 Lakhs (1 million NPR) or above with principal/interest overdue for over 90 days must be blacklisted if they fail to regularize.",
        "नेपाल राष्ट्र बैंकको निर्देशन अनुसार १० लाख रुपैयाँ वा सोभन्दा बढीको कर्जा भाखा नाघी खराब वर्गमा वर्गीकरण भएमा त्यस्ता ऋणीलाई कर्जा सूचना केन्द्रको कालोसूचीमा राख्न सिफारिस गर्नुपर्दछ।",
        "2079 BS - RBB IT")

    add_mcq("p1a_u1_mcq305", "paper1", "sectionA", 1, "Unit 1: Financial Institutions in Nepal",
        "Which component is strictly EXCLUDED when computing the Base Rate of a commercial bank as per Nepal Rastra Bank guidelines?",
        "नेपाल राष्ट्र बैंकको निर्देशन अनुसार वाणिज्य बैंकहरूको आधार दर (Base Rate) गणना गर्दा निम्नमध्ये कुन खर्च समावेश गर्न पाइँदैन?",
        ["Cost of Funds", "Statutory Liquidity Cost", "Return on Assets (Profit Margin)", "Operating Cost"],
        2,
        "As per NRB Directives, Return on Assets (profit margin) was strictly removed from the Base Rate formula to protect borrowers; banks add an explicit risk spread over the Base Rate instead.",
        "नेपाल राष्ट्र बैंकको संशोधित निर्देशन अनुसार आधार दरमा नाफाको अंश (Return on Assets) समावेश गर्न पूर्ण प्रतिबन्ध लगाइएको छ; आधार दरमा लागत, अनिवार्य मौज्दात खर्च र सञ्चालन खर्च मात्र जोडिन्छ।",
        "2078 BS - RBB IT")

    # --- Unit 2: Banking Operations & Payment Systems ---
    add_mcq("p1a_u2_mcq306", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology",
        "What is the standard minimum transaction amount eligible for routing through the Real Time Gross Settlement (RTGS) system in Nepal?",
        "नेपाल राष्ट्र बैंकको RTGS प्रणालीमार्फत ग्राहक कारोबार (Customer Transaction) गर्दा न्यूनतम कति रकम हुनुपर्ने व्यवस्था छ?",
        ["Rs. 50,000", "Rs. 1,00,000", "Rs. 2,00,000", "No minimum limit"],
        2,
        "In Nepal, customer-initiated high-value interbank payments through the RTGS system generally require a minimum threshold of Rs. 2,00,000 (Two Lakhs), while transactions below this are routed through retail switches (connectIPS/NCHL-IPS).",
        "नेपालमा ग्राहक तहको RTGS कारोबारका लागि सामान्यतया न्यूनतम २ लाख रुपैयाँको सीमा तोकिएको छ, सोभन्दा कम रकम खुद्रा भुक्तानी प्रणाली (ConnectIPS/NCHL-IPS) मार्फत हुन्छ।",
        "2079 BS - RBB IT")

    add_mcq("p1a_u2_mcq307", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology",
        "What is the maximum per-transaction transfer limit allowed via web-based connectIPS for a verified retail user in Nepal?",
        "नेपालमा प्रमाणित व्यक्तिगत प्रयोगकर्ताका लागि वेब-आधारित connectIPS मार्फत एक पटकमा गर्न सकिने अधिकतम कारोबार सीमा कति हो?",
        ["Rs. 5 Lakhs", "Rs. 10 Lakhs", "Rs. 20 Lakhs", "Rs. 1 Crore"],
        2,
        "As per NRB payment systems directives, the per-transaction limit for retail users on the web version of connectIPS is Rs. 20 Lakhs (while the mobile app limit is Rs. 2 Lakhs).",
        "नेपाल राष्ट्र बैंकको भुक्तानी प्रणाली निर्देशन अनुसार connectIPS को वेब पोर्टलबाट प्रति कारोबार अधिकतम २० लाख रुपैयाँसम्म रकमान्तर गर्न सकिन्छ (मोबाइल एपबाट प्रति कारोबार २ लाख)।",
        "2078 BS - RBB IT")

    add_mcq("p1a_u2_mcq308", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology",
        "What is the regulatory ceiling on the Single Borrower Limit (SBL) for fund-based credit facilities to a single borrower in Nepal?",
        "नेपाल राष्ट्र बैंकको निर्देशन अनुसार वाणिज्य बैंकहरूले एकल ग्राहकलाई प्रदान गर्न सक्ने कोषमा आधारित (Fund-based) कर्जाको अधिकतम सीमा (SBL) कति हो?",
        ["15% of Core Capital", "25% of Core Capital", "20% of Core Capital", "50% of Total Capital"],
        1,
        "As per NRB Prudential Regulations, the Single Borrower Limit for fund-based facilities is capped at 25% of the bank's Tier 1 (Core) Capital to minimize concentration risk.",
        "एकाग्रता जोखिम न्यूनीकरण गर्न राष्ट्र बैंकको निर्देशन बमोजिम एकल ग्राहक कोषमा आधारित कर्जा सीमा (SBL) बैंकको प्राथमिक पुँजी (Core Capital) को अधिकतम २५% तोकिएको छ।",
        "2077 BS - RBB IT")

    add_mcq("p1a_u2_mcq309", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology",
        "Under current NRB directives, what is the maximum regulatory Loan-to-Value (LTV) ratio for residential home loans in Kathmandu Valley?",
        "हालको राष्ट्र बैंक निर्देशन अनुसार काठमाडौं उपत्यकाभित्र व्यक्तिगत आवासीय घर कर्जा प्रवाह गर्दा धितो मूल्याङ्कनको अधिकतम कति प्रतिशतसम्म (LTV Ratio) कर्जा दिन पाइन्छ?",
        ["30%", "50%", "60%", "70%"],
        1,
        "As per NRB macroprudential directives, the Loan-to-Value (LTV) ratio for real estate and residential housing within Kathmandu Valley is capped at 50% (and 60% outside the valley).",
        "घरजग्गा क्षेत्रमा हुन सक्ने सट्टेबाजी रोक्न राष्ट्र बैंकले काठमाडौं उपत्यकाभित्र व्यक्तिगत आवासीय कर्जाको धितो मूल्याङ्कन सीमा (LTV) अधिकतम ५०% तोकेको छ।",
        "2079 BS - RBB IT")

    add_mcq("p1a_u2_mcq310", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology",
        "Which electronic payment instrument operates on a deferred net settlement (DNS) basis rather than real-time gross settlement?",
        "निम्नमध्ये कुन विद्युतीय भुक्तानी प्रणाली रियल-टाइम ग्रस नभई डिफर्ड नेट सेटलमेन्ट (Deferred Net Settlement - DNS) विधिमा सञ्चालन हुन्छ?",
        ["RTGS", "NCHL-IPS", "Cash on Delivery", "Over-the-Counter Deposit"],
        1,
        "NCHL-IPS operates on a Deferred Net Settlement (DNS) basis where transactions are netted in predefined clearing sessions rather than settling individually in real time.",
        "NCHL-IPS प्रणाली निश्चित समयावधि (Batches) मा नेटिङ गरी डिफर्ड नेट सेटलमेन्ट (DNS) विधिबाट राफसाफ हुन्छ, जबकि RTGS मा तत्काल प्रत्येक कारोबार छुट्टाछुट्टै हुन्छ।",
        "2076 BS - RBB IT")

    # --- Unit 3 & 4: Management, HR & Procurement ---
    add_mcq("p1a_u3_mcq311", "paper1", "sectionA", 3, "Unit 3: Human Resource & Office Management",
        "According to Frederick Herzberg's Motivation-Hygiene Theory, which of the following is classified strictly as a 'Motivator' factor?",
        "फ्रेडरिक हर्जवर्गको दुई-तत्वीय सिद्धान्त अनुसार निम्नमध्ये कुनलाई शुद्ध 'उत्प्रेरक तत्व (Motivator)' मानिन्छ?",
        ["Salary and Benefits", "Work Conditions", "Recognition and Achievement", "Company Policy"],
        2,
        "In Herzberg's theory, Recognition, Achievement, Responsibility, and Advancement are true Motivators that yield intrinsic job satisfaction, whereas Salary and Work Conditions are Hygiene factors.",
        "हर्जवर्गको सिद्धान्त अनुसार कार्यको कदर र उपलब्धि (Recognition & Achievement) उत्प्रेरक तत्व हुन्, जबकि तलब र कार्य वातावरण आरोग्य (Hygiene) तत्व हुन्।",
        "2078 BS - RBB IT")

    add_mcq("p1a_u3_mcq312", "paper1", "sectionA", 3, "Unit 3: Human Resource & Office Management",
        "What does the term 'Span of Control' refer to in organizational management?",
        "संगठनात्मक व्यवस्थापनमा 'Span of Control' (नियन्त्रणको परिधि) भन्नाले के बुझिन्छ?",
        ["The total number of branches in an organization", "The number of subordinates directly reporting to a single manager", "The geographic territory under a regional manager", "The budget allocated to a department"],
        1,
        "Span of Control refers to the optimal number of subordinates who report directly to a single supervisor or managerial executive.",
        "व्यवस्थापनमा एक जना सुपरभाइजर वा व्यवस्थापकले प्रत्यक्ष रूपमा प्रभावकारी ढंगले सुपरिवेक्षण गर्न सक्ने मातहतका कर्मचारीहरूको संख्यालाई Span of Control भनिन्छ।",
        "2077 BS - RBB IT")

    add_mcq("p1a_u4_mcq313", "paper1", "sectionA", 4, "Unit 4: Management Concepts & Principles",
        "Who formulated the concept of 'Management by Objectives' (MBO) in his 1954 classic 'The Practice of Management'?",
        "सन् १९५४ मा आफ्नो पुस्तक 'The Practice of Management' मार्फत 'उद्देश्यद्वारा व्यवस्थापन (MBO)' को अवधारणा कसले प्रतिपादन गरेका हुन्?",
        ["Peter F. Drucker", "Henri Fayol", "Max Weber", "Elton Mayo"],
        0,
        "Management by Objectives (MBO) was pioneered by Peter F. Drucker in 1954 to align individual employee goals with overall organizational strategy through participatory goal setting.",
        "उद्देश्यद्वारा व्यवस्थापन (MBO) को अवधारणा आधुनिक व्यवस्थापनका पिता मानिने पिटर एफ. ड्रकरले सन् १९५४ मा प्रतिपादन गरेका हुन्।",
        "2079 BS - RBB IT")

    add_mcq("p1a_u5_mcq314", "paper1", "sectionA", 5, "Unit 5: Office Management & Technology",
        "Under the Public Procurement Act, 2063, what is the standard minimum bid validity period typically required for international competitive bidding (ICB)?",
        "सार्वजनिक खरिद ऐन, २०६३ बमोजिम अन्तर्राष्ट्रिय स्तरको खुला बोलपत्र (ICB) आह्वान गर्दा सामान्यतया कम्तीमा कति दिनको बोलपत्र पेश गर्ने म्याद दिनुपर्छ?",
        ["15 Days", "21 Days", "30 Days", "45 Days"],
        3,
        "Pursuant to Section 14 of the Public Procurement Act 2063, the notice period for international competitive bidding (ICB) must be at least 45 days (compared to 30 days for national competitive bidding).",
        "सार्वजनिक खरिद ऐन, २०६३ अनुसार अन्तर्राष्ट्रिय स्तरको बोलपत्रका लागि कम्तीमा ४५ दिनको सूचना दिनुपर्ने व्यवस्था छ (राष्ट्रिय स्तरका लागि कम्तीमा ३० दिन)।",
        "2078 BS - RBB IT")

    add_mcq("p1a_u5_mcq315", "paper1", "sectionA", 5, "Unit 5: Office Management & Technology",
        "Under the Public Procurement Act 2063, what percentage of the bid price is typically required as Bid Security (Bid Bond)?",
        "सार्वजनिक खरिद ऐन, २०६३ अनुसार बोलपत्रदाताले पेश गर्नुपर्ने जमानत (Bid Security/Bid Bond) सामान्यतया कबोल अङ्कको कति प्रतिशत हुनुपर्छ?",
        ["1% to 2%", "2% to 3%", "5% to 10%", "10% to 15%"],
        1,
        "Under the Public Procurement Act 2063, Bid Security is typically set between 2.0% and 3.0% of the estimated contract value, valid for 30 days beyond bid validity.",
        "सार्वजनिक खरिद ऐन अनुसार बोलपत्र जमानतको रकम सामान्यतया अनुमानित लागत वा बोलपत्र कबोल रकमको २ देखि ३ प्रतिशत हुनुपर्दछ।",
        "2076 BS - RBB IT")

    # --- Unit 1 & 2 Section B: Computer Architecture & OS ---
    add_mcq("p1b_u1_mcq316", "paper1", "sectionB", 1, "Unit 1: Computer Architecture & Organization",
        "In modern CPU architecture, what is the primary role of the Translation Lookaside Buffer (TLB)?",
        "आधुनिक सीपीयू आर्किटेक्चरमा Translation Lookaside Buffer (TLB) को मुख्य भूमिका के हो?",
        ["Cache recent virtual-to-physical page table translations", "Store ALU intermediate floating point calculations", "Buffer interrupt requests from PCIe bus", "Store hard disk sector blocks"],
        0,
        "The TLB is a high-speed associative hardware cache that stores recent virtual-to-physical memory address translations, speeding up virtual memory lookups.",
        "TLB एक उच्च गतिको हार्डवेयर क्यास हो जसले भर्चुअल मेमोरी एड्रेसलाई वास्तविक भौतिक (Physical) मेमोरी एड्रेसमा अनुवाद गर्ने कामलाई तीव्र बनाउँछ।",
        "2079 BS - RBB IT")

    add_mcq("p1b_u1_mcq317", "paper1", "sectionB", 1, "Unit 1: Computer Architecture & Organization",
        "Which cache replacement algorithm suffers from Belady's Anomaly (where increasing cache/page slots causes more page faults)?",
        "पेज वा क्यास स्लटको संख्या बढाउँदा पनि पेज फल्टको संख्या झन् बढ्ने समस्या (Belady's Anomaly) निम्नमध्ये कुन अल्गोरिदममा देखिन्छ?",
        ["Least Recently Used (LRU)", "Optimal Algorithm (OPT)", "First-In, First-Out (FIFO)", "Least Frequently Used (LFU)"],
        2,
        "Belady's Anomaly is a known flaw in the FIFO page replacement policy where allocating more physical page frames can paradoxically increase the total number of page faults.",
        "FIFO (First-In, First-Out) पेज रिप्लेसमेन्ट नीतिमा पेज फ्रेम संख्या बढाउँदा पनि पेज फल्ट बढ्न सक्ने विसंगति देखिन्छ, जसलाई Belady's Anomaly भनिन्छ।",
        "2077 BS - RBB IT")

    add_mcq("p1b_u1_mcq318", "paper1", "sectionB", 1, "Unit 1: Computer Architecture & Organization",
        "In a pipelined CPU architecture, what type of hazard occurs when an instruction depends on the result of an earlier instruction that is still in execution?",
        "पाइपलाइन्ड सीपीयूमा कुनै निर्देशन (Instruction) अघिल्लो निर्देशनको नतिजामा निर्भर हुँदा उत्पन्न हुने अवरोधलाई के भनिन्छ?",
        ["Structural Hazard", "Data Hazard", "Control Hazard", "Branch Hazard"],
        1,
        "A Data Hazard (such as Read-After-Write - RAW) occurs when consecutive instructions exhibit data dependency, and the second instruction requires operand values before the first has written them back.",
        "अघिल्लो निर्देशनले गणना गरेको नतिजा मेमोरी वा रजिष्टरमा लेख्नुअगावै पछिल्लो निर्देशनलाई सो डाटा आवश्यक पर्दा उत्पन्न हुने अवरोधलाई Data Hazard भनिन्छ।",
        "2078 BS - RBB IT")

    add_mcq("p1b_u2_mcq319", "paper1", "sectionB", 2, "Unit 2: Operating System",
        "Which CPU scheduling algorithm provides the theoretical minimum average waiting time for a given set of stationary processes?",
        "दिइएको निश्चित प्रोसेसहरूको समूहका लागि सैद्धान्तिक रूपमा सबैभन्दा कम औसत प्रतीक्षा समय (Minimum Average Waiting Time) दिने सिड्युलिङ अल्गोरिदम कुन हो?",
        ["First-Come, First-Served (FCFS)", "Round Robin (RR)", "Shortest Job First (SJF / Non-preemptive)", "Priority Scheduling"],
        2,
        "Shortest Job First (SJF) is provably optimal because scheduling the process with the shortest CPU burst time first minimizes the cumulative queuing delay for subsequent processes.",
        "Shortest Job First (SJF) अल्गोरिदमले प्रोसेसहरूका लागि न्यूनतम औसत प्रतीक्षा समय प्रदान गर्दछ, किनकि छोटो प्रोसेस पहिले सम्पन्न हुँदा लाममा बस्ने समय घट्छ।",
        "2079 BS - RBB IT")

    add_mcq("p1b_u2_mcq320", "paper1", "sectionB", 2, "Unit 2: Operating System",
        "In Banker's Algorithm for deadlock avoidance, a system is defined to be in a 'Safe State' if:",
        "डेडलोक रोक्ने Banker's Algorithm मा सिस्टमलाई 'Safe State' मा रहेको तब मानिन्छ, जब:",
        ["No deadlocks currently exist", "There exists at least one execution sequence where all processes can satisfy maximum demands and terminate", "All resources are 100% utilized", "No process requests additional resources"],
        1,
        "A state is safe if there exists a 'Safe Sequence' $\\langle P_1, P_2, \\dots, P_n \\rangle$ such that each process can satisfy its maximum resource requirements using current free resources plus resources released by preceding processes.",
        "Banker's Algorithm मा कम्तीमा एउटा यस्तो सुरक्षित क्रम (Safe Sequence) विद्यमान हुनुपर्छ जसबाट सबै प्रोसेसहरूले मागे बमोजिम स्रोत प्राप्त गरी सुरक्षित सम्पन्न हुन सकून्।",
        "2078 BS - RBB IT")

    # --- Unit 3 & 4 Section B: DBMS & Computer Networks ---
    add_mcq("p1b_u3_mcq321", "paper1", "sectionB", 3, "Unit 3: Database Management System",
        "In relational database transaction management, which mechanism is primarily used to guarantee transaction Durability under ACID properties?",
        "RDBMS मा ACID गुण अन्तर्गत कारोबारको Durability (स्थायित्व) सुनिश्चित गर्न मुख्यतया कुन संयन्त्र प्रयोग गरिन्छ?",
        ["Two-Phase Locking (2PL)", "Write-Ahead Logging (WAL) & Checkpoints", "Foreign Key constraints", "Hash Indexing"],
        1,
        "Durability ensures committed transactions survive system crashes. This is achieved via Write-Ahead Logging (WAL), where log records are flushed to non-volatile disk storage before actual database pages are updated.",
        "कारोबार सम्पन्न (Commit) भएपछि कम्प्युटर क्र्यास भए पनि डाटा सुरक्षित रहने (Durability) गुण Write-Ahead Logging (WAL) र Redo Logs मार्फत सुनिश्चित गरिन्छ।",
        "2079 BS - RBB IT")

    add_mcq("p1b_u3_mcq322", "paper1", "sectionB", 3, "Unit 3: Database Management System",
        "A database relation where every non-prime attribute is fully functionally dependent on every candidate key (no partial dependencies) satisfies which normal form?",
        "कुनै रिलेसनमा सबै Non-prime विशेषताहरू कुनै पनि Candidate Key को अंशमा नभई पूर्ण Key मा मात्र निर्भर हुन्छन् (आंशिक निर्भरता नभएको) भने त्यो कुन Normal Form मा हुन्छ?",
        ["1NF", "2NF", "3NF", "BCNF"],
        1,
        "Second Normal Form (2NF) mandates that the table is in 1NF and contains zero partial functional dependencies (every non-key attribute must depend on the whole candidate key).",
        "दोस्रो नर्मल फर्म (2NF) हुनका लागि सम्बन्ध 1NF मा हुनुपर्छ र कुनै पनि आंशिक निर्भरता (Partial Dependency) हुनुहुँदैन।",
        "2077 BS - RBB IT")

    add_mcq("p1b_u4_mcq323", "paper1", "sectionB", 4, "Unit 4: Data Communication & Computer Networks",
        "What is the usable number of host IP addresses available in an IPv4 subnet configured with a `/28` CIDR prefix mask?",
        "IPv4 नेटवर्कमा `/28` CIDR प्रिफिक्स भएको सबनेटमा प्रयोग गर्न मिल्ने (Usable) होस्ट आईपी ठेगानाहरूको संख्या कति हुन्छ?",
        ["14", "16", "30", "32"],
        0,
        "A /28 subnet leaves $32 - 28 = 4$ host bits. Total IPs = $2^4 = 16$. Subtracting the network address and broadcast address yields $16 - 2 = 14$ usable host IP addresses.",
        "/28 सबनेटमा होस्टका लागि ४ बिट बाँकी रहन्छ ($२^४ = १६$ ठेगाना)। नेटवर्क र ब्रोडकास्ट ठेगाना कटाउँदा १४ वटा उपयोगी होस्ट आईपी प्राप्त हुन्छ।",
        "2079 BS - RBB IT")

    add_mcq("p1b_u4_mcq324", "paper1", "sectionB", 4, "Unit 4: Data Communication & Computer Networks",
        "During the standard TCP 3-way handshake process, which control flags are sent by the server in the second packet response?",
        "कम्प्युटर नेटवर्कमा TCP Three-Way Handshake को दोस्रो चरणमा सर्भरले पठाउने प्याकेटमा कुन कन्ट्रोल फ्ल्यागहरू सक्रिय (Set) हुन्छन्?",
        ["SYN only", "ACK only", "SYN + ACK", "FIN + ACK"],
        2,
        "In the TCP 3-way handshake: Client sends SYN $\\to$ Server replies with SYN+ACK $\\to$ Client acknowledges with ACK, establishing an active reliable connection.",
        "TCP Three-Way Handshake मा क्लाइन्टले SYN पठाएपछि सर्भरले जवाफमा SYN र ACK दुवै फ्ल्याग भएको प्याकेट पठाउँदछ।",
        "2078 BS - RBB IT")

    add_mcq("p1b_u4_mcq325", "paper1", "sectionB", 4, "Unit 4: Data Communication & Computer Networks",
        "What is the default Administrative Distance (AD) of the Open Shortest Path First (OSPF) routing protocol on enterprise Cisco routers?",
        "इन्टरप्राइज सिस्को राउटरहरूमा OSPF रुटिङ प्रोटोकलको पूर्वनिर्धारित Administrative Distance (AD) कति हुन्छ?",
        ["90", "110", "115", "120"],
        1,
        "By industry standard (Cisco default), OSPF has an Administrative Distance of 110 (compared to RIP = 120, EIGRP internal = 90, eBGP = 20, Static = 1).",
        "राउटरमा OSPF प्रोटोकलको विश्वसनीयता मापन गर्ने Administrative Distance (AD) मान ११० हुन्छ (RIP को १२०, EIGRP को ९०)।",
        "2077 BS - RBB IT")

    # --- Unit 5 & 6 Section B: Software Eng, Cybersecurity & Cyber Law ---
    add_mcq("p1b_u5_mcq326", "paper1", "sectionB", 5, "Unit 5: Software Engineering",
        "In Thomas McCabe's software cyclomatic complexity calculation formula $V(G) = E - N + 2P$, what does the variable '$E$' represent?",
        "सफ्टवेयर इन्जिनियरिङमा McCabe को Cyclomatic Complexity सूत्र $V(G) = E - N + 2P$ मा '$E$' ले के जनाउँछ?",
        ["Number of Nodes", "Number of Edges in control flow graph", "Number of Execution paths", "Number of Errors"],
        1,
        "In cyclomatic complexity graph theory, $E$ represents the number of directed edges, $N$ represents the number of decision/statement nodes, and $P$ represents connected components.",
        "Cyclomatic Complexity सूत्रमा $E$ ले कन्ट्रोल फ्लो ग्राफका किनाराहरू (Edges) र $N$ ले नोडहरू (Nodes) लाई जनाउँदछ।",
        "2079 BS - RBB IT")

    add_mcq("p1b_u5_mcq327", "paper1", "sectionB", 5, "Unit 5: Software Engineering",
        "In black-box software testing, dividing the input data domain into valid and invalid partitions where test cases are selected from each partition is known as:",
        "सफ्टवेयरको Black-Box परीक्षण गर्दा इनपुट डाटालाई विभिन्न मान्य र अमान्य समूहमा विभाजन गरी परीक्षण गर्ने विधिलाई के भनिन्छ?",
        ["Boundary Value Analysis", "Equivalence Class Partitioning", "Cyclomatic Testing", "Mutation Testing"],
        1,
        "Equivalence Class Partitioning is a specification-based black-box technique that divides inputs into equivalence classes from which representative test inputs are chosen.",
        "Equivalence Class Partitioning मा इनपुट डाटालाई बराबर मान्यता भएका वर्गहरूमा बाँडिन्छ र प्रत्येक वर्गबाट प्रतिनिधि नमुना लिएर परीक्षण गरिन्छ।",
        "2078 BS - RBB IT")

    add_mcq("p1b_u6_mcq328", "paper1", "sectionB", 6, "Unit 6: Information Security & Cyber Laws",
        "What is the primary technical defense to completely eliminate SQL Injection vulnerabilities in banking database web applications?",
        "बैंकिङ डाटाबेस वेब एप्लिकेसनहरूमा SQL Injection आक्रमण पूर्ण रूपमा रोक्न प्रयोग गरिने सबैभन्दा प्रभावकारी प्राविधिक उपाय कुन हो?",
        ["Client-side JavaScript regex validation", "Parameterized Queries / Prepared Statements", "Storing passwords in base64 encoding", "Disabling port 443"],
        1,
        "Parameterized queries (Prepared Statements) separate executable SQL code from user-supplied data inputs, making SQL injection mathematically impossible regardless of input content.",
        "Parameterized Queries (Prepared Statements) ले प्रयोगकर्ताको इनपुटलाई SQL कमान्डबाट अलग राखी डाटाको रूपमा मात्र लिने हुँदा SQL Injection आक्रमण रोकिन्छ।",
        "2079 BS - RBB IT")

    add_mcq("p1b_u6_mcq329", "paper1", "sectionB", 6, "Unit 6: Information Security & Cyber Laws",
        "Under Section 46 of Nepal's Electronic Transactions Act, 2063, what is the maximum statutory penalty for unauthorized hacking/destruction of computer source code?",
        "नेपालको विद्युतीय कारोबार ऐन, २०६३ को दफा ४६ बमोजिम कम्प्युटर स्रोत कोड नष्ट गर्ने वा हेरफेर गर्नेलाई अधिकतम कतिसम्म सजाय हुन सक्छ?",
        ["Rs. 50,000 fine or 1 year imprisonment", "Rs. 2 Lakhs fine or 3 years imprisonment or both", "Rs. 5 Lakhs fine or 5 years imprisonment", "Rs. 10 Lakhs fine"],
        1,
        "Under Section 46 of ETA 2063, altering, destroying, or concealing computer source code illegally attracts a fine up to Rs. 2,00,000 (Two Lakhs) or imprisonment up to 3 years or both.",
        "विद्युतीय कारोबार ऐन, २०६३ को दफा ४६ अनुसार कम्प्युटर स्रोत संकेत (Source Code) चोरी वा नष्ट गरेमा २ लाख रुपैयाँसम्म जरिवाना वा ३ वर्षसम्म कैद वा दुवै सजाय हुने व्यवस्था छ।",
        "2077 BS - RBB IT")

    add_mcq("p1b_u6_mcq330", "paper1", "sectionB", 6, "Unit 6: Information Security & Cyber Laws",
        "Which symmetric cryptographic algorithm is designated as the global FIPS standard and supports key sizes of 128, 192, and 256 bits?",
        "१२८, १९२ र २५६ बिट्सको कुञ्जी आकार (Key Size) समर्थन गर्ने र विश्वव्यापी मानक मानिने सिमेट्रिक इन्क्रिप्सन अल्गोरिदम कुन हो?",
        ["RSA", "AES (Advanced Encryption Standard)", "DES (Data Encryption Standard)", "Diffie-Hellman"],
        1,
        "The Advanced Encryption Standard (AES) is a symmetric block cipher approved as FIPS PUB 197 with a 128-bit block size and keys of 128, 192, and 256 bits used to protect core banking databases.",
        "AES (Advanced Encryption Standard) सिमेट्रिक इन्क्रिप्सनको विश्वव्यापी मानक हो, जसले १२८, १९२ र २५६ बिट्सको की (Key) प्रयोग गरी बैंकिङ डाटा सुरक्षित राख्छ।",
        "2078 BS - RBB IT")

    return qs
