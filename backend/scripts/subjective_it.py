# -*- coding: utf-8 -*-
"""
Comprehensive Lok Sewa Technical IT Subjective Questions and Model Answers for Paper II & Paper I Sec B
Covers Computer Architecture, Networking, Operating Systems, DBMS, Cybersecurity,
and NRB Cyber Resilience Guidelines 2023.
"""

def get_it_subjective_questions():
    questions = []

    def add_q(q_id, paper, sec, u_num, u_title, marks, yr, q_en, q_np, ans_en, ans_np):
        questions.append({
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

    # --- TOPIC 1: OSI Model vs TCP/IP (10 Marks) ---
    add_q("p2a_u3_sub201", "paper2", "sectionA", 3, "Unit 3: Communication & Computer Networks", 10, "2078 BS - RBB IT",
        "Compare and contrast the 7-layer OSI Reference Model with the 4-layer TCP/IP Protocol Suite. Explain the Protocol Data Unit (PDU) and addressing mechanism at each layer.",
        "OSI मोडलका ७ तहहरू र TCP/IP प्रोटोकल सुटका ४ तहहरू बीचको तुलनात्मक विश्लेषण गर्दै प्रत्येक तहमा प्रयोग हुने Protocol Data Unit (PDU) र ठेगाना प्रणाली (Addressing) व्याख्या गर्नुहोस्।",
        """1. Introduction & Theoretical Origin:
* **OSI (Open Systems Interconnection) Model:** Developed by ISO in 1984 as a theoretical 7-layer conceptual reference framework for open network protocol design.
* **TCP/IP Protocol Suite:** Developed by DoD/DARPA in the 1970s as a pragmatic 4-layer implementation suite that forms the practical architectural backbone of the global Internet.

2. Comprehensive Layer Comparison Matrix:
| OSI 7-Layer Model | TCP/IP 4-Layer Model | Protocol Data Unit (PDU) | Addressing Mechanism | Prominent Protocols |
|---|---|---|---|---|
| **7. Application**<br>**6. Presentation**<br>**5. Session** | **Application Layer** | **Data / Message** | Process ID / Port Number / Domain Name | HTTP, HTTPS, DNS, SMTP, FTP, SSH |
| **4. Transport Layer** | **Transport Layer** | **Segment** (TCP) / **Datagram** (UDP) | Port Address (16-bit: e.g., 443, 80) | TCP, UDP |
| **3. Network Layer** | **Internet Layer** | **Packet** | Logical IP Address (32-bit IPv4 / 128-bit IPv6) | IP, ICMP, ARP, OSPF, BGP |
| **2. Data Link Layer**<br>**1. Physical Layer** | **Network Access Layer** (Link Layer) | **Frame** (Layer 2)<br>**Bits** (Layer 1) | Physical MAC Address (48-bit hex)<br>Signal / Pinout / Voltages | Ethernet (802.3), Wi-Fi (802.11), PPP |

3. Key Architectural Differences:
* **Theoretical vs Practical:** OSI is a strict conceptual guideline designed before protocols were created; TCP/IP was created after protocols were operational, making TCP/IP the def facto global standard.
* **Session & Presentation Separation:** OSI explicitly separates Presentation (data format, encryption/decryption, compression) and Session (connection establishment, checkpointing). TCP/IP integrates both into the Application Layer.
* **Service Model:** OSI supports both connection-oriented and connectionless services at both Network and Transport layers. In TCP/IP, the Internet layer is strictly connectionless (IP), while Transport offers either connection-oriented (TCP) or connectionless (UDP).

4. Practical Significance in Core Banking:
In core banking networks (e.g., RBB CBS), understanding layers enables precise fault isolation: Physical/Link failures (cable/switch down), Network failures (routing/VPN tunnel drops), and Transport/App failures (TLS certificate expiry, port 443 firewall block).

5. Conclusion:
While TCP/IP drives practical internet engineering, the OSI model remains the gold standard for troubleshooting, security architecture, and protocol analysis in modern financial institutions.""",
        """१. परिचय तथा अवधारणात्मक पृष्ठभूमि:
* **OSI (Open Systems Interconnection) मोडल:** ISO द्वारा सन् १९८४ मा प्रतिपादित ७ तहको सैद्धान्तिक ढाँचा हो, जसले कम्प्युटरहरू बीचको सञ्चारलाई मानक बनाउँछ।
* **TCP/IP प्रोटोकल सुट:** अमेरिकी रक्षा विभाग (DoD/DARPA) द्वारा सन् १९७० को दशकमा विकसित ४ तहको व्यावहारिक ढाँचा हो, जसले आजको सम्पूर्ण इन्टरनेट सञ्चालन गरिरहेको छ।

२. OSI र TCP/IP को तुलनात्मक तालिका, PDU र ठेगाना प्रणाली:
| OSI ७-तह मोडल | TCP/IP ४-तह मोडल | Protocol Data Unit (PDU) | ठेगाना प्रणाली (Addressing) | प्रमुख प्रोटोकलहरू |
|---|---|---|---|---|
| **७. Application**<br>**६. Presentation**<br>**५. Session** | **Application Layer** | **Data / Message** | पोर्ट नम्बर / डोमेन नाम | HTTP, HTTPS, DNS, SMTP, FTP, SSH |
| **४. Transport Layer** | **Transport Layer** | **Segment** (TCP) / **Datagram** (UDP) | पोर्ट ठेगाना (16-bit: जस्तै 443, 80) | TCP, UDP |
| **३. Network Layer** | **Internet Layer** | **Packet** | तार्किक IP ठेगाना (IPv4 / IPv6) | IP, ICMP, ARP, OSPF, BGP |
| **२. Data Link Layer**<br>**१. Physical Layer** | **Network Access Layer** (Link Layer) | **Frame** (Layer 2)<br>**Bits** (Layer 1) | भौतिक MAC ठेगाना (48-bit hex)<br>विद्युतीय तरंग / संकेत | Ethernet, Wi-Fi, PPP, फाइबर अप्टिक |

३. मुख्य वास्तुकला भिन्नता:
* **सैद्धान्तिक बनाम व्यावहारिक:** OSI मोडल प्रोटोकल बन्नु अगाडि बनेको सैद्धान्तिक मार्गदर्शक हो, तर TCP/IP प्रोटोकलहरूको सफल प्रयोग पछि बनेको व्यावहारिक मानक हो।
* **तहहरूको संयोजन:** OSI मा Presentation (इन्क्रिप्सन, कम्प्रेसन) र Session तह छुट्टाछुट्टै हुन्छन् भने TCP/IP मा यी दुवैलाई Application तह भित्रै गाभिएको छ।
* **सेवाको प्रकृति:** OSI ले नेटवर्क र ट्रान्सपोर्ट दुवै तहमा कनेक्सन-उन्मुख र कनेक्सन-रहित दुवै सेवा दिन्छ। TCP/IP मा इन्टरनेट तह सधैं कनेक्सन-रहित (IP) हुन्छ भने ट्रान्सपोर्ट तहमा मात्र दुवै विकल्प (TCP वा UDP) उपलब्ध हुन्छन्।

४. बैंकिङ क्षेत्रमा यसको उपादेयता:
बैंकको कोर बैंकिङ प्रणाली (CBS) र ATM नेटवर्कमा समस्या आउँदा कुन तहमा खराबी आयो भनी पहिचान गर्न यो वर्गीकरण अपरिहार्य हुन्छ (जस्तै: केबल चुँडिनु Physical, गलत IP हुनु Network, फायरवालले पोर्ट रोक्नु Transport/Application)।

५. निष्कर्ष:
TCP/IP ले वास्तविक संसारको इन्टरनेट चलाउँछ भने OSI ले नेटवर्क इन्जिनियरहरूलाई समस्या पहिचान, सुरक्षा डिजाइन र प्रणालीगत बुझाइमा स्पष्ट मार्गदर्शन गर्दछ।""")

    # --- TOPIC 2: Database Normalization (10 Marks) ---
    add_q("p2b_u5_sub202", "paper2", "sectionB", 5, "Unit 5: DBMS, Data Warehousing & DRP", 10, "2079 BS - RBB IT",
        "Explain Database Normalization. Walk through the progression from Unnormalized Form (UNF) through 1NF, 2NF, 3NF to BCNF using a banking customer-account relational example. What are insertion, deletion, and update anomalies?",
        "डेटाबेस सामान्यीकरण (Database Normalization) भन्नाले के बुझिन्छ? एउटा बैंकिङ ग्राहक-खाताको उदाहरण दिँदै UNF देखि 1NF, 2NF, 3NF हुँदै BCNF सम्मको चरणबद्ध प्रक्रिया व्याख्या गर्नुहोस्। साथै इन्सर्सन, डिलिसन र अपडेट एनोमलीहरू प्रष्ट पार्नुहोस्।",
        """1. Definition & Core Purpose of Normalization:
**Database Normalization** is a systematic algebraic and relational design technique introduced by E.F. Codd to decompose complex database schemas into smaller, well-structured tables to:
1. Eliminate data redundancy (duplicate storage).
2. Eliminate data anomalies (insertion, deletion, modification).
3. Ensure functional and referential dependencies make logical sense.

2. The Three Database Anomalies:
Consider an unnormalized table: `Bank_Branch(Account_No, Cust_Name, Cust_Phone, Branch_Code, Branch_City, Manager_Name)`
* **Insertion Anomaly:** A new branch cannot be added into the database unless at least one customer opens an account there (because `Account_No` is primary key and cannot be null).
* **Deletion Anomaly:** If customer 'Ram' closes his account and the row is deleted, the entire branch information and manager name are permanently erased from the bank's records.
* **Update / Modification Anomaly:** If the Branch Manager changes, every single customer record assigned to that branch must be updated; failing to update one row causes inconsistent data.

3. Step-by-Step Normalization Progression:

A. First Normal Form (1NF) - Atomic Values:
* *Rule:* Eliminate multi-valued attributes and repeating groups. Each attribute must contain only single atomic values.
* *Banking Example:* A customer with multiple phone numbers `[9841..., 9801...]` is split so each row contains exactly one phone number.

B. Second Normal Form (2NF) - No Partial Dependency:
* *Rule:* Must be in 1NF, and all non-key attributes must be fully functionally dependent on the ENTIRE primary key (eliminates partial dependency on composite keys).
* *Banking Example:* Given composite primary key `(Account_No, Service_ID)`:
  * Customer Name depends only on `Account_No` (Partial dependency $\to$ violates 2NF).
  * Decomposed into:
    1. `Account(Account_No, Cust_Name, Branch_Code)`
    2. `Account_Services(Account_No, Service_ID, Activated_Date)`

C. Third Normal Form (3NF) - No Transitive Dependency:
* *Rule:* Must be in 2NF, and no non-prime attribute should depend transitively on the primary key ($X \\to Y \\to Z$). "Every non-key must depend on the key, the whole key, and nothing but the key."
* *Banking Example:* In `Account(Account_No, Cust_Name, Branch_Code, Branch_City, Manager_Name)`:
  * `Account_No` determines `Branch_Code`, and `Branch_Code` determines `Branch_City` and `Manager_Name`.
  * Transitive dependency exists. Decomposed into:
    1. `Account(Account_No, Cust_Name, Branch_Code)`
    2. `Branch(Branch_Code, Branch_City, Manager_Name)`

D. Boyce-Codd Normal Form (BCNF) - Strict Determinants:
* *Rule:* Must be in 3NF, and for every functional dependency $X \\to Y$, determinant $X$ MUST be a superkey / candidate key.

4. Trade-off: Normalization vs Denormalization:
While OLTP (Core Banking) requires high normalization (3NF/BCNF) for atomic transactional consistency, OLAP (Data Warehousing) deliberately employs denormalized star/snowflake schemas to reduce expensive multi-table joins for executive analytics.

5. Conclusion:
Proper relational normalization ensures data integrity, minimizes disk bloat, and provides ACID compliance essential for trusted banking ledgers.""",
        """१. डेटाबेस सामान्यीकरण (Normalization) को परिभाषा:
**डेटाबेस सामान्यीकरण (Normalization)** भनेको रिलेसनल डेटाबेसमा अनावश्यक डेटा दोहोरिन (Redundancy) रोक्न र डेटा विसंगति (Anomalies) हटाउन टेबलहरूलाई नियमबद्ध रूपमा विभाजन गर्ने वैज्ञानिक विधि हो।

२. तीन प्रकारका डेटा विसंगतिहरू (Anomalies):
मानौं एउटै टेबल छ: `Customer_Account(खाता_नं, ग्राहक_नाम, शाखा_कोड, शाखा_ठेगाना, प्रबन्धक_नाम)`
* **Insertion Anomaly (प्रविष्टि विसंगति):** नयाँ शाखा खुल्यो तर त्यसमा खाता खोल्ने ग्राहक नभएसम्म शाखाको विवरण डेटाबेसमा दर्ता गर्न सकिँदैन (किनकि खाता_नं Primary Key हो र Null हुन सक्दैन)।
* **Deletion Anomaly (हटाउने विसंगति):** कुनै ग्राहकले खाता बन्द गरेर उसको रेकर्ड मेटाउँदा सो शाखाको अस्तित्व र प्रबन्धकको नाम समेत डेटाबेसबाट सदाका लागि हराउँछ।
* **Update Anomaly (अद्यावधिक विसंगति):** शाखा प्रबन्धक परिवर्तन हुँदा सो शाखाका हजारौं ग्राहकका प्रत्येक लाइनमा नाम सच्याउनु पर्छ; एउटामा छुट्यो भने डेटाबेस बाझिन्छ।

३. चरणबद्ध सामान्यीकरण प्रक्रिया (बैंकिङ उदाहरण सहित):

क. पहिलो सामान्यीकरण फारम (1NF - Atomic Values):
* *नियम:* कुनै पनि कोठा (Cell) मा एक भन्दा बढी मान (Repeating Groups) हुन पाउँदैन। प्रत्येक मान अविभाज्य (Atomic) हुनुपर्छ।
* *उदाहरण:* एउटै ग्राहकको फोन नम्बर कोठामा दुईवटा नम्बर छन् भने तिनलाई छुट्टाछुट्टै पङ्क्तिमा विभाजन गरिन्छ।

ख. दोस्रो सामान्यीकरण फारम (2NF - No Partial Dependency):
* *नियम:* टेबल 1NF मा हुनुपर्छ र संयुक्त प्राथमिक साँचो (Composite Primary Key) को कुनै एक भागमा मात्र निर्भर हुने आंशिक निर्भरता हुनुहुँदैन।
* *उदाहरण:* यदि `(खाता_नं, कार्ड_नं)` मिलेर मुख्य साँचो बनेको छ, तर 'ग्राहक_नाम' खाता_नं मा मात्र निर्भर हुन्छ भने त्यसलाई छुट्ट्याएर दुईवटा टेबल बनाइन्छ:
  १. `Account(खाता_नं, ग्राहक_नाम, शाखा_कोड)`
  २. `Card_Mapping(खाता_नं, कार्ड_नं, जारी_मिति)`

ग. तेस्रो सामान्यीकरण फारम (3NF - No Transitive Dependency):
* *नियम:* टेबल 2NF मा हुनुपर्छ र कुनै गैर-प्रमुख विशेषता अर्को गैर-प्रमुख विशेषतामा निर्भर (Transitive Dependency) हुन पाउँदैन।
* *उदाहरण:* `Account(खाता_नं, ग्राहक_नाम, शाखा_कोड, शाखा_सहर, प्रबन्धक)` मा:
  * खाता_नं ले शाखा_कोड निर्धारण गर्छ, र शाखा_कोड ले शाखा_सहर र प्रबन्धक निर्धारण गर्छ। यो ट्रान्जिटिभ निर्भरता हो।
  * यसलाई हटाउन दुई टेबल बनाइन्छ:
    १. `Account(खाता_नं, ग्राहक_नाम, शाखा_कोड)`
    २. `Branch(शाखा_कोड, शाखा_सहर, प्रबन्धक)`

घ. BCNF (Boyce-Codd Normal Form):
* *नियम:* प्रत्येक फङ्सनल डिपेन्डेन्सी $X \\to Y$ मा बायाँ तर्फको $X$ अनिवार्य रूपमा सुपर कि (Super Key / Candidate Key) हुनै पर्छ।

४. निष्कर्ष:
कोर बैंकिङ प्रणाली (CBS) मा डेटाको शुद्धता, अखण्डता र ACID कारोबार सुनिश्चित गर्न तेस्रो सामान्यीकरण फारम (3NF/BCNF) अनिवार्य आधार हो।""")

    # --- TOPIC 3: Operating Systems Deadlocks & Banker's Algorithm (10 Marks) ---
    add_q("p2b_u4_sub203", "paper2", "sectionB", 4, "Unit 4: Operating System & Deadlocks", 10, "2081 BS - NRB IT",
        "What is a Deadlock in operating systems? Discuss the four Coffman conditions necessary for deadlock to arise. Detail how Dijkstra's Banker's Algorithm avoids deadlocks in resource allocation.",
        "अपरेटिङ सिस्टममा डेडलक (Deadlock) भन्नाले के बुझिन्छ? डेडलक उत्पन्न हुनका लागि आवश्यक चारवटा कफम्यान सर्तहरू (Coffman Conditions) उल्लेख गर्दै डिक्सट्राको ब्याङ्कर्स एल्गोरिदमले कसरी डेडलक निवारण गर्दछ भनी व्याख्या गर्नुहोस्।",
        """1. Definition of Deadlock:
A **Deadlock** is a permanent stall state in a multi-programming operating system where a set of active processes are blocked forever because each process is holding at least one allocated resource and waiting to acquire another resource currently held by another process in the same set.

2. The Four Necessary Coffman Conditions:
A deadlock can occur if and only if all four conditions hold simultaneously:
1. **Mutual Exclusion:** At least one resource must be non-shareable (e.g., a hardware printer, tape drive, or exclusive write lock on a bank ledger).
2. **Hold and Wait:** A process is holding at least one allocated resource while simultaneously requesting additional resources held by other processes.
3. **No Preemption:** Allocated resources cannot be forcibly seized from a process; they can only be released voluntarily after the process completes.
4. **Circular Wait:** A closed chain of processes exists $\\{P_0, P_1, \\dots, P_n\\}$ such that $P_0$ waits for a resource held by $P_1$, $P_1$ waits for $P_2$, and $P_n$ waits for a resource held by $P_0$.

3. Deadlock Avoidance: Dijkstra's Banker's Algorithm:
Named after banking credit limits, this algorithm ensures the operating system never enters an **Unsafe State** where resources could be exhausted before all processes terminate.

* **Key Data Structures (for $n$ processes and $m$ resource types):**
  1. `Available[m]`: Vector of currently unallocated resources.
  2. `Max[n][m]`: Maximum demand declared by each process in advance.
  3. `Allocation[n][m]`: Resources currently allocated to each process.
  4. `Need[n][m]`: Remaining resources needed:
     $$\\text{Need}[i][j] = \\text{Max}[i][j] - \\text{Allocation}[i][j]$$

* **Safety Algorithm Logic:**
  1. Initialize `Work = Available` and `Finish[i] = False` for all processes.
  2. Find an index $i$ such that:
     $$\\text{Finish}[i] == \\text{False} \\quad \\text{and} \\quad \\text{Need}_i \\le \\text{Work}$$
     If no such $i$ exists, jump to step 4.
  3. Assume process $i$ finishes and releases its allocated resources:
     $$\\text{Work} = \\text{Work} + \\text{Allocation}_i, \\quad \\text{Finish}[i] = \\text{True}$$
     Return to Step 2 to find the next executable process.
  4. If `Finish[i] == True` for all $i$, the system is in a **Safe State** with a valid safe sequence $\\langle P_1, P_2, \\dots, P_n \\rangle$, guaranteeing deadlock cannot occur.

* **Resource Request Algorithm:**
  When a process makes a request:
  * If $\\text{Request}_i \\le \\text{Need}_i$ and $\\text{Request}_i \\le \\text{Available}$, the OS hypothetically allocates the resources and runs the Safety Algorithm.
  * If the resulting state is Safe, the allocation is approved; if Unsafe, the process must wait.

4. Conclusion:
Banker's Algorithm provides dynamic mathematical insurance against system paralysis, ensuring core banking database locks and threads execute without catastrophic deadlocks.""",
        """१. डेडलकको अवधारणा:
मल्टिटास्किङ अपरेटिङ सिस्टममा दुई वा सोभन्दा बढी प्रक्रियाहरू (Processes) एउटै समयमा एकअर्काले ओगटेका स्रोतहरू (Resources) पर्खेर अनिश्चितकालका लागि ठप्प हुने अवस्थालाई **डेडलक (Deadlock)** भनिन्छ। यस्तो अवस्थामा कुनै पनि प्रक्रिया अगाडि बढ्न सक्दैन।

२. डेडलकका चार अनिवार्य कफम्यान सर्तहरू (Coffman Conditions):
यी चारवटै सर्तहरू एकैपटक विद्यमान भएमा मात्र डेडलक उत्पन्न हुन्छ:
१. **पारस्परिक बहिष्करण (Mutual Exclusion):** कम्तीमा एउटा स्रोत यस्तो हुनुपर्छ जसलाई एक पटकमा एउटा मात्र प्रक्रियाले प्रयोग गर्न सकोस् (जस्तै: बैंक खातामा राइट लक)।
२. **होल्ड एण्ड वेट (Hold and Wait):** कुनै प्रक्रियाले एउटा स्रोत ओगटेर बसिरहेको छ र अर्को नयाँ स्रोतको माग गरिरहेको छ।
३. **खोस्न नपाइने (No Preemption):** कुनै प्रक्रियाले ओगटेको स्रोतलाई काम नसकिँदासम्म जबर्जस्ती खोस्न पाइँदैन।
४. **गोलाकार प्रतीक्षा (Circular Wait):** प्रक्रियाहरूको एउटा यस्तो बन्द चक्र बन्छ जहाँ $P_0$ ले $P_1$ को स्रोत कुर्छ, $P_1$ ले $P_2$ को कुर्छ, र अन्तिम प्रक्रियाले $P_0$ को स्रोत कुर्छ।

३. ब्याङ्कर्स एल्गोरिदम (Banker's Algorithm) द्वारा डेडलक निवारण:
डिक्सट्राद्वारा प्रतिपादित यो एल्गोरिदम बैंकहरूले ग्राहकलाई कर्जा दिने सुरक्षित सिद्धान्तमा आधारित छ। यसले प्रणालीलाई सधैं **सुरक्षित अवस्था (Safe State)** मा राख्दछ।

* **आवश्यक चार मुख्य डेटा संरचनाहरू:**
  १. `Available`: हाल प्रणालीमा उपलब्ध बाँकी स्रोतहरूको संख्या।
  २. `Max`: प्रत्येक प्रक्रियालाई आफ्नो काम सम्पन्न गर्न आवश्यक अधिकतम स्रोतको संख्या।
  ३. `Allocation`: हाल प्रत्येक प्रक्रियालाई बाँडफाँड गरिएको स्रोतको संख्या।
  ४. `Need`: काम पूरा गर्न थप चाहिने स्रोत:
     $$\\text{Need} = \\text{Max} - \\text{Allocation}$$

* **सुरक्षा जाँच (Safety Algorithm) का चरणहरू:**
  १. सुरुमा `Work = Available` र सबै प्रक्रियाका लागि `Finish[i] = False` बनाइन्छ।
  २. यस्तो प्रक्रिया $i$ खोजिन्छ जसको `Need` हाल उपलब्ध `Work` भन्दा कम वा बराबर होस् (अर्थात् $\\text{Need}_i \\le \\text{Work}$)।
  ३. सो प्रक्रियालाई स्रोत दिएर काम सम्पन्न भएको मानिन्छ र उसले ओगटेको स्रोत फिर्ता लिइन्छ:
     $$\\text{Work} = \\text{Work} + \\text{Allocation}_i$$
     र `Finish[i] = True` बनाइन्छ। फेरि चरण २ दोहोर्‍याइन्छ।
  ४. यदि सबै प्रक्रियाका लागि `Finish` मान 'True' भयो भने प्रणाली सुरक्षित छ र कुनै डेडलक हुँदैन (Safe Sequence प्राप्त हुन्छ)।

४. निष्कर्ष:
ब्याङ्कर्स एल्गोरिदमले स्रोत बाँडफाँड गर्दा प्रणाली कहिल्यै पनि असुरक्षित चक्रमा नफसोस् भन्ने पूर्व-अनुमान गरी कम्प्युटर प्रणालीलाई पूर्ण रूपमा चलायमान राख्दछ।""")

    # --- TOPIC 4: NRB Cyber Resilience Guidelines 2023 & SOC (10 Marks) ---
    add_q("p2b_u6_sub204", "paper2", "sectionB", 6, "Unit 6: Cybersecurity & NRB Guidelines", 10, "2081 BS - RBB IT",
        "Explain the key governance and technical mandates of Nepal Rastra Bank's Cyber Resilience Guidelines, 2023. What are the core responsibilities of a 24/7 Security Operations Center (SOC) in a commercial bank?",
        "नेपाल राष्ट्र बैंकको Cyber Resilience Guidelines, २०२३ का प्रमुख संस्थागत र प्राविधिक व्यवस्थाहरू व्याख्या गर्दै वाणिज्य बैंकमा २४/७ सञ्चालन हुने Security Operations Center (SOC) का मुख्य जिम्मेवारीहरू प्रष्ट पार्नुहोस्।",
        """1. Background & Context of NRB Cyber Resilience Guidelines 2023:
Given escalating advanced persistent threats (APTs), ransomware extortion, and digital payment switch hacks, Nepal Rastra Bank issued the comprehensive **Cyber Resilience Guidelines, 2023** to elevate financial sector cybersecurity from reactive IT defence to holistic resilience.

2. Five Functional Pillars of the Guidelines:
Adopted from the globally recognized NIST Cyber Security Framework:
1. **Identify:** Asset inventory of all hardware, software, API endpoints, data classification, and continuous risk assessment.
2. **Protect:** Implementation of zero-trust architecture, multi-factor authentication (MFA), end-to-end encryption, network segmentation, and regular patch management.
3. **Detect:** Mandatory 24/7 telemetry monitoring via Security Operations Centers (SOC) and SIEM systems to detect anomalies in real time.
4. **Respond:** Documented Cyber Incident Response Plan (CIRP) with designated incident handlers and automated containment playbooks.
5. **Recover:** Resilient immutable offline backups, disaster recovery testing (DRP drills), and operational restoration.

3. Key Regulatory Compliance Mandates:
* **Dedicated CISO:** Mandatory appointment of an independent Chief Information Security Officer (CISO) reporting directly to the Board Risk Management Committee, not the IT Head.
* **Incident Reporting to NRB within 24 Hours:** Immediate notification of critical cyber breaches to NRB's IT and Payment Systems Departments within 24 hours.
* **Semi-Annual VAPT:** Comprehensive Vulnerability Assessment and Penetration Testing (VAPT) must be conducted at least twice a year by independent, certified cybersecurity audit firms.
* **Third-Party Risk Management:** Strict SLA audit clauses for core banking vendors, cloud providers, and digital wallet integrations.

4. Core Responsibilities of a 24/7 Security Operations Center (SOC):
A bank's SOC acts as the round-the-clock digital sentinel with four core responsibilities:
1. **Log Ingestion & SIEM Correlation:** Collects real-time syslog and telemetry from CBS servers, firewalls, active directories, and ATMs into a centralized SIEM to correlate suspicious patterns.
2. **Real-Time Threat Detection & Triage:** Monitors alerts (e.g., impossible travel logins, brute-force attacks, lateral movement) and classifies them by severity (P1 to P4).
3. **Automated & Manual Incident Containment:** Isolates infected endpoints from the banking network, revokes compromised credentials, and blocks malicious C2 IP addresses.
4. **Threat Intelligence & Forensics:** Analyzes indicators of compromise (IOCs) and preserves digital evidence for police cyber bureau investigations.

5. Conclusion:
The 2023 Guidelines and 24/7 SOC operations transform Nepalese commercial banks into resilient digital fortresses capable of absorbing and overcoming modern cyber warfare.""",
        """१. नेपाल राष्ट्र बैंक Cyber Resilience Guidelines, २०२३ को पृष्ठभूमि:
बढ्दो डिजिटल बैंकिङ, मोबाइल भुक्तानी र अन्तर्राष्ट्रिय स्तरका र्‍यान्समवेयर तथा साइबर आक्रमणको जोखिमबाट नेपाली वित्तीय क्षेत्रलाई जोगाउन नेपाल राष्ट्र बैंकले **Cyber Resilience Guidelines, २०२३** जारी गरेको हो। यसले परम्परागत सुरक्षाबाट माथि उठेर साइबर प्रतिरोध क्षमता (Cyber Resilience) विकास गर्न जोड दिएको छ।

२. निर्देशिकाका पाँच मुख्य आधारस्तम्भहरू (NIST ढाँचा):
१. **पहचान (Identify):** बैंकका सम्पूर्ण सर्भर, कम्प्युटर, सफ्टवेयर र डेटाको वर्गीकरण गरी जोखिमको पूर्व-मूल्याङ्कन गर्नु।
२. **सुरक्षा (Protect):** नेटवर्क सेग्मेन्टेसन, मल्टि-फ्याक्टर प्रमाणीकरण (MFA), डेटा इन्क्रिप्सन र नियमित सेक्युरिटी प्याच अपडेट गर्नु।
३. **पहिचान (Detect):** २४/७ सञ्चालन हुने SOC र SIEM मार्फत शंकास्पद गतिविधि र आक्रमणहरू तत्काल पत्ता लगाउनु।
४. **प्रतिक्रिया (Respond):** घटना घटेमा तत्काल क्षति रोक्न प्रभावकारी Incident Response Plan तयार र कार्यान्वयन गर्नु।
५. **पुनरुत्थान (Recover):** ब्याकअपबाट डेटा पुनर्स्थापना गरी बैंकिङ सेवाहरूलाई तुरुन्तै पूर्ववत् अवस्थामा सञ्चालन गर्नु।

३. मुख्य कानुनी तथा संस्थागत व्यवस्थाहरू:
* **स्वतन्त्र CISO को नियुक्ति:** बैंकमा सूचना प्रविधि प्रमुख भन्दा अलग रहने गरी सिधै सञ्चालक समिति प्रति उत्तरदायी हुने स्वतन्त्र मुख्य सूचना सुरक्षा अधिकारी (CISO) को अनिवार्य व्यवस्था।
* **२४ घण्टा भित्र राष्ट्र बैंकमा प्रतिवेदन:** कुनै गम्भीर साइबर आक्रमण भएमा बैंकले २४ घण्टा भित्र नेपाल राष्ट्र बैंकको सम्बन्धित विभागमा अनिवार्य जानकारी गराउनुपर्ने।
* **प्रत्येक ६ महिनामा VAPT परीक्षण:** आफ्ना सम्पूर्ण डिजिटल प्रणाली, CBS र मोबाइल बैंकिङको वर्षको कम्तीमा दुई पटक स्वतन्त्र विज्ञबाट VAPT (Vulnerability Assessment & Penetration Testing) गराउनुपर्ने।
* **तेस्रो पक्ष (Vendor) जोखिम व्यवस्थापन:** सफ्टवेयर भेन्डर र क्लाउड प्रदायकहरूसँग कडा सुरक्षा सम्झौता (SLA) गर्नुपर्ने।

४. २४/७ सञ्चालन हुने Security Operations Center (SOC) का मुख्य जिम्मेवारीहरू:
१. **केन्द्रीकृत लग विश्लेषण (SIEM):** बैंकका हजारौं कम्प्युटर, सर्भर, फायरवाल र ATM बाट आउने लगहरूलाई एकै ठाउँमा संकलन गरी असामान्य गतिविधि खोज्नु।
२. **वास्तविक समयमा खतरा पहिचान:** असामान्य रकम रकमान्तर, बारम्बार गलत पासवर्ड प्रविष्टि वा मालवेयर आक्रमणलाई तत्काल पत्ता लगाउनु।
३. **आक्रमण नियन्त्रण (Incident Containment):** संक्रमित कम्प्युटरलाई नेटवर्कबाट तत्काल अलग गर्नु र आक्रमणकारीको IP ठेगाना ब्लक गर्नु।
४. **फरेन्सिक अनुसन्धान:** आक्रमण कसरी भयो भनी डिजिटल प्रमाण संकलन गरी भविष्यमा हुन नदिने सुरक्षात्मक कदम चाल्नु।

५. निष्कर्ष:
नेपाल राष्ट्र बैंकको यो निर्देशिका र २४/७ SOC ले बैंकलाई साइबर आक्रमणको जोखिमबाट सुरक्षित राख्दै डिजिटल बैंकिङ प्रति सर्वसाधारणको विश्वास अभिवृद्धि गर्न ऐतिहासिक भूमिका खेल्दछ।""")

    # --- TOPIC 5: Disaster Recovery Planning (DRP & BCP) (10 Marks) ---
    add_q("p2b_u5_sub205", "paper2", "sectionB", 5, "Unit 5: DBMS, Data Warehousing & DRP", 10, "2080 BS - NRB IT",
        "Differentiate between Business Continuity Planning (BCP) and Disaster Recovery Planning (DRP). Explain Hot, Warm, and Cold secondary sites with reference to Recovery Time Objective (RTO) and Recovery Point Objective (RPO).",
        "व्यावसायिक निरन्तरता योजना (BCP) र विपद् पुनर्स्थापना योजना (DRP) बीचको भिन्नता प्रष्ट पार्दै RTO र RPO को सन्दर्भमा Hot Site, Warm Site र Cold Site को तुलनात्मक व्याख्या गर्नुहोस्।",
        """1. Conceptual Distinction: BCP vs DRP:
* **Business Continuity Planning (BCP):** A comprehensive organizational roadmap that ensures all critical business operations (customer service, cash handling, statutory compliance, employee relocation) can continue during and after an enterprise-wide catastrophe. BCP covers people, processes, facilities, and communications.
* **Disaster Recovery Planning (DRP):** A technical sub-component of BCP focusing specifically on recovering IT infrastructure, core banking databases, servers, networks, and electronic data following a disruptive disaster.

2. Two Critical Disaster Recovery Metrics:
* **Recovery Time Objective (RTO):** The maximum tolerable duration of time that banking systems can remain offline following an outage before catastrophic financial or legal damage occurs. (Duration of Downtime).
* **Recovery Point Objective (RPO):** The maximum acceptable age of data that can be lost when recovery occurs, dictating the required frequency of data backups and synchronous replication. (Tolerance for Data Loss).

```
[Normal Operation] ------------ [Disaster Occurs] ============ [Systems Restored]
                        <-- RPO -->              <-- RTO -->
                     (Data Loss Window)       (Downtime Window)
```

3. Comparison of Secondary Recovery Sites:
| Parameter | Hot Site | Warm Site | Cold Site |
|---|---|---|---|
| **Hardware State** | Fully installed, powered, identical production hardware | Installed servers and network gear, but not at live scale | Empty raised-floor data center shell (power, cooling, HVAC only) |
| **Data Synchronization** | **Real-Time Synchronous / Asynchronous continuous replication** | Periodic tape or batch backup restoration | No hardware or data present; equipment must be procured post-disaster |
| **Recovery Time Objective (RTO)** | **Near Zero to Minutes** | **Hours to 1-2 Days** | **Days to Weeks** |
| **Recovery Point Objective (RPO)** | **Zero to Few Seconds** | **Hours (last batch backup)** | **Days or complete loss** |
| **Capital & Operating Cost** | Extremely High (duplicate data center) | Moderate | Lowest |
| **Banking Application** | **Core Banking System (CBS), RTGS, ATM Switch** | Back-office batch reporting, document archive | Long-term cold warehouse storage |

4. Disaster Recovery Testing (Drills):
Under NRB IT Guidelines, commercial banks must conduct live Disaster Recovery (DR) drills at least once every fiscal year, shifting complete live banking transactions to the DR site to verify automated failover and personnel readiness.

5. Conclusion:
Deploying a live Hot Site with zero-RPO data replication ensures that banks remain resilient against natural catastrophes, preserving financial stability without transactional disruption.""",
        """१. BCP र DRP बीचको भिन्नता:
* **व्यावसायिक निरन्तरता योजना (Business Continuity Planning - BCP):** कुनै ठूलो विपद् (भूकम्प, आगलागी वा महामारी) को समयमा पनि संस्थाका सम्पूर्ण आधारभूत व्यावसायिक कार्यहरू (जनशक्ति, नगद व्यवस्थापन, कानुनी परिपालना) कसरी निरन्तर सञ्चालन गर्ने भनी बनाइएको समग्र संस्थागत योजना हो।
* **विपद् पुनर्स्थापना योजना (Disaster Recovery Planning - DRP):** यो BCP को एउटा प्राविधिक अङ्ग हो, जसले विपद् पश्चात् बैंकको सूचना प्रविधि पूर्वाधार, सर्भर, कोर बैंकिङ डेटाबेस र नेटवर्कलाई कसरी पुनः ब्युँताउने भन्नेमा मात्र केन्द्रित हुन्छ।

२. विपद् व्यवस्थापनका दुई आधारभूत सूचकहरू (RTO र RPO):
* **RTO (Recovery Time Objective):** प्रणाली क्र्यास भएपछि कति समय भित्र सेवा पुनः चालु गरिसक्नु पर्दछ भन्ने अधिकतम स्वीकार्य डाउनटाइम (Downtime) समय सीमा हो।
* **RPO (Recovery Point Objective):** प्रणाली बन्द हुँदा कति समय सम्मको डेटा नोक्सानी स्वीकार्न सकिन्छ भन्ने सीमा हो, जसले ब्याकअपको फ्रिक्वेन्सी निर्धारण गर्दछ।

३. वैकल्पिक रिकभरी साइटहरूको तुलनात्मक विश्लेषण:
| तुलनाका आधारहरू | Hot Site (हट साइट) | Warm Site (वार्म साइट) | Cold Site (कोल्ड साइट) |
|---|---|---|---|
| **हार्डवेयर पूर्वाधार** | मुख्य डेटा सेन्टर जस्तै सम्पूर्ण सर्भर र उपकरण पूर्ण चालु अवस्थामा | सर्भर र नेटवर्क जडान भएको तर पूर्ण रूपमा चालु नभएको | केवल भौतिक कोठा, बिजुली, AC र इन्टरनेट मात्र भएको खाली ठाउँ |
| **डेटा सिन्क्रोनाइजेसन** | **वास्तविक समयमा (Real-Time) स्वचालित प्रतिलिपि हुने** | दैनिक वा आवधिक ब्याकअपबाट म्यानुअल लोड गर्नुपर्ने | कुनै डेटा नहुने, विपद् पछि मात्र हार्डवेयर र डेटा ल्याइने |
| **पुनर्स्थापना समय (RTO)** | **तत्काल (केही सेकेन्डदेखि मिनेट भित्र)** | **केही घण्टादेखि १-२ दिन सम्म** | **धेरै दिन वा हप्ता लाग्ने** |
| **डेटा नोक्सानी सीमा (RPO)** | **शून्य (Zero Data Loss) वा केही सेकेन्ड** | **केही घण्टाको डेटा गुम्न सक्ने** | **ठूलो मात्रामा डेटा गुम्ने जोखिम** |
| **लागत** | अत्यधिक उच्च (दोहोरो खर्च) | मध्यम | न्यून |
| **बैंकिङ प्रयोग** | **कोर बैंकिङ (CBS), RTGS, ATM र मोबाइल बैंकिङ** | आन्तरिक प्रशासनिक प्रणाली र रिपोर्टिङ | गैर-महत्त्वपूर्ण कार्यालयीय काम |

४. नेपाल राष्ट्र बैंकको निर्देशन:
नेपाल राष्ट्र बैंकको IT निर्देशिका अनुसार सम्पूर्ण वाणिज्य बैंकहरूले वर्षमा कम्तीमा एक पटक मुख्य डेटा सेन्टर बन्द गरी वैकल्पिक DR Site बाट प्रत्यक्ष बैंकिङ कारोबार चलाएर परीक्षण (DR Drill) गर्नुपर्दछ।

५. निष्कर्ष:
बैंकिङ क्षेत्रमा ग्राहकको भरोसा र वित्तीय अभिलेख सुरक्षित राख्न वास्तविक समयको डेटा रेप्लिकेसन भएको 'Hot Site' स्थापना गर्नु अनिवार्य आवश्यकता हो।""")

    return questions

if __name__ == "__main__":
    qs = get_it_subjective_questions()
    print(f"Loaded {len(qs)} comprehensive IT subjective questions.")
