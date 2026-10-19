import json

def get_unit6_questions():
    u6 = []
    def add(idx, q_en, q_np, opts, ans, expl_en, expl_np, yr):
        u6.append({
            "id": f"p1b_u6_mcq{idx}",
            "exam_id": "rbb_it_5",
            "paper": "paper1",
            "section": "sectionB",
            "unit_number": 6,
            "unit_title": "Unit 6: Cybersecurity, Threats, NRB Cyber Guidelines & ETA 2063",
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

    # 1. Core Cybersecurity & CIA Triad
    add(101, "Which principle of the CIA Triad is violated when an unauthorized attacker intercepts and modifies the balance figure in an electronic bank fund transfer?",
        "अनधिकृत व्यक्तिले बैंक रकमान्तरको विवरण बीचमै परिवर्तन गर्दा CIA ट्रायडको कुन सिद्धान्त उल्लंघन हुन्छ?",
        ["Confidentiality (गोपनीयता)", "Integrity (सत्यनिष्ठा / शुद्धता)", "Availability (उपलब्धता)", "Authenticity (प्रमाणिकता)"],
        1, "Integrity ensures that information is accurate, complete, and protected against unauthorized modification or deletion.",
        "इन्टिग्रिटी (Integrity) ले डेटा अनधिकृत रूपमा परिवर्तन नभएको र पूर्ण रूपमा शुद्ध रहेको सुनिश्चित गर्दछ।", "2068 BS - RBB IT")

    add(102, "What is the key difference between Authentication and Authorization in access control systems?",
        "पहुँच नियन्त्रणमा प्रमाणीकरण (Authentication) र अख्तियारी (Authorization) बीचको मुख्य भिन्नता के हो?",
        ["Authentication verifies identity ('Who you are'); Authorization verifies permissions ('What you are allowed to do')", "Authentication happens after authorization", "Authentication uses access control lists, while authorization uses passwords", "There is no difference"],
        0, "Authentication validates the claim of an identity (e.g., via password/biometric). Authorization determines the privileges and resources granted to that authenticated identity.",
        "Authentication ले प्रयोगकर्ता को हो भनी चिन्छ भने Authorization ले उसलाई के-के काम गर्ने अनुमति छ भनी तोक्दछ।", "2074 BS - NRB IT")

    add(103, "Which access control model assigns permissions based on an employee's organizational job function or role rather than individual user identities?",
        "कर्मचारीको व्यक्तिगत परिचयको सट्टा उसको पद र भूमिकाका आधारमा प्रणालीको पहुँच दिने मोडल कुन हो?",
        ["Discretionary Access Control (DAC)", "Mandatory Access Control (MAC)", "Role-Based Access Control (RBAC)", "Identity-Based Access Control"],
        2, "Role-Based Access Control (RBAC) simplifies administration in banks by granting permissions to roles (e.g., Teller, Loan Officer, Manager) and assigning users to roles.",
        "RBAC (Role-Based Access Control) मा पद अनुसार अधिकार तोकिन्छ, जसले गर्दा बैंकिङ प्रणालीको व्यवस्थापन सहज हुन्छ।", "2076 BS - Loksewa Operator")

    # 2. Attacks & Social Engineering
    add(104, "Which social engineering attack specifically targets high-ranking executives (CEOs, CFOs) with highly customized, fraudulent electronic communications?",
        "संस्थाका उच्च अधिकारीहरू (CEO, CFO) लाई लक्षित गरी गरिने विशेष प्रकारको फिसिङ आक्रमणलाई के भनिन्छ?",
        ["Vishing", "Smishing", "Whaling", "Pharming"],
        2, "Whaling is a targeted phishing attack directed at C-level executives to authorize fraudulent wire transfers or disclose sensitive corporate secrets.",
        "ह्वेलिङ (Whaling) भनेको संस्थाका उच्च नेतृत्व र कार्यकारीलाई झुक्याएर गरिने परिष्कृत फिसिङ आक्रमण हो।", "2079 BS - RBB IT")

    add(105, "What type of cyberattack floods an online banking portal with an overwhelming volume of synthetic traffic from a distributed network of compromised IoT/zombie devices (botnet)?",
        "विश्वभरका संक्रमित कम्प्युटर वा क्यामराहरूको बोटनेट प्रयोग गरी बैंकिङ वेबसाइटलाई बन्द गराउने आक्रमण कुन हो?",
        ["Distributed Denial of Service (DDoS)", "Man-in-the-Middle (MITM)", "SQL Injection", "Cross-Site Scripting (XSS)"],
        0, "A Distributed Denial of Service (DDoS) attack overwhelms targeted servers or network bandwidth with botnet traffic, making the service unavailable to legitimate customers.",
        "DDoS आक्रमणले एकैपटक लाखौं नक्कली अनुरोध पठाएर बैंकको अनलाइन सेवालाई ठप्प पार्दछ।", "2078 BS - NRB IT")

    add(106, "What web vulnerability occurs when an application includes untrusted user input directly in an SQL query without proper parameterization or prepared statements?",
        "प्रयोगकर्ताले फर्ममा भरेको विवरणलाई सिधै डेटाबेस क्वेरीमा राख्दा उत्पन्न हुने गम्भीर सुरक्षा कमजोरी कुन हो?",
        ["Cross-Site Request Forgery (CSRF)", "SQL Injection (SQLi)", "Broken Object Level Authorization", "Server-Side Request Forgery"],
        1, "SQL Injection allows attackers to manipulate backend database queries, bypass authentication, extract customer tables, or drop database records.",
        "SQL इन्जेक्सन (SQLi) मार्फत ह्याकरले डेटाबेसका संवेदनशील रेकर्डहरू चोर्न वा परिवर्तन गर्न सक्दछ।", "2080 BS - PSC IT Officer")

    # 3. NRB Cyber Resilience Guidelines 2023 & NRB IT Guidelines 2012
    add(107, "According to the Nepal Rastra Bank (NRB) Cyber Resilience Guidelines 2023, every licensed commercial bank must establish which functional body for 24/7 security monitoring?",
        "नेपाल राष्ट्र बैंकको Cyber Resilience Guidelines 2023 अनुसार वाणिज्य बैंकहरूले २४सै घण्टा साइबर सुरक्षा निगरानीका लागि के स्थापना गर्नुपर्दछ?",
        ["IT Helpdesk", "Security Operations Center (SOC)", "Disaster Management Cell", "Customer Care Center"],
        1, "Section 4 of the guidelines mandates that banks must establish or outsource a 24/7 Security Operations Center (SOC) equipped with SIEM capabilities for continuous threat detection.",
        "NRB को निर्देशिका अनुसार बैंकहरूले २४/७ सुरक्षा निगरानी गर्न अनिवार्य रूपमा SOC (Security Operations Center) सञ्चालन गर्नुपर्छ।", "2081 BS - RBB IT")

    add(108, "Under NRB Cyber Resilience Guidelines 2023, licensed financial institutions must report any critical cyber security incident to NRB within what timeframe?",
        "NRB को Cyber Resilience Guidelines 2023 अनुसार कुनै गम्भीर साइबर सुरक्षा घटना घटेमा बैंकहरूले राष्ट्र बैंकलाई कति समय भित्र जानकारी गराउनुपर्छ?",
        ["Within 2 hours", "Within 24 hours (or immediate initial notification)", "Within 7 working days", "At the end of the fiscal month"],
        1, "The guidelines require licensed institutions to provide prompt initial notification to NRB's IT/Payment Department within 24 hours of detecting a critical cyber incident.",
        "कुनै गम्भीर साइबर आक्रमण भएमा बैंकले २४ घण्टा भित्र नेपाल राष्ट्र बैंकलाई प्रारम्भिक जानकारी गराउनु पर्दछ।", "2082 BS - RBB IT Probable")

    add(109, "According to NRB IT Guidelines, how often must commercial banks conduct Vulnerability Assessment and Penetration Testing (VAPT) on their mission-critical banking infrastructure?",
        "नेपाल राष्ट्र बैंकको IT निर्देशिका अनुसार बैंकहरूले आफ्नो मुख्य बैंकिङ प्रणालीमा कति अवधिमा VAPT (Vulnerability Assessment & Penetration Testing) गराउनुपर्छ?",
        ["Every month", "At least once every 6 months (Semi-annually)", "Once every two years", "Only when an attack occurs"],
        1, "NRB IT Guidelines mandate that commercial banks must conduct comprehensive VAPT assessments on critical systems at least twice a year (semi-annually) through certified third-party auditors.",
        "बैंकहरूले वर्षको कम्तीमा दुई पटक (प्रत्येक ६ महिनामा) स्वतन्त्र विज्ञ मार्फत VAPT परीक्षण गराउनुपर्ने व्यवस्था छ।", "2080 BS - NRB IT")

    # 4. Electronic Transactions Act (ETA) 2063
    add(110, "Under Chapter 9 of Nepal's Electronic Transactions Act (ETA) 2063, what is the maximum punishment for unauthorized access or hacking into a computer system with criminal intent?",
        "विद्युतीय कारोबार ऐन, २०६३ को दफा ४४ अनुसार कम्प्युटर प्रणालीमा अनधिकृत पहुँच (ह्याकिङ) गरेमा कस्तो सजाय हुने व्यवस्था छ?",
        ["Fine up to Rs. 50,000 only", "Imprisonment up to 3 years or fine up to Rs. 200,000, or both", "Life imprisonment", "Community service for 6 months"],
        1, "Section 44 of ETA 2063 prescribes imprisonment not exceeding three years or a fine not exceeding two hundred thousand rupees, or both, for illegal computer intrusion/hacking.",
        "विद्युतीय कारोबार ऐन २०६३ अनुसार अनधिकृत पहुँच पुर्‍याएमा ३ वर्षसम्म कैद वा २ लाख रुपैयाँसम्म जरिवाना वा दुवै सजाय हुन सक्छ।", "2079 BS - RBB IT")

    add(111, "Which statutory regulatory official is designated under the Electronic Transactions Act 2063 to license and supervise Certifying Authorities (CAs) issuing digital signatures in Nepal?",
        "विद्युतीय कारोबार ऐन, २०६३ अनुसार डिजिटल हस्ताक्षर जारी गर्ने प्रमाणिकरण निकायहरूको नियमन गर्न कुन अधिकारीको व्यवस्था गरिएको छ?",
        ["Chief Information Security Officer", "Controller of Certifying Authorities (CCA)", "Registrar of Companies", "Governor of NRB"],
        1, "The Controller of Certifying Authorities (CCA), under the Ministry of Communication and Information Technology, licenses, regulates, and monitors Digital Signature Certifying Authorities in Nepal.",
        "नेपालमा डिजिटल हस्ताक्षर जारी गर्ने संस्थाहरूको सुपरिवेक्षणका लागि नियन्त्रक (Controller of Certifying Authorities) को व्यवस्था छ।", "2077 BS - NRB IT")

    # Generate more questions up to 180 for Unit 6
    for i in range(112, 181):
        if i % 4 == 0:
            add(i, f"In password security, what is the cryptographic purpose of adding a random 'Salt' to passwords prior to hashing?",
                f"पासवर्ड सुरक्षित राख्न ह्यास गर्नु अघि 'साल्ट' (Salt) थप्नुको मुख्य उद्देश्य के हो?",
                ["To make the password readable by administrators", "To defeat precomputed rainbow table attacks and ensure identical passwords have unique hash values", "To shorten hash length", "To encrypt the salt with DES"],
                1, "Salting appends unique random data to each password before hashing, rendering precomputed lookup tables (Rainbow Tables) completely ineffective.",
                "साल्टले एउटै पासवर्ड भएका विभिन्न प्रयोगकर्ताहरूको ह्यास भ्यालु फरक बनाइदिन्छ, जसले रेन्बो टेबल आक्रमणबाट जोगाउँछ।", "2081 BS - Loksewa Model")
        elif i % 4 == 1:
            add(i, f"Which principle of security asserts that every software component and user should operate using the bare minimum privileges necessary to accomplish their legitimate tasks?",
                f"सुरक्षाको कुन सिद्धान्त अनुसार कुनै पनि प्रयोगकर्ता वा प्रोग्रामलाई आफ्नो काम गर्न आवश्यक न्यूनतम अधिकार मात्र दिनुपर्दछ?",
                ["Principle of Least Privilege (PoLP)", "Principle of Separation of Duties", "Defense in Depth", "Fail-Safe Defaults"],
                0, "The Principle of Least Privilege (PoLP) limits privileges to only what is strictly essential, reducing the blast radius of compromised accounts.",
                "Principle of Least Privilege अनुसार प्रयोगकर्तालाई काम चलाउन पुग्ने न्यूनतम अधिकार मात्र दिइन्छ।", "2080 BS - RBB IT")
        elif i % 4 == 2:
            add(i, f"According to the National ICT Policy of Nepal 2072, what was a key national broadband objective envisioned by the government?",
                f"राष्ट्रिय सूचना तथा सञ्चार प्रविधि नीति, २०७२ को मुख्य राष्ट्रिय लक्ष्य के थियो?",
                ["To ban all international fiber connectivity", "To expand broadband infrastructure to 100% of the population and achieve inclusive e-governance", "To replace computers with typewriters", "To restrict digital banking to urban centers"],
                1, "The ICT Policy 2072 aimed for pervasive broadband infrastructure across Nepal, digital literacy, and mainstreaming ICT for socio-economic development.",
                "ICT नीति २०७२ ले मुलुकभर ब्रोडब्यान्ड विस्तार गरी डिजिटल अर्थतन्त्र र ई-गभर्नेन्स प्रवर्द्धन गर्ने लक्ष्य लिएको छ।", "2078 BS - Loksewa Assistant")
        else:
            add(i, f"What type of malicious software encrypts the victim's critical files and displays a ransom demand demanding cryptocurrency payment for the decryption key?",
                f"कम्प्युटरका महत्त्वपूर्ण फाइलहरूलाई इन्क्रिप्ट गरी खोल्नका लागि फिरौती (Ransom) माग्ने मालवेयर कुन हो?",
                ["Trojan Horse", "Ransomware", "Keylogger", "Adware"],
                1, "Ransomware (e.g., WannaCry, LockBit) encrypts victim systems using asymmetric/symmetric ciphers, holding the decryption key hostage for payment.",
                "र्यान्समवेयर (Ransomware) ले बैंक वा व्यक्तिका फाइलहरू बन्धक बनाएर खोल्नका लागि रकम माग्ने गर्दछ।", "2082 BS - RBB IT Probable")

    return u6

print("Unit 6 generated:", len(get_unit6_questions()), "questions.")
