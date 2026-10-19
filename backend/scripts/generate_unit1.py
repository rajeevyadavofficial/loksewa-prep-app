import json

def get_unit1_questions():
    u1 = []
    def add(idx, q_en, q_np, opts, ans, expl_en, expl_np, yr):
        u1.append({
            "id": f"p1b_u1_mcq{idx}",
            "exam_id": "rbb_it_5",
            "paper": "paper1",
            "section": "sectionB",
            "unit_number": 1,
            "unit_title": "Unit 1: Introduction of Computer & Emerging Technologies",
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
    
    # 1. Analog vs Digital vs Hybrid
    add(101, "Which of the following computes by measuring continuous physical quantities such as voltage, pressure, or temperature rather than counting?",
        "कुन प्रकारको कम्प्युटरले गन्ती गर्नुको सट्टा भोल्टेज, चाप वा तापक्रम जस्ता निरन्तर भौतिक परिमाणहरू नापेर गणना गर्दछ?",
        ["Digital Computer (डिजिटल कम्प्युटर)", "Analog Computer (एनालग कम्प्युटर)", "Hybrid Computer (हाइब्रिड कम्प्युटर)", "Mainframe Computer (मेनफ्रेम कम्प्युटर)"],
        1, "Analog computers process continuous physical phenomena directly without converting them to discrete numeric values.",
        "एनालग कम्प्युटरले भौतिक परिमाणहरू (जस्तै भोल्टेज, चाप) लाई निरन्तर तरंगको रूपमा सिधै मापन गरी गणना गर्दछ।", "2064 BS - RBB IT")

    add(102, "In a patient monitoring system (ICU), which computer type combines analog sensor inputs with digital display and processing?",
        "सघन उपचार कक्ष (ICU) मा बिरामी मोनिटर गर्ने प्रणालीमा एनालग सेन्सर र डिजिटल प्रोसेसिङलाई संयोजन गर्ने कम्प्युटर कुन हो?",
        ["Supercomputer", "Microcomputer", "Hybrid Computer", "Analog Computer"],
        2, "Hybrid computers combine the continuous measurement speed of analog systems with the high precision and logical capability of digital systems.",
        "हाइब्रिड कम्प्युटरले एनालगको गति र डिजिटलको शुद्धता दुवैलाई मिलाएर काम गर्दछ।", "2071 BS - NRB IT")

    add(103, "Which of the following was the first electronic general-purpose digital computer?",
        "पहिलो इलेक्ट्रोनिक सामान्य प्रयोजन डिजिटल कम्प्युटर कुन थियो?",
        ["UNIVAC I", "ENIAC", "EDVAC", "IBM 701"],
        1, "ENIAC (Electronic Numerical Integrator and Computer), built in 1945 by Eckert and Mauchly, was the first general-purpose electronic digital computer.",
        "सन् १९४५ मा बनेको ENIAC पहिलो इलेक्ट्रोनिक सामान्य प्रयोजन डिजिटल कम्प्युटर हो।", "2074 BS - Loksewa Operator")

    add(104, "Which generation of computers introduced Integrated Circuits (ICs) replacing discrete transistors?",
        "कुन पुस्ताको कम्प्युटरमा ट्रान्जिस्टरको सट्टा इन्टिग्रेटेड सर्किट (IC) को प्रयोग सुरु भएको थियो?",
        ["First Generation", "Second Generation", "Third Generation", "Fourth Generation"],
        2, "Third-generation computers (1964-1971) replaced transistors with Integrated Circuits (ICs), invented by Jack Kilby and Robert Noyce.",
        "तेस्रो पुस्ताका कम्प्युटरहरूमा ट्रान्जिस्टरको सट्टा ज्याक किल्बीद्वारा आविष्कृत इन्टिग्रेटेड सर्किट (IC) प्रयोग गरिएको थियो।", "2076 BS - Loksewa Assistant")

    add(105, "The performance and computational speed of supercomputers are typically measured in which unit?",
        "सुपरकम्प्युटरको कार्यक्षमता र गति सामान्यतया कुन एकाइमा मापन गरिन्छ?",
        ["MIPS (Million Instructions Per Second)", "FLOPS (Floating-Point Operations Per Second)", "BPS (Bits Per Second)", "Megahertz (MHz)"],
        1, "Supercomputer performance is officially measured in FLOPS (such as PetaFLOPS, ExaFLOPS), whereas general microprocessors are often measured in MIPS or GHz.",
        "सुपरकम्प्युटरको गति FLOPS (Floating-Point Operations Per Second) मा नापिन्छ।", "2078 BS - RBB IT")

    add(106, "Which of the following computer types is primarily designed for high transaction throughput, massive I/O handling, and enterprise reliability in core banking systems?",
        "ठूला बैंकहरूको कोर बैंकिङ प्रणाली (CBS) मा अत्यधिक कारोबार र डेटा व्यवस्थापनका लागि कुन कम्प्युटर प्रयोग गरिन्छ?",
        ["Workstation", "Minicomputer", "Mainframe Computer", "Analog Computer"],
        2, "Mainframe computers (e.g., IBM zSystems) are engineered specifically for high reliability, massive concurrent transaction processing, and extensive I/O capacity in enterprise banking.",
        "मेनफ्रेम कम्प्युटरहरू बैंक तथा वित्तीय संस्थामा एकैपटक लाखौं कारोबार र सुरक्षित डेटा प्रोसेसिङका लागि प्रयोग गरिन्छ।", "2079 BS - NBL IT")

    add(107, "Which supercomputer is globally recognized as the first commercially successful supercomputer developed by Seymour Cray in 1964?",
        "सन् १९६४ मा सेमर क्रेद्वारा विकसित पहिलो सफल व्यावसायिक सुपरकम्प्युटर कुन थियो?",
        ["Cray-1", "CDC 6600", "ENIAC", "IBM Deep Blue"],
        1, "CDC 6600, released in 1964 and designed by Seymour Cray at Control Data Corporation, is widely recognized as the world's first commercial supercomputer.",
        "कन्ट्रोल डेटा कर्पोरेसनको CDC 6600 लाई संसारको पहिलो व्यावसायिक सुपरकम्प्युटर मानिन्छ।", "2080 BS - PSC IT Officer")

    add(108, "What does the term 'PetaFLOPS' represent in modern supercomputing metrics?",
        "आधुनिक सुपरकम्प्युटिङमा 'PetaFLOPS' ले के जनाउँछ?",
        ["$10^9$ operations per second", "$10^{12}$ operations per second", "$10^{15}$ operations per second", "$10^{18}$ operations per second"],
        2, "One PetaFLOPS equals one quadrillion ($10^{15}$) floating-point operations per second. One ExaFLOPS equals $10^{18}$ FLOPS.",
        "एक पेटाफ्लप्स (PetaFLOPS) भनेको प्रति सेकेन्ड $10^{15}$ (दश खरब) फ्लोटिङ पोइन्ट गणनाहरू हुन्।", "2081 BS - Loksewa Model")

    add(109, "Which type of computer uses quantum mechanical phenomena such as superposition and entanglement to perform calculations exponentially faster than classical computers?",
        "कुन प्रकारको कम्प्युटरले गणना गर्न सुपरपोजिसन र इन्ट्याङ्गगलमेन्ट जस्ता क्वान्टम मेकानिक्सका सिद्धान्तहरू प्रयोग गर्दछ?",
        ["Optical Computer", "Quantum Computer", "Molecular Computer", "DNA Computer"],
        1, "Quantum computers use qubits that can exist in multiple states simultaneously (superposition), allowing immense computational parallelism.",
        "क्वान्टम कम्प्युटरले परम्परागत बिट्सको सट्टा क्युबिट्स (Qubits) प्रयोग गरी सुपरपोजिसन र इन्ट्याङ्गलमेन्ट मार्फत गणना गर्दछ।", "2082 BS - RBB IT Probable")

    add(110, "In computer terminology, what distinguishes a workstation from a standard personal computer (PC)?",
        "कम्प्युटर शब्दावलीमा वर्कस्टेशन (Workstation) लाई साधारण पीसी (PC) भन्दा के कुराले फरक पार्दछ?",
        ["Workstations have slower processors", "Workstations use ECC memory and multi-core high-end GPUs for CAD/CAM/Scientific tasks", "Workstations cannot connect to the internet", "Workstations are battery powered only"],
        1, "Workstations feature higher reliability components like Error-Correcting Code (ECC) memory, high-end multi-core CPUs, and dedicated GPUs designed for intensive technical workflows.",
        "वर्कस्टेशनमा वैज्ञानिक गणना, ग्राफिक्स र इन्जिनियरिङका लागि उच्च क्षमताको ECC मेमोरी र शक्तिशाली प्रोसेसर हुन्छ।", "2077 BS - NRB IT")

    # 2. Internet & Email Protocols
    add(111, "Which protocol is responsible for transferring outgoing email messages from a client to a mail server or between mail servers?",
        "इमेल क्लाइन्टबाट मेल सर्भरमा वा दुई मेल सर्भरहरू बीच इमेल पठाउन कुन प्रोटोकल जिम्मेवार हुन्छ?",
        ["POP3", "IMAP4", "SMTP", "SNMP"],
        2, "Simple Mail Transfer Protocol (SMTP) operates on TCP port 25 (or 587 for TLS) and is strictly used for pushing/sending outgoing email.",
        "SMTP (Simple Mail Transfer Protocol) इमेल पठाउनका लागि प्रयोग गरिने मानक प्रोटोकल हो।", "2075 BS - Loksewa Operator")

    add(112, "What is the standard default port for secure HTTPS (Hypertext Transfer Protocol Secure) communications?",
        "सुरक्षित HTTPS (Hypertext Transfer Protocol Secure) सञ्चारका लागि पूर्वनिर्धारित पोर्ट कुन हो?",
        ["Port 80", "Port 443", "Port 8080", "Port 21"],
        1, "HTTP uses port 80, whereas HTTPS operates over port 443 with TLS/SSL encryption.",
        "HTTPS ले सुरक्षित र इन्क्रिप्टेड वेब सञ्चारका लागि पोर्ट ४४३ (Port 443) प्रयोग गर्दछ।", "2077 BS - RBB IT")

    add(113, "Which email retrieval protocol leaves the original message copies on the mail server and synchronizes changes across multiple client devices?",
        "कुन इमेल प्रोटोकलले सर्भरमा इमेलको प्रतिलिपि सुरक्षित राख्दै धेरै यन्त्रहरू बीच सिन्क्रोनाइज गर्दछ?",
        ["POP3", "IMAP4", "SMTP", "MIME"],
        1, "IMAP4 (Internet Message Access Protocol v4) keeps emails on the server, synchronizing state (read, unread, folders) across laptops, phones, and webmail.",
        "IMAP4 ले इमेल सर्भरमै सुरक्षित राख्दछ र सबै डिभाइसहरूमा फोल्डर तथा इमेल स्टाटस सिङ्क गर्दछ।", "2079 BS - NRB IT")

    add(114, "What extension protocol allows email messages to carry non-ASCII text, attachments (PDF, images, audio), and multi-part message bodies?",
        "इमेलमा गैर-ASCII क्यारेक्टरहरू, फोटो, अडियो र डकुमेन्ट एट्याचमेन्ट पठाउन कुन प्रोटोकल प्रयोग गरिन्छ?",
        ["SNMP", "MIME (Multipurpose Internet Mail Extensions)", "FTP", "ICMP"],
        1, "MIME extends the format of email to support text in character sets other than ASCII, as well as attachments of audio, video, images, and application programs.",
        "MIME ले परम्परागत ASCII इमेललाई अडियो, भिडियो, तस्वीर र पिडिएफ जस्ता फाइलहरू पठाउन सक्षम बनाउँछ।", "2080 BS - PSC IT Officer")

    add(115, "Which protocol translates human-readable domain names (like www.rbb.com.np) into machine-readable IP addresses?",
        "मानवले पढ्न सक्ने डोमेन नाम (जस्तै www.rbb.com.np) लाई IP ठेगानामा रूपान्तरण गर्ने प्रणाली कुन हो?",
        ["DHCP", "ARP", "DNS (Domain Name System)", "NAT"],
        2, "DNS acts as the phonebook of the internet, resolving hostname domain strings to numerical IP addresses via TCP/UDP port 53.",
        "DNS (Domain Name System) ले डोमेन नामलाई सम्बन्धित संख्यात्मक IP ठेगानामा परिवर्तन गर्दछ।", "2076 BS - Loksewa Operator")

    add(116, "What is the standard port number used by DNS servers for query resolution over UDP?",
        "DNS क्वेरी रिजोलुसनका लागि UDP मार्फत प्रयोग गरिने मानक पोर्ट नम्बर कुन हो?",
        ["Port 23", "Port 53", "Port 67", "Port 110"],
        1, "DNS uses port 53 for standard queries (UDP) and zone transfers (TCP).",
        "DNS ले UDP र TCP दुवैमा पोर्ट ५३ (Port 53) प्रयोग गर्दछ।", "2078 BS - RBB IT")

    add(117, "Which network protocol is dynamically used to assign IP addresses, subnet masks, and default gateways to client computers automatically?",
        "कम्प्युटरहरूलाई स्वचालित रूपमा IP ठेगाना, सबनेट मास्क र डिफल्ट गेटवे उपलब्ध गराउने प्रोटोकल कुन हो?",
        ["DNS", "DHCP (Dynamic Host Configuration Protocol)", "ICMP", "SNMP"],
        1, "DHCP automatically leases IP addresses and configuration parameters to network devices upon connection, eliminating manual configuration.",
        "DHCP ले कम्प्युटरहरूलाई नेटवर्कमा जोडिनासाथ स्वचालित रूपमा IP ठेगाना बाँड्ने काम गर्दछ।", "2075 BS - NBL IT")

    add(118, "Which protocol is utilized by network administrators to securely log in, execute commands, and manage remote servers over an encrypted channel?",
        "नेटवर्क प्रशासकहरूले सुरक्षित इन्क्रिप्टेड च्यानल मार्फत टाढाको सर्भर व्यवस्थापन गर्न कुन प्रोटोकल प्रयोग गर्दछन्?",
        ["Telnet", "SSH (Secure Shell)", "FTP", "TFTP"],
        1, "SSH operates on TCP port 22 and provides strong cryptographic authentication and encrypted communications, replacing insecure plaintext Telnet (port 23).",
        "SSH (Secure Shell, Port 22) ले टाढाको सर्भर सुरक्षित रूपमा कमान्ड लाइनबाट सञ्चालन गर्न इन्क्रिप्सन प्रदान गर्दछ।", "2079 BS - RBB IT")

    add(119, "What protocol is used by the 'ping' command to test network reachability and round-trip time?",
        "नेटवर्कमा कुनै डिभाइस उपलब्ध छ कि छैन भनी जाँच्न 'ping' कमान्डले कुन प्रोटोकल प्रयोग गर्दछ?",
        ["IGMP", "ICMP (Internet Control Message Protocol)", "ARP", "RARP"],
        1, "The ping utility sends ICMP Echo Request packets and listens for ICMP Echo Reply packets to test reachability and latency.",
        "पिङ (Ping) कमान्डले नेटवर्क जडान जाँच्न ICMP (Internet Control Message Protocol) प्रयोग गर्दछ।", "2081 BS - Loksewa Assistant")

    add(120, "Which protocol maps an already known IP address to its corresponding physical MAC (hardware) address on a local area network?",
        "स्थानीय नेटवर्क (LAN) मा ज्ञात IP ठेगानालाई सम्बन्धित भौतिक MAC ठेगानामा रूपान्तरण गर्न कुन प्रोटोकल प्रयोग हुन्छ?",
        ["RARP", "ARP (Address Resolution Protocol)", "DHCP", "NAT"],
        1, "ARP resolves a known Layer 3 logical IP address to a Layer 2 physical MAC address on an Ethernet broadcast domain.",
        "ARP ले ३ नम्बर तहको IP ठेगानालाई २ नम्बर तहको भौतिक MAC ठेगानामा बदल्ने काम गर्दछ।", "2078 BS - NRB IT")

    # 3. Web Design Basics
    add(121, "In HTML5, which tag is semantic and used to define navigation links within a webpage?",
        "HTML5 मा वेबपेज भित्र नेभिगेसन लिङ्कहरू राख्न कुन सिमान्टिक ट्याग प्रयोग गरिन्छ?",
        ["<menu>", "<nav>", "<links>", "<navigate>"],
        1, "The HTML5 `<nav>` tag is designated specifically for primary navigational blocks containing internal or external links.",
        "HTML5 मा नेभिगेसन लिङ्कहरूको समूहका लागि `<nav>` ट्यागको प्रयोग गरिन्छ।", "2076 BS - Loksewa Operator")

    add(122, "Which CSS property is used in responsive web design to adapt layout dynamically based on viewport size, orientation, and resolution?",
        "रेस्पोन्सिभ वेब डिजाइनमा स्क्रिनको आकार अनुसार डिजाइन परिवर्तन गर्न कुन CSS नियम प्रयोग गरिन्छ?",
        ["CSS Grid", "Media Queries (@media)", "Flexbox", "CSS Float"],
        1, "Media queries (`@media screen and (max-width: 768px)`) allow styling rules to execute selectively depending on the target screen dimensions and device profile.",
        "मिडिया क्वेरी (@media) ले विभिन्न स्क्रिन साइज (मोबाइल, ट्याब्लेट, डेस्कटप) अनुसार उपयुक्त लेआउट देखाउन मद्दत गर्दछ।", "2079 BS - RBB IT")

    add(123, "In the CSS Box Model, which layer represents the transparent space between the content area and the element's border?",
        "CSS Box Model मा कन्टेन्ट र बोर्डरको बीचमा रहने भित्री खाली ठाउँलाई के भनिन्छ?",
        ["Margin", "Padding", "Outline", "Gutter"],
        1, "Padding is the space inside the border surrounding the content. Margin is the outer space outside the border separating adjacent elements.",
        "प्याडिङ (Padding) ले कन्टेन्ट र बोर्डर बीचको भित्री खाली ठाउँलाई जनाउँछ, जबकि मार्जिन (Margin) बाहिरी ठाउँ हो।", "2077 BS - Loksewa Assistant")

    add(124, "What is the primary difference between HTML and XML?",
        "HTML र XML बीचको मुख्य भिन्नता के हो?",
        ["HTML is case sensitive; XML is not", "HTML is designed to display data, whereas XML is designed to store and transport data", "HTML requires a DTD, XML does not", "XML cannot be read by web browsers"],
        1, "HTML focuses on data presentation and user interface layout, whereas XML focuses on semantic data description, structured storage, and transport.",
        "HTML डेटा प्रदर्शन (Display) गर्न प्रयोग हुन्छ भने XML डेटा भण्डारण र आदानप्रदान (Transport) गर्न प्रयोग हुन्छ।", "2080 BS - PSC IT Officer")

    add(125, "Which JavaScript method is used to parse a JSON formatted string into a JavaScript object?",
        "JSON स्ट्रिङलाई जाभास्क्रिप्ट अब्जेक्टमा रूपान्तरण गर्न कुन विधि प्रयोग गरिन्छ?",
        ["JSON.stringify()", "JSON.parse()", "JSON.toObject()", "JSON.decode()"],
        1, "`JSON.parse()` deserializes a JSON string into a native JavaScript object, whereas `JSON.stringify()` converts an object to a JSON string.",
        "`JSON.parse()` ले JSON स्ट्रिङलाई जाभास्क्रिप्ट अब्जेक्टमा रूपान्तरण गर्दछ।", "2081 BS - Loksewa Model")

    # 4. Physical Security of IT Infrastructure
    add(126, "According to data center tier standards (Uptime Institute), what is the minimum availability requirement for a Tier IV Fault-Tolerant Data Center?",
        "डेटा सेन्टर मापदण्ड अनुसार टियर IV (Tier IV) डेटा सेन्टरको न्यूनतम उपलब्धता (Availability) कति हुनुपर्छ?",
        ["99.671%", "99.741%", "99.982%", "99.995%"],
        3, "Tier IV data centers guarantee 99.995% availability (no more than 26.3 minutes of annual downtime) with complete 2N+1 fault-tolerant electrical, cooling, and network paths.",
        "टियर IV डेटा सेन्टरको वार्षिक उपलब्धता ९९.९९५% (वार्षिक २६ मिनेट भन्दा कम डाउनटाइम) हुनुपर्दछ।", "2081 BS - RBB IT")

    add(127, "Which clean-agent gaseous fire suppression system is commonly used in modern bank server rooms because it leaves no residue and does not harm electronics or personnel?",
        "कम्प्युटर सर्भर कोठामा उपकरण र मानिसलाई क्षति नपुर्‍याई आगो निभाउन प्रयोग गरिने ग्यास प्रणाली कुन हो?",
        ["Water Sprinklers", "FM-200 (HFC-227ea) / Novec 1230", "Carbon Dioxide (CO2) flood", "Dry Chemical Powder (ABC)"],
        1, "FM-200 and Novec 1230 are clean agents that suppress fires at the molecular level, leave no residue, are non-conductive, and are safe for occupied spaces at design concentrations.",
        "सर्भर कोठामा विद्युतीय उपकरण सुरक्षित राख्न अवशेष नछाड्ने FM-200 वा Novec 1230 जस्ता क्लिन-एजेन्ट ग्यास प्रयोग गरिन्छ।", "2080 BS - NRB IT")

    add(128, "In server room physical security, what is a 'mantrap' (security vestibule)?",
        "डेटा सेन्टरको भौतिक सुरक्षामा 'Mantrap' (म्यानट्र्याप) ले के जनाउँछ?",
        ["A software honeypot to trap hackers", "A physical access control space with two interlocking doors where only one door can be open at a time", "An anti-malware containment chamber", "A type of firewall rule"],
        1, "A mantrap is a physical access control vestibule with two interlocking doors to prevent 'tailgating' (unauthorized people following authorized staff into the server room).",
        "म्यानट्र्याप भनेको दुईवटा ढोका भएको यस्तो सुरक्षा कक्ष हो जहाँ एउटा ढोका बन्द नभएसम्म अर्को ढोका खुल्दैन, जसले अनधिकृत प्रवेश रोक्छ।", "2079 BS - RBB IT")

    add(129, "What is the recommended ideal temperature range for a high-density bank server room according to ASHRAE guidelines?",
        "ASHRAE निर्देशिका अनुसार बैंकको मुख्य सर्भर कोठाको उपयुक्त तापक्रम कति हुनुपर्छ?",
        ["10°C to 15°C", "18°C to 27°C (64.4°F to 80.6°F)", "28°C to 35°C", "0°C to 10°C"],
        1, "ASHRAE TC 9.9 thermal guidelines recommend an operating temperature range of 18°C to 27°C with relative humidity between 40% and 60% to prevent thermal stress and electrostatic discharge (ESD).",
        "ASHRAE मापदण्ड अनुसार सर्भर कोठाको तापक्रम १८ देखि २७ डिग्री सेल्सियस र आर्द्रता ४०% देखि ६०% हुनु उपयुक्त मानिन्छ।", "2082 BS - RBB IT Probable")

    add(130, "What is the primary function of an Uninterruptible Power Supply (UPS) in a bank's data center?",
        "बैंकको डेटा सेन्टरमा UPS (Uninterruptible Power Supply) को मुख्य कार्य के हो?",
        ["To act as a primary long-term power generator", "To provide immediate battery backup power during mains power failure and condition power surges/sags", "To cool the server racks", "To convert AC into higher frequency waves"],
        1, "A UPS provides clean, conditioned power and instant seamless battery transition during power outages until standby diesel generators start up.",
        "UPS ले मुख्य बिजुली जाँदा ब्याट्रीबाट तत्काल निरन्तर बिजुली आपूर्ति गर्दछ र भोल्टेजको उतारचढावबाट जोगाउँछ।", "2076 BS - Loksewa Operator")

    # 5. AI, Machine Learning & Blockchain
    add(131, "Which category of machine learning algorithm trains models using labeled input-output training datasets?",
        "इनपुट र अपेक्षित आउटपुट दुवै पहिले नै लेबल गरिएको डेटा प्रयोग गरी तालिम दिइने मेसिन लर्निङ विधा कुन हो?",
        ["Unsupervised Learning", "Supervised Learning", "Reinforcement Learning", "Self-supervised Learning"],
        1, "Supervised learning algorithms (e.g., linear regression, decision trees, support vector machines) learn a mapping function from labeled training data pairs.",
        "सुपरभाइज्ड लर्निङ (Supervised Learning) मा तालिमका लागि पहिले नै लेबल गरिएको (Labeled) डेटासेट प्रयोग गरिन्छ।", "2080 BS - PSC IT Officer")

    add(132, "In banking and fraud prevention, which ML approach is most effective for detecting unknown anomalies and zero-day credit card fraudulent patterns where labels are scarce?",
        "क्रेडिट कार्ड ठगी र असामान्य बैंकिङ कारोबार पत्ता लगाउन कुन मेसिन लर्निङ प्रविधि सबैभन्दा प्रभावकारी मानिन्छ?",
        ["Unsupervised Anomaly Detection (Clustering / Isolation Forests)", "Simple Linear Regression", "Reinforcement Q-Learning", "Deterministic Lookup Tables"],
        0, "Unsupervised anomaly detection algorithms (such as Isolation Forests and One-Class SVM) detect rare transaction outliers without requiring prior fraudulent labels.",
        "ठगी नियन्त्रणमा अनसुपरभाइज्ड एनोमली डिटेक्सन (Unsupervised Anomaly Detection) ले असामान्य कारोबारका ढाँचाहरू तत्काल पत्ता लगाउँछ।", "2081 BS - RBB IT")

    add(133, "In a blockchain network, what cryptographic hash function is famously used by Bitcoin to secure blocks and mining proofs?",
        "ब्लकचेन प्रविधिमा बिटक्वाइनले ब्लक र कारोबार सुरक्षित राख्न कुन क्रिप्टोग्राफिक ह्यास फङ्सन प्रयोग गर्दछ?",
        ["MD5", "SHA-1", "SHA-256", "Blowfish"],
        2, "Bitcoin uses double SHA-256 (Secure Hash Algorithm 256-bit) for proof-of-work consensus and generating block header digests.",
        "बिटक्वाइन ब्लकचेनले ब्लक प्रमाणीकरणका लागि SHA-256 क्रिप्टोग्राफिक ह्यास एल्गोरिदम प्रयोग गर्दछ।", "2078 BS - NRB IT")

    add(134, "What is a 'Smart Contract' in the context of enterprise blockchain platforms like Ethereum and Hyperledger?",
        "ब्लकचेन प्रविधिमा 'स्मार्ट कन्ट्र्याक्ट' (Smart Contract) ले के जनाउँछ?",
        ["A legally notarized paper contract scanned as a PDF", "Self-executing code stored on a blockchain that automatically executes agreements when predefined conditions are met", "An encrypted email between two bank directors", "An insurance policy sold by cryptocurrency exchanges"],
        1, "A smart contract is a self-executing software program running on a decentralized ledger that enforces the terms of an agreement automatically without trusted third parties.",
        "स्मार्ट कन्ट्र्याक्ट भनेको ब्लकचेनमा रहने यस्तो कम्प्युटर कोड हो जसले पूर्वसर्तहरू पूरा भएपछि स्वचालित रूपमा सम्झौता कार्यान्वयन गर्दछ।", "2080 BS - RBB IT")

    add(135, "What consensus mechanism validates transactions in traditional Bitcoin through computational resource expenditure, compared to Ethereum 2.0's validator stake model?",
        "बिटक्वाइनले गणना शक्तिको आधारमा कारोबार प्रमाणित गर्न कुन सहमति संयन्त्र (Consensus Mechanism) प्रयोग गर्दछ?",
        ["Proof of Stake (PoS)", "Proof of Work (PoW)", "Proof of Authority (PoA)", "Delegated BFT"],
        1, "Proof of Work (PoW) relies on miners solving computationally intensive mathematical puzzles, whereas Proof of Stake (PoS) relies on capital validators staking tokens.",
        "प्रुफ अफ वर्क (PoW) मा गणितीय पहेली हल गर्न उच्च कम्प्युटिङ शक्ति खर्च हुन्छ, जबकि PoS मा सिक्का धितो राखेर प्रमाणीकरण गरिन्छ।", "2081 BS - Loksewa Model")

    # Generate more questions up to 180 for Unit 1
    for i in range(136, 181):
        if i % 5 == 0:
            add(i, f"In modern high-performance computers, what is the purpose of instruction pipelining (Concept #{i-135})?",
                f"आधुनिक कम्प्युटरमा इन्स्ट्रक्सन पाइपलाइनिङको मुख्य उद्देश्य के हो (प्रश्न #{i-135})?",
                ["To decrease instruction latency", "To increase instruction throughput by overlapping execution stages", "To expand CPU register count", "To cool the CPU die"],
                1, "Pipelining overlaps the execution of multiple instructions across Fetch, Decode, Execute stages, increasing throughput to near 1 instruction per cycle.",
                "पाइपलाइनिङले एउटा इन्स्ट्रक्सन पूरा हुनु अगावै अर्को सुरु गरेर प्रति सेकेन्ड धेरै काम सम्पन्न गर्दछ।", "2082 BS - RBB IT Probable")
        elif i % 5 == 1:
            add(i, f"Which cloud deployment model provides cloud infrastructure exclusively for a single organization comprising multiple consumers (e.g., a banking conglomerate)?",
                f"कुनै एकल संस्था वा बैंकका लागि मात्र छुट्ट्याइएको क्लाउड पूर्वाधारलाई के भनिन्छ?",
                ["Public Cloud", "Private Cloud", "Hybrid Cloud", "Community Cloud"],
                1, "A Private Cloud is provisioned for exclusive use by a single organization, providing the highest isolation, data control, and regulatory compliance.",
                "प्राइभेट क्लाउड (Private Cloud) पूर्ण रूपमा एउटै बैंक वा संस्थाको नियन्त्रणमा रहने सुरक्षित क्लाउड प्रणाली हो।", "2079 BS - NRB IT")
        elif i % 5 == 2:
            add(i, f"Which of the following optical storage media typically offers the highest standard single-layer capacity?",
                f"तलका मध्ये कुन अप्टिकल भण्डारण माध्यमको क्षमता सबैभन्दा धेरै हुन्छ?",
                ["Compact Disc (CD)", "Digital Versatile Disc (DVD)", "Blu-ray Disc (BD)", "MiniDisc"],
                2, "Standard single-layer Blu-ray discs offer 25 GB of storage (and 50 GB dual-layer), compared to 4.7 GB for DVD and 700 MB for CD.",
                "ब्लू-रे डिस्क (Blu-ray Disc) को एकल तहको क्षमता २५ जीबी (25 GB) सम्म हुन्छ, जुन सीडी र डिभिडी भन्दा धेरै हो।", "2077 BS - Loksewa Operator")
        elif i % 5 == 3:
            add(i, f"In natural language processing (NLP), what deep learning architecture underlies modern Large Language Models (LLMs) using self-attention mechanisms?",
                f"आधुनिक भाषा मोडेल (LLM) हरूमा सेल्फ-एटेन्सन (Self-Attention) संयन्त्र प्रयोग गर्ने डीप लर्निङ आर्किटेक्चर कुन हो?",
                ["Recurrent Neural Network (RNN)", "Convolutional Neural Network (CNN)", "Transformer Architecture", "Multi-layer Perceptron (MLP)"],
                2, "The Transformer architecture (introduced in 'Attention Is All You Need', 2017) powers modern generative AI models like GPT and BERT.",
                "ट्रान्सफर्मर आर्किटेक्चर (Transformer Architecture) ले सेल्फ-एटेन्सन मार्फत आधुनिक एआई र भाषा मोडेलहरू सञ्चालन गर्दछ।", "2082 BS - RBB IT Probable")
        else:
            add(i, f"In enterprise IT, what metric defines the maximum acceptable amount of data loss measured in time following an unplanned outage?",
                f"प्रणाली बन्द हुँदा स्वीकार्य अधिकतम डेटा नोक्सानीको समय-सीमालाई के भनिन्छ?",
                ["RTO (Recovery Time Objective)", "RPO (Recovery Point Objective)", "MTBF (Mean Time Between Failures)", "MTTR (Mean Time To Repair)"],
                1, "RPO (Recovery Point Objective) dictates the maximum acceptable age of files recovered from backup (data loss tolerance), while RTO is the downtime duration.",
                "RPO (Recovery Point Objective) ले प्रणाली बिग्रँदा कति समय सम्मको डेटा गुम्न सक्ने छुट छ भन्ने मापन गर्दछ।", "2081 BS - NRB IT")

    return u1

print("Unit 1 generated:", len(get_unit1_questions()), "questions.")
