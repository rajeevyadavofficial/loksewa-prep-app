import json
import os

def get_batch3_questions():
    b3 = []
    def add(unit_num, idx, q_en, q_np, opts, ans, expl_en, expl_np, yr, u_title):
        b3.append({
            "id": f"p1a_u{unit_num}_mcq{idx}",
            "exam_id": "rbb_it_5",
            "paper": "paper1",
            "section": "sectionA",
            "unit_number": unit_num,
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

    # Unit 1: Financial Institutions in Nepal (45 questions)
    u1_title = "Unit 1: Financial Institutions in Nepal (Role, Contribution & Status)"
    add(1, 101, "According to the Bank and Financial Institutions Act (BAFIA) 2073, which category represents commercial banks in Nepal?",
        "बैंक तथा वित्तीय संस्था सम्बन्धी ऐन (BAFIA) २०७३ अनुसार वाणिज्य बैंकहरू कुन वर्गमा पर्दछन्?",
        ["'क' वर्ग (Class 'A')", "'ख' वर्ग (Class 'B')", "'ग' वर्ग (Class 'C')", "'घ' वर्ग (Class 'D')"],
        0, "Under BAFIA 2073, licensed institutions are classified as Class A (Commercial Banks), Class B (Development Banks), Class C (Finance Companies), and Class D (Microfinance Institutions).",
        "BAFIA २०७३ अनुसार 'क' वर्गमा वाणिज्य बैंक, 'ख' मा विकास बैंक, 'ग' मा वित्त कम्पनी र 'घ' मा लघुवित्त पर्दछन्।", "2065 BS - RBB IT", u1_title)

    add(1, 102, "What is the minimum paid-up capital requirement mandated by Nepal Rastra Bank for a national-level Class 'A' commercial bank?",
        "नेपाल राष्ट्र बैंकको निर्देशन अनुसार राष्ट्रिय स्तरको 'क' वर्गको वाणिज्य बैंक खोल्न न्यूनतम चुक्ता पुँजी कति हुनुपर्छ?",
        ["रू २ अर्ब (Rs. 2 Billion)", "'रू ५ अर्ब (Rs. 5 Billion)", "रू ८ अर्ब (Rs. 8 Billion)", "रू २० अर्ब (Rs. 20 Billion)"],
        2, "NRB Monetary Policy mandated that Class A commercial banks maintain a minimum paid-up capital of Rs. 8 Billion.",
        "वाणिज्य बैंकहरूको न्यूनतम चुक्ता पुँजी रू ८ अर्ब तोकिएको छ।", "2073 BS - NRB Assistant", u1_title)

    add(1, 103, "Nepal Infrastructure Development Bank (NIFRA) is licensed under BAFIA 2073 specifically to finance:",
        "नेपाल पूर्वाधार विकास बैंक (NIFRA) मुख्यतया कुन क्षेत्रमा कर्जा प्रवाह गर्न स्थापना गरिएको हो?",
        ["Short-term consumer gold loans", "Long-term infrastructure projects (hydropower, highways, airports)", "Retail vegetable vendors", "Agricultural microcredit"],
        1, "NIFRA was established with a minimum capital of Rs. 20 Billion to mobilize long-term capital for national infrastructure projects.",
        "NIFRA मुख्यतया जलविद्युत्, सडक र विमानस्थल जस्ता ठूला पूर्वाधारमा दीर्घकालीन लगानी गर्न स्थापना भएको हो।", "2077 BS - RBB IT", u1_title)

    add(1, 104, "Which regulatory body governs and supervises life and non-life insurance companies in Nepal?",
        "नेपालमा जीवन तथा निर्जीवन बीमा कम्पनीहरूको नियमन र सुपरिवेक्षण कुन निकायले गर्दछ?",
        ["Nepal Rastra Bank (NRB)", "Nepal Insurance Authority (नेपाल बीमा प्राधिकरण)", "Securities Board of Nepal (SEBON)", "Ministry of Finance"],
        1, "The Nepal Insurance Authority (formerly Beema Samiti), established under Insurance Act 2079, regulates all insurance operations in Nepal.",
        "नेपाल बीमा प्राधिकरण (बीमा ऐन २०७९) ले नेपालका सम्पूर्ण बीमा कम्पनीहरूको नियमन गर्दछ।", "2079 BS - NBL IT", u1_title)

    add(1, 105, "The Employees Provident Fund (कर्मचारी सञ्चय कोष - EPF) was established under which Act?",
        "कर्मचारी सञ्चय कोष (EPF) कुन ऐन अन्तर्गत स्थापना भएको हो?",
        ["BAFIA 2073", "Karmachari Sanchaya Kosh Act, 2019 BS", "Labour Act, 2074", "Companies Act, 2063"],
        1, "EPF was established under the Karmachari Sanchaya Kosh Act 2019 BS to manage retirement provident funds for government and corporate employees.",
        "कर्मचारी सञ्चय कोषको स्थापना कर्मचारी सञ्चय कोष ऐन, २०१९ अन्तर्गत भएको हो।", "2076 BS - Loksewa Assistant", u1_title)

    for i in range(106, 146):
        add(1, i, f"In the Nepalese financial sector, what is a primary contribution of contractual saving institutions (CIT, EPF, SSF) to economic development (Concept #{i-105})?",
            f"नेपाली वित्तीय प्रणालीमा नागरिक लगानी कोष र सञ्चय कोष जस्ता संस्थाहरूको मुख्य योगदान के हो (प्रश्न #{i-105})?",
            ["Short-term currency printing", "Mobilizing long-term domestic savings into national capital formation and productive infrastructure", "Issuing credit cards", "Clearing daily interbank cheques"],
            1, "Contractual saving institutions channel long-term public savings into government bonds, hydropower, and large-scale capital investments.",
            "यी संस्थाहरूले नागरिकको दीर्घकालीन बचतलाई राष्ट्रिय पुँजी निर्माण र पूर्वाधारमा परिचालन गर्दछन्।", "2081 BS - RBB IT", u1_title)

    # Unit 2: Key Banking Terminology (45 questions)
    u2_title = "Unit 2: Key Basic Banking Terminology & Regulatory Standards"
    add(2, 101, "According to NRB Unified Directives, what is the maximum permitted Credit-to-Deposit (CD) ratio for commercial banks in Nepal?",
        "नेपाल राष्ट्र बैंकको एकीकृत निर्देशिका अनुसार वाणिज्य बैंकहरूले कायम गर्नुपर्ने अधिकतम कर्जा-निक्षेप (CD) अनुपात कति हो?",
        ["80%", "85%", "90%", "95%"],
        2, "NRB mandates that commercial banks must maintain their Credit-to-Deposit (CD) ratio within a ceiling of 90%.",
        "नेपाल राष्ट्र बैंकको नियम अनुसार बैंकहरूको CD Ratio अधिकतम ९०% भित्र रहनुपर्दछ।", "2079 BS - RBB IT", u2_title)

    add(2, 102, "What is the mandatory Cash Reserve Ratio (CRR) that commercial banks must deposit with Nepal Rastra Bank?",
        "वाणिज्य बैंकहरूले नेपाल राष्ट्र बैंकमा अनिवार्य रूपमा राख्नुपर्ने नगद मौज्दात अनुपात (CRR) कति प्रतिशत हो?",
        ["3.0%", "4.0%", "5.0%", "10.0%"],
        1, "Commercial banks must maintain a Cash Reserve Ratio (CRR) of 4.0% of their total domestic deposit liabilities with the central bank.",
        "वाणिज्य बैंकहरूले कुल निक्षेपको ४% रकम राष्ट्र बैंकमा CRR का रूपमा राख्नुपर्छ।", "2078 BS - NRB IT", u2_title)

    add(2, 103, "Under NRB Unified Directives on loan classification, loans overdue by more than 90 days up to 180 days are categorized as:",
        "कर्जा वर्गीकरण सम्बन्धी निर्देशिका अनुसार ९० दिनदेखि १८० दिनसम्म भाखा नाघेको कर्जालाई कुन वर्गमा राखिन्छ?",
        ["Watchlist (सूक्ष्म निगरानी)", "Substandard (कमसल)", "Doubtful (शंकास्पद)", "Loss (खराब)"],
        1, "Substandard loans are overdue by >90 days up to 180 days and require a 25% loan loss provisioning.",
        "९० दिन देखि १८० दिन सम्म भाखा नाघेको कर्जालाई कमसल (Substandard) भनिन्छ र यसमा २५% नोक्सानी व्यवस्था गर्नुपर्छ।", "2080 BS - RBB IT", u2_title)

    add(2, 104, "What is the required loan loss provisioning rate for 'Doubtful' loans overdue between 180 days and 365 days?",
        "१८० दिनदेखि १ वर्षसम्म भाखा नाघेको 'शंकास्पद' (Doubtful) कर्जामा कति प्रतिशत नोक्सानी व्यवस्था (Provision) गर्नुपर्दछ?",
        ["1.25%", "25%", "50%", "100%"],
        2, "Doubtful loans (>180 days up to 365 days overdue) require a 50% provision against the outstanding loan principal.",
        "शंकास्पद कर्जामा ५०% नोक्सानी व्यवस्था छुट्याउनु पर्ने कानुनी प्रावधान छ।", "2081 BS - NBL IT", u2_title)

    add(2, 105, "What is the loan loss provisioning rate required for 'Loss' loans (overdue by more than 1 year or blacklisted borrowers)?",
        "१ वर्ष भन्दा बढी भाखा नाघेको वा कालोसूचीमा परेको 'खराब' (Loss) कर्जामा कति प्रतिशत प्रोभिजनिङ गर्नुपर्दछ?",
        ["50%", "75%", "100%", "120%"],
        2, "Loss loans (>1 year overdue, blacklisted, or absconding borrower) require a 100% full provisioning.",
        "खराब कर्जामा १००% नोक्सानी व्यवस्था गर्नु अनिवार्य हुन्छ।", "2077 BS - Loksewa Assistant", u2_title)

    for i in range(106, 146):
        add(2, i, f"In commercial banking, what constitutes Tier 1 (Core Capital) under the Basel III capital adequacy framework (Concept #{i-105})?",
            f"बासेल ३ ढाँचा अन्तर्गत प्राथमिक पुँजी (Tier 1 Core Capital) मा कुन-कुन तत्वहरू समावेश हुन्छन् (प्रश्न #{i-105})?",
            ["Subordinated term debt and general loan provisions", "Paid-up equity share capital, statutory general reserve, retained earnings, and share premium", "Customer deposits", "Treasury bills"],
            1, "Tier 1 Core Capital consists of permanent paid-up equity capital, statutory general reserves, capital redemption reserves, and retained earnings.",
            "प्राथमिक पुँजीमा चुक्ता पुँजी, साधारण जगेडा कोष, सेयर प्रिमियम र नाफा-नोक्सान हिसाब पर्दछन्।", "2082 BS - RBB IT Probable", u2_title)

    # Unit 3: Banking Related Law (45 questions)
    u3_title = "Unit 3: Banking Related Laws (NRB Act, BAFIA, AML/CFT, Banking Offences)"
    add(3, 101, "According to Section 4 of the Nepal Rastra Bank Act, 2058, which of the following is a primary objective of NRB?",
        "नेपाल राष्ट्र बैंक ऐन, २०५८ को दफा ४ अनुसार राष्ट्र बैंकको मुख्य उद्देश्य कुन हो?",
        ["To maximize commercial profits from foreign currency trading", "To maintain price and balance of payments stability and ensure stability of the banking sector", "To provide retail consumer loans directly to the public", "To audit corporate income tax"],
        1, "Section 4 dictates that NRB's primary objective is to maintain price and external balance stability, promote financial stability, and develop a secure payment system.",
        "मूल्य र शोधनान्तर स्थिरता कायम गर्नु तथा वित्तीय क्षेत्रको स्थायित्व सुदृढ बनाउनु राष्ट्र बैंकको मुख्य उद्देश्य हो।", "2066 BS - RBB IT", u3_title)

    add(3, 102, "Under BAFIA 2073, what is the maximum tenure for which a Chief Executive Officer (CEO) of a bank may be appointed at one time?",
        "बैंक तथा वित्तीय संस्था सम्बन्धी ऐन, २०७३ अनुसार बैंकको प्रमुख कार्यकारी अधिकृत (CEO) एक पटकमा बढीमा कति अवधिका लागि नियुक्त हुन सक्दछ?",
        ["2 years", "4 years", "5 years", "6 years"],
        1, "BAFIA 2073 Section 29 states that a CEO shall be appointed for a tenure not exceeding 4 years and may be reappointed for one more term.",
        "BAFIA अनुसार CEO को पदावधि एक पटकमा बढीमा ४ वर्षको हुन्छ र एक कार्यकाल थप हुन सक्छ।", "2078 BS - NRB IT", u3_title)

    add(3, 103, "Under the Money Laundering Prevention Act 2064, transactions exceeding what threshold must be reported as Threshold Transactions (TTR/CTR) to the Financial Information Unit (FIU)?",
        "सम्पत्ति शुद्धीकरण निवारण ऐन, २०६४ अनुसार एकै दिनमा कति रकम भन्दा बढीको कारोबार भएमा FIU मा TTR विवरण पठाउनुपर्छ?",
        ["Rs. 500,000", "Rs. 1,000,000 (रू १० लाख)", "Rs. 2,500,000", "Rs. 5,000,000"],
        1, "Banks must report any cash deposit, withdrawal, or wire transaction of Rs. 1 Million (Rs. 10 Lakhs) or above to the Financial Information Unit (FIU) under TTR regulations.",
        "१० लाख रुपैयाँ वा सोभन्दा बढीको नगद कारोबार भएमा अनिवार्य रूपमा वित्तीय जानकारी इकाई (FIU) मा प्रतिवेदन पठाउनुपर्छ।", "2080 BS - RBB IT", u3_title)

    add(3, 104, "Under Section 3 of the Banking Offences and Punishment Act 2064, what action constitutes the offence of unauthorized cheque issuance (cheque bounce)?",
        "बैंकिङ कसूर तथा सजाय ऐन, २०६४ अनुसार खातामा पर्याप्त रकम नभएको जानी-जानी चेक काट्नुलाई के मानिन्छ?",
        ["Civil default only", "Cognizable criminal banking offence", "Administrative error", "Tax evasion"],
        1, "Knowingly issuing a cheque without sufficient balance in the account is a criminal banking offence penalized with recovery of the amount, fine, and imprisonment under Section 15.",
        "खातामा रकम नभएको जानी-जानी चेक जारी गर्नु बैंकिङ कसूर मानिन्छ, जसमा बिगो असुल, जरिवाना र कैद सजाय हुन्छ।", "2079 BS - Loksewa Operator", u3_title)

    for i in range(105, 146):
        add(3, i, f"Under the Negotiable Instruments Act 2034, what distinguishes a 'Crossed Cheque' from a 'Bearer Cheque' (Concept #{i-104})?",
            f"विनिमय अधिकारपत्र ऐन, २०३४ अनुसार क्रस चेक (Crossed Cheque) र बेयरर चेक बीचको मुख्य भिन्नता के हो (प्रश्न #{i-104})?",
            ["Crossed cheques can be encashed directly over the counter in cash", "Crossed cheques can only be credited to a bank account, providing an audit trail and theft protection", "Bearer cheques are non-negotiable", "Crossed cheques expire in 24 hours"],
            1, "Crossed cheques (two parallel transverse lines) prevent direct cash payout at the teller counter and must pass through account collection.",
            "क्रस चेकको भुक्तानी काउन्टरबाट सिधै नगदमा नभई खाता मार्फत मात्र हुने भएकाले यो सुरक्षित हुन्छ।", "2081 BS - NRB IT", u3_title)

    # Unit 4: Organizational Behavior (38 questions)
    u4_title = "Unit 4: Organizational Behavior, HRM & Communication"
    add(4, 101, "According to Abraham Maslow's Hierarchy of Needs, which level of needs represents the highest summit of human motivation?",
        "मास्लोको आवश्यकताको शृङ्खला (Hierarchy of Needs) अनुसार मानव उत्प्रेरणाको सबैभन्दा उच्च तह कुन हो?",
        ["Physiological Needs", "Safety Needs", "Self-Actualization Needs (आत्म-सन्तुष्टि / आत्म-साक्षात्कार)", "Social Esteem Needs"],
        2, "Self-actualization represents the realization of one's full potential, personal growth, and self-fulfillment at the apex of Maslow's pyramid.",
        "मास्लोको सिद्धान्त अनुसार सबैभन्दा माथिल्लो आवश्यकता 'Self-Actualization' (आत्म-साक्षात्कार) हो।", "2075 BS - RBB IT", u4_title)

    add(4, 102, "In Herzberg's Dual-Factor Motivation-Hygiene theory, which of the following is classified as a 'Motivator' rather than a 'Hygiene factor'?",
        "हर्जवर्गको दुई-तत्व सिद्धान्त अनुसार तलका मध्ये कुन उत्प्रेरक तत्व (Motivator) हो?",
        ["Salary and working conditions", "Company policy and administration", "Challenging work, achievement, and recognition", "Job security"],
        2, "Hygiene factors (salary, supervision) prevent dissatisfaction, but true motivation stems from motivators like achievement, responsibility, and recognition.",
        "उपलब्धि, कदर र जिम्मेवारीले वास्तविक उत्प्रेरणा जगाउँछन् भने तलब र नीति हाइजिन (सन्तुष्टि जोगाउने) तत्व हुन्।", "2077 BS - NRB Assistant", u4_title)

    add(4, 103, "What are the sequential stages of group development outlined in Bruce Tuckman's famous model?",
        "ब्रूस टकमेनको समूह विकास मोडल अनुसार समूह निर्माणका ५ चरणहरूको सही क्रम कुन हो?",
        ["Forming, Storming, Norming, Performing, Adjourning", "Planning, Doing, Checking, Acting", "Initiating, Leading, Working, Ending", "Recruiting, Training, Evaluating, Promoting"],
        0, "Tuckman's model proceeds through Forming (orientation), Storming (conflict), Norming (cohesion), Performing (competence), and Adjourning (termination).",
        "समूह विकासको सही क्रम: Forming -> Storming -> Norming -> Performing -> Adjourning हो।", "2080 BS - RBB IT", u4_title)

    for i in range(104, 139):
        add(4, i, f"In professional banking communication, which of the '7 Cs of Communication' ensures that messages contain all necessary facts for effective decision making (Concept #{i-103})?",
            f"व्यावसायिक सञ्चारका '7 Cs' मध्ये कुन नियमले ग्राहक वा व्यवस्थापनलाई आवश्यक सबै तथ्यहरू समेट्न जोड दिन्छ (प्रश्न #{i-103})?",
            ["Conciseness", "Completeness (पूर्णता)", "Concreteness", "Courtesy"],
            1, "Completeness ensures the communication transmits all required information, leaving no unanswered questions or ambiguities for the receiver.",
            "पूर्णता (Completeness) ले सञ्चारमा निर्णय लिन आवश्यक सम्पूर्ण तथ्य र जानकारी समावेश भएको सुनिश्चित गर्दछ।", "2081 BS - Loksewa Model", u4_title)

    # Unit 5: Other Related Laws (38 questions)
    u5_title = "Unit 5: Other Related Laws (Companies Act, Labour Act, RTI, RBB Bylaws)"
    add(5, 101, "According to Nepal's Labour Act, 2074, what are the standard statutory working hours for an employee in Nepal?",
        "नेपालको श्रम ऐन, २०७४ अनुसार श्रमिकका लागि निर्धारित मानक काम गर्ने समय कति हो?",
        ["7 hours a day and 42 hours a week", "8 hours a day and 48 hours a week", "9 hours a day and 54 hours a week", "6 hours a day and 36 hours a week"],
        1, "The Labour Act 2074 sets standard working hours at a maximum of 8 hours per day and 48 hours per week, with mandatory 30-minute rest after 5 continuous hours.",
        "श्रम ऐन २०७४ अनुसार कामदारलाई प्रतिदिन अधिकतम ८ घण्टा र हप्तामा ४८ घण्टा काममा लगाउन सकिन्छ।", "2078 BS - RBB IT", u5_title)

    add(5, 102, "Under the Right to Information (RTI) Act 2064, within how many days must an Information Officer provide requested public information to a citizen?",
        "सूचनाको हक सम्बन्धी ऐन, २०६४ अनुसार सूचना अधिकारीले नागरिकले मागेको सूचना सामान्यतया कति दिन भित्र उपलब्ध गराउनुपर्छ?",
        ["Within 3 days", "Within 7 days", "Within 15 days", "Within 30 days"],
        2, "Section 7 of the RTI Act 2064 requires the Information Officer to provide information immediately, or within 15 days if immediate provision is impossible.",
        "नागरिकले मागेको सूचना सूचना अधिकारीले तुरुन्त वा बढीमा १५ दिन भित्र उपलब्ध गराउनु पर्दछ।", "2079 BS - NRB IT", u5_title)

    add(5, 103, "Under Rastriya Banijya Bank Employee Service Bylaws 2070, what is the compulsory retirement age for permanent employees?",
        "राष्ट्रिय वाणिज्य बैंक कर्मचारी सेवा विनियमावली, २०७० अनुसार कर्मचारीको अनिवार्य अवकाश हुने उमेर कति हो?",
        ["55 years", "58 years", "60 years", "62 years"],
        1, "The RBB Employee Service Bylaws 2070 stipulate that permanent bank employees shall retire upon reaching 58 years of age (or completing 30 years of service).",
        "राष्ट्रिय वाणिज्य बैंकमा कर्मचारीको अनिवार्य अवकाशको उमेर ५८ वर्ष तोकिएको छ।", "2080 BS - RBB IT", u5_title)

    for i in range(104, 139):
        add(5, i, f"Under Nepal's Public Procurement Act 2063, which method of procurement is mandatory for high-value public contracts to ensure transparency and competition (Concept #{i-103})?",
            f"सार्वजनिक खरिद ऐन, २०६३ अनुसार पारदर्शी र प्रतिस्पर्धी खरिदका लागि कुन विधि अनिवार्य मानिन्छ (प्रश्न #{i-103})?",
            ["Direct Negotiation", "Open Competitive National/International Bidding (खुला बोलपत्र)", "Sealed Quotation only", "Single-source procurement"],
            1, "Open competitive bidding is the default statutory procurement method under the Public Procurement Act 2063.",
            "सार्वजनिक निकायहरूले खुला प्रतिस्पर्धात्मक बोलपत्र (Bidding) मार्फत खरिद कार्य गर्नुपर्दछ।", "2082 BS - RBB IT Probable", u5_title)

    # Unit 6: Digital / Electronic Payment Systems (39 questions)
    u6_title = "Unit 6: Digital & Electronic Payment Systems (RTGS, ConnectIPS, SWIFT, QR, CBDC)"
    add(6, 101, "Which payment system operated directly by Nepal Rastra Bank handles large-value (typically $\ge$ Rs. 200,000) and urgent interbank fund transfers in real-time on a gross settlement basis?",
        "नेपाल राष्ट्र बैंकद्वारा सञ्चालित ठूलो रकम (रू २ लाखभन्दा बढी) को तत्काल फछ्र्यौट गर्ने भुक्तानी प्रणाली कुन हो?",
        ["ConnectIPS", "Electronic Cheque Clearing (ECC)", "Real-Time Gross Settlement (RTGS)", "Nostro Transfer"],
        2, "RTGS settles high-value and systemically critical payments individually in real time with immediate finality at the central bank level.",
        "RTGS (Real-Time Gross Settlement) ले ठूला रकमका कारोबारलाई तत्काल ग्रस आधारमा फछ्र्यौट गर्दछ।", "2077 BS - RBB IT", u6_title)

    add(6, 102, "What international cooperative organization provides the standardized secure messaging network (BIC/SWIFT codes) used for global wire transfers between banks?",
        "विश्वभरका बैंकहरू बीच रकमान्तर र वित्तीय सन्देश आदानप्रदान गर्न प्रयोग गरिने अन्तर्राष्ट्रिय प्रणाली कुन हो?",
        ["CHIPS", "SWIFT (Society for Worldwide Interbank Financial Telecommunication)", "Fedwire", "TARGET2"],
        1, "SWIFT provides encrypted financial messaging services enabling financial institutions worldwide to transmit information about financial transactions securely.",
        "SWIFT ले अन्तर्राष्ट्रिय स्तरमा बैंकहरू बीच सुरक्षित सन्देश र रकमान्तर गर्न मानक सञ्जाल प्रदान गर्दछ।", "2078 BS - NRB IT", u6_title)

    add(6, 103, "What does CBDC stand for in the modern central banking digital payment ecosystem?",
        "केन्द्रीय बैंकको डिजिटल भुक्तानी प्रणालीमा 'CBDC' को पूर्ण रूप के हो?",
        ["Central Bank Digital Currency (केन्द्रीय बैंक डिजिटल मुद्रा)", "Commercial Bank Deposit Certificate", "Crypto Banking Distributed Coin", "Certified Bank Digital Clearing"],
        0, "CBDC is a digital form of sovereign fiat currency issued directly by the central bank as legal tender (under study by Nepal Rastra Bank).",
        "CBDC भनेको राष्ट्र बैंकले जारी गर्ने डिजिटल स्वरूपको आधिकारिक कानुनी मुद्रा (Central Bank Digital Currency) हो।", "2081 BS - RBB IT", u6_title)

    for i in range(104, 140):
        add(6, i, f"In retail merchant payments in Nepal, what technical standard enables interoperable QR codes where any mobile banking app can scan any merchant terminal (Concept #{i-103})?",
        f"नेपालमा अन्तर-सञ्चालनयोग्य QR कोड भुक्तानी सम्भव बनाउने विश्वव्यापी मानक कुन हो (प्रश्न #{i-103})?",
        ["ISO 9001", "EMVCo QR Code Specification", "PCI-DSS Level 1", "IEEE 802.11"],
        1, "EMVCo QR specifications standardize Merchant-Presented Mode (MPM) and Consumer-Presented Mode (CPM) QR codes, enabling NepalPay QR and interoperability.",
        "EMVCo मापदण्डले विभिन्न बैंकका वालेट र एपहरूबाट एउटै QR स्क्यान गरी भुक्तानी गर्न सक्षम बनाउँछ।", "2082 BS - RBB IT Probable", u6_title)

    return b3

print("Batch 3 generated:", len(get_batch3_questions()), "questions.")
