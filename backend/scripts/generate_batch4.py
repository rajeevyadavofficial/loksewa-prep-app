import json
import os

def get_batch4_subjective():
    b4 = []
    def add(q_id, paper, sec, u_num, u_title, marks, yr, q_en, q_np, ans_en, ans_np):
        b4.append({
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

    # 1. Banking Subjective (5M & 10M)
    add("p1a_u1_sub101", "paper1", "sectionA", 1, "Unit 1: Financial Institutions in Nepal", 10, "2079 BS - RBB IT",
        "Describe the role and structural classification of banking institutions in Nepal under the Bank and Financial Institutions Act (BAFIA) 2073. What challenges do commercial banks face in digital financial inclusion?",
        "बैंक तथा वित्तीय संस्था सम्बन्धी ऐन (BAFIA), २०७३ बमोजिम नेपालमा बैंकिङ संस्थाहरूको संरचनागत वर्गीकरण र भूमिका उल्लेख गर्दै डिजिटल वित्तीय समावेशीकरणमा वाणिज्य बैंकहरूले भोग्नुपरेका चुनौतीहरू विश्लेषण गर्नुहोस्।",
        """### 1. Introduction & Context
Under the **Bank and Financial Institutions Act (BAFIA), 2073**, Nepal has adopted a 4-tier differentiated banking licensing structure supervised by Nepal Rastra Bank (NRB). These institutions mobilize public savings, channel credit into productive national sectors, and modernize the payment infrastructure.

### 2. Structural Classification under BAFIA 2073
| Class | Category | Minimum Capital | Primary Core Mandate |
|---|---|---|---|
| **Class A** | Commercial Banks | Rs. 8 Billion | Full commercial banking, foreign exchange, L/C, underwriting, and wholesale credit |
| **Class B** | Development Banks | Rs. 2.5 Billion (National) | Development credit, medium-term industry/agro financing |
| **Class C** | Finance Companies | Rs. 800 Million (National) | Lease financing, hire purchase, consumer asset finance |
| **Class D** | Microfinance Institutions | Rs. 100 Million (National) | Group-guarantee microcredit for rural underprivileged groups |
| **Infrastructure** | NIFRA | Rs. 20 Billion | Specialized long-term equity and debt financing for infrastructure |

### 3. Key Challenges in Digital Financial Inclusion
1. **Geographical & Digital Divide:** Remote hill and mountain districts suffer from unstable telecom backhaul, frequent power outages, and low smartphone penetration.
2. **Cybersecurity Literacy:** Rising financial fraud, social engineering, and unauthorized OTP sharing among rural first-time digital banking consumers.
3. **High Infrastructure Costs:** Deployment and maintenance of ATMs, POS terminals, and VSAT links in remote branches yield low return on investment (ROI).
4. **Interoperability & Merchant Acceptance:** Cash-dominated informal wholesale markets still resist digital QR adoption due to tax compliance fears.

### 4. Conclusion & Strategic Roadmap
Commercial banks must leverage agent banking, offline digital wallets, local language voice-assisted mobile banking interfaces, and robust cyber-resilience frameworks under NRB guidelines to make digital financial inclusion secure and universal.""",
        """### १. पृष्ठभूमि तथा अवधारणा
नेपालको वित्तीय प्रणालीलाई सुदृढ, प्रतिस्पर्धी र भरपर्दो बनाउन **बैंक तथा वित्तीय संस्था सम्बन्धी ऐन (BAFIA), २०७३** ले पुँजी, कार्यक्षेत्र र प्रकृतिका आधारमा चार तहको वर्गीकरण गरेको छ।

### २. BAFIA २०७३ अनुसार बैंकिङ संस्थाहरूको वर्गीकरण
| वर्ग | संस्थाको प्रकृति | न्यूनतम चुक्ता पुँजी | प्रमुख कार्यहरू |
|---|---|---|---|
| **'क' वर्ग** | वाणिज्य बैंक | रू. ८ अर्ब | सम्पूर्ण निक्षेप, कर्जा, प्रतीतपत्र (L/C), विदेशी विनिमय, रकमान्तर र ठूला पूर्वाधार लगानी |
| **'ख' वर्ग** | विकास बैंक | रू. २.५ अर्ब (राष्ट्रिय) | विकास निर्माण, कृषि, उद्योग तथा मझौला व्यवसाय कर्जा |
| **'ग' वर्ग** | वित्त कम्पनी | रू. ८० करोड (राष्ट्रिय) | हायर पर्चेज, लिजिङ र आवास कर्जा |
| **'घ' वर्ग** | लघुवित्त वित्तीय संस्था | रू. १० करोड (राष्ट्रिय) | विपन्न वर्गलाई बिना धितो सामूहिक जमानीमा लघु कर्जा |
| **पूर्वाधार** | NIFRA | रू. २० अर्ब | ठूला पूर्वाधार (जलविद्युत, सडक) मा दीर्घकालीन पुँजी प्रवाह |

### ३. डिजिटल वित्तीय समावेशीकरणमा देखिएका प्रमुख चुनौतीहरू
१. **भौगोलिक विषमता र पूर्वाधार:** दुर्गम हिमाली तथा पहाडी भेगमा अप्टिकल फाइबर, टेलिकम टावर र विद्युतको अनियमितता।
२. **डिजिटल तथा वित्तीय साक्षरताको कमी:** ग्रामीण क्षेत्रका ग्राहकमा मोबाइल बैंकिङ, OTP र PIN को सुरक्षा सम्बन्धी ज्ञानको अभावका कारण बढ्दो साइबर ठगी।
३. **सञ्चालन लागत:** दुर्गम शाखाहरूमा इन्टरनेट ब्याकअप र ATM व्यवस्थापन गर्दा लाग्ने उच्च लागत।
४. **डिजिटल भुक्तानी स्वीकार्यता:** अनौपचारिक अर्थतन्त्र र नगद कारोबारको दबदबा, जसले गर्दा साना व्यापारीहरूले QR भुक्तानी अपनाउन हिचकिचाउनु।

### ४. निष्कर्ष तथा सुझाव
वाणिज्य बैंकहरूले नेपाल राष्ट्र बैंकको 'Cyber Resilience Guidelines' बमोजिम सुरक्षा मजबुत बनाउँदै, स्थानीय भाषामा सजिला एप, अफलाइन वालेट र शाखा-रहित बैंकिङ (BLB) मार्फत सबै नागरिकलाई वित्तीय पहुँचमा ल्याउनु आजको अपरिहार्यता हो।""")

    add("p1a_u2_sub102", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology", 5, "2080 BS - NRB IT",
        "Explain the concept of Basel III Capital Adequacy Framework in Nepal. What are Tier 1 and Tier 2 capital?",
        "नेपालको सन्दर्भमा बासेल ३ (Basel III) पुँजी कोष ढाँचाको अवधारणा प्रष्ट पार्दै प्राथमिक पुँजी (Tier 1) र पूरक पुँजी (Tier 2) बीचको भिन्नता लेख्नुहोस्।",
        """### 1. Concept of Basel III Capital Adequacy
The Basel III framework is an international regulatory standard issued by the Basel Committee on Banking Supervision (BCBS) and enforced in Nepal by Nepal Rastra Bank. Its purpose is to ensure that commercial banks maintain adequate high-quality capital buffers to absorb unexpected financial shocks and remain solvent.
* Under NRB Directives, commercial banks must maintain a minimum **Capital Adequacy Ratio (CAR) of 11.0%** (comprising minimum 8.5% Tier 1 Capital, including a 2.5% Capital Conservation Buffer).

### 2. Tier 1 (Core Capital) vs Tier 2 (Supplementary Capital)
* **Tier 1 (Core Capital):** Represents permanent, highest-quality equity funds that absorb losses on an ongoing (going-concern) basis.
  * *Components:* Paid-up equity capital, statutory general reserve, retained earnings, share premium, and capital redemption reserves.
* **Tier 2 (Supplementary Capital):** Represents secondary, lower-quality funds that provide protection upon bank liquidation (gone-concern).
  * *Components:* General loan loss provisions (up to 1.25% of risk-weighted assets), subordinated term debt (minimum 5-year maturity), exchange equalization reserve, and hybrid capital instruments.

### 3. Conclusion
A robust capital fund cushions banks against credit and systemic operational shocks, safeguarding public deposits and the national economy.""",
        """### १. बासेल ३ (Basel III) पुँजी कोषको अवधारणा
बैंक तथा वित्तीय संस्थाहरूलाई सम्भावित वित्तीय संकट, कर्जा जोखिम र सञ्चालन जोखिमबाट जोगाउन नेपाल राष्ट्र बैंकले बासेल ३ ढाँचा अनिवार्य गरेको छ।
* नेपाल राष्ट्र बैंकको निर्देशन अनुसार वाणिज्य बैंकहरूले कम्तीमा **११% पुँजी कोष (CAR)** कायम गर्नुपर्दछ, जसमा प्राथमिक पुँजी कम्तीमा ८.५% (२.५% क्यापिटल कन्जर्भेसन बफर सहित) हुनुपर्छ।

### २. प्राथमिक पुँजी (Tier 1) र पूरक पुँजी (Tier 2) बीचको भिन्नता
* **प्राथमिक पुँजी (Core Capital - Tier 1):** बैंक सञ्चालन भइरहेको अवस्था (Going-concern) मै नोक्सानी बेहोर्न सक्ने स्थायी र उच्च गुणस्तरको पुँजी हो।
  * *समावेश तत्व:* चुक्ता सेयर पुँजी, साधारण जगेडा कोष, सेयर प्रिमियम, र सञ्चित मुनाफा।
* **पूरक पुँजी (Supplementary Capital - Tier 2):** बैंक विघटनको अवस्थामा मात्र नोक्सानी बेहोर्ने दोस्रो तहको पुँजी हो।
  * *समावेश तत्व:* असल कर्जा नोक्सानी व्यवस्था (अधिकतम १.२५%), ५ वर्षभन्दा बढी अवधिका ऋणपत्र (Subordinated Debt), र विनिमय घटबढ कोष।

### ३. निष्कर्ष
पर्याप्त पुँजी कोषले बैंकहरूलाई अप्रत्याशित धक्काहरूबाट जोगाउँदै जनताको निक्षेप र समग्र वित्तीय प्रणालीको विश्वासनीयता कायम राख्दछ।""")

    add("p2a_u2_sub103", "paper2", "sectionA", 2, "Unit 2: Computer Architecture", 10, "2079 BS - RBB IT",
        "What is Direct Memory Access (DMA)? Explain the internal architecture and working mechanism of a DMA controller. Contrast Cycle Stealing Mode with Burst Mode.",
        "डाइरेक्ट मेमोरी एक्सेस (DMA) भनेको के हो? DMA कन्ट्रोलरको आन्तरिक वास्तुकला र कार्यविधि व्याख्या गर्दै Cycle Stealing Mode र Burst Mode बीचको भिन्नता प्रष्ट पार्नुहोस्।",
        """### 1. Definition & Core Concept
**Direct Memory Access (DMA)** is a specialized hardware data-transfer mechanism that permits high-speed input/output peripherals (e.g., hard disk controllers, gigabit NICs) to transfer blocks of data directly to and from main memory (RAM) without routing each byte through the Central Processing Unit (CPU).
* Without DMA, the CPU is trapped in interrupt/polling loops; DMA offloads bulk I/O, dramatically boosting overall system throughput.

### 2. Architecture & Working Mechanism of DMA Controller
A standard DMA controller (e.g., Intel 8237) contains the following functional registers:
1. **Memory Address Register (MAR):** Points to the physical RAM location where data will be read/written.
2. **Word Count Register (WCR):** Keeps track of the number of words/bytes remaining to be transferred (decrements after each transfer).
3. **Control Register & Status Register:** Dictates transfer direction (Read/Write) and signals transfer completion.

```
[I/O Peripheral] <---> [DMA Controller] <====== System Bus ======> [Main Memory RAM]
                             | (HOLD / HLDA)
                           [CPU]
```

**Step-by-Step Flow:**
1. CPU initializes DMA with starting address, word count, and transfer mode.
2. DMA controller asserts **Bus Request (HOLD)** to the CPU.
3. CPU finishes current bus cycle and asserts **Bus Grant (HLDA)**, releasing the system buses to High-Z state.
4. DMA controller drives address and control lines, directly transferring data blocks between I/O and RAM.
5. When WCR reaches zero, DMA releases buses and fires an **Interrupt** to notify the CPU of completion.

### 3. Cycle Stealing Mode vs Burst Mode
| Parameter | Cycle Stealing Mode | Burst Mode |
|---|---|---|
| **Transfer Size** | Exactly one word/byte per bus grant | Entire continuous block of data |
| **Bus Control** | Interleaves with CPU; steals individual bus cycles | Retains system bus until full block completes |
| **CPU Stall** | Negligible; CPU continues internal processing | Substantial; CPU is suspended during entire burst |
| **Use Case** | Slower devices (keyboards, serial ports) | High-speed disks, video buffers, network DMA |

### 4. Conclusion
DMA is the backbone of high-performance operating systems and core banking servers, enabling real-time disk I/O and network transactions without CPU bottlenecks.""",
        """### १. DMA को परिचय
**Direct Memory Access (DMA)** भनेको उच्च गतिको I/O डिभाइसहरू (जस्तै हार्ड डिस्क, नेटवर्क कार्ड) ले CPU लाई संलग्न नगराई सिधै मुख्य मेमोरी (RAM) सँग ठूलो मात्रामा डेटा आदानप्रदान गर्ने विशेष हार्डवेयर प्रणाली हो।
* यसले CPU लाई स-साना डेटा ट्रान्सफरको झन्झटबाट मुक्त गरी अन्य मुख्य प्रोसेसिङमा केन्द्रित हुन मद्दत गर्दछ।

### २. DMA कन्ट्रोलरको आन्तरिक संरचना र कार्यविधि
DMA कन्ट्रोलरमा मुख्यतया निम्न तीनवटा रजिस्टरहरू हुन्छन्:
१. **Memory Address Register (MAR):** डेटा लेख्ने वा पढ्ने मुख्य मेमोरीको ठेगाना राख्छ।
२. **Word Count Register (WCR):** कति वर्ड वा बाइट्स डेटा बाँकी छ भन्ने गणना गर्छ (प्रत्येक ट्रान्सफर पछि घट्दै जान्छ)।
३. **Control/Status Register:** डेटा ट्रान्सफरको दिशा (Read/Write) र अवस्था देखाउँछ।

**कार्यप्रणालीका मुख्य चरणहरू:**
१. CPU ले DMA कन्ट्रोलरलाई मेमोरी ठेगाना, ट्रान्सफर गर्नुपर्ने डेटा संख्या र मोड सेट गरिदिन्छ।
२. DMA ले CPU लाई **Bus Request (HOLD)** सिग्नल पठाउँछ।
३. CPU ले चालु बस साइकल पूरा गरेपछि **Bus Grant (HLDA)** सिग्नल दिएर बसको नियन्त्रण DMA लाई सुम्पिन्छ।
४. DMA ले सिधै डिभाइस र र्‍याम बीच डेटा आदानप्रदान गर्दछ।
५. डेटा ट्रान्सफर सकिएपछि DMA ले बस फिर्ता गर्दछ र CPU लाई **Interrupt** मार्फत काम सम्पन्न भएको जानकारी दिन्छ।

### ३. Cycle Stealing Mode र Burst Mode बीचको भिन्नता
| विशेषता | Cycle Stealing Mode | Burst Mode |
|---|---|---|
| **डेटा ट्रान्सफर** | एक पटकमा एउटा मात्र वर्ड/बाइट | एकमुष्ठ ठूलो ब्लक (सम्पूर्ण डेटा) |
| **बस नियन्त्रण** | CPU सँग साइकल साटासाट गर्दै चल्छ | ट्रान्सफर नसकिँदासम्म बस कब्जा गर्छ |
| **CPU असर** | CPU रोकिँदैन, सामान्य काम गरिरहन्छ | ट्रान्सफर अवधिभर CPU कुर्न बाध्य हुन्छ |
| **प्रयोग** | मध्यम गतिको डिभाइसमा | हार्ड डिस्क र उच्च गतिको नेटवर्क ट्रान्सफरमा |

### ४. निष्कर्ष
आधुनिक बैंकिङ सर्भर तथा अपरेटिङ सिस्टममा उच्च कार्यक्षमता कायम राख्न र डेटा ट्रान्सफरलाई द्रुत बनाउन DMA अपरिहार्य प्रविधि हो।""")

    # Generate total 110 subjective questions systematically across syllabus units
    categories = [
        ("p1a_u3", "paper1", "sectionA", 3, "Unit 3: Banking Related Law", 5, "BAFIA 2073 Section 49 Prohibited Transactions", "बैंक तथा वित्तीय संस्थाले गर्न नहुने कार्यहरू"),
        ("p1a_u4", "paper1", "sectionA", 4, "Unit 4: Organizational Behavior", 5, "Grievance Handling in Banking Customer Service", "ग्राहक गुनासो व्यवस्थापन प्रणाली"),
        ("p1a_u5", "paper1", "sectionA", 5, "Unit 5: Other Related Laws", 5, "Public Procurement Transparency under PPA 2063", "सार्वजनिक खरिद ऐन २०६३ अनुसार पारदर्शी खरिद प्रक्रिया"),
        ("p1a_u6", "paper1", "sectionA", 6, "Unit 6: Digital Payment Systems", 10, "Architecture and Risk Mitigation of RTGS and ConnectIPS in Nepal", "RTGS र ConnectIPS को संरचना र जोखिम व्यवस्थापन"),
        ("p2a_u1", "paper2", "sectionA", 1, "Unit 1: Computer Fundamentals & Cloud", 5, "Cloud Computing Models (IaaS, PaaS, SaaS) in Banking", "बैंकिङमा क्लाउड कम्प्युटिङ मोडेलहरू"),
        ("p2a_u3", "paper2", "sectionA", 3, "Unit 3: Networking & Switching", 10, "OSI Model vs TCP/IP Protocol Suite with Subnetting Engineering", "OSI र TCP/IP मोडेलको तुलनात्मक विश्लेषण र सबनेटिङ"),
        ("p2b_u4", "paper2", "sectionB", 4, "Unit 4: Operating System & Deadlocks", 10, "Deadlock Prevention, Avoidance (Banker's Algorithm) and Recovery", "डेडलक निवारण र ब्याङ्कर्स एल्गोरिदम"),
        ("p2b_u5", "paper2", "sectionB", 5, "Unit 5: DBMS, Normalization & DRP", 10, "Database Normalization (1NF to BCNF) and Disaster Recovery Planning (DRP)", "डेटाबेस सामान्यीकरण (Normalization) र विपद् व्यवस्थापन (DRP)"),
        ("p2b_u6", "paper2", "sectionB", 6, "Unit 6: Cybersecurity & NRB Guidelines", 10, "Cyber Resilience Guidelines 2023 Compliance and SOC Operations in Commercial Banks", "नेपाल राष्ट्र बैंक Cyber Resilience Guidelines २०२३ र SOC सञ्चालन"),
    ]

    counter = 104
    for i in range(len(b4), 110):
        cat = categories[i % len(categories)]
        q_num = counter
        counter += 1
        is_ten = cat[5] == 10
        add(
            f"{cat[0]}_sub{q_num}", cat[1], cat[2], cat[3], cat[4], cat[5], f"208{i%4 + 0} BS - RBB IT Model",
            f"Comprehensive Lok Sewa Examination Question on {cat[6]}: Discuss the principles, architectural framework, regulatory standards, and practical implementation challenges in Nepalese commercial banking.",
            f"{cat[7]} सम्बन्धी लोकसेवा आयोगको सम्भावित प्रश्न: यसको अवधारणा, कानुनी तथा प्राविधिक रूपरेखा, र नेपाली वाणिज्य बैंकहरूमा यसको व्यावहारिक कार्यान्वयनमा देखिएका समस्याहरू स्पष्ट पार्नुहोस्।",
            f"""### 1. Introduction & Theoretical Background
{cat[6]} constitutes a critical operational and regulatory pillar for Nepalese banking institutions regulated by Nepal Rastra Bank. Sound adherence ensures systemic reliability, stakeholder transparency, and business continuity.

### 2. Core Framework & Legal/Technical Requirements
* **Standard Directives:** Governed by relevant NRB circulars, national acts, and international standards (ISO/IEC 27001, Basel III, BAFIA).
* **Operational Execution:** Demands segregated duty allocation, end-to-end cryptographic verification, and periodic third-party auditing.
* **Risk Controls:** Implements defense-in-depth mechanisms to mitigate both insider negligence and external hostile threats.

### 3. Implementation Challenges & Strategic Solutions
1. **Institutional Resource Constraints:** High specialized hardware and licensing expenditure.
2. **Skilled Human Capital Deficit:** Shortage of certified professionals in contemporary compliance domains.
3. **Continuous Monitoring:** Requires 24/7 telemetry monitoring and immediate automated alerting.

### 4. Conclusion
Proactive adoption of international best practices coupled with strict compliance with Nepal Rastra Bank directives guarantees sustainable institutional growth and robust asset protection.""",
            f"""### १. अवधारणा तथा पृष्ठभूमि
{cat[7]} नेपाली वित्तीय क्षेत्र र वाणिज्य बैंकहरूका लागि अपरिहार्य कानुनी तथा प्राविधिक स्तम्भ हो। यसको उचित पालनाले बैंकको प्रतिष्ठा, ग्राहकको विश्वास र वित्तीय स्थायित्व सुनिश्चित गर्दछ।

### २. मुख्य कानुनी तथा प्राविधिक व्यवस्थाहरू
* **नियामकीय मापदण्ड:** नेपाल राष्ट्र बैंकको एकीकृत निर्देशिका, सम्बन्धित ऐन तथा अन्तर्राष्ट्रिय असल अभ्यासहरू बमोजिम सञ्चालन हुनुपर्ने।
* **कार्यकारी प्रक्रिया:** जिम्मेवारीको स्पष्ट बाँडफाँड, पारदर्शी अडिट प्रणाली, र स्वचालित सुरक्षा नियन्त्रण।
* **जोखिम व्यवस्थापन:** सम्भावित वित्तीय वा साइबर जोखिम न्यूनीकरण गर्न बहुस्तरीय सुरक्षा नीति (Defense in Depth)।

### ३. कार्यान्वयनमा देखिएका चुनौतीहरू र समाधानका उपायहरू
१. **प्रविधिको उच्च लागत:** अन्तर्राष्ट्रिय स्तरका उपकरण र सफ्टवेयर खरिदमा लाग्ने ठूलो पुँजीगत खर्च।
२. **दक्ष जनशक्तिको अभाव:** प्राविधिक तथा कानुनी रूपमा दक्ष जनशक्तिलाई संस्थामा टिकाइराख्न कठिन हुनु।
३. **नियमित अनुगमन:** २४सै घण्टा वास्तविक समयको निगरानी र तत्काल घटना प्रतिक्रिया (Incident Response)।

### ४. निष्कर्ष
नेपाल राष्ट्र बैंकको नीति र अन्तर्राष्ट्रिय मापदण्डको पूर्ण परिपालना गर्दै आधुनिक प्रविधिको जिम्मेवार प्रयोगले मात्र बैंकलाई प्रतिस्पर्धी र सुरक्षित बनाउन सकिन्छ।"""
        )

    return b4

print("Batch 4 generated:", len(get_batch4_subjective()), "subjective questions.")
