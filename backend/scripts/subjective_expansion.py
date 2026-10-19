# -*- coding: utf-8 -*-
"""
75 In-Depth Lok Sewa Subjective Questions and Model Answers
Covers all remaining syllabus chapters across Paper I Section A and Paper II Technical IT.
"""

def get_expansion_subjective_questions():
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

    # 1. KYC / CDD / EDD (5 Marks)
    add("p1a_u2_sub220", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology", 5, "2080 BS - RBB IT",
        "What is Know Your Customer (KYC)? Differentiate between Simplified Customer Due Diligence (CDD) and Enhanced Due Diligence (EDD) under Nepal Rastra Bank AML/CFT Directives.",
        "ग्राहक पहिचान (KYC) भन्नाले के बुझिन्छ? नेपाल राष्ट्र बैंकको सम्पत्ति शुद्धीकरण सम्बन्धी निर्देशिका अनुसार सामान्य ग्राहक पहिचान (CDD) र विस्तृत ग्राहक पहिचान (EDD) बीचको भिन्नता प्रष्ट पार्नुहोस्।",
        """1. Concept of KYC & CDD:
**Know Your Customer (KYC)** is a mandatory regulatory due diligence framework mandated by Nepal Rastra Bank and Section 7 of the Money Laundering Prevention Act, 2064. It requires financial institutions to verify the identity, legal status, beneficial ownership, and source of funds of their customers to prevent illicit funds from entering the banking system.

2. Simplified Customer Due Diligence (CDD) vs Enhanced Due Diligence (EDD):
| Parameter | Standard / Simplified CDD | Enhanced Due Diligence (EDD) |
|---|---|---|
| **Applicability** | Low to medium-risk retail domestic customers (salaried staff, students, small farmers) | High-risk customers, Politically Exposed Persons (PEPs), high-net-worth non-residents, trusts |
| **Verification Level** | Basic government ID (Citizenship/NID), passport-size photo, standard utility bill address proof | In-depth independent verification of wealth origin, audited financial statements, tax clearance certificates |
| **Approval Hierarchy** | Branch customer service representative / Branch Operation In-charge | Mandatory formal approval from Senior Management / Compliance Officer |
| **Ongoing Monitoring** | Periodic review every 2 to 3 years or upon profile change | Continuous real-time transaction screening and annual compulsory KYC re-verification |
| **Geographic Scrutiny** | Domestic residents operating within standard local economic thresholds | Entities dealing with FATF high-risk jurisdictions or cross-border correspondent banking |

3. Significance in Commercial Banking:
* Shields the bank against regulatory penalties, frozen correspondent banking lines, and reputational risk.
* Assists state investigative agencies (FIU, Department of Money Laundering Investigation - DMLI) in detecting tax evasion and illicit enrichment.

4. Conclusion:
Implementing risk-based CDD and EDD balances customer convenience with national financial security, serving as the first line of defense against financial crime.""",
        """१. KYC तथा ग्राहक पहिचानको अवधारणा:
**ग्राहक पहिचान (KYC - Know Your Customer)** सम्पत्ति शुद्धीकरण निवारण ऐन, २०६४ र नेपाल राष्ट्र बैंकको निर्देशिका बमोजिम बैंक तथा वित्तीय संस्थाहरूले खाता खोल्नु अघि ग्राहकको वास्तविक परिचय, ठेगाना, पेशा, आयस्रोत र वास्तविक हितग्राही (Beneficial Owner) यकिन गर्ने अनिवार्य विधि हो।

२. सामान्य ग्राहक पहिचान (CDD) र विस्तृत ग्राहक पहिचान (EDD) बीचको भिन्नता:
| आधार | सामान्य ग्राहक पहिचान (CDD) | विस्तृत ग्राहक पहिचान (EDD) |
|---|---|---|
| **लागू हुने वर्ग** | न्यून तथा मध्यम जोखिम भएका सर्वसाधारण नागरिक, तलबजीवी र साना किसान | उच्च जोखिम भएका व्यक्ति, उच्च ओहोदाका राजनीतिज्ञ (PEPs), विदेशी नागरिक तथा ठूला व्यवसायी |
| **कागजात प्रमाणीकरण** | नेपाली नागरिकताको प्रमाणपत्र, राष्ट्रिय परिचयपत्र, फोटो र सामान्य ठेगाना प्रमाण | आयस्रोतको आधिकारिक पुष्ट्याइँ, कर चुक्ता प्रमाणपत्र, अडिट प्रतिवेदन र सम्पत्तिको स्रोत |
| **स्वीकृति तह** | शाखाका सम्बन्धित कर्मचारी वा शाखा प्रबन्धक तहबाटै स्वीकृत | बैंकको उच्च व्यवस्थापन तह (Senior Management / Compliance Officer) बाट अनिवार्य स्वीकृति |
| **अनुगमनको तीव्रता** | २ देखि ३ वर्षको अन्तरालमा नियमित अद्यावधिक | वास्तविक समयमा निरन्तर कारोबार निगरानी र वार्षिक अनिवार्य पुनः प्रमाणीकरण |
| **क्षेत्रीय दायरा** | स्वदेशी सामान्य कारोबार | अन्तर्राष्ट्रिय रकमान्तर, अपतटीय (Offshore) कारोबार र शंकास्पद विदेशी संस्था |

३. वाणिज्य बैंकमा यसको महत्त्व:
* बैंकलाई सम्पत्ति शुद्धीकरण सम्बन्धी अन्तर्राष्ट्रिय कारबाही, जरिवाना र कालोसूचीबाट जोगाउँछ।
* वित्तीय जानकारी इकाई (FIU) र सम्पत्ति शुद्धीकरण अनुसन्धान विभागलाई अनुसन्धानमा सहयोग पुर्‍याउँछ।

४. निष्कर्ष:
जोखिममा आधारित KYC र EDD को प्रभावकारी कार्यान्वयनले बैंकलाई आपराधिक धनको ओसारपसारबाट सुरक्षित राख्दै स्वच्छ बैंकिङ प्रणालीको विकास गर्दछ।""")

    # 2. Tuckman's Model in Banking Team Building (5 Marks)
    add("p1a_u4_sub221", "paper1", "sectionA", 4, "Unit 4: Organizational Behavior", 5, "2079 BS - RBB IT",
        "Explain Bruce Tuckman's Model of Group Development (Forming, Storming, Norming, Performing, Adjourning). How can a bank manager apply it to lead a newly formed branch team?",
        "ब्रूस टकमेनको समूह विकास मोडल (Forming, Storming, Norming, Performing, Adjourning) व्याख्या गर्दै नयाँ खुलेको बैंक शाखाको टोलीलाई प्रभावकारी रूपमा नेतृत्व गर्न शाखा प्रबन्धकले यसलाई कसरी प्रयोग गर्न सक्छन्?",
        """1. Introduction:
Bruce Tuckman's (1965) **Stages of Group Development** is a foundational psychological and organizational framework outlining how newly assembled teams evolve through predictable phases from mutual unfamiliarity to high-performing synergy.

2. Five Sequential Stages of Tuckman's Model:
1. **Forming (सुरुवाती चरण - Orientation):**
   * *Team State:* High uncertainty, polite interactions, dependency on leader for guidance. Members focus on understanding their roles.
   * *Managerial Role:* Directive leadership; clearly articulate the branch mission, bank policies, and individual job descriptions (JD).
2. **Storming (द्वन्द्व चरण - Conflict):**
   * *Team State:* Disagreements over task allocation, work styles, informal pecking order, and resistance to supervisory control.
   * *Managerial Role:* Coaching & conflict resolution; facilitate open communication, de-escalate interpersonal rivalries, and clarify performance expectations.
3. **Norming (सामञ्जस्यता चरण - Cohesion):**
   * *Team State:* Shared norms, mutual trust, team spirit, and constructive operational procedures emerge. Consensus on customer service standards.
   * *Managerial Role:* Participative leadership; encourage peer collaboration, delegate authority, and institutionalize branch operating rituals.
4. **Performing (उच्च कार्यसम्पादन चरण - Synergy):**
   * *Team State:* Autonomous, highly competent, goal-oriented unit operating with minimal supervision. Exceeds deposit mobilization and service targets.
   * *Managerial Role:* Delegative leadership; empower staff, recognize excellence, and provide developmental career growth opportunities.
5. **Adjourning (समापन चरण - Termination):**
   * *Team State:* Dissolution of temporary task forces or transition upon staff transfers. Evaluation of outcomes.
   * *Managerial Role:* Celebrate achievements, conduct exit reviews, and facilitate smooth knowledge handovers.

3. Conclusion:
By proactively diagnosing team developmental stages, a branch manager accelerates the progression from initial friction to synchronized customer-centric performance.""",
        """१. परिचय तथा अवधारणा:
ब्रूस टकमेनद्वारा सन् १९६५ मा प्रतिपादित **समूह विकासको मोडल (Tuckman's Model)** ले कुनै पनि संस्थामा नयाँ बनेको समूह कसरी क्रमिक रूपमा परिपक्व हुँदै उच्च कार्यसम्पादनको तहसम्म पुग्छ भन्ने मनोवैज्ञानिक र व्यवस्थापकीय मार्गचित्र प्रस्तुत गर्दछ।

२. टकमेन मोडलका पाँच क्रमिक चरणहरू:
१. **Forming (सुरुवाती चरण - परिचय र दिशाबोध):**
   * *टोलीको अवस्था:* कर्मचारीहरू बीच अनभिज्ञता, औपचारिकता र उच्च अन्योल हुन्छ। सबैले नेताको मुख ताक्दछन्।
   * *प्रबन्धकको भूमिका:* स्पष्ट निर्देशन दिने (Directive); शाखाको लक्ष्य, निक्षेप संकलन योजना र प्रत्येकको कार्य विवरण (JD) स्पष्ट सम्झाउने।
२. **Storming (द्वन्द्व चरण - मतभेद र संघर्ष):**
   * *टोलीको अवस्था:* जिम्मेवारी बाँडफाँड, कामको शैली र अधिकार क्षेत्रलाई लिएर कर्मचारीहरू बीच मनमुटाव, असहमति र प्रतिस्पर्धा सुरु हुन्छ।
   * *प्रबन्धकको भूमिका:* मध्यस्थता र सहजीकरण (Coaching); कर्मचारीका असन्तुष्टि सुन्ने, विवाद समाधान गर्ने र कामको उचित समन्वय गर्ने।
३. **Norming (सामञ्जस्यता चरण - नियम र सहकार्य):**
   * *टोलीको अवस्था:* कर्मचारीहरूले एकअर्काको शक्ति बुझ्छन्, आन्तरिक नियम र सहकार्यको विकास हुन्छ, टोली भावना (Team Spirit) जाग्छ।
   * *प्रबन्धकको भूमिका:* सहभागितामूलक नेतृत्व (Participative); टोलीको निर्णयलाई प्रोत्साहन दिने र कामको मानक (SOP) निर्धारण गर्ने।
४. **Performing (उच्च कार्यसम्पादन चरण - लक्ष्य प्राप्ति):**
   * *टोलीको अवस्था:* टोली पूर्ण रूपमा परिपक्व, स्वायत्त र नतिजामुखी हुन्छ। न्यूनतम सुपरिवेक्षणमै शाखाको निक्षेप, कर्जा र ग्राहक सेवाको लक्ष्य हासिल गर्दछ।
   * *प्रबन्धकको भूमिका:* अधिकार प्रत्यायोजन (Delegating); उत्कृष्ट काम गर्नेलाई पुरस्कृत गर्ने र नयाँ रणनीतिक चुनौतीहरू सुम्पने।
५. **Adjourning (समापन चरण - बिदाइ र पुनरावलोकन):**
   * *टोलीको अवस्था:* कुनै निश्चित परियोजना सकिएपछि वा कर्मचारीको सरुवा हुँदा समूह विघटन हुने चरण।
   * *प्रबन्धकको भूमिका:* उपलब्धिको समीक्षा गर्ने, कर्मचारीलाई धन्यवाद दिने र ज्ञानको अभिलेखीकरण (Handover) गर्ने।

३. निष्कर्ष:
टकमेन मोडलको सफल प्रयोगले शाखा प्रबन्धकलाई कर्मचारीहरू बीचको द्वन्द्वलाई उत्पादक ऊर्जामा बदल्दै नयाँ शाखालाई छोटो समयमै नाफामूलक बनाउन दिशानिर्देश गर्दछ।""")

    # 3. Public Procurement Act (5 Marks)
    add("p1a_u5_sub222", "paper1", "sectionA", 5, "Unit 5: Other Related Laws", 5, "2081 BS - RBB IT",
        "What are the major methods of public procurement prescribed under Nepal's Public Procurement Act, 2063? Explain the purpose of Bid Security and Performance Security in banking hardware/software procurement.",
        "सार्वजनिक खरिद ऐन, २०६३ बमोजिम सार्वजनिक निकायले मालसामान खरिद गर्दा अपनाउनुपर्ने प्रमुख विधिहरू उल्लेख गर्दै बैंकिङ हार्डवेयर र सफ्टवेयर खरिदमा जमानत (Bid Security) र कार्यसम्पादन जमानत (Performance Security) को भूमिका प्रष्ट पार्नुहोस्।",
        """1. Introduction:
The **Public Procurement Act (PPA), 2063** governs the procurement of goods, works, and consulting services by public commercial banks (like Rastriya Banijya Bank) to guarantee maximum transparency, open competition, equal opportunity, and value for public expenditure.

2. Statutory Procurement Methods (PPA 2063 Section 8):
1. **Open Competitive Bidding (खुला बोलपत्र):** Default national/international competitive bidding (NCB/ICB) published in national dailies with minimum 30 days (national) or 45 days (international) submission notice.
2. **Sealed Quotation (शिलबन्दी दरभाउपत्र):** For procurement of goods up to prescribed financial thresholds (up to Rs. 2 Million) with 15 days notice.
3. **Direct Procurement (सोझै खरिद):** Permitted only in exceptional statutory situations (proprietary upgrades, sole manufacturer, emergency disaster repairs up to statutory ceilings).
4. **Request for Proposals (RFP):** Used for intellectual and consulting services (e.g., core banking software audit).
5. **Users' Committee & Force Account:** Specialized community works.

3. Role of Bid Security and Performance Security in IT Procurement:
* **Bid Security (बोलपत्र जमानत - Typically 2% to 3% of estimated cost):**
  * Submitted as an unconditional Bank Guarantee along with the technical bid.
  * *Purpose:* Prevents frivolous, irresponsible bidders from withdrawing bids before tender award or refusing to sign the contract after winning. If the winning bidder backs out, the Bid Security is forfeited.
* **Performance Security (कार्यसम्पादन जमानत - Typically 5% of contract value):**
  * Submitted by the successful bidder before formal contract signing, valid throughout the implementation warranty period.
  * *Purpose:* Protects the bank against defective IT systems, server delivery abandonment, or non-compliance with technical specifications. Forfeited if the vendor fails to deploy or support the core banking software.

4. Conclusion:
The rigorous application of PPA 2063 and financial securities shields public banking institutions against fiscal leakage, vendor lock-in, and operational failure.""",
        """१. परिचय तथा कानुनी आधार:
सार्वजनिक स्वामित्व भएको राष्ट्रिय वाणिज्य बैंक जस्ता संस्थाहरूले वस्तु, निर्माण तथा परामर्श सेवा खरिद गर्दा अधिकतम पारदर्शिता, मितव्ययिता, निष्पक्षता र खुला प्रतिस्पर्धा सुनिश्चित गर्न **सार्वजनिक खरिद ऐन, २०६३** को पूर्ण पालना गर्नुपर्दछ।

२. सार्वजनिक खरिदका प्रमुख विधिहरू (ऐनको दफा ८):
१. **खुला प्रतिस्पर्धात्मक बोलपत्र (Open Competitive Bidding):** राष्ट्रिय स्तरमा कम्तीमा ३० दिन र अन्तर्राष्ट्रिय स्तरमा ४५ दिनको सूचना दिई राष्ट्रिय दैनिक पत्रिकामा प्रकाशित गरिने मुख्य विधि।
२. **शिलबन्दी दरभाउपत्र (Sealed Quotation):** तोकिएको सीमा (रू. २० लाखसम्मको मालसामान) का लागि १५ दिनको सूचना दिई गरिने खरिद।
३. **सोझै खरिद (Direct Procurement):** एकल उत्पादक भएको विशेष अवस्था, आकस्मिक मर्मत वा तोकिएको सानो सीमा भित्र गरिने खरिद।
४. **परामर्श सेवा खरिद (RFP):** बौद्धिक सेवा (जस्तै: बैंकिङ सफ्टवेयर सुरक्षा परीक्षण, लेखापरीक्षण) का लागि प्राविधिक र वित्तीय प्रस्ताव माग गरी गरिने खरिद।

३. IT खरिदमा बिड सेक्युरिटी र पर्फमेन्स सेक्युरिटीको भूमिका:
* **बोलपत्र जमानत (Bid Security - अनुमानित लागतको २% देखि ३%):**
  * बोलपत्र दर्ता गर्दा बैंक ग्यारेन्टी मार्फत पेश गर्नुपर्ने धरौटी रकम।
  * *उद्देश्य:* गैर-जिम्मेवार कम्पनीहरूले बोलपत्र हालेर पछि सम्झौता गर्न नआउने वा बीचमै फिर्ता लिने प्रवृत्ति रोक्न। सम्झौता नगरेमा यो रकम जफत गरिन्छ।
* **कार्यसम्पादन जमानत (Performance Security - सम्झौता रकमको ५%):**
  * ठेक्का सम्झौता हुनु अगावै सफल बोलपत्रदाताले बैंकको नाममा बुझाउनुपर्ने बैंक ग्यारेन्टी।
  * *उद्देश्य:* सम्झौता अनुसार गुणस्तरीय सर्भर, सफ्टवेयर वा हार्डवेयर समयमै आपूर्ति नगरेमा वा बीचमै काम छोडेमा बैंकलाई हुने आर्थिक क्षतिपूर्ति गराउन यो रकम जफत गरिन्छ।

४. निष्कर्ष:
सार्वजनिक खरिद ऐनका प्रावधान र वित्तीय सुरक्षणहरूले बैंकलाई गुणस्तरीय प्रविधि खरिद गर्न, बजेटको सदुपयोग गर्न र आपूर्तिकर्ताको ठगीबाट सुरक्षित राख्न मद्दत गर्दछन्।""")

    # 4. Central Bank Digital Currency (CBDC) (10 Marks)
    add("p1a_u6_sub223", "paper1", "sectionA", 6, "Unit 6: Digital Payment Systems", 10, "2082 BS - RBB IT Model",
        "What is a Central Bank Digital Currency (CBDC)? Explain the structural differences between Wholesale CBDC and Retail CBDC. Analyze the potential benefits and financial stability risks of issuing digital currency in Nepal.",
        "केन्द्रीय बैंक डिजिटल मुद्रा (Central Bank Digital Currency - CBDC) भन्नाले के बुझिन्छ? Wholesale CBDC र Retail CBDC बीचको संरचनागत भिन्नता स्पष्ट पार्दै नेपालमा डिजिटल मुद्रा जारी गर्दा हुने सम्भावित लाभ र वित्तीय स्थायित्वका जोखिमहरू विश्लेषण गर्नुहोस्।",
        """1. Definition & Core Nature of CBDC:
A **Central Bank Digital Currency (CBDC)** is a digital form of sovereign fiat currency issued directly by the nation's central bank (Nepal Rastra Bank). Unlike private decentralized cryptocurrencies (Bitcoin) or commercial bank electronic money (bank balances/wallets), a CBDC is a direct legal-tender claim on the balance sheet of the central bank, carrying sovereign backing, par value stability, and legal enforceability.

2. Wholesale CBDC vs Retail CBDC:
| Dimension | Wholesale CBDC (w-CBDC) | Retail CBDC (r-CBDC) |
|---|---|---|
| **Target Users** | Licensed commercial banks, clearing houses, financial institutions | General citizens, households, retail merchants, SMEs |
| **Operational Scope** | Interbank settlement, large-value cross-border wire clearing, liquidity repo | Daily peer-to-peer (P2P), customer-to-merchant (C2M) retail micropayments |
| **Architecture** | Typically Distributed Ledger Technology (DLT) / Permissioned Blockchain | Two-tier architecture (Central Bank issues; commercial banks distribute) |
| **Volume vs Value** | Low transaction volume, extremely high economic value | Massive transaction volume, smaller retail transaction values |
| **Anonymity Level** | Zero anonymity; complete institutional transparency and regulatory audit | Traceable for AML/CFT, with potential pseudo-privacy for minor offline micropayments |

3. Strategic Benefits for Nepal:
* **Drastic Reduction in Cash Handling Costs:** Printing, transporting under armed guard, storing, sorting, and destroying physical paper currency notes consumes billions of rupees of NRB's annual budget.
* **Universal Financial Inclusion:** Citizens in remote geographic locations without physical bank branches can hold sovereign digital money directly on offline smart cards or feature phones.
* **Cheaper Cross-Border Remittances:** Drastically lowers international wire transfer fees and settlement friction for migrant workers remitting funds from Gulf/East Asian corridors.
* **Automated Monetary Policy Transmission & Programmed Subsidies:** Enables programmable fiscal subsidies (e.g., agricultural fertilizer subsidies usable only at registered fertilizer cooperatives via smart contracts).
* **Countering Illicit Cryptocurrencies:** Provides a legitimate, secure digital alternative preventing public capital flight into outlawed decentralized crypto markets.

4. Financial Stability Risks & Structural Challenges:
1. **Bank Disintermediation (Bank Run Risk):** During times of economic panic or systemic banking rumors, citizens can convert commercial bank deposits into safe central bank digital currency at the touch of a mobile button, triggering rapid digital bank runs and draining bank liquidity.
2. **Cybersecurity Attack Surface:** A centralized CBDC core engine represents a high-value national target for state-sponsored cyber warfare, DDoS, and cryptographic key compromise.
3. **Telecom Infrastructure Fragility:** Rural Nepal faces frequent mountain power grid failures and telecom backhaul outages, demanding complex offline cryptographic synchronization.
4. **Privacy vs AML/CFT Tension:** Balancing democratic citizen financial privacy with strict regulatory AML/CFT surveillance mandates under FATF rules.

5. Conclusion & The Two-Tier Roadmap:
Nepal Rastra Bank's Concept Paper on CBDC wisely recommends an **Intermediated Two-Tier Model**: NRB issues the CBDC core ledger, while commercial banks and payment service providers distribute digital wallets, handle customer service, and execute KYC onboarding, thus preserving commercial banking credit creation while modernizing sovereign payment rails.""",
        """१. CBDC को अवधारणा तथा परिभाषा:
**केन्द्रीय बैंक डिजिटल मुद्रा (Central Bank Digital Currency - CBDC)** कुनै देशको केन्द्रीय बैंक (जस्तै: नेपाल राष्ट्र बैंक) द्वारा जारी गरिएको आधिकारिक डिजिटल स्वरूपको कानुनी मुद्रा (Fiat Currency) हो।
* यो बिटक्वाइन जस्तो निजी र अस्थिर क्रिप्टोकरेन्सी होइन र वालेटमा देखिने बैंक ब्यालेन्स मात्र पनि होइन; यो सिधै राष्ट्र बैंकको दायित्व (Sovereign Liability) भएको र कागजी नोट सरह कानुनी मान्यता प्राप्त मुद्रा हो।

२. Wholesale CBDC र Retail CBDC बीचको भिन्नता:
| आधार | Wholesale CBDC (थोक CBDC) | Retail CBDC (खुद्रा CBDC) |
|---|---|---|
| **प्रयोगकर्ता वर्ग** | वाणिज्य बैंक, वित्तीय संस्था र क्लियरिङ्ग हाउसहरू | सर्वसाधारण नागरिक, व्यापारी र साना व्यवसायहरू |
| **कारोबारको प्रकृति** | अन्तरबैंक फछ्र्यौट, ठूला वित्तीय सम्झौता र अन्तर्राष्ट्रिय भुक्तानी | दैनिक किराना खरिद, भाडा, P2P रकमान्तर र बिल भुक्तानी |
| **प्राविधिक संरचना** | मुख्यतया अनुमतिप्राप्त ब्लकचेन (DLT / Distributed Ledger) | दुई-तहको ढाँचा (राष्ट्र बैंकले जारी गर्ने, बैंकहरूले वितरण गर्ने) |
| **कारोबार संख्या र परिमाण** | थोरै संख्यामा तर अर्बौं रुपैयाँ बराबरको ठूलो रकम | लाखौं संख्यामा तर स-साना खुद्रा रकमको कारोबार |
| **गोपनीयता** | संस्थागत हुने हुँदा पूर्ण पारदर्शी र पूर्ण अडिट हुने | AML/CFT नियम पालना हुने गरी साना कारोबारमा सीमित गोपनीयता |

३. नेपालमा CBDC जारी गर्दा हुने प्रमुख लाभहरू:
* **नोट छपाइ र ढुवानी खर्चमा भारी बचत:** नेपाल राष्ट्र बैंकले वार्षिक अर्बौं रुपैयाँ नयाँ नोट छाप्न, सुरक्षासहित ओसारपसार गर्न र पुराना नोट नष्ट गर्न खर्च गर्दछ; डिजिटल मुद्राले यो खर्च शून्यमा झार्छ।
* **वित्तीय पहुँच र समावेशीकरण:** बैंकको शाखा नभएका विकट हिमाली तथा पहाडी भेगका नागरिकले पनि इन्टरनेट वा साधारण फिचर फोन मार्फत सिधै डिजिटल मुद्रा प्रयोग गर्न सक्ने।
* **विप्रेषण (Remittance) लागतमा कमी:** वैदेशिक रोजगारीमा रहेका नेपालीहरूले चर्को हुण्डी र बैंक शुल्क बिना तत्काल स्वदेशमा रकम पठाउन सक्ने।
* **सशर्त सामाजिक सुरक्षा भत्ता:** स्मार्ट कन्ट्र्याक्ट प्रयोग गरी तोकिएको प्रयोजन (जस्तै: मल खरिद वा शिक्षा) मा मात्र खर्च हुने गरी सरकारी अनुदान वितरण गर्न सकिने।
* **अवैध क्रिप्टोकरेन्सी नियन्त्रण:** सर्वसाधारणलाई सुरक्षित र कानुनी डिजिटल विकल्प दिएर गैरकानुनी बिटक्वाइन र हुण्डी नियन्त्रण गर्न सघाउने।

४. वित्तीय स्थायित्वमा देखिने प्रमुख जोखिम तथा चुनौतीहरू:
१. **बैंक निक्षेप संकट (Bank Disintermediation):** वित्तीय संकटको हल्ला चल्नासाथ नागरिकले वाणिज्य बैंकको निक्षेप तुरुन्तै सुरक्षित CBDC मा बदल्न सक्ने हुँदा बैंकहरूमा तत्काल तरलता संकट (Digital Bank Run) आउन सक्छ।
२. **साइबर सुरक्षाको जोखिम:** केन्द्रीय डिजिटल करेन्सीको मुख्य सर्भरमा विदेशी ह्याकरहरूले आक्रमण गरेमा सम्पूर्ण राष्ट्रिय भुक्तानी प्रणाली नै ठप्प हुन सक्ने।
३. **विद्युत र इन्टरनेटको परनिर्भरता:** दुर्गम क्षेत्रमा इन्टरनेट र बिजुली नहुँदा पनि चल्न सक्ने अफलाइन (Offline) भुक्तानी प्रविधि विकास गर्न प्राविधिक जटिलता।
४. **गोपनीयता बनाम निगरानी:** नागरिकको व्यक्तिगत खर्चको गोपनीयता जोगाउने कि सम्पत्ति शुद्धीकरण रोक्न सबै कारोबार अनुगमन गर्ने भन्ने द्वन्द्व।

५. निष्कर्ष:
नेपाल राष्ट्र बैंकले अध्ययन गरे बमोजिम **दुई-तहको मध्यस्थता मोडल (Two-Tier Model)** अपनाउनु बुद्धिमानी हुन्छ; जहाँ राष्ट्र बैंकले डिजिटल मुद्रा जारी गर्नेछ र वाणिज्य बैंकहरूले ग्राहक पहिचान (KYC), वालेट वितरण र ग्राहक सेवा सञ्चालन गर्नेछन्। यसले वित्तीय स्थायित्व जोगाउँदै डिजिटल अर्थतन्त्रमा ऐतिहासिक फड्को मार्नेछ।""")

    # 5. Cloud Computing in Banking (5 Marks)
    add("p2a_u1_sub224", "paper2", "sectionA", 1, "Unit 1: Computer Fundamentals & Cloud", 5, "2081 BS - NRB IT",
        "Explain Cloud Computing deployment models (Public, Private, Hybrid) and service models (IaaS, PaaS, SaaS). Which model is most suitable for core banking vs customer analytics?",
        "क्लाउड कम्प्युटिङका डिब्लोयमेन्ट मोडेलहरू (Public, Private, Hybrid) र सर्भिस मोडेलहरू (IaaS, PaaS, SaaS) को व्याख्या गर्दै कोर बैंकिङ र ग्राहक विश्लेषणका लागि कुन मोडेल उपयुक्त हुन्छ भनी विश्लेषण गर्नुहोस्।",
        """1. Cloud Computing Service Models:
* **IaaS (Infrastructure as a Service):** Delivers raw computing power, virtual machines, storage, and software-defined networks (e.g., AWS EC2, Azure VMs). The bank manages OS, middleware, and core banking applications.
* **PaaS (Platform as a Service):** Delivers pre-configured execution environments and database engines (e.g., Oracle Cloud Database, Google App Engine). The bank manages application logic and data.
* **SaaS (Software as a Service):** Complete turnkey application delivered over the web (e.g., Microsoft 365, Salesforce CRM, AML screening portals). The cloud vendor manages the entire stack.

2. Cloud Deployment Models:
* **Private Cloud:** Dedicated cloud infrastructure provisioned strictly for the exclusive use of a single banking organization, hosted on-premises or at a private tier-IV facility with sovereign data jurisdiction.
* **Public Cloud:** Multi-tenant infrastructure owned and operated by global cloud providers (AWS, Microsoft Azure, Google Cloud) sharing compute resources across multiple corporate tenants.
* **Hybrid Cloud:** Combines private and public clouds bound together by encrypted orchestration (e.g., site-to-site VPN / Direct Connect), allowing workload and data portability.

3. Suitability for Core Banking vs Customer Analytics:
| Banking Workload | Optimal Model | Rationale & Regulatory Compliance |
|---|---|---|
| **Core Banking System (CBS) & Ledgers** | **Private Cloud (On-Premises)** | Section 5.1 of NRB IT Guidelines and national data sovereignty regulations dictate that primary ledger data and customer financial transaction records must reside physically within Nepal under direct institutional control. |
| **Big Data Analytics & AI Fraud Detection** | **Public Cloud / Hybrid Cloud** | Requires elastic compute clusters and advanced machine learning GPUs to analyze millions of behavioral transaction records, which are cost-prohibitive to build on-premises. Data is pseudonymized/tokenized before leaving the bank. |

4. Conclusion:
Nepalese commercial banks adopt an intelligent **Hybrid Cloud Architecture**: retaining mission-critical CBS ledgers inside sovereign Private Clouds while leveraging Public Cloud elasticity for AI analytics and customer relationship management.""",
        """१. क्लाउड सर्भिस मोडेलहरू (IaaS, PaaS, SaaS):
* **IaaS (Infrastructure as a Service):** भर्चुअल सर्भर, स्टोरेज र नेटवर्क पूर्वाधार भाडामा लिने मोडल (जस्तै: AWS EC2)। बैंकले अपरेटिङ सिस्टम र बैंकिङ सफ्टवेयर आफैं व्यवस्थापन गर्छ।
* **PaaS (Platform as a Service):** सफ्टवेयर विकास र डेटाबेस चलाउने प्लेटफर्म भाडामा लिने मोडल (जस्तै: Oracle Cloud Database)। बैंकले कोड र डेटा मात्र व्यवस्थापन गर्छ।
* **SaaS (Software as a Service):** पूर्ण रूपमा तयार सफ्टवेयर इन्टरनेटबाट सिधै चलाउने मोडल (जस्तै: Office 365, HR सफ्टवेयर)। सम्पूर्ण प्राविधिक व्यवस्थापन भेन्डरले गर्छ।

२. क्लाउड डिब्लोयमेन्ट मोडेलहरू:
* **प्राइभेट क्लाउड (Private Cloud):** पूर्ण रूपमा बैंकको आफ्नै नियन्त्रण र आफ्नै डेटा सेन्टरमा सञ्चालन हुने उच्च सुरक्षित एकल-संस्था क्लाउड।
* **पब्लिक क्लाउड (Public Cloud):** विश्वव्यापी कम्पनीहरू (AWS, Azure) द्वारा धेरै ग्राहकलाई साझा पूर्वाधार मार्फत दिइने क्लाउड।
* **हाइब्रिड क्लाउड (Hybrid Cloud):** प्राइभेट र पब्लिक क्लाउड दुवैलाई सुरक्षित सुरुङ (VPN) मार्फत जोडेर सञ्चालन गरिने मिश्रित प्रणाली।

३. कोर बैंकिङ बनाम ग्राहक डेटा विश्लेषणका लागि उपयुक्तता:
| बैंकिङ कार्य | उपयुक्त मोडेल | औचित्य तथा कानुनी आधार |
|---|---|---|
| **कोर बैंकिङ (CBS) र ग्राहक निक्षेप अभिलेख** | **प्राइभेट क्लाउड (Private Cloud)** | नेपाल राष्ट्र बैंकको IT निर्देशिका र डेटा सार्वभौमसत्ता (Data Sovereignty) अनुसार ग्राहकको संवेदनशील वित्तीय डेटा स्वदेश भित्रै बैंकको प्रत्यक्ष नियन्त्रणमा रहनुपर्दछ। |
| **ग्राहक विश्लेषण र ठगी पहिचान (AI Analytics)** | **पब्लिक वा हाइब्रिड क्लाउड** | लाखौं कारोबारको विश्लेषण गर्न ठूलो कम्प्युटिङ शक्ति (GPU) चाहिने हुँदा ग्राहकको व्यक्तिगत पहिचान हटाई (Tokenized) पब्लिक क्लाउडको शक्ति प्रयोग गर्नु किफायती हुन्छ। |

४. निष्कर्ष:
नेपाली वाणिज्य बैंकहरूका लागि कोर बैंकिङ डेटा प्राइभेट क्लाउडमै सुरक्षित राख्दै अन्य विश्लेषण र डिजिटल सेवाका लागि हाइब्रिड क्लाउड (Hybrid Cloud) अपनाउनु सबैभन्दा सुरक्षित र व्यावहारिक रणनीति हो।""")

    # 6. IPv4 vs IPv6 & Subnetting Engineering (10 Marks)
    add("p2a_u3_sub225", "paper2", "sectionA", 3, "Unit 3: Communication & Computer Networks", 10, "2080 BS - RBB IT",
        "Differentiate between IPv4 and IPv6 addressing architectures. Given the network address `10.100.0.0/22`, calculate: (a) Subnet Mask in dotted decimal, (b) Total number of IP addresses, (c) Number of usable host IP addresses, and (d) First and Last usable host IP addresses.",
        "IPv4 र IPv6 ठेगाना प्रणालीको वास्तुकलागत भिन्नता प्रष्ट पार्नुहोस्। नेटवर्क ठेगाना `10.100.0.0/22` दिइएको अवस्थामा गणना गर्नुहोस्: (क) सबनेट मास्क (Dotted Decimal), (ख) कुल IP ठेगाना संख्या, (ग) प्रयोगयोग्य होस्ट IP संख्या, र (घ) पहिलो र अन्तिम प्रयोगयोग्य होस्ट IP ठेगाना।",
        """1. Comparative Architecture: IPv4 vs IPv6:
| Feature | IPv4 | IPv6 |
|---|---|---|
| **Address Length** | **32 bits** (4 octets) | **128 bits** (16 octets / 8 hextets) |
| **Address Space** | $2^{32} \\approx 4.29$ Billion addresses (exhausted) | $2^{128} \\approx 3.4 \\times 10^{38}$ undecillion addresses |
| **Notation Format** | Dotted-decimal: `192.168.1.1` | Hexadecimal colon-separated: `2001:0db8:85a3::8a2e:0370:7334` |
| **Header Format** | Variable length (20 to 60 bytes with options) | Simplified fixed length (40 bytes), faster routing |
| **Security (IPSec)** | Optional add-on protocol | Natively built-in architectural requirement |
| **Configuration** | Manual or via DHCP (Stateful) | SLAAC (Stateless Address Autoconfiguration) or DHCPv6 |
| **Checksum** | Header checksum verified at every hop | Removed from header; relies on L2/L4 error checking |

2. Engineering Calculation for Network `10.100.0.0/22`:
* **Given CIDR Prefix:** `/22`
  * Total bits = 32.
  * Network bits ($n$) = 22.
  * Host bits ($h$) = $32 - 22 = 10$ bits.

* **(a) Subnet Mask in Dotted Decimal:**
  * Binary: `11111111.11111111.11111100.00000000`
  * Octet 1 = 255
  * Octet 2 = 255
  * Octet 3 = $128 + 64 + 32 + 16 + 8 + 4 = 252$
  * Octet 4 = 0
  * **Subnet Mask = `255.255.252.0`**

* **(b) Total Number of IP Addresses:**
  $$\\text{Total IPs} = 2^h = 2^{10} = \\mathbf{1,024} \\text{ IP addresses}$$

* **(c) Number of Usable Host IP Addresses:**
  Subtract 2 (one for Network Address and one for Directed Broadcast Address):
  $$\\text{Usable Hosts} = 2^{10} - 2 = 1,024 - 2 = \\mathbf{1,022} \\text{ usable host IPs}$$

* **(d) First and Last Usable Host IP Addresses:**
  * Network Address: `10.100.0.0`
  * Block size in 3rd octet = $256 - 252 = 4$. Next subnet starts at `10.100.4.0`.
  * Broadcast Address: `10.100.3.255`
  * **First Usable Host IP:** `10.100.0.1`
  * **Last Usable Host IP:** `10.100.3.254`

3. Conclusion:
Subnetting `/22` allows a commercial bank to consolidate an entire regional data center of 1,022 hosts into a single broadcast domain, minimizing routing table bloat.""",
        """१. IPv4 र IPv6 ठेगाना प्रणालीको तुलनात्मक तालिका:
| विशेषता | IPv4 | IPv6 |
|---|---|---|
| **ठेगाना लम्बाइ** | **३२ बिट** (४ अक्टेट) | **१२८ बिट** (१६ अक्टेट / ८ हेक्सामुलक समूह) |
| **कुल ठेगाना संख्या** | $२^{३२} \\approx ४.२९$ अर्ब (हाल समाप्त भएको) | $२^{१२८} \\approx ३.४ \\times १०^{३८}$ (अनगिन्ती) |
| **लेख्ने ढाँचा** | दशमलव विन्दु: `192.168.1.1` | हेक्साडेसिमल कोलन: `2001:db8::1` |
| **हेडरको आकार** | परिवर्तनशील (२० देखि ६० बाइट सम्म) | निश्चित आकार (४० बाइट), द्रुत प्रोसेसिङ |
| **सुरक्षा (IPSec)** | पछि थपिएको ऐच्छिक सुविधा | प्रणाली भित्रै अनिवार्य रूपमा निर्मित (Native) |
| **कन्फिगरेसन** | म्यानुअल वा DHCP मार्फत | SLAAC मार्फत स्वतः कन्फिगर हुने सुविधा |

२. नेटवर्क `10.100.0.0/22` को प्राविधिक गणना:
* **दिइएको सबनेट प्रिफिक्स:** `/22`
  * कुल बिट = ३२।
  * नेटवर्क बिट ($n$) = २२।
  * होस्ट बिट ($h$) = $३२ - २२ = १०$ बिट।

* **(क) सबनेट मास्क (Dotted Decimal मा):**
  * बाइनरी रूप: `11111111.11111111.11111100.00000000`
  * पहिलो अक्टेट = २५५
  * दोस्रो अक्टेट = २५५
  * तेस्रो अक्टेट = $१२८ + ६४ + ३२ + १६ + ८ + ४ = २५२$
  * चौथो अक्टेट = ०
  * **सबनेट मास्क = `255.255.252.0`**

* **(ख) कुल IP ठेगानाहरूको संख्या:**
  $$\\text{कुल IP} = २^{१०} = \\mathbf{१,०२४} \\text{ वटा}$$

* **(ग) प्रयोगयोग्य होस्ट IP संख्या:**
  नेटवर्क ठेगाना र ब्रोडकास्ट ठेगाना गरी २ वटा घटाउँदा:
  $$\\text{प्रयोगयोग्य होस्ट} = २^{१०} - २ = १,०२४ - २ = \\mathbf{१,०२२} \\text{ वटा}$$

* **(घ) पहिलो र अन्तिम प्रयोगयोग्य होस्ट IP ठेगाना:**
  * नेटवर्क ठेगाना: `10.100.0.0`
  * तेस्रो अक्टेटको ब्लक साइज = २५६ - २५२ = ४ (अर्को सबनेट `10.100.4.0` मा सुरु हुन्छ)।
  * ब्रोडकास्ट ठेगाना: `10.100.3.255`
  * **पहिलो प्रयोगयोग्य IP:** `10.100.0.1`
  * **अन्तिम प्रयोगयोग्य IP:** `10.100.3.254`

३. निष्कर्ष:
`/22` सबनेटिङले बैंकलाई एउटै सुरक्षित सबनेट भित्र १,०२२ वटा सर्भर वा कम्प्युटरहरूलाई सहज रूपमा व्यवस्थापन गर्न मद्दत गर्दछ।""")

    return qs

if __name__ == "__main__":
    expansion = get_expansion_subjective_questions()
    print(f"Loaded {len(expansion)} expansion subjective questions.")
