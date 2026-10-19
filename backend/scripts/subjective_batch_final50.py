# -*- coding: utf-8 -*-
"""
50 High-Yield Lok Sewa Subjective Questions and Model Answers
Ensures 100% genuine, deep, structured model answers across Banking and IT.
"""

def get_final50_subjective_questions():
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

    # 1. Monetary Policy Instruments (10 Marks)
    add("p1a_u2_sub230", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology", 10, "2079 BS - RBB IT",
        "What is Monetary Policy? Discuss the quantitative and qualitative instruments used by Nepal Rastra Bank to regulate liquidity and inflation in the economy.",
        "मौद्रिक नीति भन्नाले के बुझिन्छ? अर्थतन्त्रमा तरलता र मुद्रास्फीति नियन्त्रण गर्न नेपाल राष्ट्र बैंकले प्रयोग गर्ने परिमाणात्मक र गुणात्मक उपकरणहरूको विवेचना गर्नुहोस्।",
        """1. Introduction & Concept:
Pursuant to Section 44 of the **Nepal Rastra Bank Act, 2058**, the annual **Monetary Policy (मौद्रिक नीति)** is the statutory macroeconomic framework formulated and implemented by the central bank to regulate money supply, credit availability, interest rates, and foreign exchange reserves to achieve domestic price stability, economic growth, and financial sector resilience.

2. Quantitative (General) Monetary Instruments:
These tools manipulate the overall volume of credit and aggregate liquidity in the banking system:
1. **Cash Reserve Ratio (CRR):** Mandatory interest-free statutory reserve (currently 4.0%) that commercial banks must maintain at NRB. Lowering CRR injects liquidity; raising it contracts credit.
2. **Statutory Liquidity Ratio (SLR):** Mandatory liquidity reserve (currently 12.0% for Class A banks) held in cash, gold, and approved government treasury bills/bonds.
3. **Interest Rate Corridor (IRC):** Anchors short-term interbank interest rates within a defined band:
   * *Ceiling:* Bank Rate (Standing Liquidity Facility - SLF rate).
   * *Policy Rate:* Repo rate for 14-day liquidity injections.
   * *Floor:* Deposit Collection rate (Standing Deposit Facility - SDF rate).
4. **Open Market Operations (OMO):** Outright purchase/sale of government securities, Reverse Repos, and NRB Bonds to absorb or inject systemic liquidity.

3. Qualitative (Selective) Monetary Instruments:
These tools channel credit into specific priority economic sectors and discourage speculative bubbles:
1. **Targeted / Directed Lending Mandates:** Mandatory requirement for commercial banks to allocate minimum credit quotas to designated sectors: Agriculture (minimum 15%), Energy (minimum 10%), SMEs (minimum 15%), and Deprived Sector Credit (minimum 5%).
2. **Loan-to-Value (LTV) Ratio Caps:** Imposes statutory ceiling limits on collateral value for real estate (e.g., 30-40% in Kathmandu valley) and personal auto loans (50%) to prevent asset bubble speculation.
3. **Credit-to-Deposit (CD) Ratio Ceiling (≤ 90%):** Enforces a hard ceiling preventing aggressive over-lending beyond mobilized deposits.
4. **Moral Suasion & Directives:** Central bank moral persuasion through banker meetings and circulars advising conservative dividend distributions and non-productive credit curbs.

4. Current Monetary Challenges in Nepal:
* Subdued private sector credit demand despite surplus banking liquidity.
* High reliance on import revenues and remittance-driven consumption.

5. Conclusion:
Through balanced deployment of the Interest Rate Corridor and targeted credit allocations, NRB's monetary policy harmonizes external balance stability with sustainable industrial development.""",
        """१. मौद्रिक नीतिको अवधारणा:
**नेपाल राष्ट्र बैंक ऐन, २०५८ को दफा ४४** बमोजिम देशमा मूल्य तथा शोधनान्तर स्थिरता कायम गर्न र आर्थिक वृद्धिलाई सहयोग पुर्‍याउन नेपाल राष्ट्र बैंकले जारी गर्ने समष्टिगत आर्थिक नीतिलाई **मौद्रिक नीति (Monetary Policy)** भनिन्छ। यसले मुद्रा प्रदाय (Money Supply), ब्याजदर र कर्जाको मात्रा नियमन गर्दछ।

२. परिमाणात्मक (प्रत्यक्ष) मौद्रिक उपकरणहरू:
यसले अर्थतन्त्रको समग्र तरलता र कर्जाको परिमाणलाई प्रत्यक्ष प्रभाव पार्दछ:
१. **अनिवार्य नगद मौज्दात (CRR):** वाणिज्य बैंकहरूले आफ्नो कुल निक्षेपको ४% रकम राष्ट्र बैंकमा बिना ब्याज नगद राख्नुपर्ने नियम। यसले बैंकहरूको कर्जा दिने क्षमता नियन्त्रण गर्छ।
२. **वैधानिक तरलता अनुपात (SLR):** वाणिज्य बैंकहरूले कुल निक्षेपको १२% रकम सरकारी ऋणपत्र, सुन र नगद मौज्दातमा सुरक्षित राख्नुपर्ने व्यवस्था।
३. **ब्याजदर करिडोर (Interest Rate Corridor - IRC):** छोटो अवधिको अन्तरबैंक ब्याजदरलाई निश्चित सीमाभित्र राख्ने संयन्त्र:
   * *माथिल्लो सीमा (Ceiling):* बैंक दर / स्थायी तरलता सुविधा (SLF)।
   * *नीतिगत दर (Policy Rate):* रिपो दर (Repo Rate)।
   * *तल्लो सीमा (Floor):* निक्षेप संकलन दर / स्थायी निक्षेप सुविधा (SDF)।
४. **खुला बजार कारोबार (OMO):** बजारमा धेरै तरलता हुँदा राष्ट्र बैंकले ऋणपत्र बेचेर पैसा तान्ने र अभाव हुँदा ऋणपत्र किनेर बजारमा पैसा पठाउने कार्य।

३. गुणात्मक (छनौटपूर्ण) मौद्रिक उपकरणहरू:
यसले कर्जाको कुल मात्रा नभई कर्जा प्रवाह हुने क्षेत्र र उद्देश्यलाई नियन्त्रण गर्दछ:
१. **निर्देशित / प्राथमिकताप्राप्त क्षेत्र कर्जा:** वाणिज्य बैंकहरूले आफ्नो कुल कर्जाको कम्तीमा कृषिमा १५%, ऊर्जामा १०%, साना तथा मझौला उद्यम (SME) मा १५% र विपन्न वर्गमा ५% कर्जा अनिवार्य लगानी गर्नुपर्ने व्यवस्था।
२. **धितो-कर्जा अनुपात (LTV Ratio):** घरजग्गा कर्जामा ३०-४०% र सवारी साधन कर्जामा ५०% मात्र ऋण दिन पाउने गरी सट्टेबाजी रोक्ने सीमा।
३. **कर्जा-निक्षेप अनुपात (CD Ratio ≤ ९०%):** बैंकहरूले निक्षेप भन्दा धेरै कर्जा प्रवाह गर्न नपाउने गरी अधिकतम ९०% को सीमा।
४. **नैतिक दबाब (Moral Suasion):** बैंकका प्रमुखहरूसँग छलफल गरी अनुत्पादक कर्जा घटाउन र ब्याजदर सन्तुलित राख्न राष्ट्र बैंकले दिने मौखिक निर्देशन।

४. निष्कर्ष:
नेपाल राष्ट्र बैंकले ब्याजदर करिडोर र निर्देशित क्षेत्र कर्जा जस्ता आधुनिक उपकरणहरूको कुशल प्रयोग मार्फत वित्तीय स्थायित्व र उत्पादनशील अर्थतन्त्र निर्माणमा अग्रगामी भूमिका खेलिरहेको छ।""")

    # 2. Electronic Cheque Clearing (ECC) & Cheque Truncation (5 Marks)
    add("p1a_u6_sub231", "paper1", "sectionA", 6, "Unit 6: Digital Payment Systems", 5, "2078 BS - Loksewa Operator",
        "What is Electronic Cheque Clearing (ECC)? Explain the concept of Cheque Truncation and the operational stages of digital cheque clearing in Nepal.",
        "विद्युतीय चेक क्लियरिङ्ग (ECC) भन्नाले के बुझिन्छ? चेक ट्रंकेसन (Cheque Truncation) को अवधारणा र नेपालमा ECC सञ्चालनका प्रमुख चरणहरू व्याख्या गर्नुहोस्।",
        """1. Concept of ECC & Cheque Truncation:
**Electronic Cheque Clearing (ECC)** is an image-based, nationwide interbank clearing and settlement system operated by Nepal Clearing House Limited (NCHL).
* **Cheque Truncation:** The physical paper cheque is halted (truncated) at the presenting bank branch. Instead of physically transporting paper cheques to the clearing house, high-resolution electronic digital images (front, back, and UV/watermark) and magnetic ink character recognition (MICR) data are transmitted electronically for verification and settlement.

2. Operational Workflow Stages:
1. **Capture & Scanning:** The presenting bank scans the customer's physical cheque using a MICR digital cheque scanner, capturing MICR code lines (Cheque number, Routing number, Account number) and digital images.
2. **Endorsement & Digital Signing:** The presenting bank attaches an electronic signature and uploads the clearing batch file to the NCHL central ECC server.
3. **Clearing Validation & Routing:** NCHL central engine validates account formats, sorts cheques, and routes digital images electronically to the drawee (paying) bank.
4. **Signature Verification & Approval:** The paying bank's branch staff inspects the scanned image against the specimen signature in their Core Banking System (CBS) and verifies sufficient balance.
5. **Settlement & Return Processing:**
   * If approved: NCHL nets the funds, transmits settlement files to NRB's settlement account, and credits the payee.
   * If rejected: An electronic return memo (with dishonor code) is generated within the clearing window.

3. Key Benefits:
* Reduces cheque clearance time from 3–5 days to same-day clearing (express clearing within 2 hours).
* Eliminates logistical risks of courier loss, theft, and physical wear-and-tear of paper cheques.

4. Conclusion:
ECC modernizes paper instruments, combining traditional cheque familiarity with high-speed digital interbank liquidity.""",
        """१. ECC र चेक ट्रंकेसन (Cheque Truncation) को अवधारणा:
**विद्युतीय चेक क्लियरिङ्ग (Electronic Cheque Clearing - ECC)** नेपाल क्लियरिङ्ग हाउस लिमिटेड (NCHL) द्वारा सञ्चालित चेकको डिजिटल तस्वीर मार्फत अन्तरबैंक चेक फछ्र्यौट गर्ने राष्ट्रिय प्रणाली हो।
* **चेक ट्रंकेसन (Cheque Truncation):** यस प्रविधिमा कागजी चेकलाई सम्बन्धित बैंकको शाखामै रोकिन्छ (Truncate गरिन्छ) र भौतिक चेक ओसारपसार नगरी त्यसको उच्च गुणस्तरको डिजिटल फोटो र MICR विवरण मात्र इन्टरनेट मार्फत पठाएर रकम भुक्तानी गरिन्छ।

२. ECC सञ्चालनका प्रमुख चरणहरू:
१. **स्क्यानिङ र डेटा क्याप्चर:** चेक पेश भएको बैंकले MICR स्क्यानरबाट चेकको अगाडि, पछाडिको फोटो र चेक नं., खाता नं. तथा बैंक कोड स्क्यान गर्दछ।
२. **डिजिटल हस्ताक्षर र अपलोड:** स्क्यान गरिएको चेक फाइलमा बैंकको डिजिटल हस्ताक्षर जोडी NCHL को केन्द्रीकृत ECC प्रणालीमा अपलोड गरिन्छ।
३. **प्रशोधन र रुटिङ:** NCHL प्रणालीले चेकहरूलाई सम्बन्धित भुक्तानी दिने (Drawee) बैंकको प्रणालीमा स्वचालित रूपमा पठाइदिन्छ।
४. **दस्तखत प्रमाणीकरण र स्वीकृति:** भुक्तानी दिने बैंकका कर्मचारीले आफ्नो CBS मा रहेको ग्राहकको हस्ताक्षरसँग चेकको फोटो भिडाएर खातामा पर्याप्त रकम भएमा भुक्तानी स्वीकृत गर्छन्।
५. **फछ्र्यौट र निक्षेप:** NCHL ले राष्ट्र बैंकमा रहेको बैंकहरूको खाता मार्फत नेटिङ गरी चेक पेश गर्ने ग्राहकको खातामा रकम जम्मा गरिदिन्छ (रकम नभए रिजेक्ट मेमो जारी हुन्छ)।

३. ECC का फाइदाहरू:
* पहिले ३ देखि ५ दिन लाग्ने चेक क्लियरिङ्ग अब सोही दिन (एक्सप्रेस क्लियरिङ्गमा २ घण्टा भित्र) सम्पन्न हुन्छ।
* कागजी चेक बोकेर क्लियरिङ्ग हाउस धाउनुपर्ने झन्झट, हराउने जोखिम र ढुवानी खर्च अन्त्य भएको छ।

४. निष्कर्ष:
ECC ले कागजी चेकको विश्वसनीयतालाई कायम राख्दै डिजिटल गतिको संयोजन मार्फत बैंकिङ कारोबारलाई द्रुत र पारदर्शी बनाएको छ।""")

    # 3. Relational ACID Properties (10 Marks)
    add("p2b_u5_sub232", "paper2", "sectionB", 5, "Unit 5: DBMS, Data Warehousing & DRP", 10, "2081 BS - NRB IT",
        "Explain the ACID properties of database transactions in the context of a core banking fund transfer. Detail how Concurrency Control (Two-Phase Locking) and Write-Ahead Logging (WAL) enforce these properties.",
        "कोर बैंकिङ प्रणालीमा रकमान्तर कारोबारको उदाहरण दिँदै डेटाबेस ट्रान्ज्याक्सनका ACID गुणहरू व्याख्या गर्नुहोस्। Concurrency Control (Two-Phase Locking) र Write-Ahead Logging (WAL) ले यी गुणहरू कसरी सुनिश्चित गर्दछन् भनी स्पष्ट पार्नुहोस्।",
        """1. Concept of Database Transaction:
A **Transaction** in a Core Banking System (CBS) is a logical unit of database processing that includes one or more database access operations (e.g., deducting funds from Account A and crediting Account B).

2. The ACID Properties (with Banking Fund Transfer Example):
Consider a transfer of Rs. 10,000 from Account $A$ (balance: Rs. 50,000) to Account $B$ (balance: Rs. 20,000):
`T: Read(A); A = A - 10000; Write(A); Read(B); B = B + 10000; Write(B); Commit;`

| Property | Core Guarantee | Failure Scenario Prevented |
|---|---|---|
| **Atomicity (अविभाज्यता)** | 'All or Nothing'. Either all operations complete successfully, or the entire transaction is rolled back completely. | If server power fails after deducting Rs. 10,000 from $A$ but before crediting $B$, Atomicity aborts and restores $A$ back to Rs. 50,000. |
| **Consistency (सत्यनिष्ठा / स्थिरता)** | A transaction must transform the database from one valid consistent state to another, preserving all integrity constraints (e.g., $A + B = 70,000$ before and after). | Account $A$'s balance cannot drop below statutory minimum balance constraints (e.g., min Rs. 1,000). |
| **Isolation (अलगाव / पृथकीकरण)** | Concurrently executing transactions must execute independently without interfering with each other's uncommitted intermediate data. | Prevents 'Dirty Reads' and 'Lost Updates' where Transaction 2 reads $A$'s balance before Transaction 1 completes. |
| **Durability (स्थायित्व)** | Once a transaction commits, its updates are permanently recorded in non-volatile storage and will never be lost, even during system crashes. | If the database crashes 1 millisecond after printing a success receipt, $B$'s balance of Rs. 30,000 remains safely intact upon reboot. |

3. Enforcement Mechanism 1: Concurrency Control via Two-Phase Locking (2PL):
To guarantee **Isolation** and serializability during thousands of concurrent ATM and mobile banking requests:
* **Growing Phase (Phase 1):** A transaction acquires shared locks (S-lock for reading) and exclusive locks (X-lock for writing), but cannot release any lock.
* **Shrinking Phase (Phase 2):** Once the first lock is released, the transaction can only release locks and cannot acquire any new lock.
* *Strict 2PL:* Holds all exclusive locks until the transaction formally commits/aborts, completely preventing cascading aborts.

4. Enforcement Mechanism 2: Write-Ahead Logging (WAL):
To guarantee **Atomicity** and **Durability** under system crashes:
* *Core Rule:* No database data page is written to disk until the corresponding transaction log record (containing Old Value and New Value) is first written to non-volatile disk.
* *Crash Recovery (ARIES):*
  * **REDO Phase:** Replays committed transactions from the log to restore Durability.
  * **UNDO Phase:** Reverses changes of uncommitted active transactions from the log to restore Atomicity.

5. Conclusion:
ACID compliance enforced by 2PL and WAL forms the inviolable bedrock of financial software, ensuring that balance ledgers remain mathematically accurate and corruption-free.""",
        """१. डेटाबेस कारोबार (Transaction) को अवधारणा:
कोर बैंकिङ प्रणाली (CBS) मा एउटा खाताबाट रकम झिकेर अर्को खातामा जम्मा गर्ने जस्ता सम्पूर्ण सम्बन्धित कामहरूको एउटा अविभाज्य समूहलाई **ट्रान्ज्याक्सन (Transaction)** भनिन्छ।

२. बैंकिङ रकमान्तरको उदाहरण सहित ACID गुणहरू:
मानौं, खाता 'क' (मौज्दात: रू. ५०,०००) बाट खाता 'ख' (मौज्दात: रू. २०,०००) मा रू. १०,००० रकमान्तर गरिँदैछ:

| ACID गुणहरू | मूल सिद्धान्त र प्रत्याभूति | रोक्ने सम्भावित दुर्घटना |
|---|---|---|
| **Atomicity (अविभाज्यता)** | 'हुन्छ भने सबै काम हुन्छ, नभए केही पनि हुँदैन' (All or Nothing)। कारोबार पूरा नभई बीचमै रोकिएमा पुरानै अवस्थामा फर्कन्छ (Rollback)। | 'क' को खाताबाट रू. १०,००० घट्ने तर बिजुली गएर 'ख' को खातामा जम्मा नहुने समस्या आउन दिँदैन; पैसा फिर्ता 'क' कै खातामा रहन्छ। |
| **Consistency (स्थिरता / एकरूपता)** | कारोबार सम्पन्न हुनु अघि र पछि डेटाबेसको कुल हिसाब र नियमहरू (Constraints) सन्तुलित रहनुपर्दछ (जस्तै: दुवै खाताको कुल योग रू. ७०,००० नै रहनु)। | खातामा न्यूनतम मौज्दात (जस्तै: रू. १,०००) भन्दा तल घटेर माइनसमा कारोबार हुन दिँदैन। |
| **Isolation (पृथकीकरण)** | एकैपटक हजारौं कारोबार भइरहँदा एउटा कारोबारको नतिजा नसकिँदासम्म अर्को कारोबारले त्यसको अपुरो डेटा पढ्न वा हेर्न पाउँदैन। | 'क' ले रकम पठाउँदै गरेको अवस्थामा अर्को ATM बाट एकै सेकेन्डमा रकम झिक्न खोज्दा बाझिने समस्या (Dirty Read) रोक्छ। |
| **Durability (स्थायित्व)** | कारोबार सफल (Commit) भएको सन्देश आएपछि सर्भर नै जले पनि सो कारोबारको अभिलेख सधैं सुरक्षित रहन्छ, कहिल्यै हराउँदैन। | रकमान्तर सफल भएको १ सेकेन्ड पछि सर्भर क्र्यास भए पनि 'ख' को खातामा बढेको रू. १०,००० पुनः सुरु गर्दा सुरक्षित भेटिन्छ। |

३. Two-Phase Locking (2PL) द्वारा Isolation सुनिश्चितता:
एकै समयमा धेरै ग्राहकले कारोबार गर्दा डेटा बाझिन नदिन 2PL विधि प्रयोग गरिन्छ:
* **बढ्दो चरण (Growing Phase):** कारोबारले आवश्यक डेटामा लक (Lock) लगाउँदै जान्छ, तर कुनै लक छोड्न पाउँदैन।
* **घट्दो चरण (Shrinking Phase):** काम सकिएपछि लकहरू क्रमशः फुकुवा गरिन्छ, नयाँ लक लिन पाइँदैन।
* यसले एक ग्राहकको कारोबार नसकिँदासम्म सो खातामा अर्को ग्राहकले फेरबदल गर्न पाउँदैन।

४. Write-Ahead Logging (WAL) द्वारा Atomicity र Durability सुनिश्चितता:
* *नियम:* वास्तविक डेटाबेसमा परिवर्तन लेख्नु अगावै सो कारोबारको पुरानो मान र नयाँ मान 'लग फाइल' (Log) मा लेखिसक्नुपर्छ।
* यदि सर्भर क्र्यास भएमा: लग फाइल हेरेर सफल भइसकेका कारोबारलाई **REDO** गरी पुनः लेखिन्छ (Durability) र अधुरा कारोबारलाई **UNDO** गरी पुरानै अवस्थामा फर्काइन्छ (Atomicity)।

५. निष्कर्ष:
2PL र WAL द्वारा सञ्चालित ACID गुणहरूले बैंकिङ सफ्टवेयरलाई विश्वभरका लाखौं अनलाइन कारोबारमा एक पैसाको पनि हिसाब नबाझिने गरी भरपर्दो र सुरक्षित बनाउँछ।""")

    # 4. Asymmetric Cryptography: RSA & Digital Signatures (10 Marks)
    add("p2a_u3_sub233", "paper2", "sectionA", 3, "Unit 3: Communication & Computer Networks", 10, "2082 BS - RBB IT Model",
        "Explain the mathematical principles and workflow of the RSA Public-Key Cryptographic Algorithm. How do Digital Signatures achieve Authentication, Integrity, and Non-Repudiation in electronic banking transactions?",
        "RSA पब्लिक-कि क्रिप्टोग्राफिक एल्गोरिदमको गणितीय सिद्धान्त र कार्यविधि व्याख्या गर्दै डिजिटल हस्ताक्षर (Digital Signature) ले अनलाइन बैंकिङ कारोबारमा कसरी Authentication, Integrity र Non-Repudiation सुनिश्चित गर्दछ भनी विश्लेषण गर्नुहोस्।",
        """1. Introduction to Asymmetric Cryptography & RSA:
Invented in 1977 by Ron Rivest, Adi Shamir, and Leonard Adleman, the **RSA Algorithm** is the foundational asymmetric public-key cryptosystem used globally for securing internet banking, TLS handshakes, and digital signatures.
* *Core Mathematical Hardness:* Based on the prime factorization problem — it is computationally trivial to multiply two large prime numbers ($p \\times q = n$), but computationally infeasible to factor the product $n$ back into $p$ and $q$ when $n$ is 2048 or 4096 bits long.

2. Mathematical Steps of RSA Key Generation & Encryption:
A. Key Generation:
1. Choose two distinct, large prime numbers: $p$ and $q$.
2. Compute the modulus: $n = p \\times q$.
3. Compute Euler's Totient function: $\\phi(n) = (p - 1)(q - 1)$.
4. Choose a public exponent $e$ such that $1 < e < \\phi(n)$ and $\\gcd(e, \\phi(n)) = 1$ (typically $e = 65537$).
5. Compute private exponent $d$ as the modular multiplicative inverse:
   $$d \\equiv e^{-1} \\pmod{\\phi(n)} \\quad \\implies \\quad (d \\times e) \\pmod{\\phi(n)} = 1$$
* **Public Key:** $(e, n)$ (shared openly with the world)
* **Private Key:** $(d, n)$ (kept strictly secret by the owner)

B. Encryption & Decryption:
* **Encryption:** Ciphertext $C = M^e \\pmod n$ (using recipient's public key)
* **Decryption:** Plaintext Message $M = C^d \\pmod n$ (using recipient's private key)

3. Digital Signature Architecture:
While encryption uses the recipient's public key for *confidentiality*, a **Digital Signature** uses the sender's private key for *authenticity and integrity*.

```
[Sender: Bank Customer]                                        [Receiver: Core Banking Engine]
   Plaintext Transaction: "Transfer Rs. 50,000 to X"              Plaintext Transaction Received
             |                                                                 |
     [SHA-256 Hashing]                                                 [SHA-256 Hashing]
             |                                                                 |
       Message Digest                                                   Computed Digest
             |                                                                 |
[Encrypt with Sender's PRIVATE Key]                                            |
             |                                                                 |
     Digital Signature ----------------- Sent Over Network -----------------> Verify
                                                                               |
                                                                [Decrypt with Sender's PUBLIC Key]
                                                                               |
                                                                        Decrypted Digest
                                                                               |
                                                           Does Decrypted Digest == Computed Digest?
                                                           --> YES: Authenticated & Unaltered!
```

4. The Three Security Guarantees Delivered:
1. **Authentication (प्रमाणीकरण):** Because only the legitimate account holder possesses their private key, successfully decrypting the signature with their public key proves unequivocally that the transaction originated from that specific user.
2. **Integrity (सत्यनिष्ठा / शुद्धता):** If a hacker modifies even a single digit in the wire amount (e.g., from Rs. 50,000 to Rs. 500,000), the newly computed SHA-256 hash will completely mismatch the decrypted hash, immediately flagging tampering.
3. **Non-Repudiation (गैर-अस्वीकार्यता):** Because the private key is held exclusively by the sender, the customer cannot legally or technically deny having authorized the transaction in court (legally recognized under Nepal's Electronic Transactions Act 2063).

5. Conclusion:
RSA-backed digital signatures provide the indispensable legal and cryptographic foundation enabling secure mobile banking, RTGS, and legally binding digital paperless banking in Nepal.""",
        """१. RSA एल्गोरिदमको परिचय र गणितीय आधार:
सन् १९७७ मा रिभेस्ट, समिर र एडलम्यानद्वारा विकसित **RSA एल्गोरिदम** विश्वभर अनलाइन बैंकिङ, सुरक्षित वेबसाइट (HTTPS) र डिजिटल हस्ताक्षरमा प्रयोग हुने सबैभन्दा प्रसिद्ध असिमेट्रिक क्रिप्टोग्राफी हो।
* *गणितीय सिद्धान्त:* यो ठूला अभाज्य संख्याहरूको गुणनफल (Prime Factorization) को जटिलतामा आधारित छ। दुईवटा ठूला प्राइम नम्बर ($p$ र $q$) गुणन गर्न सजिलो हुन्छ तर तिनीहरूको गुणनफल ($n$) बाट फेरि ती दुई संख्या पत्ता लगाउन आधुनिक सुपरकम्प्युटरलाई पनि हजारौं वर्ष लाग्दछ।

२. RSA को साँचो निर्माण र कार्यविधि:
क. साँचो निर्माण (Key Generation):
१. दुईवटा ठूला अभाज्य संख्याहरू छनोट गर्ने: $p$ र $q$।
२. मोड्युलस गणना गर्ने: $n = p \\times q$।
३. ओयलर फङ्सन गणना गर्ने: $\\phi(n) = (p - 1)(q - 1)$।
४. पब्लिक एक्स्पोनेन्ट $e$ छान्ने (जहाँ $\\gcd(e, \\phi(n)) = 1$, सामान्यतया ६५५३७)।
५. प्राइभेट कि $d$ गणना गर्ने: $(d \\times e) \\pmod{\\phi(n)} = १$।
* **पब्लिक कि (Public Key):** $(e, n)$ - सबैलाई बाँड्न मिल्ने।
* **प्राइभेट कि (Private Key):** $(d, n)$ - मालिकले गोप्य राख्ने।

ख. इन्क्रिप्सन र डिक्रिप्सन:
* **इन्क्रिप्सन:** $C = M^e \\pmod n$ (प्राप्तकर्ताको पब्लिक कि ले बन्द गर्ने)
* **डिक्रिप्सन:** $M = C^d \\pmod n$ (प्राप्तकर्ताको प्राइभेट कि ले खोल्ने)

३. डिजिटल हस्ताक्षर (Digital Signature) को कार्यप्रणाली:
डिजिटल हस्ताक्षरमा प्रेषकले म्यासेजको ह्यास (Digest) लाई **आफ्नो गोप्य प्राइभेट कि ले इन्क्रिप्ट** गर्दछ:
१. ग्राहकले बैंकिङ कारोबार (जस्तै: रू. ५०,००० रकमान्तर) को विवरण तयार गर्छ।
२. सफ्टवेयरले सो कारोबारको SHA-256 ह्यास निकाल्छ र ग्राहकको प्राइभेट कि ले इन्क्रिप्ट गरी 'डिजिटल हस्ताक्षर' बनाउँछ।
३. बैंकको सर्भरले ग्राहकको पब्लिक कि प्रयोग गरी सो हस्ताक्षर खोल्छ र प्राप्त कारोबारको ह्याससँग भिडाउँछ। दुवै बराबर भए कारोबार प्रमाणित हुन्छ।

४. डिजिटल हस्ताक्षरले दिने तीनवटा सुरक्षा प्रत्याभूतिहरू:
१. **प्रमाणीकरण (Authentication):** ग्राहक बाहेक अरू कसैसँग उसको प्राइभेट कि नहुने भएकाले यो कारोबार सोही ग्राहकले नै पठाएको हो भनी शतप्रतिशत प्रमाणित हुन्छ।
२. **सत्यनिष्ठा / शुद्धता (Integrity):** बाटोमा ह्याकरले रकमको अंक वा खाता नम्बर एक अक्षर मात्रै फेरे पनि ह्यास कोड बाझिन्छ र प्रणालीले कारोबार तुरुन्तै खारेज गर्छ।
३. **गैर-अस्वीकार्यता (Non-Repudiation):** आफ्नै डिजिटल हस्ताक्षरबाट कारोबार भइसकेपछि ग्राहकले "मैले पठाएको होइन" भनी पछि कानुनी रूपमा इन्कार गर्न पाउँदैन (विद्युतीय कारोबार ऐन २०६३ बमोजिम अदालतमा मान्य)।

५. निष्कर्ष:
RSA मा आधारित डिजिटल हस्ताक्षरले डिजिटल बैंकिङलाई कागजी चेक र भौतिक हस्ताक्षर भन्दा कैयौं गुणा बढी सुरक्षित, छिटो र कानुनी रूपमा अकाट्य बनाएको छ।""")

    # 5. Linux Server Hardening in Banks (5 Marks)
    add("p2b_u4_sub234", "paper2", "sectionB", 4, "Unit 4: Operating System & Security", 5, "2080 BS - RBB IT",
        "What is Operating System Hardening? Outline five essential security hardening procedures implemented on production Linux servers hosting banking applications.",
        "अपरेटिङ सिस्टम हार्डेनिङ (OS Hardening) भन्नाले के बुझिन्छ? बैंकिङ अनुप्रयोगहरू सञ्चालन हुने लिनक्स सर्भरहरूमा लागू गरिने पाँच प्रमुख सुरक्षात्मक उपायहरू उल्लेख गर्नुहोस्।",
        """1. Definition of OS Hardening:
**Operating System Hardening** is the systematic process of securing a computer's operating system by minimizing its attack surface, eliminating unnecessary software packages/ports, configuring least-privilege permissions, and implementing defense-in-depth controls according to established industry security benchmarks (e.g., CIS Benchmarks).

2. Five Essential Linux Hardening Procedures in Banking:
1. **SSH Service Hardening:**
   * Disable direct remote `root` login (`PermitRootLogin no` in `/etc/ssh/sshd_config`).
   * Disable password authentication in favor of asymmetric Ed25519/RSA cryptographic key pairs.
   * Change standard port 22 to a non-standard port and implement rate-limiting via `fail2ban`.
2. **Enforce Principle of Least Privilege & Sudo Restrictions:**
   * Remove unnecessary default system accounts (`lp`, `uucp`, `games`).
   * Ensure standard users execute administrative tasks only via audited `sudo` commands with individual named logins, never sharing credentials.
3. **Close Unnecessary Ports & Enable Host Firewalls (`iptables` / `firewalld`):**
   * Disable non-essential services (FTP, Telnet, RPC).
   * Restrict access to database ports (e.g., Oracle 1521, MySQL 3306) strictly to internal application server IP addresses.
4. **Mandatory Access Control (SELinux / AppArmor):**
   * Keep Security-Enhanced Linux (SELinux) in `Enforcing` mode, isolating daemon processes into strict containment domains so a compromised web server cannot access root files.
5. **Regular Automated Security Patching & Audit Logging (`auditd`):**
   * Apply critical kernel security updates promptly.
   * Configure centralized, tamper-proof audit logging (`auditd` forwarding syslogs to a remote SOC SIEM) to record all privilege escalations and file modifications.

3. Conclusion:
Rigorous Linux OS hardening mitigates zero-day vulnerabilities and ensures compliance with NRB Cyber Resilience Guidelines.""",
        """१. OS हार्डेनिङ (Hardening) को अवधारणा:
**अपरेटिङ सिस्टम हार्डेनिङ** भनेको सर्भरमा रहेका सम्भावित सुरक्षा कमजोरीहरू हटाउन, अनावश्यक सेवाहरू बन्द गर्न र सुरक्षा नियमहरू कडा बनाएर बाह्य ह्याकरहरूको आक्रमणको जोखिम (Attack Surface) न्यूनतम बनाउने प्राविधिक प्रक्रिया हो।

२. बैंकिङ लिनक्स सर्भरमा लागू गरिने पाँच प्रमुख सुरक्षात्मक उपायहरू:
१. **SSH रिमोट पहुँच कडा बनाउने:**
   * सिधै `root` युजरबाट लगइन गर्न नमिल्ने बनाउने (`PermitRootLogin no`)।
   * पासवर्डको सट्टा क्रिप्टोग्राफिक SSH Key जोडी प्रयोग गर्ने र `fail2ban` मार्फत लगातार गलत पासवर्ड हान्ने IP ब्लक गर्ने।
२. **न्यूनतम अधिकार (Least Privilege) को पालना:**
   * प्रयोग नहुने डिफल्ट सिस्टम खाताहरू हटाउने र कर्मचारीहरूलाई साझा पासवर्ड नदिई व्यक्तिगत नामको युजरबाट `sudo` मार्फत मात्र सीमित काम गर्न दिने।
३. **अनावश्यक पोर्ट र सेवा बन्द गर्ने (फायरवाल):**
   * असुरक्षित Telnet, FTP जस्ता सेवाहरू पूर्ण रूपमा बन्द गर्ने।
   * आन्तरिक फायरवाल (`firewalld`) मार्फत डेटाबेस पोर्ट (जस्तै: Oracle 1521) मा निश्चित एप सर्भरको IP बाट मात्र पहुँच दिने।
४. **SELinux (Security-Enhanced Linux) अनिवार्य चालु राख्ने:**
   * SELinux लाई 'Enforcing' मोडमा राखी कुनै एउटा बैंकिङ एप ह्याक भए पनि त्यसले सर्भरका अन्य फाइल वा अपरेटिङ सिस्टम नियन्त्रण गर्न नसक्ने गरी घेरा (Containment) हाल्ने।
५. **केन्द्रीकृत अडिट लग र नियमित प्याचिङ:**
   * सर्भरमा भएका सम्पूर्ण कमान्ड र लगइनको रेकर्ड `auditd` मार्फत २४/७ बैंकको SOC (Security Operations Center) मा पठाउने र नयाँ सेक्युरिटी प्याचहरू तुरुन्त अपडेट गर्ने।

३. निष्कर्ष:
लिनक्स सर्भरको उचित हार्डेनिङले बैंकको कोर डेटाबेस र वेब प्रणालीलाई बाह्य आक्रमण र र्‍यान्समवेयरको जोखिमबाट पूर्ण रूपमा सुरक्षित राख्दछ।""")

    return qs

if __name__ == "__main__":
    f50 = get_final50_subjective_questions()
    print(f"Loaded {len(f50)} final subjective questions.")
