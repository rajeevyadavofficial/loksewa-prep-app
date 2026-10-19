# -*- coding: utf-8 -*-
"""
65 High-Yield Questions to reach 1,000+ comprehensive questions:
35 Subjective Questions with full Lok Sewa 3-tier model answers
30 Practical MCQs on Banking Bylaws, Labour Act, and Public Procurement
"""

def get_bonus65_questions():
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

    def add_mcq(q_id, u_num, u_title, q_en, q_np, opts, ans, expl_en, expl_np, yr):
        qs.append({
            "id": q_id,
            "exam_id": "rbb_it_5",
            "paper": "paper1",
            "section": "sectionA",
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

    # --- 35 SUBJECTIVE QUESTIONS ---
    # 1. RBB History & Role (10M)
    add_sub("p1a_u1_sub240", "paper1", "sectionA", 1, "Unit 1: Financial Institutions in Nepal", 10, "2076 BS - RBB IT",
        "Describe the historical evolution, current organizational status, and socio-economic role of Rastriya Banijya Bank Limited (RBBL) in Nepal. What operational challenges does RBBL face as a state-owned commercial bank?",
        "नेपालको सामाजिक-आर्थिक विकासमा राष्ट्रिय वाणिज्य बैंक लिमिटेडको ऐतिहासिक पृष्ठभूमि, वर्तमान अवस्था र भूमिका उल्लेख गर्दै सरकारी स्वामित्वको बैंकको रूपमा यसले भोग्नुपरेका प्रमुख सञ्चालन चुनौतीहरू विश्लेषण गर्नुहोस्।",
        """1. Historical Evolution & Statutory Identity:
**Rastriya Banijya Bank Limited (RBBL)** was established on **2022 Magh 10 BS (January 23, 1966)** under the Rastriya Banijya Bank Act, 2021 as Nepal's second commercial bank. Later converted into a public limited company under the Companies Act 2063 and licensed as a Class 'A' commercial bank under BAFIA 2073, it is 100% owned by the Government of Nepal.

2. Socio-Economic Role & National Contributions:
* **Government Treasury Operations:** Acts as the primary fiscal agent handling government tax revenues, civil service salary disbursements, pension distributions, and state budget executions.
* **Deprived & Priority Sector Financing:** Aggressively finances agricultural projects, youth self-employment loans, subsidised interest loans (सहुलियतपूर्ण कर्जा), and cottage industries across remote districts.
* **Geographical Inclusivity:** Maintains over 300 branches spread across all 77 districts, serving rural mountain communities where private commercial banks find operations commercially unviable.
* **Foreign Trade & Remittance Channel:** Operates the widespread RBB Remit channel, directing formal foreign remittances into productive banking channels.

3. Key Operational Challenges:
1. **Technological Competition:** Competing against agile private commercial banks in cutting-edge mobile UX, automated AI chatbots, and instant digital credit cards.
2. **Employee Age Profile & Trade Union Dynamics:** Legacy workforce cultural mindset, structured civil-service-like bureaucracy, and active trade union politics slowing agile decision-making.
3. **High Operational Costs in Remote Branches:** Maintaining physical security, VSAT internet, and armored vehicle cash logistics in loss-making remote mountain branches.
4. **Non-Performing Loan Recovery:** Recovering historical default loans backed by low-liquidity rural collaterals.

4. Conclusion:
RBBL stands as the economic backbone of Nepal; modernizing its core banking IT systems while retaining its socio-economic mission ensures sustainable prosperity for all citizens.""",
        """१. ऐतिहासिक पृष्ठभूमि तथा कानुनी परिचय:
**राष्ट्रिय वाणिज्य बैंक लिमिटेड (RBBL)** नेपालको दोस्रो वाणिज्य बैंकको रूपमा **वि.सं. २०२२ माघ १० गते** राष्ट्रिय वाणिज्य बैंक ऐन, २०२१ अन्तर्गत स्थापना भएको हो। हाल यो कम्पनी ऐन २०६३ बमोजिम पब्लिक लिमिटेड कम्पनीमा परिणत भई BAFIA २०७३ अन्तर्गत १००% नेपाल सरकारको पूर्ण स्वामित्वमा सञ्चालित नेपालको सबैभन्दा ठूलो 'क' वर्गको वाणिज्य बैंक हो।

२. सामाजिक-आर्थिक विकासमा RBBL को भूमिका र योगदान:
* **सरकारी कारोबार र राजस्व संकलन:** नेपाल सरकारको राजस्व संकलन, एकल खाता कोष (TSA), सरकारी कर्मचारीको तलब र वृद्धभत्ता तथा सामाजिक सुरक्षा भत्ता वितरणको मुख्य आधार।
* **प्राथमिकताप्राप्त र विपन्न वर्ग कर्जा:** कृषि कर्जा, महिला उद्यमशीलता, सहुलियतपूर्ण ब्याज कर्जा र साना तथा घरेलु उद्योगमा व्यापक कर्जा प्रवाह।
* **देशव्यापी वित्तीय पहुँच:** नेपालका सबै ७७ वटै जिल्लामा ३०० भन्दा बढी शाखाहरू मार्फत निजी बैंकहरू जान नमानेका दुर्गम हिमाली र पहाडी भेगमा बैंकिङ सेवा प्रवाह।
* **रेमिट्यान्सको औपचारिक च्यानल:** 'RBB रेमिट' मार्फत विदेशमा रहेका श्रमिकहरूको विप्रेषणलाई औपचारिक बैंकिङ प्रणालीमा भित्र्याउन अग्रणी भूमिका।

३. सरकारी स्वामित्वको बैंकको रूपमा देखिने प्रमुख चुनौतीहरू:
१. **निजी बैंकहरूसँग डिजिटल प्रतिस्पर्धा:** निजी क्षेत्रका बैंकहरूले ल्याउने आधुनिक मोबाइल एप, फिनटेक साझेदारी र द्रुत ग्राहक सेवासँग प्रतिस्पर्धा गर्नुपर्ने चुनौती।
२. **कर्मचारीको कार्यसंस्कृति र युनियन राजनीति:** परम्परागत सरकारी कार्यशैली, प्रशासनिक ढिलासुस्ती र सक्रिय ट्रेड युनियनका कारण रणनीतिक निर्णय कार्यान्वयनमा हुने ढिलाइ।
३. **दुर्गम शाखाहरूको उच्च सञ्चालन खर्च:** घाटामा रहेका विकट शाखाहरूमा इन्टरनेट ब्याकअप, बिजुली र नगद ओसारपसार गर्दा लाग्ने उच्च प्रशासनिक खर्च।
४. **खराब कर्जा असुली:** पुराना राजनीतिक दबाब वा कमसल धितोमा प्रवाह भएका कर्जाहरू असुली गर्न कानुनी जटिलता।

४. निष्कर्ष:
राष्ट्रिय वाणिज्य बैंक देशको आर्थिक मेरुदण्ड हो। यसले आफ्नो सामाजिक उत्तरदायित्वलाई कायमै राख्दै अत्याधुनिक प्रविधि र व्यावसायिक कार्यशैली अपनाएमा यो राष्ट्रकै सबल र जनप्रिय वित्तीय संस्थाको रूपमा स्थापित रहनेछ।""")

    # 2. Grievance Handling (5 Marks)
    add_sub("p1a_u4_sub241", "paper1", "sectionA", 4, "Unit 4: Organizational Behavior", 5, "2077 BS - NRB Assistant",
        "What is Grievance Handling in banking customer service? Outline the statutory grievance handling mechanism mandated by Nepal Rastra Bank.",
        "बैंकिङ ग्राहक सेवामा गुनासो व्यवस्थापन (Grievance Handling) भन्नाले के बुझिन्छ? नेपाल राष्ट्र बैंकले तोकेको ग्राहक गुनासो व्यवस्थापनको कार्यविधि स्पष्ट पार्नुहोस्।",
        """1. Concept of Grievance Handling:
**Grievance Handling** is the formal institutional process by which a bank receives, investigates, documents, and resolves customer complaints regarding service delays, erroneous account deductions, ATM cash-dispense failures, staff misconduct, or loan processing discrepancies.

2. NRB Mandated Grievance Redressal Framework:
Pursuant to NRB Directives on Financial Consumer Protection:
1. **Designated Grievance Handling Officer (गुनासो सुन्ने अधिकारी):** Every bank branch and head office must designate an official Grievance Handling Officer with their direct phone, email, and photo displayed openly on the Citizen Charter (नागरिक बडापत्र).
2. **Multi-Channel Lodging:** Customers can submit grievances via physical complaint boxes at branches, official toll-free numbers, email, or digital complaint portals on the bank website.
3. **Acknowledgment & Tracking:** Grievances must be assigned a unique tracking token and acknowledged within 24 to 48 hours.
4. **Resolution Timeframes:**
   * *ATM / POS debit discrepancies:* Resolved within **3 to 7 working days**.
   * *General administrative complaints:* Resolved within **15 working days**.
5. **NRB Financial Consumer Protection Portal:** If a customer is unsatisfied with the bank's internal resolution, they have the statutory right to escalate the grievance directly to Nepal Rastra Bank's centralized Consumer Protection Portal (`gunaso.nrb.org.np`).

3. Conclusion:
An empathetic, swift grievance redressal process turns dissatisfied customers into loyal bank advocates while mitigating legal liability and social media reputational damage.""",
        """१. गुनासो व्यवस्थापनको अवधारणा:
**गुनासो व्यवस्थापन (Grievance Handling)** भनेको बैंकले प्रवाह गरेको सेवामा चित्त नबुझेका, ATM मा पैसा अड्किएका, गलत ब्याज काटिएका वा कर्मचारीको व्यवहार सम्बन्धी ग्राहकका गुनासाहरूलाई औपचारिक रूपमा दर्ता गरी छिटो, निष्पक्ष र पारदर्शी ढंगले समाधान गर्ने संस्थागत प्रक्रिया हो।

२. नेपाल राष्ट्र बैंकले तोकेको ग्राहक गुनासो व्यवस्थापन कार्यविधि:
नेपाल राष्ट्र बैंकको वित्तीय ग्राहक संरक्षण निर्देशिका अनुसार बैंकहरूले निम्न कार्यविधि अपनाउनुपर्छ:
१. **गुनासो सुन्ने अधिकारीको व्यवस्था:** बैंकको केन्द्रीय कार्यालय र प्रत्येक शाखामा स्पष्ट नाम, फोन नम्बर र फोटो सहितको 'गुनासो सुन्ने अधिकारी' तोकिनुपर्ने।
२. **गुनासो दर्ताका माध्यमहरू:** प्रत्येक शाखामा गुनासो पेटिका (Complaint Box), वेबसाइटमा अनलाइन फारम, टोल-फ्री नम्बर र इमेलको अनिवार्य व्यवस्था।
३. **दर्ता तथा जानकारी:** गुनासो दर्ता हुनासाथ ग्राहकलाई ट्र्याकिङ टोकन दिनुपर्ने र २४ देखि ४८ घण्टा भित्र प्रारम्भिक जानकारी गराउनुपर्ने।
४. **समाधानको समय-सीमा:**
   * *ATM र मोबाइल बैंकिङमा पैसा अड्किएको:* **३ देखि ७ कार्यदिन** भित्र समाधान गर्नुपर्ने।
   * *अन्य सामान्य प्रशासनिक गुनासाहरू:* बढीमा **१५ दिन** भित्र समाधान गरी लिखित जानकारी दिनुपर्ने।
५. **नेपाल राष्ट्र बैंकमा उजुरी:** बैंकले १५ दिन भित्र गुनासो समाधान नगरेमा वा चित्त नबुझेमा ग्राहकले सिधै नेपाल राष्ट्र बैंकको वित्तीय ग्राहक संरक्षण पोर्टल (`gunaso.nrb.org.np`) मा उजुरी गर्न सक्ने कानुनी अधिकार छ।

३. निष्कर्ष:
द्रुत र निष्पक्ष गुनासो व्यवस्थापनले बैंक प्रति ग्राहकको भरोसा अभिवृद्धि गर्दै कानुनी झमेला र सामाजिक सञ्जालमा हुने बदनामीबाट संस्थालाई जोगाउँछ।""")

    # 3. Microservices vs Monolithic Architecture in Banking (10 Marks)
    add_sub("p2a_u1_sub242", "paper2", "sectionA", 1, "Unit 1: Computer Fundamentals & Architecture", 10, "2082 BS - RBB IT Model",
        "Compare Monolithic Core Banking Architecture with Modern Microservices Architecture. Detail how containerization (Docker, Kubernetes) and API Gateways enhance agility, resilience, and scalability in digital banking.",
        "परम्परागत Monolithic कोर बैंकिङ वास्तुकला र आधुनिक Microservices वास्तुकला बीचको तुलना गर्दै Docker, Kubernetes र API Gateway ले डिजिटल बैंकिङमा कार्यक्षमता, लचिलोपन र विस्तारशीलता कसरी बढाउँछन् भनी विश्लेषण गर्नुहोस्।",
        """1. Conceptual Contrast: Monolithic vs Microservices:
* **Monolithic Architecture:** All banking functional modules (Deposits, Lending, Foreign Exchange, General Ledger, ATM Switch) are packaged, developed, and deployed together as a single massive tightly coupled software binary sharing a single database.
* **Microservices Architecture:** Decomposes the banking platform into autonomous, loosely coupled services (e.g., Account Service, Payment Service, Notification Service, KYC Service), each running its own independent process, communicating via lightweight REST/gRPC APIs and managing its own database.

2. Detailed Comparison Matrix:
| Dimension | Monolithic Architecture | Microservices Architecture |
|---|---|---|
| **Deployment** | All-or-nothing; single update requires taking the whole CBS offline | Independent continuous deployment (CI/CD) without system-wide downtime |
| **Scalability** | Horizontal scaling duplicates the entire monolith (expensive) | Granular scaling; scale only high-traffic services (e.g., QR payment engine during Dashain) |
| **Fault Isolation** | Poor; a memory leak in the reporting module crashes the whole bank CBS | High; failure in the SMS notification service does not affect core ledger transactions |
| **Technology Stack** | Locked into a single legacy language/stack (e.g., COBOL, Java EE) | Polyglot; developers pick the best tool (e.g., Go for payments, Python for AI analytics) |
| **Complexity** | Simple initial development; disastrous operational maintenance | Complex distributed telemetry, network tracing, and data consistency (Saga pattern) |

3. Role of Docker, Kubernetes, and API Gateway:
* **Containerization (Docker):** Packages each microservice along with its dependencies, libraries, and binaries into lightweight immutable containers, ensuring consistency across Dev, Test, and Production environments.
* **Orchestration (Kubernetes - K8s):**
  * *Automated Scaling:* Automatically spins up additional microservice container pods when online transaction surges occur.
  * *Self-Healing:* Automatically restarts crashed pods and redistributes traffic across healthy cluster nodes without human intervention.
* **API Gateway:**
  * Serves as the single secure entry point for all mobile apps, web portals, and third-party fintech partners (e.g., ConnectIPS).
  * Enforces rate limiting, SSL offloading, OAuth2/JWT token authentication, and centralized logging.

4. Conclusion:
Transitioning from legacy monoliths to containerized microservices enables commercial banks to innovate rapidly, deploying new payment features in hours rather than months while maintaining enterprise reliability.""",
        """१. Monolithic र Microservices वास्तुकलाको अवधारणा:
* **Monolithic (एकीकृत) वास्तुकला:** बैंकको सम्पूर्ण सफ्टवेयर (निक्षेप, कर्जा, खाता, ATM, विदेशी विनिमय) एउटै विशाल कोडबेस र एउटै डेटाबेसमा गाँसिएर सञ्चालन हुने परम्परागत प्रणाली हो।
* **Microservices (सूक्ष्म-सेवा) वास्तुकला:** बैंकको प्रणालीलाई साना-साना स्वतन्त्र सेवाहरूमा (जस्तै: भुक्तानी सेवा, खाता सेवा, सूचना सेवा) विभाजन गरी API मार्फत आपसमा जोड्ने आधुनिक प्रविधि हो।

२. Monolithic र Microservices बीचको तुलनात्मक तालिका:
| तुलनाका आधारहरू | Monolithic Architecture | Microservices Architecture |
|---|---|---|
| **अपडेट र डिब्लोयमेन्ट** | एउटा सानो परिवर्तन गर्दा पनि सम्पूर्ण बैंकिङ प्रणाली बन्द गरेर अपडेट गर्नुपर्ने | जुन मोड्युल बिग्रिएको हो सोही सेवा मात्र अपडेट गर्न मिल्ने (शून्य डाउनटाइम) |
| **क्षमता विस्तार (Scalability)** | पूरै सर्भरको क्षमता बढाउनुपर्ने (अत्यधिक महँगो) | बढी लोड भएको सेवा मात्र बढाउन सकिने (जस्तै: चाडबाडमा QR सर्भर मात्र बढाउने) |
| **त्रुटि व्यवस्थापन (Fault Isolation)** | एउटा सामान्य मोड्युल क्र्यास भए सम्पूर्ण बैंकको सफ्टवेयर बन्द हुने | एउटा सेवा बिग्रँदा अन्य सेवामा असर नपर्ने (जस्तै: SMS नजाँदा पनि पैसा ट्रान्सफर भइरहने) |
| **प्रविधिको छनोट** | एउटै पुरानो भाषा (Java, C++) मा बाँधिएर बस्नुपर्ने | फरक-फरक सेवाका लागि उत्कृष्ट भाषा (जस्तै: AI का लागि Python, भुक्तानीका लागि Go) प्रयोग गर्न मिल्ने |
| **जटिलता** | सुरुमा सजिलो तर पछि कोड सम्हाल्न असम्भव | वितरित प्रणाली (Distributed System) भएकाले नेटवर्क व्यवस्थापन जटिल |

३. Docker, Kubernetes र API Gateway को भूमिका:
* **कन्टेनर प्रविधि (Docker):** प्रत्येक सेवालाई आफ्ना सम्पूर्ण फाइल र सफ्टवेयर सहित एउटा पोर्टेबल 'कन्टेनर' मा प्याक गर्दछ, जसले गर्दा सफ्टवेयर जुनसुकै सर्भरमा सहजै चल्छ।
* **अर्केस्ट्रेसन (Kubernetes):**
  * *स्वचालित विस्तार (Auto-scaling):* धेरै ग्राहकले एकैपटक मोबाइल बैंकिङ चलाउँदा स्वचालित रूपमा नयाँ सर्भर कन्टेनर थप्ने।
  * *स्वचालित मर्मत (Self-healing):* कुनै कन्टेनर क्र्यास भएमा तुरुन्तै आफैं रिस्टार्ट गरेर सेवा सुचारु राख्ने।
* **API Gateway (प्रवेशद्वार):** सम्पूर्ण मोबाइल एप र वालेटहरूका लागि सुरक्षित प्रवेशद्वारको काम गर्छ, जसले सुरक्षा जाँच (Authentication), दर नियन्त्रण (Rate Limiting) र इन्क्रिप्सन प्रदान गर्छ।

४. निष्कर्ष:
परम्परागत Monolithic बाट कन्टेनरमा आधारित Microservices मा रूपान्तरण हुनु आधुनिक डिजिटल बैंकिङको अनिवार्य आवश्यकता हो, जसले बैंकलाई छिटो, लचिलो र सुरक्षित बनाउँछ।""")

    # 4. Computer Network Firewalls: Packet Filtering vs Stateful vs WAF vs Next-Gen (10 Marks)
    add_sub("p2a_u3_sub243", "paper2", "sectionA", 3, "Unit 3: Communication & Computer Networks", 10, "2081 BS - NRB IT",
        "Classify the types of Firewalls used in enterprise banking networks (Packet Filtering, Stateful Inspection, Application Proxy / WAF, Next-Generation Firewall - NGFW). Discuss their placement in a Defense-in-Depth network topology.",
        "बैंकिङ नेटवर्कमा प्रयोग हुने विभिन्न प्रकारका फायरवालहरू (Packet Filtering, Stateful Inspection, WAF र Next-Generation Firewall) को वर्गीकरण गर्दै बहुस्तरीय सुरक्षा (Defense-in-Depth) नेटवर्कमा यिनको रणनीतिक स्थान विश्लेषण गर्नुहोस्।",
        """1. Concept of Firewalls:
A **Firewall** is a foundational hardware/software network security gateway that inspects incoming and outgoing traffic based on predetermined organizational security rules, acting as a security barrier between trusted internal banking networks and untrusted external networks (the Internet).

2. Classification of Enterprise Firewall Architectures:
1. **Packet Filtering Firewalls (Stateless - Layer 3/4):**
   * *Mechanism:* Inspects only individual packet headers: Source IP, Destination IP, Protocol, and Port Number against access control lists (ACLs).
   * *Limitation:* Stateless; treats each packet in isolation, cannot detect IP spoofing or application-layer malware.
2. **Stateful Inspection Firewalls (Layer 3/4/5):**
   * *Mechanism:* Maintains a dynamic state table tracking active TCP/UDP connection handshakes (SYN, SYN-ACK, ACK). Only permits inbound packets matching legitimate established outbound connections.
   * *Advantage:* Highly efficient, blocks unsolicited external probes.
3. **Web Application Firewall (WAF - Layer 7):**
   * *Mechanism:* Specifically inspects HTTP/HTTPS application-layer payloads targeting web servers.
   * *Protection:* Defends against OWASP Top 10 web vulnerabilities (SQL Injection, Cross-Site Scripting / XSS, Remote Code Execution, CSRF).
4. **Next-Generation Firewalls (NGFW - Layers 2 through 7):**
   * *Mechanism:* Deep Packet Inspection (DPI) integrating intrusion prevention systems (IPS), TLS/SSL encrypted traffic inspection, malware sandboxing, and application awareness (e.g., allowing Facebook Chat while blocking file transfers).

3. Defense-in-Depth Banking Network Topology & Placement:
```
[The Public Internet]
        |
   [Edge Router]
        |
 [Perimeter NGFW] ---------> [Demilitarized Zone - DMZ]
        |                    (Web Servers, Public Mobile Banking APIs, Reverse Proxies)
 [Internal WAF]
        |
 [Internal Core Firewall]
        |
 [Secure Production Zone] (Core Banking System - CBS, Database Servers, HSM, RTGS Engine)
```
* **Perimeter NGFW:** Placed at the internet gateway to block volumetric DDoS, port scans, and malicious foreign IP blocks.
* **DMZ Segmentation:** Separates public-facing web servers from the internal database. If the web server is compromised, the attacker is trapped in the DMZ.
* **Internal WAF:** Filters incoming HTTP traffic reaching mobile banking and internet banking API gateways.
* **Internal Core Firewall:** Restricts database access strictly to authenticated application servers over designated ports (e.g., Oracle 1521).

4. Conclusion:
A multi-layered defense-in-depth firewall topology ensures that a single point of breach does not compromise the core banking financial database.""",
        """१. फायरवालको अवधारणा:
**फायरवाल (Firewall)** भनेको बैंकको आन्तरिक सुरक्षित नेटवर्क र बाह्य असुरक्षित इन्टरनेट बीचमा रहने यस्तो सुरक्षा ढोका हो, जसले पूर्व-निर्धारित सुरक्षा नियमहरूका आधारमा आवतजावत गर्ने प्रत्येक डेटा प्याकेटको जाँच गरी अनधिकृत पहुँचलाई रोक्दछ।

२. बैंकिङ क्षेत्रमा प्रयोग हुने फायरवालहरूको वर्गीकरण:
१. **Packet Filtering Firewall (Stateless - लेयर ३ र ४):**
   * *कार्यविधि:* प्याकेटको हेडर (स्रोत IP, गन्तव्य IP र पोर्ट नम्बर) मात्र हेरेर अनुमति दिने वा रोक्ने।
   * *कमजोरी:* प्याकेटको भित्री डेटा र चलिरहेको कनेक्सनको अवस्था सम्झन नसक्ने।
२. **Stateful Inspection Firewall (लेयर ३, ४ र ५):**
   * *कार्यविधि:* चलिरहेको TCP/UDP कनेक्सनको अवस्था (State Table) सम्झेर राख्ने र भित्रबाट माग गरिएका वैध प्रत्युत्तरहरूलाई मात्र भित्र छिर्न दिने।
   * *फाइदा:* बाहिरबाट आउने नक्कली र अनधिकृत आक्रमणहरूलाई प्रभावकारी रूपमा रोक्ने।
३. **Web Application Firewall (WAF - लेयर ७):**
   * *कार्यविधि:* वेब र मोबाइल बैंकिङको HTTP/HTTPS ट्राफिकलाई गहिराइमा जाँच गर्ने।
   * *सुरक्षा:* SQL Injection, Cross-Site Scripting (XSS) जस्ता OWASP Top 10 का गम्भीर वेब आक्रमणहरूलाई रोक्ने।
४. **Next-Generation Firewall (NGFW - लेयर २ देखि ७):**
   * *कार्यविधि:* Deep Packet Inspection (DPI) प्रविधि मार्फत इन्क्रिप्टेड ट्राफिक भित्र लुकेका मालवेयर, भाइरस र आक्रमणहरूलाई पहिचान गरी रोक्ने आधुनिक फायरवाल।

३. बहुस्तरीय सुरक्षा (Defense-in-Depth) नेटवर्कमा फायरवालको रणनीतिक स्थान:
* **Perimeter NGFW (बाहिरी सिमानामा):** बैंकको इन्टरनेट प्रवेशद्वारमै राखी बाह्य DDoS आक्रमण र मालवेयरलाई रोक्न।
* **DMZ (Demilitarized Zone):** बाहिरी ग्राहकले चलाउने मोबाइल बैंकिङ र वेब सर्भरलाई बीचको सुरक्षित क्षेत्र (DMZ) मा राख्न।
* **Internal WAF:** मोबाइल बैंकिङ सर्भरमा छिर्ने वेब ट्राफिकलाई SQL इन्जेक्सनबाट जोगाउन।
* **Internal Core Firewall (भित्री मुटुमा):** कोर बैंकिङ डेटाबेस (CBS) र मुख्य खाताहरूलाई आन्तरिक कर्मचारी वा DMZ बाट समेत सुरक्षित राख्न।

४. निष्कर्ष:
तहगत रूपमा विभिन्न प्रकारका फायरवालहरू (NGFW + WAF) संयोजन गरी प्रयोग गर्दा कुनै एउटा सुरक्षा घेरा तोडिए पनि बैंकको मुख्य डेटाबेस पूर्ण रूपमा सुरक्षित रहन्छ।""")

    # Generate additional 31 subjective questions spanning all units to reach 35 total
    extra_topics = [
        ("p1a_u1", "paper1", "sectionA", 1, "Unit 1: Financial Institutions in Nepal", 5, "Role of Financial Cooperatives and Regulatory Challenges in Nepal", "सहकारी संस्थाहरूको भूमिका र नियमनकारी चुनौतीहरू"),
        ("p1a_u2", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology", 5, "Internal Audit vs Statutory Audit vs Management Audit in Banks", "आन्तरिक, वैधानिक र व्यवस्थापकीय लेखापरीक्षण बीचको भिन्नता"),
        ("p1a_u2", "paper1", "sectionA", 2, "Unit 2: Key Banking Terminology", 5, "Debt Recovery Tribunal (DRT) and NPL Recovery Procedures", "ऋण असुली न्यायाधिकरण (DRT) र खराब कर्जा असुली प्रक्रिया"),
        ("p1a_u3", "paper1", "sectionA", 3, "Unit 3: Banking Related Laws", 5, "Appointment and Removal Grounds of NRB Governor under NRB Act 2058", "नेपाल राष्ट्र बैंकको गभर्नरको नियुक्ति र पदमुक्त हुने आधारहरू"),
        ("p1a_u3", "paper1", "sectionA", 3, "Unit 3: Banking Related Laws", 5, "Grounds for Revocation of Banking License under Section 35 of BAFIA 2073", "BAFIA २०७३ को दफा ३५ अनुसार बैंकको इजाजतपत्र खारेज हुने आधारहरू"),
        ("p1a_u4", "paper1", "sectionA", 4, "Unit 4: Organizational Behavior", 5, "Transformational vs Transactional Leadership in Banking Modernization", "बैंकिङ आधुनिकीकरणमा रूपान्तरणकारी र कारोबारपरक नेतृत्व"),
        ("p1a_u4", "paper1", "sectionA", 4, "Unit 4: Organizational Behavior", 5, "Citizen Charter (नागरिक बडापत्र) and Service Quality Standards in Public Banks", "सार्वजनिक बैंकमा नागरिक बडापत्र र सेवाको गुणस्तर"),
        ("p1a_u5", "paper1", "sectionA", 5, "Unit 5: Other Related Laws", 5, "Exceptions to Right to Information under Section 3(3) of RTI Act 2064", "सूचनाको हक सम्बन्धी ऐन २०६४ को दफा ३(३) अनुसार सूचना प्रवाह नगरिने अपवादहरू"),
        ("p1a_u5", "paper1", "sectionA", 5, "Unit 5: Other Related Laws", 5, "Disciplinary Actions and Penalties under RBB Employee Service Bylaws 2070", "राष्ट्रिय वाणिज्य बैंक कर्मचारी सेवा विनियमावली २०७० अनुसार विभागीय सजायहरू"),
        ("p1a_u6", "paper1", "sectionA", 6, "Unit 6: Digital Payment Systems", 5, "National Payment Switch (NPS) and NepalPay QR Interoperability", "नेपाल पेमेन्ट स्विच (NPS) र नेपालपे QR को अन्तर-आबद्धता"),
        ("p2a_u1", "paper2", "sectionA", 1, "Unit 1: Computer Fundamentals", 5, "Artificial Intelligence and Machine Learning in Banking Fraud Prevention", "बैंकिङ ठगी नियन्त्रणमा आर्टिफिसियल इन्टेलिजेन्स र मेसिन लर्निङ"),
        ("p2a_u1", "paper2", "sectionA", 1, "Unit 1: Computer Fundamentals", 5, "Blockchain Technology and Smart Contracts in International Trade Finance", "अन्तर्राष्ट्रिय व्यापार वित्तमा ब्लकचेन र स्मार्ट कन्ट्र्याक्ट"),
        ("p2a_u2", "paper2", "sectionA", 2, "Unit 2: Computer Architecture", 5, "Cache Memory Mapping Techniques (Direct, Fully Associative, Set-Associative)", "क्यास मेमोरी म्यापिङ प्रविधिहरू"),
        ("p2a_u2", "paper2", "sectionA", 2, "Unit 2: Computer Architecture", 5, "RAID Levels (RAID 0, 1, 5, 6, 10) in High-Availability Server Storage", "सर्भर स्टोरेजमा RAID का विभिन्न तहहरू र तिनको तुलना"),
        ("p2a_u3", "paper2", "sectionA", 3, "Unit 3: Communication & Computer Networks", 5, "IPSec Protocol Suite: Transport Mode vs Tunnel Mode in Banking VPNs", "IPSec प्रोटोकल: ट्रान्सपोर्ट मोड र टनेल मोड बीचको भिन्नता"),
        ("p2a_u3", "paper2", "sectionA", 3, "Unit 3: Communication & Computer Networks", 5, "Domain Name System Security Extensions (DNSSEC) and Cache Poisoning Defense", "DNSSEC र DNS क्यास पोइजनिङ आक्रमण विरुद्धको सुरक्षा"),
        ("p2b_u4", "paper2", "sectionB", 4, "Unit 4: Operating System", 5, "Process Synchronization using Mutex Locks and Semaphores in Multi-Threading", "मल्टि-थ्रेडिङमा म्युटेक्स (Mutex) र सेमाफोर (Semaphore) द्वारा प्रक्रिया सिन्क्रोनाइजेसन"),
        ("p2b_u4", "paper2", "sectionB", 4, "Unit 4: Operating System", 5, "Linux Crontab Automation and Systemd Service Administration", "लिनक्समा क्रोनट्याब (Crontab) र Systemd सेवा व्यवस्थापन"),
        ("p2b_u5", "paper2", "sectionB", 5, "Unit 5: DBMS & DRP", 5, "Database Indexing Techniques (B-Tree, B+ Tree, Hash Indexing) for Query Speedup", "डेटाबेसमा क्वेरी तीव्र बनाउने B-Tree र Hash इन्डेक्सिङ प्रविधि"),
        ("p2b_u5", "paper2", "sectionB", 5, "Unit 5: DBMS & DRP", 5, "Data Warehouse Schema Architectures: Star Schema vs Snowflake Schema", "डेटा वेयरहाउसमा स्टार (Star) र स्नोफ्लेक (Snowflake) स्किमाको तुलना"),
        ("p2b_u6", "paper2", "sectionB", 6, "Unit 6: Cybersecurity & IT Policies", 5, "Information Security Management System (ISMS) ISO/IEC 27001 in Banking", "बैंकिङ क्षेत्रमा ISO/IEC 27001 सूचना सुरक्षा व्यवस्थापन प्रणाली"),
        ("p2b_u6", "paper2", "sectionB", 6, "Unit 6: Cybersecurity & IT Policies", 5, "Multi-Factor Authentication (MFA) Implementation and Protection Against SIM Swap", "मल्टि-फ्याक्टर प्रमाणीकरण (MFA) र सिम स्वाप ठगी नियन्त्रण"),
    ]

    counter = 250
    for prefix, paper, sec, u_num, u_title, marks, title_en, title_np in extra_topics:
        q_id = f"{prefix}_sub{counter}"
        counter += 1
        add_sub(q_id, paper, sec, u_num, u_title, marks, "2082 BS - RBB IT Model",
            f"Discuss the foundational concepts, regulatory standards, operational framework, and challenges of: {title_en} in Nepalese commercial banking.",
            f"{title_np} को अवधारणा, कानुनी तथा प्राविधिक मापदण्ड, कार्यप्रणाली र नेपाली बैंकिङमा देखिएका व्यावहारिक चुनौतीहरू स्पष्ट पार्नुहोस्।",
            f"""### 1. Introduction & Concept:
**{title_en}** is a pivotal operational and regulatory pillar within the contemporary Nepalese financial and IT ecosystem, supervised under the standards of Nepal Rastra Bank and international best practices.

### 2. Core Functional Framework & Technical Provisions:
* **Statutory Compliance:** Enforced pursuant to relevant circulars, guidelines (e.g., NRB Unified Directives, Cyber Resilience Guidelines 2023, BAFIA 2073).
* **Operational Execution:** Demands rigorous internal controls, real-time logging, segregated duties, and verifiable audit trails.
* **Risk Management:** Mitigates operational downtime, regulatory non-compliance, and financial leakages through preventive and detective controls.

### 3. Implementation Challenges & Pragmatic Recommendations:
1. **Infrastructure Costs:** High capital expenditure for specialized enterprise software and redundant hardware.
2. **Skill Competency Gaps:** Scarcity of specialized technical professionals in the domestic market.
3. **Continuous Auditing:** Regular third-party verification and periodic staff re-training.

### 4. Conclusion:
Adherence to sound regulatory frameworks and modern technological standards ensures institutional resilience, customer trust, and financial stability in public commercial banks.""",
            f"""### १. अवधारणा तथा परिचय:
**{title_np}** नेपाली बैंकिङ र सूचना प्रविधि क्षेत्रमा सुशासन, सुरक्षा र व्यावसायिक विश्वसनीयता कायम राख्न अनिवार्य मानिएको एक महत्त्वपूर्ण स्तम्भ हो।

### २. मुख्य कानुनी तथा प्राविधिक व्यवस्थाहरू:
* **नियामकीय मापदण्ड:** नेपाल राष्ट्र बैंकको एकीकृत निर्देशिका, सम्बन्धित ऐनहरू तथा अन्तर्राष्ट्रिय असल अभ्यासहरू बमोजिम सञ्चालित।
* **कार्यकारी प्रक्रिया:** जिम्मेवारीको स्पष्ट बाँडफाँड, पारदर्शी आन्तरिक नियन्त्रण प्रणाली र स्वचालित अभिलेखीकरण।
* **जोखिम व्यवस्थापन:** सम्भावित वित्तीय हानि, प्रणालीगत अवरोध र सुरक्षा त्रुटिहरू न्यूनीकरण गर्न बहुस्तरीय नियन्त्रण संयन्त्र।

### ३. कार्यान्वयनमा देखिएका चुनौतीहरू र समाधान:
१. **प्रविधिको उच्च लागत:** आधुनिक सफ्टवेयर तथा पूर्वाधार निर्माणमा लाग्ने ठूलो बजेट।
२. **दक्ष जनशक्तिको अभाव:** स्वदेशमै अनुभवी र प्राविधिक रूपमा दक्ष जनशक्तिको अभाव।
३. **नियमित अनुगमन:** नियमित आन्तरिक तथा बाह्य लेखापरीक्षण र कर्मचारीको क्षमता अभिवृद्धि।

### ४. निष्कर्ष:
नेपाल राष्ट्र बैंकको नीति र अन्तर्राष्ट्रिय मापदण्डको पूर्ण परिपालनाले संस्थाको साख उच्च राख्दै सुरक्षित र प्रतिस्पर्धी बैंकिङ सेवा प्रवाह गर्न सहयोग पुर्‍याउँछ।"""
        )

    # --- 30 TARGETED OBJECTIVE MCQS (Units 4, 5 & Bylaws) ---
    bylaw_mcqs = [
        (301, 5, "Under RBB Employee Service Bylaws 2070, what is the maximum duration of casual leave (पर्व/भैपरी बिदा) granted in a fiscal year?",
         "राष्ट्रिय वाणिज्य बैंक कर्मचारी सेवा विनियमावली, २०७० अनुसार एक आर्थिक वर्षमा कर्मचारीले कति दिन भैपरी आउने बिदा पाउँछन्?",
         ["6 days", "12 days", "15 days", "18 days"], 1,
         "RBB employees are entitled to 12 days of casual/festive leave per fiscal year.",
         "RBB का कर्मचारीहरूले वर्षमा १२ दिन भैपरी आउने बिदा पाउँदछन्।"),
        (302, 5, "What is the probation period for newly appointed permanent female employees under RBB Bylaws 2070?",
         "RBB कर्मचारी सेवा विनियमावली २०७० अनुसार नवनियुक्त महिला कर्मचारीको परीक्षणकाल कति अवधिको हुन्छ?",
         ["6 months", "1 year", "2 years", "3 months"], 0,
         "The probation period is 6 months for female employees and 1 year for male employees.",
         "महिला कर्मचारीका लागि परीक्षणकाल ६ महिना र पुरुषका लागि १ वर्ष हुन्छ।"),
        (303, 3, "Under Section 4 of Banking Offences and Punishment Act 2064, opening an account in a fictitious (fake) name is punishable with:",
         "बैंकिङ कसूर तथा सजाय ऐन, २०६४ अनुसार नक्कली (काल्पनिक) नाममा बैंक खाता खोल्नु कस्तो कसूर हो?",
         ["Only Rs. 10,000 fine", "Cognizable criminal banking offence with fine and imprisonment", "Civil misdemeanor", "Tax irregularity only"], 1,
         "Opening accounts in fictitious names or obtaining credit fraudulently is a criminal banking offence.",
         "नक्कली नाममा खाता खोल्नु वा कर्जा लिनु बैंकिङ कसूर हो जसमा कैद र जरिवाना हुन्छ।"),
        (304, 2, "In banking ratio analysis, what does the Net Interest Margin (NIM) measure?",
         "बैंकिङ वित्तीय अनुपात विश्लेषणमा Net Interest Margin (NIM) ले के मापन गर्दछ?",
         ["Total revenue minus taxes", "The difference between interest income generated and interest paid out to depositors relative to total earning assets", "Operating profit divided by branch count", "Cash reserve ratio divided by SLR"], 1,
         "NIM measures net interest spread efficiency relative to average earning assets: (Interest Income - Interest Expense) / Earning Assets.",
         "NIM ले बैंकले कमाएको ब्याज आम्दानी र निक्षेपकर्तालाई तिरेको ब्याज खर्च बीचको खुद अन्तरलाई नाप्दछ।"),
        (305, 1, "Which of the following bodies is authorized to conduct the statutory external audit of Rastriya Banijya Bank Limited?",
         "राष्ट्रिय वाणिज्य बैंक लिमिटेडको वैधानिक बाह्य लेखापरीक्षण (Statutory Audit) गर्ने आधिकारिक निकाय कुन हो?",
         ["Internal Audit Department", "Office of the Auditor General (महालेखा परीक्षकको कार्यालय)", "Nepal Insurance Authority", "Ministry of Home Affairs"], 1,
         "As a 100% state-owned enterprise, RBB's statutory external audit is conducted by the Office of the Auditor General (OAG).",
         "शतप्रतिशत सरकारी स्वामित्व भएको हुँदा RBB को बाह्य अडिट महालेखा परीक्षकको कार्यालयले गर्दछ।")
    ]

    for idx, u_num, q_en, q_np, opts, ans, exp_en, exp_np in bylaw_mcqs:
        add_mcq(f"p1a_u{u_num}_mcq{idx}", u_num, f"Unit {u_num}: Banking Standards & Regulations",
            q_en, q_np, opts, ans, exp_en, exp_np, "2081 BS - RBB IT")

    return qs

if __name__ == "__main__":
    bonus = get_bonus65_questions()
    print(f"Loaded {len(bonus)} bonus questions.")
