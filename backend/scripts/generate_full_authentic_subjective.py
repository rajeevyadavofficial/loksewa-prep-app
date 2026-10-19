# -*- coding: utf-8 -*-
import json
import os

def generate_authentic_subjective_suite():
    qs = []

    def add(q_id, paper, sec, u_num, u_title, marks, yr, q_en, q_np, ans_en, ans_np):
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

    # ==================== PAPER 1 SECTION A: BANKING & MANAGEMENT ====================
    
    # 1. Citizen Investment Trust (CIT)
    add("p1a_u1_sub210", "paper1", "sectionA", 1, "Unit 1: Financial Institutions in Nepal", 5, "2077 BS - RBB IT",
        "Explain the objectives, functions, and economic importance of the Citizen Investment Trust (नागरिक लगानी कोष - CIT) in Nepal.",
        "नेपालमा नागरिक लगानी कोष (Citizen Investment Trust) का उद्देश्य, कार्यहरू र आर्थिक महत्त्व स्पष्ट पार्नुहोस्।",
        """1. Introduction & Statutory Basis:
The **Citizen Investment Trust (नागरिक लगानी कोष - CIT)** was established in 2047 BS under the Citizen Investment Trust Act, 2047 as a specialized contractual saving institution to mobilize domestic savings and encourage citizen investment in national capital markets.

2. Core Objectives & Operational Functions:
* **Voluntary Retirement Schemes:** Manages voluntary pension programs, gratuity funds, and employee investment schemes for civil servants, corporate staff, and self-employed professionals.
* **Capital Market Intermediation:** Operates mutual funds, underwrites public corporate debentures and shares, and acts as a market stabilizer.
* **Bridge Financing:** Provides credit to strategic infrastructure projects (e.g., Nepal Airlines aircraft financing, hydropower development).
* **Investor Accounts:** Operates individual investment accounts with guaranteed minimum returns and tax exemption benefits under the Income Tax Act (up to Rs. 300,000 annually).

3. Economic Significance:
* Channels scattered household micro-savings into institutional capital formation.
* Stabilizes the domestic stock exchange (NEPSE) by serving as a major institutional investor.
* Extends low-cost collateralized loans (housing loans, educational loans) to participating savers.

4. Conclusion:
CIT serves as a vital non-bank financial intermediary bridging household voluntary savings with long-term industrial investment in Nepal.""",
        """१. परिचय तथा कानुनी पृष्ठभूमि:
**नागरिक लगानी कोष (CIT)** नागरिक लगानी कोष ऐन, २०४७ बमोजिम वि.सं. २०४७ मा स्थापित नेपालको एक प्रमुख गैर-बैंकिङ वित्तीय मध्यस्थकर्ता संस्था हो। यसले सर्वसाधारण र कर्मचारीहरूमा बचत गर्ने बानी बसाल्दै राष्ट्रिय पुँजी निर्माणमा टेवा पुर्‍याउँछ।

२. मुख्य उद्देश्य तथा कार्यहरू:
* **बचत परिचालन तथा उपदान योजना:** निजामती, सार्वजनिक संस्था तथा निजी क्षेत्रका कर्मचारीहरूको उपदान, पेन्सन र कर्मचारी बचत कोष सञ्चालन गर्नु।
* **पुँजी बजारको विकास:** सेयर तथा ऋणपत्रको प्रत्याभूति (Underwriting) गर्ने, सामूहिक लगानी कोष (Mutual Fund) सञ्चालन गर्ने र सेयर बजारमा संस्थागत लगानीकर्ताको भूमिका खेल्नु।
* **पूर्वाधारमा लगानी:** ठूला राष्ट्रिय गौरवका आयोजना (जस्तै: नेपाल वायुसेवा निगमको जहाज खरिद, जलविद्युत आयोजना) मा सहवित्तीयकरण मार्फत दीर्घकालीन ऋण लगानी गर्नु।
* **आयकर छुट सुविधा:** आयकर ऐन बमोजिम वार्षिक रू. ३ लाखसम्मको बचतमा कर छुट सुविधा प्रदान गरी नागरिकलाई बचततर्फ आकर्षित गर्नु।

३. अर्थतन्त्रमा यसको महत्त्व:
* छरिएर रहेको स-साना घरायसी बचतलाई संकलन गरी दीर्घकालीन राष्ट्रिय पुँजीमा रूपान्तरण गर्दछ।
* सेयर बजार (NEPSE) मा संस्थागत लगानीकर्ताको रूपमा बजारको अस्थिरता घटाउन मद्दत गर्दछ।
* आफ्ना बचतकर्ताहरूलाई सहुलियत दरमा आवास, शिक्षा र सापटी कर्जा उपलब्ध गराउँछ।

४. निष्कर्ष:
नागरिक लगानी कोषले नागरिकको सामाजिक सुरक्षा सुदृढ बनाउँदै राष्ट्रिय पूर्वाधार र उत्पादनशील क्षेत्रमा पुँजी परिचालन गर्ने बलियो खम्बाको रूपमा कार्य गरिरहेको छ।""")

    # 2. Social Security Fund (SSF)
    add("p1a_u1_sub211", "paper1", "sectionA", 1, "Unit 1: Financial Institutions in Nepal", 5, "2079 BS - NRB Assistant",
        "What is the Social Security Fund (SSF)? Discuss the major benefit schemes operated under the Social Security Act, 2074.",
        "सामाजिक सुरक्षा कोष (SSF) भन्नाले के बुझिन्छ? योगदानमा आधारित सामाजिक सुरक्षा ऐन, २०७४ बमोजिम सञ्चालित प्रमुख सुविधा योजनाहरू उल्लेख गर्नुहोस्।",
        """1. Introduction & Constitutional Mandate:
The **Social Security Fund (सामाजिक सुरक्षा कोष - SSF)** is an autonomous statutory fund established under the Contributory Social Security Act, 2074 to implement the fundamental constitutional right to social security (Article 43 of the Constitution of Nepal) for formal and informal sector workers.

2. Contribution Structure:
A total monthly contribution of **31% of the basic remuneration** is deposited into the fund:
* **11%** deducted from the employee's basic salary.
* **20%** contributed by the employer.

3. Four Core Benefit Schemes:
1. **Medical, Health, and Maternity Protection Scheme:**
   * Reimburses OPD expenses (up to Rs. 25,000/year) and IPD hospitalization expenses (up to Rs. 100,000/year).
   * Provides maternity allowance equal to 1 month's minimum basic remuneration for newborn care.
2. **Accident and Disability Protection Scheme:**
   * 100% treatment expenses for workplace accidents.
   * Monthly lifetime disability pension (up to 60% of basic remuneration) in case of permanent incapacity.
3. **Dependent Family Protection Scheme:**
   * In the event of an employee's demise, the surviving spouse receives a lifetime monthly pension of 60% of basic salary.
   * Educational scholarship for dependent children up to 18 years of age (or 21 years if pursuing continuous study).
4. **Old Age Protection Scheme (Pension Scheme):**
   * Accumulates retirement gratuity and provides a monthly pension following retirement after reaching 60 years of age and minimum 180 months of contributions.

4. Conclusion:
SSF creates a sustainable welfare net that formalizes labor markets, protects workers against destitution, and provides commercial banks with institutional long-term deposits.""",
        """१. परिचय तथा संवैधानिक आधार:
नेपालको संविधानको धारा ४३ ले प्रत्याभूत गरेको सामाजिक सुरक्षाको मौलिक हकलाई कार्यान्वयन गर्न **योगदानमा आधारित सामाजिक सुरक्षा ऐन, २०७४** बमोजिम सामाजिक सुरक्षा कोष (SSF) को स्थापना भएको हो। यसले औपचारिक तथा अनौपचारिक क्षेत्रका श्रमिकहरूको जीवनचक्रका जोखिमहरू व्यवस्थापन गर्दछ।

२. योगदानको ढाँचा:
श्रमिकको आधारभूत पारिश्रमिकको कुल **३१% रकम** कोषमा मासिक रूपमा जम्मा हुन्छ:
* **११%** श्रमिकको पारिश्रमिकबाट कट्टी गरिन्छ।
* **२०%** रोजगारदाताले थप गरिदिन्छ।

३. सञ्चालित चार प्रमुख सामाजिक सुरक्षा योजनाहरू:
१. **औषधोपचार, स्वास्थ्य तथा मातृत्व सुरक्षा योजना:**
   * वार्षिक रू. २५ हजारसम्मको ओपिडी (OPD) र रू. १ लाखसम्मको अस्पताल भर्ना (IPD) खर्च शोधभर्ना।
   * सुत्केरी महिलालाई शिशु स्याहारका लागि १ महिनाको न्यूनतम आधारभूत पारिश्रमिक बराबरको भत्ता।
२. **दुर्घटना तथा अशक्तता सुरक्षा योजना:**
   * कार्यस्थलमा भएको दुर्घटनाको सम्पूर्ण उपचार खर्च कोषले बेहोर्ने।
   * स्थायी रूपमा अशक्त भएमा जीवनभर आधारभूत पारिश्रमिकको ६०% सम्म मासिक अशक्तता पेन्सन।
३. **आश्रित परिवार सुरक्षा योजना:**
   * योगदानकर्ताको मृत्यु भएमा पति/पत्नीलाई जीवनभर आधारभूत तलबको ६०% मासिक पेन्सन।
   * १८ वर्ष मुनिका सन्ततिलाई २१ वर्षसम्म अध्ययनका लागि शैक्षिक वृत्ति (Scholarship)।
४. **वृद्ध अवस्था सुरक्षा योजना (पेन्सन योजना):**
   * ६० वर्ष उमेर पूरा भएपछि कम्तीमा १५ वर्ष (१८० महिना) योगदान गरेका श्रमिकलाई जीवनभर मासिक निवृत्तिभरण (पेन्सन) र उपदान भुक्तानी।

४. निष्कर्ष:
सामाजिक सुरक्षा कोषले श्रमिकहरूको आत्मसम्मान र सामाजिक न्याय सुनिश्चित गर्दै औद्योगिक शान्ति र आर्थिक स्थायित्व कायम गर्न ऐतिहासिक भूमिका निर्वाह गर्दछ।""")

    # 3. Credit Information Bureau (CIB) & Blacklisting
    add("p1a_u2_sub212", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology", 5, "2078 BS - RBB IT",
        "What is the Credit Information Bureau (CIB)? What are the statutory criteria for blacklisting a defaulter borrower under Nepal Rastra Bank Directives?",
        "कर्जा सूचना केन्द्र (CIB) भन्नाले के बुझिन्छ? नेपाल राष्ट्र बैंकको निर्देशिका बमोजिम ऋणीलाई कालोसूचीमा राख्ने प्रमुख कानुनी आधारहरू के-के हुन्?",
        """1. Concept of Credit Information Bureau (CIB):
The **Credit Information Bureau (कर्जा सूचना केन्द्र - Karja Suchana Kendra)** is a specialized institutional credit-reporting agency established under NRB Directives and Section 88 of BAFIA 2073. It collects, compiles, and disseminates credit repayment histories of borrowers to mitigate Non-Performing Loans (NPL) and prevent multiple borrowing.
* Commercial banks must obtain a mandatory CIB Credit Report before sanctioning any loan facility exceeding **Rs. 500,000**.

2. Mandatory Blacklisting Criteria under NRB Directives:
A borrower (individual or corporate) must be reported for blacklisting under any of the following circumstances:
1. **Loan Overdue > 90 Days with Loss of Contact:** When principal or interest remains unpaid for over 90 days and the borrower absconds or refuses contact.
2. **Loan Overdue Exceeding 1 Year (Loss Category):** Failure to settle overdue loans classified under the 'Loss' (खराब) category.
3. **Misappropriation / Fund Diversion:** Diversion of sanctioned loan funds to purposes other than the approved business objective (e.g., using working capital for real estate speculation).
4. **Fraudulent / Fake Collateral:** Pledging forged land ownership titles (लालपुर्जा), duplicate gold, or non-existent assets as security.
5. **Cheque Bounce Offence:** Knowingly issuing a cheque with insufficient funds, where the cheque bounces three consecutive times and remains unsettled after 7 days of written notice.
6. **Bankruptcy / Insolvency Adjudication:** Being declared bankrupt by a competent court.

3. Repercussions of Being Blacklisted:
* Barred from opening new bank accounts (except basic savings), obtaining new loans, or issuing cheques.
* Passport impoundment, suspension of government tenders, and prohibition from holding public office or directorships in any BFI.

4. Conclusion:
The CIB blacklisting mechanism enforces credit discipline, protects banks against willful defaulters, and preserves the sanctity of the financial sector.""",
        """१. कर्जा सूचना केन्द्र (CIB) को अवधारणा:
**कर्जा सूचना केन्द्र (Credit Information Bureau - Karja Suchana Kendra)** नेपाल राष्ट्र बैंकको एकीकृत निर्देशिका र BAFIA २०७३ को दफा ८८ बमोजिम स्थापित बैंक तथा वित्तीय संस्थाहरूको कर्जा सम्बन्धी सूचना संकलन, प्रशोधन र आदानप्रदान गर्ने आधिकारिक निकाय हो।
* बैंकहरूले **रू. ५ लाख वा सोभन्दा बढी** को कर्जा स्वीकृत गर्नु अगावै अनिवार्य रूपमा CIB बाट ऋणीको कर्जा प्रतिवेदन (Credit Report) लिनुपर्दछ।

२. ऋणीलाई कालोसूचीमा राख्ने प्रमुख कानुनी आधारहरू:
नेपाल राष्ट्र बैंकको निर्देशिका अनुसार निम्न अवस्थामा ऋणीलाई कालोसूचीमा समावेश गरिन्छ:
१. **९० दिन भन्दा बढी भाखा नाघी ऋणी सम्पर्कविहीन भएमा:** कर्जाको साँवा-ब्याज नतिरी ऋणी बेपत्ता भएमा वा बैंकको सम्पर्कमा नआएमा।
२. **१ वर्षभन्दा बढी भाखा नाघेको खराब कर्जा भएमा:** कर्जा 'खराब' (Loss) वर्गमा वर्गीकरण भई लामो समयसम्म असुल हुन नसकेमा।
३. **कर्जाको दुरुपयोग (Fund Diversion) गरेमा:** जुन प्रयोजनका लागि कर्जा लिएको हो सो काममा नलगाई अन्यत्र (जस्तै: घरजग्गा सट्टेबाजी वा सेयर) मा लगानी गरेमा।
४. **नक्कली वा जाली धितो राखेमा:** जाली लालपुर्जा, किर्ते कागजात वा कमसल सुन धितो राखी कर्जा लिएको पाइएमा।
५. **चेक अनादर (Cheque Bounce) सम्बन्धी कसूर:** खातामा रकम नभई काटेको चेक लगातार ३ पटकसम्म बाउन्स भएर ७ दिनको म्याद दिँदा पनि भुक्तानी नगरेमा।
६. **अदालतबाट टाट पल्टेको घोषणा भएमा:** कानुन बमोजिम साहुको ऋण तिर्न नसकी दामासाहीमा परेमा।

३. कालोसूचीमा पर्दा हुने कानुनी असरहरू:
* कुनै पनि बैंक तथा वित्तीय संस्थाबाट नयाँ कर्जा, क्रेडिट कार्ड वा ग्यारेन्टी सुविधा नपाउने।
* राहदानी जफत हुन सक्ने, सरकारी ठेक्कापट्टामा भाग लिन नपाउने र बैंकको सञ्चालक बन्न अयोग्य हुने।

४. निष्कर्ष:
कालोसूची सम्बन्धी कडा कानुनी व्यवस्थाले ऋणीहरूमा समयमै कर्जा भुक्तानी गर्ने अनुशासन कायम गर्दै वित्तीय प्रणालीको खराब कर्जा न्यूनीकरण गर्न महत्वपूर्ण भूमिका खेल्दछ।""")

    # 4. Cheque Bounce & Banking Offences Act 2064
    add("p1a_u3_sub213", "paper1", "sectionA", 3, "Unit 3: Banking Related Laws", 5, "2080 BS - Loksewa Operator",
        "Explain the legal provisions regarding the offence of Cheque Dishonor (Cheque Bounce) under the Banking Offences and Punishment Act, 2064. What penalties are imposed on the offender?",
        "बैंकिङ कसूर तथा सजाय ऐन, २०६४ बमोजिम चेक अनादर (Cheque Bounce) सम्बन्धी कानुनी व्यवस्था र यसमा हुने सजायहरू स्पष्ट पार्नुहोस्।",
        """1. Conceptual Background:
Under Section 3(c) of the **Banking Offences and Punishment Act, 2064**, drawing a cheque knowingly on a bank account where there are insufficient funds to honor the payment constitutes a recognized criminal banking offence against the economic integrity of the payment system.

2. Procedural Pre-requisites for Filing a Case:
1. The cheque must be presented to the bank and dishonored (bounced) due to insufficient balance.
2. The bank issues an official **Cheque Dishonor Slip** with reasons stated.
3. The payee issues a written legal notice giving a minimum of **7 days** for the drawer to settle the cash amount.
4. If payment is still unpaid, the payee can file an FIR with the Police under the Banking Offences and Punishment Act 2064 within the statutory limitation period (usually within 1 year).

3. Penalties Prescribed under Section 15 of the Act:
* **Recovery of Amount (बिगो भराउने):** The court orders the full disputed cheque amount to be recovered from the offender and paid to the victim.
* **Fine (जरिवाना):** A statutory fine equal to the cheque amount (up to 100% penalty).
* **Imprisonment (कैद सजाय):** Imprisonment up to **3 months** depending on the severity and fraud intent.
* Furthermore, the offender is recommended for blacklisting at the Credit Information Bureau (CIB), freezing their operational accounts.

4. Distinguishing from Negotiable Instruments Act 2034:
* Under the Negotiable Instruments Act 2034 (Section 107a), cheque bounce can also be treated as a pure civil recovery petition with 10% interest and up to 3 months jail.
* The Banking Offences Act route involves state-prosecuted police investigation and arrests, providing faster recovery pressure.

5. Conclusion:
Criminalizing cheque dishonor protects market liquidity, discourages frivolous fraudulent commitments, and preserves legal trust in commercial paper transactions.""",
        """१. अवधारणा तथा कानुनी पृष्ठभूमि:
आफ्नो बैंक खातामा पर्याप्त रकम छैन भन्ने जानी-जानी कसैलाई चेक काटिदिनु **बैंकिङ कसूर तथा सजाय ऐन, २०६४ को दफा ३(ग)** अनुसार गम्भीर बैंकिङ फौजदारी कसूर हो। यसले वित्तीय बजारको साख र विश्वासनीयतामा आँच पुर्‍याउँछ।

२. चेक अनादर सम्बन्धी मुद्दा प्रक्रियाका चरणहरू:
१. सम्बन्धित बैंकमा चेक भुक्तानीका लागि पेश गर्दा खातामा रकम अभावका कारण चेक फिर्ता (Dishonor) हुनुपर्ने।
२. बैंकले आधिकारिक 'Cheque Dishonor Slip' जारी गरेको हुनुपर्ने।
३. चेक धारकले ऋणीलाई ७ दिनको लिखित सूचना (Notice) दिई रकम भुक्तानी गर्न आग्रह गर्नुपर्ने।
४. सो अवधिमा पनि भुक्तानी नगरेमा चेक धारकले १ वर्ष भित्र नेपाल प्रहरीको केन्द्रीय अनुसन्धान ब्युरो (CIB) वा सम्बन्धित प्रहरी कार्यालयमा जाहेरी दिन सक्ने।

३. ऐनको दफा १५ बमोजिम हुने कानुनी सजायहरू:
* **बिगो भराउने:** चेकमा उल्लेख भएको सम्पूर्ण रकम (बिगो) कसूरदारबाट पीडितलाई फिर्ता भराइन्छ।
* **जरिवाना:** बिगो बराबरको रकम (१००% सम्म) राज्यकोषमा जरिवाना।
* **कैद सजाय:** कसूरको गम्भीरता हेरी बढीमा **३ महिनासम्म कैद** सजाय।
* साथै, कसूरदारलाई कर्जा सूचना केन्द्रको कालोसूचीमा राखी सम्पूर्ण बैंकिङ कारोबार रोक्का गरिन्छ।

४. विनिमय अधिकारपत्र ऐन, २०३४ सँगको भिन्नता:
* विनिमय अधिकारपत्र ऐन २०३४ को दफा १०७(क) अनुसार चेक बाउन्समा ३ महिना कैद र वार्षिक १०% ब्याज सहित बिगो भराउने देवानी प्रकृतिको मुद्दा चल्छ।
* बैंकिङ कसूर ऐन २०६४ अन्तर्गत सरकारवादी फौजदारी मुद्दा चल्ने भएकाले प्रहरीले थुनामा राखी अनुसन्धान गर्ने हुँदा रकम असुली छिटो हुन्छ।

५. निष्कर्ष:
चेक अनादर सम्बन्धी कडा कानुनी प्रावधानले वित्तीय बजारमा चेकलाई नगद सरह स्वीकार्य बनाउन र ठगी नियन्त्रण गर्न महत्त्वपूर्ण योगदान पुर्‍याउँछ।""")

    # 5. Core Banking Architecture: Pipelining Hazards (Paper 2)
    add("p2a_u2_sub214", "paper2", "sectionA", 2, "Unit 2: Computer Architecture", 10, "2080 BS - RBB IT",
        "Explain the concept of Instruction Pipelining in modern CPU architecture. Analyze the three major pipeline hazards (Structural, Data, Control) with clear illustrations and discuss their hardware mitigation techniques.",
        "आधुनिक CPU वास्तुकलामा इन्स्ट्रक्सन पाइपलाइनिङ (Instruction Pipelining) को अवधारणा प्रष्ट पार्नुहोस्। पाइपलाइनमा देखिने तीन प्रमुख समस्याहरू (Structural, Data र Control Hazards) को विश्लेषण गर्दै तिनलाई समाधान गर्ने हार्डवेयर प्रविधिहरू व्याख्या गर्नुहोस्।",
        """1. Concept of Instruction Pipelining:
**Instruction Pipelining** is an advanced computer architectural technique where the execution of consecutive instructions is overlapped in time across dedicated hardware stages (Fetch, Decode, Execute, Memory Access, Write-Back), analogous to an industrial factory assembly line.
* *Ideal Speedup:* For a $k$-stage pipeline executing $n$ instructions, the theoretical speedup approaches $k$ times over non-pipelined execution:
$$\\text{Speedup} = \\frac{n \\times k}{k + n - 1} \\approx k \\quad (\\text{as } n \\to \\infty)$$

2. The Three Pipeline Hazards (Bottlenecks):

A. Structural Hazards (Resource Conflicts):
* *Cause:* Two or more instructions in different stages attempt to access the same physical hardware resource simultaneously.
* *Example:* Instruction 1 is writing data to memory (MEM stage) while Instruction 4 is simultaneously fetching an instruction from the same memory (IF stage) in a unified Von Neumann memory bus.
* *Mitigation:*
  1. **Harvard Architecture:** Physically separate Instruction Cache (I-Cache) and Data Cache (D-Cache).
  2. **Pipeline Bubble / Stall:** Insert hardware NOP (no-operation) stalls delaying the dependent instruction.

B. Data Hazards (Data Dependencies):
* *Cause:* An instruction depends on the result of an earlier instruction that is still in-flight and has not yet written its output back to the register file (Read-After-Write / RAW dependency).
* *Example:*
  `ADD R1, R2, R3` (Result R1 is calculated in ALU stage, written back in WB stage)
  `SUB R5, R1, R4` (Needs R1 during Decode stage before WB completes)
* *Mitigation:*
  1. **Operand Forwarding / Bypassing:** Route the ALU output directly from the EX/MEM pipeline register back to the ALU input for the next cycle without waiting for the register file write-back.
  2. **Compiler Code Reordering:** The compiler inserts independent instructions between the producer and consumer.

C. Control Hazards (Branch / Instruction Flow Penalties):
* *Cause:* The pipeline fetches subsequent sequential instructions before a conditional branch (`JUMP`, `BEQ`) has been evaluated in the Execute/Decode stage. If the branch is taken, all fetched speculative instructions must be flushed (Branch Penalty).
* *Mitigation:*
  1. **Branch Prediction:** Hardware dynamic Branch History Tables (BHT) predict whether branches will be 'Taken' or 'Not Taken' based on past loops.
  2. **Branch Target Buffer (BTB):** Caches target branch addresses to fetch targets with zero latency.
  3. **Delayed Branching:** Always execute the instruction immediately following the branch (branch delay slot).

3. Summary Comparison Table:
| Hazard Type | Root Cause | Primary Hardware Solution |
|---|---|---|
| **Structural** | Hardware resource contention | Dual-ported RAM, Separate I/D Caches |
| **Data (RAW)** | Operands not yet committed | Operand Forwarding / Interlocking |
| **Control** | Conditional jumps alter Program Counter | Dynamic Branch Prediction & BTB |

4. Conclusion:
Through operand forwarding, branch prediction, and superscalar multi-issue execution, modern banking server processors sustain instruction throughput near 1 cycle per instruction (CPI $\\approx 1$).""",
        """१. इन्स्ट्रक्सन पाइपलाइनिङको अवधारणा:
**इन्स्ट्रक्सन पाइपलाइनिङ (Instruction Pipelining)** भनेको आधुनिक प्रोसेसरमा एउटा निर्देशनको काम नसकिँदै अर्को निर्देशनको काम सुरु गरी एकै समयमा धेरै कामहरूलाई खप्ट्याएर (Overlap) गर्ने वास्तुकला हो। यो औद्योगिक कारखानामा सामान बनाउने 'एसेम्बली लाइन' जस्तै हो।
* सामान्यतया पाइपलाइनलाई ५ चरणमा विभाजन गरिन्छ: **Fetch (IF) $\\to$ Decode (ID) $\\to$ Execute (EX) $\\to$ Memory Access (MEM) $\\to$ Write-Back (WB)**।

२. पाइपलाइनमा देखिने तीन प्रमुख समस्याहरू (Hazards):

क. स्ट्रक्चरल हजार्ड (Structural Hazard - स्रोतको द्वन्द्व):
* *कारण:* पाइपलाइनका दुई फरक चरणमा रहेका निर्देशनहरूले एकै समयमा एउटै हार्डवेयर स्रोत (जस्तै मेमोरी) प्रयोग गर्न खोज्दा यो समस्या आउँछ।
* *उदाहरण:* एउटा इन्स्ट्रक्सनले मेमोरीमा डेटा लेखिरहेको बेला अर्को इन्स्ट्रक्सनले त्यही मेमोरीबाट नयाँ कोड तान्न खोज्नु।
* *समाधान:*
  १. **हार्वर्ड आर्किटेक्चरको प्रयोग:** इन्स्ट्रक्सन क्यास (I-Cache) र डेटा क्यास (D-Cache) छुट्टाछुट्टै राख्ने।
  २. **पाइपलाइन स्टल (Stall/Bubble):** आवश्यक परेमा १ साइकल कुराउने।

ख. डेटा हजार्ड (Data Hazard - डेटाको अन्तरनिर्भरता):
* *कारण:* अघिल्लो निर्देशनले गणना गरेर निकालेको नतिजा दर्ता (Register) मा लेखिनु अगावै पछिल्लो निर्देशनले सोही डेटा प्रयोग गर्न खोज्दा यो समस्या आउँछ (Read-After-Write - RAW)।
* *उदाहरण:*
  `ADD R1, R2, R3` (R1 को मान पाँचौं चरणमा मात्र लेखिन्छ)
  `SUB R5, R1, R4` (दोस्रो निर्देशनलाई अहिल्यै R1 को मान चाहिन्छ)
* *समाधान:*
  १. **अपरेन्ड फरवार्डिङ (Operand Forwarding):** नतिजा मेमोरीमा जानु अघि नै ALU को आउटपुटबाट सिधै तार जोडेर अर्को इन्स्ट्रक्सनलाई तत्काल दिने।
  २. **कम्पाइलर रिअर्डरिङ:** कम्पाइलरले सम्बन्ध नभएका अन्य निर्देशनलाई बीचमा घुसाउने।

ग. कन्ट्रोल हजार्ड (Control Hazard - सर्तयुक्त जम्पको समस्या):
* *कारण:* प्रोग्राममा `IF`, `GOTO`, `JUMP` जस्ता सर्त आउँदा कता जाने भन्ने निर्णय तेस्रो चरणमा मात्र थाहा हुन्छ, तर पाइपलाइनले पहिले नै तलका गलत निर्देशनहरू तानिसकेको हुन्छ। निर्णय फरक भएमा ती सबै नष्ट (Flush) गर्नुपर्छ।
* *समाधान:*
  १. **शाखा पूर्वानुमान (Branch Prediction):** पहिलेको इतिहास हेरेर सर्त 'सत्य' हुन्छ कि 'असत्य' भनी हार्डवेयरले अनुमान गर्ने।
  २. **Branch Target Buffer (BTB):** जम्प हुने ठेगाना पहिले नै क्यासमा राख्ने।

३. तुलनात्मक सारांश तालिका:
| समस्याको प्रकार | मुख्य कारण | प्रमुख प्राविधिक समाधान |
|---|---|---|
| **Structural** | एउटै हार्डवेयर स्रोतमा एकैपटक तानातान | छुट्टाछुट्टै डेटा र कोड क्यास (Harvard) |
| **Data (RAW)** | अघिल्लो नतिजा आउन ढिला हुनु | अपरेन्ड फरवार्डिङ (Bypassing) |
| **Control** | सर्तयुक्त जम्पले बाटो बदल्नु | ब्रान्च प्रिडिक्सन र BTB क्यास |

४. निष्कर्ष:
पाइपलाइनिङ र यसका हजार्डहरूको कुशल समाधानले आधुनिक कम्प्युटर प्रोसेसरको गतिलाई कैयौं गुणा तीव्र बनाएर कोर बैंकिङको जटिल कारोबार सहज बनाउँछ।""")

    return qs

if __name__ == "__main__":
    suite = generate_authentic_subjective_suite()
    print(f"Generated {len(suite)} questions in suite.")
