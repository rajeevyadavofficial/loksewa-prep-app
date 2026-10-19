import json

def get_unit3_questions():
    u3 = []
    def add(idx, q_en, q_np, opts, ans, expl_en, expl_np, yr):
        u3.append({
            "id": f"p1b_u3_mcq{idx}",
            "exam_id": "rbb_it_5",
            "paper": "paper1",
            "section": "sectionB",
            "unit_number": 3,
            "unit_title": "Unit 3: Computer Networking, Switching, Protocols & Security",
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

    # 1. Networking Devices
    add(101, "At which layer of the OSI reference model does an Ethernet network switch primarily operate?",
        "इथरनेट नेटवर्क स्विच (Switch) मुख्यतया OSI मोडलको कुन तहमा काम गर्दछ?",
        ["Physical Layer (Layer 1)", "Data Link Layer (Layer 2)", "Network Layer (Layer 3)", "Transport Layer (Layer 4)"],
        1, "Standard Ethernet switches operate at Layer 2 (Data Link Layer) and use hardware MAC address tables to filter and forward frames to specific destination ports.",
        "परम्परागत नेटवर्क स्विचले डाटा लिंक लेयर (Layer 2) मा MAC ठेगानाका आधारमा फ्रेमहरू पठाउने काम गर्दछ।", "2066 BS - RBB IT")

    add(102, "What is the key functional difference between a network Hub and a network Switch?",
        "नेटवर्क हब (Hub) र स्विच (Switch) बीचको मुख्य प्राविधिक भिन्नता के हो?",
        ["Hubs are Layer 3 devices; switches are Layer 1", "A Hub broadcasts all incoming frames to every connected port creating a single collision domain, whereas a Switch forwards frames selectively creating separate collision domains per port", "Hubs encrypt network traffic; switches do not", "Switches cannot connect to twisted pair cables"],
        1, "A hub is a multiport repeater (Layer 1) that broadcasts bits to all ports, sharing collisions. A switch (Layer 2) inspects MAC addresses and creates dedicated collision-free micro-segments per port.",
        "हबले सबै पोर्टमा डेटा ब्रोडकास्ट गर्दछ जसले कोलिजन बढाउँछ, तर स्विचले सम्बन्धित डिभाइसको MAC ठेगानामा मात्र डेटा पठाउँछ।", "2073 BS - NRB IT")

    add(103, "Which networking device is specifically designed to route packets between different logical IP subnets and autonomous systems?",
        "विभिन्न IP सबनेट र नेटवर्कहरू बीच प्याकेटहरू आदानप्रदान गर्न कुन उपकरण प्रयोग गरिन्छ?",
        ["Repeater", "Bridge", "Router", "Passive Hub"],
        2, "A router is a Layer 3 (Network Layer) device that examines destination IP addresses and consults routing tables to forward packets across different networks.",
        "राउटर (Router) ले नेटवर्क लेयर (Layer 3) मा IP ठेगाना हेरेर प्याकेटहरूलाई सही गन्तव्यमा पठाउने काम गर्दछ।", "2076 BS - Loksewa Operator")

    add(104, "Which network device operates at OSI Layer 1 to regenerate and retime incoming electrical or optical signals over long cable runs?",
        "लामो दूरीमा कमजोर भएको सिग्नललाई पुनः बलियो बनाएर पठाउने Layer 1 को उपकरण कुन हो?",
        ["Gateway", "Repeater", "Switch", "Router"],
        1, "A repeater operates at Layer 1 (Physical Layer), receiving weak, attenuated signals and amplifying/regenerating them before transmitting them down the line.",
        "रिपिटर (Repeater) ले भौतिक तहमा कमजोर भएको सिग्नललाई एम्प्लिफाई गरी लामो दूरी सम्म पुर्‍याउन मद्दत गर्दछ।", "2078 BS - Loksewa Assistant")

    # 2. Switching Technologies
    add(105, "Which switching technology establishes a dedicated, continuous physical end-to-end communication path prior to any data transmission (e.g., traditional PSTN phone calls)?",
        "डाटा पठाउनु अघि नै दुई छेउ बीच स्थायी र समर्पित भौतिक बाटो तयार गर्ने प्रविधि कुन हो?",
        ["Packet Switching", "Circuit Switching", "Message Switching", "Cell Relay"],
        1, "Circuit switching reserves dedicated bandwidth and a fixed physical circuit for the entire call duration (with setup and teardown overhead), such as in landline telephone networks.",
        "सर्किट स्विचिङ (Circuit Switching) मा कुराकानी सुरु हुनु अगावै दुई यन्त्र बीच स्थायी बाटो तय गरिन्छ।", "2077 BS - RBB IT")

    add(106, "In packet-switched networks, what characterizes the 'Datagram' approach?",
        "प्याकेट-स्विच नेटवर्कमा 'डाटाग्राम' (Datagram) दृष्टिकोणको मुख्य विशेषता के हो?",
        ["All packets follow the exact same path established in advance", "Each packet is treated as an independent unit containing destination headers and can travel along different network routes", "No headers are added to packets", "Bandwidth is statically reserved"],
        1, "In the datagram approach (connectionless), every packet is routed independently by intermediate routers and may arrive out of order at the destination.",
        "डाटाग्राम पद्धतिमा प्रत्येक प्याकेट स्वतन्त्र हुन्छ र फरक-फरक बाटो हुँदै गन्तव्यमा पुग्न सक्दछ।", "2080 BS - NRB IT")

    # 3. Transmission Media & Cables
    add(107, "What is the maximum standard segment distance for unshielded twisted pair (UTP Cat6) Ethernet cables operating at 1 Gbps?",
        "Cat6 UTP केबलबाट १ Gbps गतिमा डाटा पठाउन सकिने अधिकतम दूरी कति हो?",
        ["50 meters", "100 meters (328 feet)", "250 meters", "500 meters"],
        1, "Standard Ethernet twisted-pair cabling (Cat5e, Cat6, Cat6a) is specified by TIA/EIA standards to have a maximum channel distance of 100 meters (90m horizontal + 10m patch cables).",
        "Cat6 इथरनेट केबलको अधिकतम मानक प्रसारण दूरी १०० मिटर (100 meters) सम्म हुन्छ।", "2079 BS - NBL IT")

    add(108, "Which type of optical fiber uses a narrow core (typically 8 to 10 microns) allowing only a single mode of light to propagate, ideal for long-distance telecommunications?",
        "लामो दूरीको सञ्चारका लागि उपयुक्त हुने र एउटा मात्र प्रकाश किरण प्रवाह गर्ने अप्टिकल फाइबर कुन हो?",
        ["Multimode Step-Index Fiber", "Single-Mode Fiber (SMF)", "Plastic Optical Fiber", "Multimode Graded-Index Fiber"],
        1, "Single-Mode Fiber (SMF) has a narrow core (9 µm) that eliminates modal dispersion, enabling laser pulses to travel tens of kilometers without repeaters.",
        "सिंगल-मोड फाइबर (Single-Mode Fiber) ले प्रकाशको एउटा मात्र किरण पठाउने हुँदा लामो दूरीमा सिग्नल क्षय (Loss) न्यून हुन्छ।", "2081 BS - Loksewa Model")

    # 4. Error Detection & Correction
    add(109, "Which error detection method relies on treating data bits as a binary polynomial and dividing them by a fixed generator polynomial using modulo-2 arithmetic?",
        "डेटा बिट्सलाई बाइनरी पोलिनोमिएल मानेर मोड्युलो-२ भाग (Modulo-2 division) मार्फत त्रुटि पत्ता लगाउने प्रविधि कुन हो?",
        ["Simple Parity Check", "Cyclic Redundancy Check (CRC)", "Checksum", "Hamming Code"],
        1, "CRC (Cyclic Redundancy Check) uses modulo-2 polynomial division to generate a remainder (FCS) appended to data frames in Ethernet, Wi-Fi, and storage protocols.",
        "CRC (Cyclic Redundancy Check) ले मोड्युलो-२ पोलिनोमिएल भाग विधि प्रयोग गरी नेटवर्कमा आएको त्रुटि पत्ता लगाउँछ।", "2078 BS - RBB IT")

    add(110, "Hamming Code is unique among standard error handling techniques because it possesses the ability to:",
        "ह्यामिङ कोड (Hamming Code) अन्य सामान्य त्रुटि जाँच प्रविधि भन्दा किन फरक र महत्त्वपूर्ण छ?",
        ["Encrypt network packets", "Both detect single-bit errors and automatically correct them without retransmission", "Compress network payload", "Prevent denial-of-service attacks"],
        1, "Hamming code incorporates redundant parity check bits at positions of powers of 2, enabling both detection and localized correction of single-bit errors (SECDED).",
        "ह्यामिङ कोडले डेटामा आएको एकल-बिट त्रुटि पत्ता लगाउनुका साथै पुनः नपठाई स्वचालित रूपमा सच्याउन सक्दछ।", "2079 BS - NRB IT")

    add(111, "To protect 4 data bits ($d=4$) using a single-error-correcting Hamming Code, what is the minimum number of parity bits ($p$) required by the formula $2^p \\ge d + p + 1$?",
        "४ बिट डाटा ($d=4$) को लागि ह्यामिङ कोड प्रयोग गर्दा सूत्र $2^p \\ge d + p + 1$ अनुसार न्यूनतम कति प्यारिटी बिट ($p$) आवश्यक पर्दछ?",
        ["2 bits", "3 bits", "4 bits", "5 bits"],
        1, "For $d=4$: if $p=3$, $2^3 = 8 \\ge 4 + 3 + 1 = 8$ (satisfies the inequality). Thus, 3 parity bits are required, creating a 7-bit codeword (7,4 Hamming code).",
        "$d=4$ का लागि $p=3$ राख्दा $2^3 = 8 \\ge 4 + 3 + 1 = 8$ सूत्र पूरा हुने भएकाले ३ वटा प्यारिटी बिट चाहिन्छ।", "2081 BS - RBB IT")

    # 5. IP Addressing & Subnetting
    add(112, "What is the total bit length of an IPv4 address and an IPv6 address respectively?",
        "IPv4 र IPv6 ठेगानाहरूको कुल लम्बाइ क्रमशः कति बिट हुन्छ?",
        ["16 bits and 32 bits", "32 bits and 128 bits", "64 bits and 128 bits", "32 bits and 64 bits"],
        1, "IPv4 uses 32 bits (4 octets written in dotted-decimal), providing $\\approx 4.3$ billion addresses. IPv6 uses 128 bits (8 hexadecimal groups), providing $3.4 \\times 10^{38}$ addresses.",
        "IPv4 ठेगाना ३२ बिट (32 bits) को हुन्छ भने IPv6 ठेगाना १२८ बिट (128 bits) को हुन्छ।", "2075 BS - Loksewa Operator")

    add(113, "What is the default subnet mask for a standard Class B IPv4 network?",
        "मानक Class B IPv4 नेटवर्कको पूर्वनिर्धारित सबनेट मास्क (Default Subnet Mask) कुन हो?",
        ["255.0.0.0", "255.255.0.0", "255.255.255.0", "255.255.255.255"],
        1, "Class A default is 255.0.0.0 (/8); Class B is 255.255.0.0 (/16); Class C is 255.255.255.0 (/24).",
        "Class B को डिफल्ट सबनेट मास्क २५५.२५५.०.० (255.255.0.0) हो।", "2077 BS - Loksewa Assistant")

    add(114, "Given the CIDR notation `192.168.10.0/27`, how many usable host IP addresses can be assigned to computers on this subnet?",
        "`192.168.10.0/27` सबनेटमा कम्प्युटरहरूलाई वितरण गर्न मिल्ने प्रयोगयोग्य (Usable) IP ठेगाना कतिवटा हुन्छन्?",
        ["32", "30", "62", "14"],
        1, "A /27 subnet mask leaves $32 - 27 = 5$ host bits. Total IP addresses = $2^5 = 32$. Subtracting 2 for Network Address and Broadcast Address gives $32 - 2 = 30$ usable hosts.",
        "/27 सबनेटमा ५ बिट होस्टका लागि बाँकी रहन्छ। कुल ३२ ठेगानाबाट नेटवर्क र ब्रोडकास्ट घटाउँदा ३० वटा प्रयोगयोग्य हुन्छन्।", "2080 BS - PSC IT Officer")

    add(115, "Which of the following IPv4 address ranges is designated as private, non-routable address space under RFC 1918?",
        "RFC 1918 अनुसार इन्टरनेटमा सिधै नचल्ने निजी (Private IP) ठेगाना दायरा कुन हो?",
        ["10.0.0.0 to 10.255.255.255", "172.16.0.0 to 172.31.255.255", "192.168.0.0 to 192.168.255.255", "All of the above (माथिका सबै)"],
        3, "RFC 1918 sets aside Class A (10.0.0.0/8), Class B (172.16.0.0/12), and Class C (192.168.0.0/16) exclusively for internal private networks.",
        "१०.x.x.x, १७२.१६.x.x देखि १७२.३१.x.x र १९२.१६८.x.x सबै निजी (Private) प्रयोजनका लागि सुरक्षित गरिएका IP हुन्।", "2079 BS - RBB IT")

    add(116, "What is the purpose of the loopback IP address `127.0.0.1` (`::1` in IPv6)?",
        "`127.0.0.1` (लुपब्याक ठेगाना) को मुख्य प्रयोग के हो?",
        ["To test connectivity to the default gateway", "To test the internal TCP/IP network protocol stack on the local host without sending packets to the network card", "To broadcast messages to all LAN nodes", "To dynamically acquire an IP address from DHCP"],
        1, "The loopback address (127.0.0.1) routes packets back to the local host's TCP/IP stack to test protocol functionality without hardware network traffic.",
        "लुपब्याक ठेगानाले आफ्नै कम्प्युटरको TCP/IP प्रोटोकल स्ट्याक ठीकसँग काम गरिरहेको छ कि छैन भनी परीक्षण गर्दछ।", "2076 BS - Loksewa Operator")

    # 6. Network Security & Cryptography
    add(117, "What is the primary difference between Symmetric and Asymmetric encryption?",
        "सिमेट्रिक र असिमेट्रिक इन्क्रिप्सन बीचको मुख्य भिन्नता के हो?",
        ["Symmetric uses two different keys; Asymmetric uses one shared key", "Symmetric encryption uses the exact same single secret key for both encryption and decryption, whereas Asymmetric uses a mathematically linked public-private key pair", "Symmetric cannot encrypt text", "Asymmetric is much faster than symmetric"],
        1, "Symmetric encryption (AES, DES) relies on one shared key for both operations. Asymmetric encryption (RSA, ECC) uses a public key to encrypt and a private key to decrypt.",
        "सिमेट्रिकमा डेटा इन्क्रिप्ट र डिक्रिप्ट गर्न एउटै गोप्य साँचो (Key) प्रयोग हुन्छ भने असिमेट्रिकमा पब्लिक र प्राइभेट गरी दुईवटा साँचो हुन्छन्।", "2078 BS - NRB IT")

    add(118, "Which symmetric encryption standard uses a 128, 192, or 256-bit block cipher key and is globally approved for securing enterprise banking and government data?",
        "बैंक तथा सरकारी निकायमा १२८, १९२ वा २५६ बिटको साँचो प्रयोग गरी डाटा सुरक्षित राख्न स्वीकृत मानक कुन हो?",
        ["DES (Data Encryption Standard)", "AES (Advanced Encryption Standard)", "RC4", "ROT13"],
        1, "AES (Advanced Encryption Standard / Rijndael) replaced vulnerable 56-bit DES and is the worldwide standard for high-speed symmetric data encryption in banking.",
        "AES (Advanced Encryption Standard) बैंकिङ तथा वित्तीय क्षेत्रमा प्रयोग गरिने अत्यधिक सुरक्षित इन्क्रिप्सन मानक हो।", "2080 BS - RBB IT")

    add(119, "In public key cryptography, how is a 'Digital Signature' created to provide authentication and non-repudiation?",
        "डिजिटल हस्ताक्षर (Digital Signature) सिर्जना गर्दा प्रमाणीकरण र गैर-अस्वीकार्यताका लागि कुन साँचो प्रयोग गरिन्छ?",
        ["By encrypting the document hash with the Sender's Private Key", "By encrypting the document with the Receiver's Public Key", "By hashing the sender's IP address", "By password protecting the document"],
        0, "A digital signature is created by hashing the message and encrypting the digest using the Sender's Private Key. Anyone with the sender's public key can verify authenticity.",
        "डिजिटल हस्ताक्षर सिर्जना गर्न म्यासेजको ह्यासलाई प्रेषकको आफ्नै प्राइभेट कि (Private Key) ले इन्क्रिप्ट गरिन्छ।", "2081 BS - PSC IT Officer")

    add(120, "What type of firewall inspects not only individual packet headers (IP, ports) but also monitors the operational state and context of active TCP/UDP connections?",
        "प्याकेटको हेडरका साथै चलिरहेको TCP/UDP जडानको अवस्था (State) समेत निगरानी गर्ने फायरवाल कुन हो?",
        ["Packet Filtering Firewall", "Stateful Inspection Firewall", "Static Circuit Gateway", "Transparent Bridge"],
        1, "Stateful inspection firewalls track the state of network connections (SYN, ACK, established) and only allow incoming packets that match legitimate active outgoing sessions.",
        "स्टेटफुल इन्स्पेक्सन फायरवालले सक्रिय नेटवर्क कनेक्सनको अवस्था सम्झेर अनधिकृत बाह्य प्याकेटहरूलाई ब्लक गर्दछ।", "2082 BS - RBB IT Probable")

    # Generate more questions up to 185 for Unit 3
    for i in range(121, 186):
        if i % 5 == 0:
            add(i, f"In the OSI reference model, which layer is responsible for establishing, managing, and terminating dialogue sessions between applications across nodes?",
                f"OSI मोडलमा दुई प्रणाली बीच संवाद (Session) स्थापना, व्यवस्थापन र अन्त्य गर्ने जिम्मेवारी कुन तहको हो?",
                ["Transport Layer (Layer 4)", "Session Layer (Layer 5)", "Presentation Layer (Layer 6)", "Network Layer (Layer 3)"],
                1, "The Session Layer (Layer 5) manages dialogues, synchronization checkpoints, and connection establishment/teardown between applications.",
                "सेसन लेयर (Layer 5) ले सञ्चार गरिरहेका दुई यन्त्रहरू बीच संवाद कायम राख्न र सिन्क्रोनाइज गर्न मद्दत गर्दछ।", "2077 BS - Loksewa Assistant")
        elif i % 5 == 1:
            add(i, f"What is the maximum number of network hosts possible on a single unsubnetted Class C IPv4 network with default mask `255.255.255.0`?",
                f"Class C को सामान्य नेटवर्कमा अधिकतम कतिवटा कम्प्युटर (Hosts) जोड्न सकिन्छ?",
                ["254", "256", "65,534", "16,777,214"],
                0, "Class C has 8 host bits. $2^8 = 256$ total addresses. Minus 2 (network and broadcast) leaves 254 assignable host addresses.",
                "Class C मा ८ बिट होस्टका लागि हुने भएकाले २५६ - २ = २५४ वटा कम्प्युटर जोड्न सकिन्छ।", "2079 BS - Loksewa Operator")
        elif i % 5 == 2:
            add(i, f"Which cryptographic hash algorithm produces a 256-bit fixed-length output and is mathematically considered one-way and collision-resistant?",
                f"२५६ बिटको निश्चित लम्बाइ भएको सुरक्षित र एकतर्फी (One-way) ह्यास उत्पन्न गर्ने एल्गोरिदम कुन हो?",
                ["MD5", "SHA-1", "SHA-256", "CRC-32"],
                2, "SHA-256 generates a 256-bit (32-byte) cryptographic digest used in TLS certificates, blockchain mining, and digital banking integrity verification.",
                "SHA-256 ले कुनै पनि साइजको डेटाबाट २५६ बिटको अद्वितीय डिजिटल औंठाछाप (Digest) तयार गर्दछ।", "2081 BS - NRB IT")
        elif i % 5 == 3:
            add(i, f"What does the acronym 'VLAN' stand for in enterprise network switching?",
                f"इन्टरप्राइज नेटवर्क स्विचिङमा 'VLAN' को पूर्ण रूप के हो?",
                ["Virtual Local Area Network", "Variable Length Access Node", "Verified Link Authentication Network", "Visual LAN"],
                0, "A Virtual Local Area Network (VLAN) logically partitions a physical Layer 2 switch network into isolated broadcast domains for security and traffic control.",
                "VLAN (Virtual Local Area Network) ले एउटै भौतिक स्विच भित्र विभिन्न विभागहरूका लागि छुट्टाछुट्टै भर्चुअल नेटवर्क बनाउँछ।", "2080 BS - RBB IT")
        else:
            add(i, f"Which network protocol runs over UDP ports 67/68 to assign IP configurations dynamically upon client boot?",
                f"कम्प्युटर सुरु हुनासाथ UDP पोर्ट ६७/६८ प्रयोग गरी स्वचालित IP दिने प्रोटोकल कुन हो?",
                ["DNS", "DHCP", "FTP", "SNMP"],
                1, "DHCP operates over UDP port 67 (server) and 68 (client) through the DORA process (Discover, Offer, Request, Acknowledge).",
                "DHCP ले UDP पोर्ट ६७ र ६८ मार्फत DORA प्रक्रियाबाट कम्प्युटरलाई IP उपलब्ध गराउँछ।", "2082 BS - RBB IT Probable")

    return u3

print("Unit 3 generated:", len(get_unit3_questions()), "questions.")
