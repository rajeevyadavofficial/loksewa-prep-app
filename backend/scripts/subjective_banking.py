# -*- coding: utf-8 -*-
"""
50 Comprehensive Lok Sewa Subjective Questions and Model Answers for Paper I Section A
Covers Units 1 to 6: Financial Institutions, Banking Terminology, Banking Laws,
Organizational Behavior, Related Acts, and Digital Payments.
"""

def get_banking_subjective_questions():
    questions = []

    def add_q(q_id, u_num, u_title, marks, yr, q_en, q_np, ans_en, ans_np):
        questions.append({
            "id": q_id,
            "exam_id": "rbb_it_5",
            "paper": "paper1",
            "section": "sectionA",
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

    # --- UNIT 1: Financial Institutions in Nepal ---
    add_q("p1a_u1_sub201", 1, "Unit 1: Financial Institutions in Nepal", 5, "2076 BS - RBB IT",
        "What is the role and importance of the Nepal Insurance Authority (नेपाल बीमा प्राधिकरण) in the financial sector of Nepal?",
        "नेपालको वित्तीय क्षेत्रमा नेपाल बीमा प्राधिकरणको भूमिका र महत्त्व प्रष्ट पार्नुहोस्।",
        """1. Introduction & Concept:
The **Nepal Insurance Authority (नेपाल बीमा प्राधिकरण)**, established pursuant to the Insurance Act, 2079 (superseding the Insurance Board / Beema Samiti), is the apex statutory regulatory body tasked with regulating, supervising, and developing the life, non-life, and reinsurance industries in Nepal.

2. Core Roles & Functions:
* **Prudential Regulation & Licensing:** Formulates capital norms (minimum Rs. 5 Billion for life, Rs. 2.5 Billion for non-life) and issues operational licenses to domestic and foreign insurers.
* **Solvency & Risk Management:** Implements Risk-Based Capital (RBC) frameworks to ensure insurers possess sufficient liquidity and reserves to honor claims during catastrophic events.
* **Consumer Protection & Dispute Adjudication:** Hears policyholder grievances and enforces prompt claim settlements under Section 120 of the Insurance Act.
* **Microinsurance & Inclusivity:** Promotes targeted microinsurance schemes for rural, agricultural, and low-income demographics.
* **Reinsurance Governance:** Regulates mandatory domestic reinsurance ceding through national reinsurers (Nepal Re, Himalayan Re).

3. Significance in the Financial Sector:
* **Long-Term Capital Mobilization:** Insurance funds represent long-term domestic capital invested in government treasury bonds, hydropower, and infrastructure.
* **Financial Resilience:** Transfers individual, agricultural, and commercial risks, safeguarding banking credit portfolios against borrower insolvency.

4. Conclusion:
Through strict governance, automated claim tracking, and nationwide insurance literacy, the Nepal Insurance Authority serves as an essential pillar of macro-financial stability.""",
        """१. परिचय तथा अवधारणा:
**नेपाल बीमा प्राधिकरण** बीमा ऐन, २०७९ बमोजिम स्थापित नेपालको बीमा क्षेत्र (जीवन, निर्जीवन र पुनर्बीमा) को नियमन, सुपरिवेक्षण र विकास गर्ने सर्वोच्च स्वायत्त निकाय हो। यसले विगतको बीमा समितिलाई प्रतिस्थापन गरी थप अधिकारसहित कार्य गरिरहेको छ।

२. प्रमुख भूमिका तथा कार्यहरू:
* **इजाजतपत्र तथा पुँजी नियमन:** जीवन बीमाका लागि कम्तीमा रू. ५ अर्ब र निर्जीवन बीमाका लागि रू. २.५ अर्ब चुक्ता पुँजी तोकी इजाजतपत्र नियमन गर्नु।
* **जोखिममा आधारित पुँजी (RBC) प्रणाली:** बीमकहरूले दाबी भुक्तानी गर्न सक्ने पर्याप्त शोधन क्षमता (Solvency Margin) कायम गरेको सुनिश्चित गर्नु।
* **बीमित हित संरक्षण तथा विवाद निरुपण:** बीमितका गुनासाहरू सम्बोधन गरी समयमै दाबी भुक्तानी गराउन अर्ध-न्यायिक अधिकार प्रयोग गर्नु।
* **लघुबीमा र वित्तीय समावेशीकरण:** विपन्न, ग्रामीण र कृषि क्षेत्रका नागरिकलाई न्यून प्रिमियममा लघुबीमाको दायरामा ल्याउनु।
* **पुनर्बीमा व्यवस्थापन:** जोखिम विविधीकरण गर्न स्वदेशी तथा विदेशी पुनर्बीमा कम्पनीहरूको नियमन गर्नु।

३. वित्तीय प्रणालीमा यसको महत्त्व:
* **दीर्घकालीन पुँजी निर्माण:** बीमा प्रिमियमबाट संकलित दीर्घकालीन कोषलाई सरकारी ऋणपत्र र राष्ट्रिय पूर्वाधारमा लगानी गरी आर्थिक विकासमा सघाउँछ।
* **कर्जा जोखिम न्यूनीकरण:** बैंक तथा वित्तीय संस्थाबाट प्रवाह भएको कर्जाको धितो (घर, गाडी, उद्योग) को बीमा गरी बैंकिङ क्षेत्रलाई डुब्नबाट जोगाउँछ।

४. निष्कर्ष:
बीमा पहुँच विस्तार, प्रविधिमैत्री दाबी भुक्तानी र प्रभावकारी सुपरिवेक्षण मार्फत नेपाल बीमा प्राधिकरणले देशको वित्तीय स्थायित्वमा महत्वपूर्ण योगदान पुर्‍याइरहेको छ।""")

    add_q("p1a_u1_sub202", 1, "Unit 1: Financial Institutions in Nepal", 10, "2078 BS - NRB Assistant",
        "Compare the functions, target clientele, and capital requirements of Class 'A' Commercial Banks and Class 'D' Microfinance Financial Institutions under BAFIA 2073.",
        "बैंक तथा वित्तीय संस्था सम्बन्धी ऐन, २०७३ बमोजिम 'क' वर्गका वाणिज्य बैंक र 'घ' वर्गका लघुवित्त वित्तीय संस्थाहरूको कार्य, लक्षित वर्ग र पुँजीगत आवश्यकताको तुलनात्मक विश्लेषण गर्नुहोस्।",
        """1. Introduction & Context:
The Bank and Financial Institutions Act (BAFIA), 2073 categorizes banking institutions into a differentiated functional hierarchy. Class 'A' Commercial Banks serve wholesale and formal retail enterprise markets, whereas Class 'D' Microfinance Financial Institutions act as frontline catalysts for grassroots financial inclusion and poverty alleviation.

2. Comparative Matrix (Class 'A' vs Class 'D'):
| Dimension | Class 'A' Commercial Banks | Class 'D' Microfinance Financial Institutions |
|---|---|---|
| **Statutory Mandate** | Section 49(1) of BAFIA 2073 | Section 49(4) of BAFIA 2073 |
| **Minimum Paid-up Capital** | **Rs. 8 Billion** (National Level) | **Rs. 100 Million** (National Level) |
| **Target Clientele** | Corporate entities, industrial conglomerates, SMEs, and general public depositors | Rural underprivileged women, marginalized farmers, low-income micro-entrepreneurs |
| **Core Functions** | Full commercial banking, foreign exchange, L/C, bank guarantees, RTGS, merchant banking, treasury | Group-guarantee microcredit, micro-savings, financial literacy, micro-enterprise training |
| **Deposit Mobilization** | Open to the general public across Current, Savings, Fixed, and Call accounts | Limited primarily to members' group savings and collateral-free micro-deposits |
| **Foreign Trade & L/C** | Authorized for cross-border Letter of Credit (L/C), SWIFT, and foreign currency borrowing | Strictly prohibited from foreign currency trading, L/C, and international SWIFT |
| **Collateral Modality** | Tangible legal collateral (real estate, gold, fixed deposit receipts, corporate hypothecation) | Social group guarantee (peer pressure), non-collateral group loans (up to statutory ceilings) |

3. Complementary Symbiosis in the Financial System:
* Commercial banks are mandated by NRB to channel at least 5% of their total credit into deprived sectors (विपन्न वर्ग कर्जा), which they primarily disburse as wholesale bulk loans to Class 'D' microfinance institutions.
* In turn, microfinance institutions disburse these wholesale funds as retail microloans to rural grassroots borrowers.

4. Current Sectoral Challenges:
* Over-indebtedness and multiple borrowing across multiple microfinances by the same borrower.
* Escalating Non-Performing Loans (NPL) in microfinance due to economic slowdown and loan recovery resistance.

5. Conclusion:
Both tiers are mutually indispensable: Class 'A' banks drive national capital formation and corporate trade, while Class 'D' microfinance institutions democratize grassroots credit access.""",
        """१. पृष्ठभूमि तथा अवधारणा:
बैंक तथा वित्तीय संस्था सम्बन्धी ऐन (BAFIA), २०७३ ले कार्य प्रकृति, पुँजी र कार्यक्षेत्रका आधारमा संस्थाहरूलाई विशिष्टीकृत गरेको छ। 'क' वर्गका वाणिज्य बैंकहरू बृहत् आर्थिक कारोबार र व्यापार सञ्चालनका संवाहक हुन् भने 'घ' वर्गका लघुवित्त संस्थाहरू ग्रामीण गरिबी निवारण र वित्तीय पहुँचका आधारस्तम्भ हुन्।

२. 'क' वर्ग वाणिज्य बैंक र 'घ' वर्ग लघुवित्त बीचको तुलनात्मक तालिका:
| तुलनाका आधारहरू | 'क' वर्गका वाणिज्य बैंक | 'घ' वर्गका लघुवित्त वित्तीय संस्था |
|---|---|---|
| **कानुनी आधार** | BAFIA २०७३ को दफा ४९(१) | BAFIA २०७३ को दफा ४९(४) |
| **न्यूनतम चुक्ता पुँजी** | **रू. ८ अर्ब** (राष्ट्रिय स्तर) | **रू. १० करोड** (राष्ट्रिय स्तर) |
| **लक्षित ग्राहक वर्ग** | ठूला उद्योगी, व्यापारी, कर्पोरेट घराना र सर्वसाधारण नागरिक | ग्रामीण विपन्न वर्ग, न्यून आय भएका महिला तथा साना किसान |
| **मुख्य कार्यहरू** | निक्षेप संकलन, ठूला परियोजना कर्जा, विदेशी विनिमय, L/C, ग्यारेन्टी, डिजिटल बैंकिङ | समूह जमानीमा बिना धितो लघु कर्जा, बचत परिचालन र सीप विकास |
| **निक्षेप परिचालनको दायरा** | चालु, बचत, मुद्दती लगायत सर्वसाधारणबाट खुला रूपमा | मुख्यतया आफ्ना सदस्यहरूको समूह बचतमा मात्र सीमित |
| **अन्तर्राष्ट्रिय व्यापार/L/C** | L/C, बैंक ग्यारेन्टी र SWIFT सञ्चालन गर्न पूर्ण अधिकार | विदेशी विनिमय र L/C कारोबार गर्न पूर्ण प्रतिबन्ध |
| **धितोको प्रकृति** | अचल सम्पत्ति (घर, जग्गा), सुनचाँदी, सेयर तथा हाइपोथिकेसन धितो | सामाजिक सामूहिक जमानी (सामूहिक उत्तरदायित्व) र बिना धितो |

३. दुई संस्था बीचको सह-सम्बन्ध:
* वाणिज्य बैंकहरूले आफ्नो कुल कर्जाको कम्तीमा ५% विपन्न वर्गमा प्रवाह गर्नुपर्ने नेपाल राष्ट्र बैंकको बाध्यकारी नियम छ।
* यो नियम पूरा गर्न वाणिज्य बैंकहरूले लघुवित्त संस्थाहरूलाई थोक कर्जा (Wholesale Loan) उपलब्ध गराउँछन् र लघुवित्तले सो रकम ग्रामीण विपन्नलाई खुद्रा कर्जाका रूपमा बाँड्दछन्।

४. वर्तमान चुनौतीहरू:
* एउटै ऋणीले धेरै लघुवित्तबाट कर्जा लिने बहु-बैंकिङ (Multiple Borrowing) समस्या।
* आर्थिक मन्दीका कारण कर्जा असुलीमा अवरोध र लघुवित्तको खराब कर्जा (NPL) मा वृद्धि।

५. निष्कर्ष:
यी दुवै संस्था एकअर्काका प्रतिस्पर्धी नभई परिपूरक हुन्। वाणिज्य बैंकले राष्ट्रिय पुँजी परिचालन गर्छ भने लघुवित्तले तल्लो तहसम्म वित्तीय साक्षरता र समावेशीकरण पुर्‍याउँछ।""")

    # --- UNIT 2: Key Banking Terminology ---
    add_q("p1a_u2_sub203", 2, "Unit 2: Key Banking Terminology", 5, "2080 BS - RBB IT",
        "What is Loan Loss Provisioning? Explain the provisioning criteria prescribed by Nepal Rastra Bank for Performing and Non-Performing Loans.",
        "कर्जा नोक्सानी व्यवस्था (Loan Loss Provisioning) भन्नाले के बुझिन्छ? नेपाल राष्ट्र बैंकको निर्देशिका बमोजिम असल र खराब कर्जाका लागि तोकिएको प्रोभिजनिङ दरहरू उल्लेख गर्नुहोस्।",
        """1. Concept of Loan Loss Provisioning:
Loan Loss Provisioning is a statutory non-cash expense deducted from a bank's operating income and held in reserve to absorb anticipated defaults and credit impairments in its loan portfolio. It protects depositor funds and maintains bank solvency.

2. NRB Loan Classification & Provisioning Norms (Unified Directives):
Nepal Rastra Bank categorizes loans into two broad groups:

A. Performing Loans (सक्रिय कर्जा):
* **Pass (असल कर्जा):** Overdue up to 30 days $\to$ **1.20% / 1.25% provision**
* **Watchlist (सूक्ष्म निगरानी):** Overdue between 31 to 90 days, or borrower with consecutive operating losses $\to$ **5% provision**

B. Non-Performing Loans - NPL (निष्क्रिय कर्जा):
* **Substandard (कमसल कर्जा):** Overdue between 91 to 180 days $\to$ **25% provision**
* **Doubtful (शंकास्पद कर्जा):** Overdue between 181 to 365 days (1 year) $\to$ **50% provision**
* **Loss (खराब कर्जा):** Overdue by more than 365 days (1 year), borrower blacklisted, collateral unrecoverable, or loan misappropriated $\to$ **100% provision**

3. Impact on Financial Performance:
* Higher NPL directly increases provisioning expenses, reducing net profit and eroding Tier 1 Core Capital.
* If a bank's net NPL crosses 5%, NRB imposes prompt corrective action (PCA) restricting dividend distribution.

4. Conclusion:
Rigorous adherence to provisioning norms ensures transparent balance sheets and provides an early warning buffer against systemic insolvency.""",
        """१. कर्जा नोक्सानी व्यवस्थाको अवधारणा:
बैंकले प्रवाह गरेको कर्जा समयमै फिर्ता नहुने सम्भावित जोखिमलाई दृष्टिगत गरी बैंकको नाफा-नोक्सान हिसाबबाट छुट्ट्याएर राखिने सुरक्षा कोषलाई **कर्जा नोक्सानी व्यवस्था (Loan Loss Provisioning)** भनिन्छ। यसले सर्वसाधारणको निक्षेपलाई सुरक्षित राख्न मद्दत गर्दछ।

२. नेपाल राष्ट्र बैंकको एकीकृत निर्देशिका बमोजिम कर्जा वर्गीकरण र प्रोभिजनिङ दरहरू:

क. सक्रिय कर्जा (Performing Loans):
* **असल कर्जा (Pass):** समयमै भुक्तानी भइरहेको वा १ महिना (३० दिन) सम्म भाखा नाघेको $\to$ **१.२५% (वा तोकिए बमोजिम १.२०%)**
* **सूक्ष्म निगरानी (Watchlist):** १ महिनादेखि ३ महिना (३१ देखि ९० दिन) सम्म भाखा नाघेको वा लगातार घाटामा चलेको $\to$ **५%**

ख. निष्क्रिय कर्जा (Non-Performing Loans - NPL):
* **कमसल कर्जा (Substandard):** ३ महिनादेखि ६ महिना (९१ देखि १८० दिन) सम्म भाखा नाघेको $\to$ **२५%**
* **शंकास्पद कर्जा (Doubtful):** ६ महिनादेखि १ वर्ष (१८१ देखि ३६५ दिन) सम्म भाखा नाघेको $\to$ **५०%**
* **खराब कर्जा (Loss):** १ वर्षभन्दा बढी भाखा नाघेको, ऋणी कालोसूचीमा परेको वा धितो लिलाम हुन नसकेको $\to$ **१००%**

३. वित्तीय विवरणमा यसको प्रभाव:
* खराब कर्जा बढ्दा प्रोभिजनिङ रकम बढ्न गई बैंकको खुद नाफा र प्राथमिक पुँजी कोष (Tier 1) घट्छ।
* कुल निष्क्रिय कर्जा ५% भन्दा बढी भएमा नेपाल राष्ट्र बैंकले लाभांश वितरणमा रोक लगाउन सक्दछ।

४. निष्कर्ष:
यथार्थपरक कर्जा वर्गीकरण र नोक्सानी व्यवस्थाले बैंकको वित्तीय स्वास्थ्यलाई पारदर्शी र संकटमुक्त बनाउन मद्दत गर्दछ।""")

    add_q("p1a_u2_sub204", 2, "Unit 2: Key Banking Terminology", 10, "2079 BS - RBB IT",
        "What is the Base Rate of a commercial bank? Elaborate its mathematical components, significance in loan pricing, and the rationale behind NRB's Interest Rate Spread cap.",
        "वाणिज्य बैंकको आधार दर (Base Rate) भन्नाले के बुझिन्छ? यसका गणितीय तत्वहरू, कर्जाको ब्याजदर निर्धारणमा यसको भूमिका र नेपाल राष्ट्र बैंकले ब्याजदर अन्तर (Interest Rate Spread) मा सीमा तोक्नुको औचित्य पुष्टि गर्नुहोस्।",
        """1. Concept of Base Rate:
The **Base Rate** is the statutory minimum benchmark interest rate determined objectively by a commercial bank below which it is legally prohibited to lend (except for targeted government-subsidized priority schemes). It reflects the bank's internal cost of loanable funds and operational efficiency.

2. Mathematical Components of Base Rate:
Pursuant to NRB Directives, Base Rate is calculated monthly using the formula:
$$\\text{Base Rate} = \\text{Cost of Funds (\\%)} + \\text{Cost of CRR (\\%)} + \\text{Cost of SLR (\\%)} + \\text{Operating Cost (\\%)} + \\text{Return on Assets / Profit Margin (\\% capped)}$$

Where:
* **Cost of Funds:** Weighted average interest paid on all deposits and borrowings.
* **Cost of CRR:** Opportunity cost of holding 4% unremunerated cash with NRB.
* **Cost of SLR:** Yield shortfall from holding 12% statutory liquidity in government securities.
* **Operating Cost:** Staff, administrative, and technological operating expenditure as a percentage of total earning assets.
* **Return on Assets (RoA):** Capped regulated benchmark margin (traditionally 0.75%).

3. Role of Base Rate in Loan Pricing:
* Banks determine individual loan interest rates transparently as:
$$\\text{Lending Rate} = \\text{Base Rate} + \\text{Risk Premium (Spread)}$$
* The risk premium (e.g., 1.5% to 4.0%) reflects the borrower's credit score, collateral liquidity, and business sector risk.
* Prevents arbitrary discriminatory interest rate gouging by branch managers.

4. Rationale Behind Capping the Interest Rate Spread (≤ 4.0%):
* Under current NRB Directives, the spread between weighted average lending rate and weighted average deposit rate must not exceed **4.00%**.
* **Protection against Monopolistic Gouging:** Prevents banks from paying rock-bottom interest to public depositors while charging exorbitant rates to borrowers.
* **Economic Stimulus:** Lowers borrowing costs for productive national industries and employment-generating startups.
* **Operational Efficiency Discipline:** Forces banks to rein in bloated operational and administrative costs rather than shifting inefficiencies onto borrowers.

5. Conclusion:
The Base Rate system and Spread cap provide algorithmic transparency to Nepalese monetary transmission, aligning banking profitability with national industrial competitiveness.""",
        """१. आधार दर (Base Rate) को अवधारणा:
**आधार दर (Base Rate)** भनेको बैंकले कर्जा प्रवाह गर्दा लिनुपर्ने न्यूनतम लागतमा आधारित पारदर्शी ब्याजदर हो। नेपाल राष्ट्र बैंकको नियम अनुसार आधार दर भन्दा कम ब्याज लिएर कर्जा प्रवाह गर्न पाइँदैन (सहुलियतपूर्ण कर्जा बाहेक)।

२. आधार दर गणनाका गणितीय तत्वहरू:
नेपाल राष्ट्र बैंकको कार्यविधि अनुसार प्रत्येक महिनाको अन्त्यमा निम्न सूत्रबाट आधार दर निकालिन्छ:
$$\\text{आधार दर} = \\text{कोषको लागत (Cost of Funds)} + \\text{अनिवार्य नगद अनुपात लागत (Cost of CRR)} + \\text{वैधानिक तरलता लागत (Cost of SLR)} + \\text{सञ्चालन खर्च (Operating Cost)} + \\text{सम्पत्तिमा प्रतिफल (RoA Margin)}$$

* **कोषको लागत:** निक्षेप संकलन गर्दा तिर्नुपर्ने भारित औसत ब्याज।
* **CRR लागत:** राष्ट्र बैंकमा बिना ब्याज राख्नुपर्ने ४% नगद मौज्दातको अवसर लागत।
* **SLR लागत:** १२% सरकारी ऋणपत्रमा लगानी गर्दा हुने ब्याज अन्तरको लागत।
* **सञ्चालन लागत:** कर्मचारी खर्च, कार्यालय सञ्चालन र प्रविधि खर्चको अनुपात।
* **RoA मार्जिन:** नियमनकारी निकायले तोकेको प्रतिफल सीमा (०.७५% सम्म)।

३. कर्जाको ब्याजदर निर्धारणमा भूमिका:
* बैंकले ग्राहकको ब्याजदर तोक्दा आधार दरलाई मुख्य आधार मान्दछ:
$$\\text{कर्जाको ब्याजदर} = \\text{आधार दर (Base Rate)} + \\text{जोखिम प्रिमियम (Risk Premium)}$$
* ग्राहकको कर्जा जोखिम (Credit Risk) र धितोको आधारमा १ देखि ४ प्रतिशतसम्म प्रिमियम जोडिन्छ।
* यसले बैंकका कर्मचारीले मनपरी ढंगले ब्याजदर थपघट गर्ने विभेद अन्त्य गर्दछ।

४. ब्याजदर अन्तर (Interest Rate Spread) मा सीमा (अधिकतम ४.०%) तोक्नुको औचित्य:
* नेपाल राष्ट्र बैंकले कर्जाको औसत ब्याजदर र निक्षेपको औसत ब्याजदर बीचको अन्तर **४.००% भन्दा बढी हुन नहुने** व्यवस्था गरेको छ।
* **निक्षेपकर्ता र ऋणीको संरक्षण:** बैंकहरूले निक्षेपकर्तालाई एकदमै न्यून ब्याज दिने र ऋणीबाट चर्को असुल्ने मनोमानी रोक्न।
* **औद्योगिक लागत घटाउन:** बैंकको ब्याजदर सन्तुलित बनाई उत्पादनशील उद्योग र व्यापारलाई प्रोत्साहन गर्न।
* **बैंकको खर्च नियन्त्रण:** बैंकहरूलाई फजुल प्रशासनिक खर्च घटाएर कार्यक्षमता बढाउन बाध्य पार्न।

५. निष्कर्ष:
आधार दर र स्प्रेड दरको पारदर्शी कार्यान्वयनले वित्तीय बजारमा स्वस्थ प्रतिस्पर्धा कायम गर्दै मौद्रिक नीतिको प्रभावकारी कार्यान्वयनमा सहयोग पुर्‍याउँछ।""")

    # --- UNIT 3: Banking Related Law ---
    add_q("p1a_u3_sub205", 3, "Unit 3: Banking Related Laws", 10, "2080 BS - RBB IT",
        "Elaborate the prohibited activities for licensed banks and financial institutions under Section 49 of BAFIA 2073. What is the rationale behind these statutory restrictions?",
        "बैंक तथा वित्तीय संस्था सम्बन्धी ऐन (BAFIA), २०७३ को दफा ४९ बमोजिम इजाजतपत्रप्राप्त बैंक तथा वित्तीय संस्थाहरूले गर्न नहुने कार्यहरू उल्लेख गर्दै ती प्रतिबन्धहरूको औचित्य स्पष्ट पार्नुहोस्।",
        """1. Introduction:
Section 49 of the **Bank and Financial Institutions Act (BAFIA), 2073** delineates explicit statutory prohibitions restricting activities of licensed financial institutions. These negative covenants prevent conflict of interest, curb speculative asset bubbles, and safeguard public deposits from reckless management.

2. Prohibited Transactions under BAFIA 2073 (Section 49):
Licensed banks and financial institutions are strictly barred from:
1. **Trading in Goods & Commodities:** Engaging in direct purchase and sale of merchandise or commercial commodities for business trade (except for recovering collateral).
2. **Real Estate Speculation:** Purchasing real estate or immovable property, other than what is strictly necessary for housing its own bank branches and offices.
3. **Lending Against Own Shares:** Advancing loans or credit facilities backed by the pledge of its own equity shares.
4. **Insider Lending to Promoters & Executives:** Granting loans or credit facilities to its own Directors, CEO, Managing Director, major shareholders (holding $\ge 1\\%$ shares), or their close family members.
5. **Discriminatory Credit Syndication:** Extending credit to customers who are blacklisted by the Credit Information Bureau (CIB).
6. **Cross-Holding Restrictions:** Investing more than prescribed regulatory limits in equity shares of other BFIs or corporate entities outside central bank guidelines.
7. **Monopolistic Collusion:** Forming cartels, fixing non-competitive rates, or participating in uncompetitive restrictive trade practices.

3. Rationale Behind Statutory Restrictions:
* **Fiduciary Duty Protection:** Depositors' money accounts for over 85-90% of a bank's balance sheet; speculative trading or insider self-dealing jeopardizes public solvency.
* **Mitigation of Systemic Risk:** Restricting real estate speculation prevents banks from over-leveraging into volatile real estate bubbles that precipitated the 2008 global financial crisis.
* **Elimination of Moral Hazard & Cronyism:** Preventing promoter loans ensures that powerful bank founders cannot siphon depositors' money into their personal private businesses.
* **Focus on Core Intermediation:** Keeps banks focused strictly on safe credit intermediation rather than commercial retail speculation.

4. Conclusion:
Section 49 represents the foundational regulatory firewall preserving corporate governance, depositor trust, and structural stability across Nepal's financial sector.""",
        """१. परिचय तथा कानुनी पृष्ठभूमि:
बैंक तथा वित्तीय संस्थाहरू सर्वसाधारणको निक्षेपको जिम्मा लिने विश्वासका धरोहर हुन्। **बैंक तथा वित्तीय संस्था सम्बन्धी ऐन (BAFIA), २०७३ को दफा ४९** ले बैंकहरूलाई सञ्चालन जोखिम, स्वार्थको द्वन्द्व र सट्टेबाजीबाट जोगाउन गर्न नहुने कार्यहरूको स्पष्ट कानुनी सूची निर्धारण गरेको छ।

२. BAFIA २०७३ को दफा ४९ अनुसार गर्न नहुने प्रमुख कार्यहरू:
१. **व्यापारिक वस्तुको खरिद-बिक्री गर्न नहुने:** व्यापार गर्ने उद्देश्यले कुनै पनि मालसामान खरिद-बिक्री गर्न वा व्यापारिक उद्योग सञ्चालन गर्न पाइँदैन (धितो लिलाम बाहेक)।
२. **घरजग्गा सट्टेबाजीमा रोक:** आफ्नो कार्यालय र शाखा सञ्चालन गर्न आवश्यक पर्ने बाहेक व्यापार वा नाफा कमाउने उद्देश्यले घरजग्गा खरिद गर्न नहुने।
३. **आफ्नै सेयर धितोमा कर्जा दिन नहुने:** बैंकले आफ्नै संस्थाको सेयर धितो राखेर कसैलाई पनि कर्जा प्रवाह गर्न पाउँदैन।
४. **सञ्चालक तथा पदाधिकारीलाई कर्जा दिन नहुने (इन्साइडर लेन्डिङ रोक):** आफ्ना सञ्चालक, प्रमुख कार्यकारी अधिकृत (CEO), १% भन्दा बढी सेयर भएका संस्थापक र तिनका परिवारका सदस्यलाई कर्जा दिन पूर्ण बन्देज।
५. **कालोसूचीमा परेकालाई कर्जा दिन नहुने:** कर्जा सूचना केन्द्र (CIB) को कालोसूचीमा रहेका व्यक्ति वा फर्मलाई कर्जा प्रवाह गर्न नहुने।
६. **अनुमति बिना अन्य संस्थामा लगानी गर्न नहुने:** नेपाल राष्ट्र बैंकले तोकेको सीमा भन्दा बढी अन्य संगठित संस्थाको सेयर वा धितोपत्रमा लगानी गर्न नहुने।
७. **एकाधिकार तथा कार्टेलिङ गर्न नहुने:** अन्य बैंकहरूसँग मिलेर ब्याजदर सिन्डिकेट गर्ने वा स्वच्छ प्रतिस्पर्धामा बाधा पुर्‍याउने कार्य गर्न नहुने।

३. यी प्रतिबन्धहरूको औचित्य:
* **निक्षेपकर्ताको सुरक्षा:** बैंकमा ९०% रकम सर्वसाधारण जनताको हुने भएकाले सञ्चालकहरूले व्यक्तिगत स्वार्थमा सो रकम दुरुपयोग गर्न नपाऊन्।
* **घरजग्गा बबलबाट मुक्ति:** अनुत्पादक घरजग्गामा अत्यधिक लगानी हुँदा आउने वित्तीय संकटबाट बैंकिङ क्षेत्रलाई जोगाउन।
* **स्वार्थको द्वन्द्व (Conflict of Interest) अन्त्य:** संस्थापकहरूले बैंकबाट आफैं ऋण लिएर आफ्ना निजी उद्योगमा लगानी गर्ने विकृति रोक्न।
* **बैंकिङ अनुशासन:** बैंकलाई वस्तु व्यापारको सट्टा शुद्ध वित्तीय मध्यस्थता र उत्पादनशील कर्जामा केन्द्रित गराउन।

४. निष्कर्ष:
दफा ४९ को कडा परिपालनाले वित्तीय सुशासन, निष्पक्षता र बैंकिङ प्रणालीको विश्वसनीयता अक्षुण्ण राख्न निर्णायक भूमिका खेल्दछ।""")

    add_q("p1a_u3_sub206", 3, "Unit 3: Banking Related Laws", 5, "2079 BS - RBB IT",
        "What are the major objectives and key reporting obligations of banks under the Money Laundering Prevention Act, 2064?",
        "सम्पत्ति शुद्धीकरण निवारण ऐन, २०६४ का मुख्य उद्देश्यहरू र यस अन्तर्गत बैंकहरूले पूरा गर्नुपर्ने प्रमुख प्रतिवेदन दायित्वहरू प्रष्ट पार्नुहोस्।",
        """1. Objectives of the Act:
The **Money Laundering Prevention Act, 2064 (AML/CFT)** aims to:
* Prevent illicit funds generated from organized crime, corruption, drug trafficking, tax evasion, and terrorism from infiltrating the formal financial system.
* Confiscate property acquired through criminal activities and penalize offenders.
* Ensure Nepal's compliance with Financial Action Task Force (FATF) 40 Recommendations to avoid the FATF 'Grey List'.

2. Key Reporting Obligations for Commercial Banks:
* **Customer Due Diligence (CDD/KYC):** Mandatorily verify the identity of account holders, beneficial owners, and PEPs (Politically Exposed Persons) before establishing business relationships.
* **Threshold Transaction Reporting (TTR):** Report any cash transaction (deposit, withdrawal, exchange) of **Rs. 1 Million (Rs. 10 Lakhs) or above** in a single day to the Financial Information Unit (FIU) within 7 days.
* **Suspicious Transaction Reporting (STR):** Promptly file an STR to the FIU (without tipping off the customer) within 3 days if any transaction deviates from the customer's legitimate profile or smells of illicit origin, regardless of the transaction amount.
* **Record Retention:** Retain all customer identification documents, transaction ledgers, and KYC files for at least **5 years** following the termination of the business relationship.

3. Conclusion:
Robust AML/CFT compliance protects commercial banks from reputational destruction and sanctions while upholding Nepal's international banking integrity.""",
        """१. ऐनको मुख्य उद्देश्य:
**सम्पत्ति शुद्धीकरण (मनि लाउन्डरिङ) निवारण ऐन, २०६४** का प्रमुख उद्देश्यहरू:
* आतंकवाद, भ्रष्टाचार, लागुऔषध र संगठित अपराधबाट आर्जित अवैध कालो धनलाई बैंकिङ प्रणाली मार्फत सेतो बनाउने कार्य रोक्नु।
* अपराधजन्य सम्पत्ति जफत गरी अपराधीलाई कानुनी कारबाहीको दायरामा ल्याउनु।
* नेपाललाई अन्तर्राष्ट्रिय संस्था FATF (Financial Action Task Force) को 'ग्रे लिस्ट' मा पर्नबाट जोगाउनु।

२. बैंकहरूले पूरा गर्नुपर्ने प्रमुख प्रतिवेदन दायित्वहरू:
* **ग्राहक पहिचान तथा प्रमाणीकरण (KYC/CDD):** खाता खोल्नु अघि ग्राहकको वास्तविक परिचय, पेशा, आयस्रोत र वास्तविक हितग्राही (Beneficial Owner) यकिन गर्नु।
* **सीमा कारोबार प्रतिवेदन (TTR):** कुनै ग्राहकले एकै दिनमा **रू. १० लाख वा सोभन्दा बढी** को नगद कारोबार गरेमा सोको विवरण ७ दिन भित्र वित्तीय जानकारी इकाई (FIU) मा पठाउनु।
* **शंकास्पद कारोबार प्रतिवेदन (STR):** कारोबारको रकम जतिसुकै भए पनि शंकास्पद लागेमा ३ दिन भित्र गोप्य रूपमा FIU मा STR प्रतिवेदन पेश गर्नु (ग्राहकलाई थाहा नदिई - Tipping Off निषेध)।
* **अभिलेख संरक्षण:** खाता बन्द भएको वा कारोबार सम्पन्न भएको कम्तीमा **५ वर्षसम्म** सम्पूर्ण कागजात र विद्युतीय अभिलेख सुरक्षित राख्नु।

३. निष्कर्ष:
सम्पत्ति शुद्धीकरण निवारण ऐनको पूर्ण परिपालनाले बैंकलाई अन्तर्राष्ट्रिय प्रतिबन्ध र प्रतिष्ठाको जोखिमबाट जोगाउँछ।""")

    # --- UNIT 4: Organizational Behavior ---
    add_q("p1a_u4_sub207", 4, "Unit 4: Organizational Behavior", 5, "2077 BS - NRB Assistant",
        "Define Job Description (JD) and Terms of Reference (TOR). Highlight their significance in banking human resource management.",
        "कार्य विवरण (Job Description) र कार्य सर्त (Terms of Reference - TOR) को परिभाषा दिँदै बैंकिङ जनशक्ति व्यवस्थापनमा यिनको महत्त्व उजागर गर्नुहोस्।",
        """1. Definitions:
* **Job Description (JD):** A formal written document detailing the title, duties, reporting hierarchy, responsibilities, working conditions, and performance metrics of a permanent job position in the organization.
* **Terms of Reference (TOR):** A project- or assignment-specific framework outlining the objectives, scope of work, deliverables, milestones, and timeline for contractual consultants, committee members, or temporary task forces.

2. Key Differences in Matrix Form:
| Dimension | Job Description (JD) | Terms of Reference (TOR) |
|---|---|---|
| **Nature** | Continuous, role-centric, permanent | Assignment-centric, bounded, temporary |
| **Applicability** | Core staff (e.g., Senior Assistant IT, Branch Manager) | Consultants, task forces, outsourced system auditors |
| **Content** | Duties, qualifications, supervisory reporting | Project deliverables, deadlines, remuneration milestones |

3. Significance in Banking HR Management:
* **Role Clarity & Accountability:** Prevents role ambiguity and overlap between departments (e.g., IT Operations vs Information Security).
* **Objective Performance Appraisal:** Provides measurable Key Performance Indicators (KPIs) for annual promotions, bonus allocations, and training needs analysis.
* **Recruitment Precision:** Guides the HR recruitment team to screen candidate skillsets matching statutory job specifications.
* **Conflict Minimization:** Eliminates jurisdictional disputes and establishes clear supervisory chains of command.

4. Conclusion:
Clear JDs and TORs serve as the cornerstone of employee motivation, operational precision, and regulatory compliance in modern commercial banks.""",
        """१. परिभाषा तथा अवधारणा:
* **कार्य विवरण (Job Description - JD):** संस्थाको कुनै निश्चित स्थायी पदको नाम, कामको प्रकृति, गर्नुपर्ने कर्तव्य, उत्तरदायित्व, आवश्यक योग्यता र सुपरिवेक्षण सम्बन्ध खुलाइएको औपचारिक दस्तावेज हो।
* **कार्य सर्त (Terms of Reference - TOR):** कुनै निश्चित परियोजना, अध्ययन कार्यदल वा परामर्शदाताका लागि तोकिएको उद्देश्य, कार्यक्षेत्र, सम्पन्न गर्नुपर्ने माइलस्टोन र समय-सीमा तोकिएको दस्तावेज हो।

२. JD र TOR बीचको मुख्य भिन्नता:
| आधार | कार्य विवरण (Job Description) | कार्य सर्त (Terms of Reference) |
|---|---|---|
| **प्रकृति** | स्थायी र पद-केन्द्रित हुन्छ | अस्थायी र कार्य/परियोजना-केन्द्रित हुन्छ |
| **लागू हुने** | नियमित कर्मचारी (जस्तै: वरिष्ठ सहायक IT) | विज्ञ, परामर्शदाता, अडिटर वा कार्यदल |
| **मुख्य विषय** | दैनिक कर्तव्य, उत्तरदायित्व, कार्यसम्पादन मापन | परियोजनाका उपलब्धि (Deliverables) र म्याद |

३. बैंकिङ जनशक्ति व्यवस्थापनमा यसको महत्त्व:
* **काममा स्पष्टता र जिम्मेवारीबोध:** कर्मचारीले के काम गर्ने र कसलाई प्रतिवेदन गर्ने भन्ने स्पष्ट भई द्विविधा हट्छ।
* **पारदर्शी कार्यसम्पादन मूल्याङ्कन:** वार्षिक कार्यसम्पादन, बढुवा र पुरस्कार वितरणका लागि वस्तुगत सूचक (KPI) प्रदान गर्छ।
* **पदपूर्तिमा सहजता:** विज्ञापन र छनोट गर्दा पद अनुसार चाहिने ठ्याक्कै योग्यता र सीप पहिचान गर्न सघाउँछ।
* **विवाद र कार्य दोहोरोपन न्यूनीकरण:** विभागहरू बीच अधिकार क्षेत्रको विवाद र जिम्मेवारी पन्छाउने प्रवृत्ति रोक्छ।

४. निष्कर्ष:
स्पष्ट कार्य विवरण र कार्य सर्तले कर्मचारीको मनोबल बढाउँदै संस्थागत उत्पादकत्व र सुशासन कायम राख्न मद्दत गर्दछ।""")

    # --- UNIT 5: Other Related Laws ---
    add_q("p1a_u5_sub208", 5, "Unit 5: Other Related Laws", 5, "2078 BS - RBB IT",
        "Discuss the employee leave and welfare entitlements guaranteed under Nepal's Labour Act, 2074.",
        "नेपालको श्रम ऐन, २०७४ ले श्रमिकहरूका लागि सुनिश्चित गरेका विभिन्न प्रकारका बिदा र कल्याणकारी सुविधाहरू बारे चर्चा गर्नुहोस्।",
        """1. Introduction:
The **Labour Act, 2074** serves as the umbrella labor legislation governing rights, remuneration, working hours, occupational safety, and social security for workers across private and public corporate enterprises in Nepal.

2. Statutory Leave Entitlements under Labour Act 2074:
* **Weekly Rest:** 1 day off for every 6 continuous working days.
* **Public Holidays:** 13 days of paid public holidays per year (including May Day).
* **Home / Annual Leave:** 1 day of paid leave for every 20 days worked (accruable up to 90 days).
* **Sick Leave:** Fully paid sick leave of 12 days per year (accruable up to 45 days).
* **Maternity Leave:** 98 days for female employees (fully paid for 60 days).
* **Paternity Leave:** 15 days of fully paid paternity leave for male employees.
* **Mourning Leave:** 13 days of fully paid mourning leave.

3. Key Welfare & Social Security Entitlements:
* **Social Security Fund (SSF):** Mandatory contribution of 31% of basic salary (11% deducted from employee + 20% contributed by employer) towards medical, accident, disability, and retirement pension schemes.
* **Provident Fund (10%) & Gratuity (8.33%):** Directly integrated into SSF.
* **Festival Allowance:** Equivalent to 1 month's basic remuneration paid annually (Dashain allowance).
* **Occupational Health & Safety (OHS):** Mandatory safe physical working conditions, first aid, ergonomic seating, and ventilation.

4. Conclusion:
The Labour Act 2074 harmonizes employee productivity with social welfare, fostering equitable industrial relations and employee retention in banking institutions.""",
        """१. परिचय:
**श्रम ऐन, २०७४** नेपालका प्रतिष्ठानहरूमा कार्यरत श्रमिक तथा कर्मचारीहरूको हकहित, कामको वातावरण, पारिश्रमिक र सामाजिक सुरक्षाको प्रत्याभूति गर्ने मूल कानुन हो।

२. श्रम ऐन, २०७४ अनुसार श्रमिकले पाउने बिदाका व्यवस्थाहरू:
* **साप्ताहिक बिदा:** प्रत्येक हप्ता १ दिनको बिदा।
* **सार्वजनिक बिदा:** वर्षमा १३ दिन (मे दिवस सहित) पारिश्रमिक सहितको बिदा।
* **घर बिदा:** प्रत्येक २० दिन काम गरे बापत १ दिन (वर्षको बढीमा १८ दिन, ९० दिनसम्म सञ्चित हुने)।
* **बिरामी बिदा:** वर्षमा १२ दिन पूरा पारिश्रमिक सहित (४५ दिनसम्म सञ्चित हुने)।
* **प्रसूति बिदा:** महिला कर्मचारीलाई ९८ दिन (६० दिन पूरा तलब सहित)।
* **प्रसूति स्याहार बिदा:** पुरुष कर्मचारीलाई १५ दिन पूरा तलब सहित।
* **किरिया बिदा:** वर्षमा १३ दिन पूरा पारिश्रमिक सहित।

३. मुख्य कल्याणकारी तथा सामाजिक सुरक्षा सुविधाहरू:
* **सामाजिक सुरक्षा कोष (SSF) मा आबद्धता:** आधारभूत तलबको कुल ३१% (कर्मचारीको ११% + रोजगारदाताको २०%) कोषमा जम्मा गरी पेन्सन, स्वास्थ्य तथा दुर्घटना सुविधा।
* **चाडपर्व खर्च:** वर्षको एक पटक १ महिनाको आधारभूत तलब बराबरको चाडपर्व खर्च (दशैं खर्च)।
* **व्यावसायिक स्वास्थ्य तथा सुरक्षा:** सुरक्षित कार्यथलो, प्राथमिक उपचार, स्वच्छ हावा र प्रकाशको प्रबन्ध।

४. निष्कर्ष:
श्रम ऐनका यी कल्याणकारी व्यवस्थाहरूले बैंक तथा वित्तीय संस्थामा कार्यरत कर्मचारीहरूको जीवनस्तर सुधार्दै कार्यक्षमता र उत्पादकत्व वृद्धि गर्न मद्दत पुर्‍याउँछन्।""")

    # --- UNIT 6: Digital Payment Systems ---
    add_q("p1a_u6_sub209", 6, "Unit 6: Digital Payment Systems", 10, "2081 BS - RBB IT",
        "Explain the architecture, settlement mechanism, and risk-mitigation features of Real Time Gross Settlement (RTGS) operated by Nepal Rastra Bank. How does it contrast with ConnectIPS?",
        "नेपाल राष्ट्र बैंकद्वारा सञ्चालित RTGS (Real Time Gross Settlement) प्रणालीको वास्तुकला, फछ्र्यौट विधि र जोखिम न्यूनीकरणका पक्षहरू व्याख्या गर्दै यसलाई ConnectIPS सँग तुलना गर्नुहोस्।",
        """1. Introduction & Concept:
The **Real Time Gross Settlement (RTGS)** system, implemented and operated directly by Nepal Rastra Bank since September 2019, is the apex financial market infrastructure (FMI) handling high-value and systemically critical wholesale interbank payments in Nepal.

2. Architecture & Working Mechanism of RTGS:
* **Real Time:** Each transaction is processed immediately upon receipt by the central bank's RTGS core engine without deferred waiting.
* **Gross Settlement:** Transactions are settled individually on a one-to-one basis without netting against counterparty debits or credits.
* **Immediate Finality:** Once settled across the settlement accounts maintained at NRB, transactions are legally irrevocable and unconditional.

```
[Sending Bank A] --- SWIFT / VPN ---> [NRB Central RTGS Core Engine] --- Real Time Settlement ---> [Receiving Bank B]
                                             |
                                  [Settlement Accounts at NRB]
```

3. Systemic Risk Mitigation Features:
* **Elimination of Settlement Risk:** In deferred net settlement (DNS), if one bank defaults at day-end, the whole clearing chain fails. RTGS settles on pre-funded central bank reserves, eliminating credit and counterparty risk.
* **Liquidity Management:** Provides intraday liquidity facility (ILF) and queuing mechanisms for banks to manage temporary liquidity shortages.
* **High-Value Isolation:** Protects the macroeconomy by keeping retail retail runs separate from wholesale interbank clearing.

4. Comparison: RTGS vs ConnectIPS:
| Parameter | RTGS (Real Time Gross Settlement) | ConnectIPS (NCHL) |
|---|---|---|
| **Operator** | Operated directly by **Nepal Rastra Bank (NRB)** | Operated by **Nepal Clearing House Limited (NCHL)** |
| **Target Segment** | Wholesale, high-value, systemic interbank payments | Retail, customer-to-business (C2B), P2P, merchant payments |
| **Transaction Floor** | Typically **$\\ge$ Rs. 200,000** (urgent transactions) | Small to medium retail transactions (up to Rs. 2 Million per transaction) |
| **Settlement Basis** | **Gross Real-Time** (Individual transaction basis) | **Deferred Net Settlement (DNS)** in cycles (under National Payment Switch) |
| **Channel Integration** | Core Banking System (CBS) / SWIFT / Branch banking | Web portal, Mobile Banking apps, Digital Wallets, APIs |
| **Fee Structure** | Regulated low tiered fee per transaction | Tiered micro-transaction fees (Rs. 2 to Rs. 8) |

5. Conclusion:
While RTGS acts as the sovereign wholesale spine guaranteeing financial stability against systemic bank default, ConnectIPS functions as the retail circulatory system empowering citizen-level digital commerce in Nepal.""",
        """१. RTGS को अवधारणा तथा परिचय:
**RTGS (Real Time Gross Settlement)** नेपाल राष्ट्र बैंकद्वारा आफैं सञ्चालन गरिएको नेपालको सबैभन्दा ठूलो र सुरक्षित थोक भुक्तानी प्रणाली हो। यसले वित्तीय बजारमा बैंकहरू बीच हुने ठूला र संवेदनशील रकमको तत्काल फछ्र्यौट गर्दछ।

२. RTGS को वास्तुकला र कार्यविधि:
* **Real Time (वास्तविक समय):** कारोबार दर्ता हुनासाथ कुनै पर्खाइ बिना तत्कालै प्रोसेस हुन्छ।
* **Gross Settlement (ग्रस फछ्र्यौट):** धेरै कारोबारलाई जोडेर नेटिङ (Netting) नगरी प्रत्येक कारोबारलाई व्यक्तिगत रूपमा छुट्टाछुट्टै फछ्र्यौट गरिन्छ।
* **अपरिवर्तनीय (Irrevocable):** राष्ट्र बैंकमा रहेको बैंकहरूको खातामा रकम स्थानान्तरण भएपछि सो कारोबार कानुनी रूपमा अन्तिम र अपरिवर्तनीय हुन्छ।

३. प्रणालीगत जोखिम न्यूनीकरणका पक्षहरू:
* **काउन्टरपार्टी जोखिमको अन्त्य:** अन्य प्रणालीमा दिनभरिको कारोबार बेलुका एकमुष्ठ मिलान गर्दा कुनै बैंक टाट पल्टिएमा सम्पूर्ण प्रणाली फेल हुने जोखिम हुन्छ। RTGS मा तत्कालै खातामा रकम भए मात्र कारोबार हुने हुँदा शून्य जोखिम रहन्छ।
* **इन्ट्रा-डे तरलता सुविधा (ILF):** दिनको समयमा बैंकलाई रकम अभाव भएमा राष्ट्र बैंकले धितोमा अस्थायी तरलता उपलब्ध गराउँछ।
* **प्रणालीगत स्थायित्व:** ठूला कारोबारलाई खुद्रा कारोबारबाट अलग राखी अर्थतन्त्रमा आउन सक्ने संकट रोक्छ।

४. RTGS र ConnectIPS बीचको तुलनात्मक विश्लेषण:
| तुलनाका आधारहरू | RTGS (नेपाल राष्ट्र बैंक) | ConnectIPS (NCHL) |
|---|---|---|
| **सञ्चालक निकाय** | सिधै **नेपाल राष्ट्र बैंक** द्वारा सञ्चालित | **नेपाल क्लियरिङ्ग हाउस लिमिटेड (NCHL)** द्वारा सञ्चालित |
| **कारोबारको प्रकृति** | ठूलो रकम (Wholesale) र अन्तरबैंक कारोबार | साना तथा मझौला खुद्रा (Retail), P2P र अनलाइन भुक्तानी |
| **कारोबारको सीमा** | सामान्यतया **रू. २ लाखभन्दा माथि** का ठूला रकम | रू. १ देखि अधिकतम रू. २० लाखसम्म (च्यानल अनुसार) |
| **फछ्र्यौटको आधार** | **Real Time Gross** (तत्काल छुट्टाछुट्टै फछ्र्यौट) | **Deferred Net Settlement (DNS)** (तोकिएको समय चक्रमा) |
| **पहुँच माध्यम** | बैंकको शाखा काउन्टर, CBS र SWIFT | मोबाइल बैंकिङ, वेबसाइट, वालेट र API |
| **शुल्क** | राष्ट्र बैंकले तोकेको न्यूनतम निश्चित शुल्क | कारोबार रकम अनुसार न्यूनतम रू. २ देखि रू. ८ सम्म |

५. निष्कर्ष:
RTGS ले देशको बैंकिङ प्रणालीको मेरुदण्डका रूपमा ठूला वित्तीय जोखिमबाट जोगाउँछ भने ConnectIPS ले आम नागरिकको दैनिक जीवनमा डिजिटल भुक्तानीलाई सहज र व्यापक बनाउँछ।""")

    return questions

if __name__ == "__main__":
    qs = get_banking_subjective_questions()
    print(f"Loaded {len(qs)} comprehensive banking subjective questions.")
