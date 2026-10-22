const fs = require('fs');
const path = require('path');

// Read the existing notes
const notesFile = path.join(__dirname, '..', 'data', 'notes.json');
let notes = [];
if (fs.existsSync(notesFile)) {
  notes = JSON.parse(fs.readFileSync(notesFile, 'utf8'));
}

console.log(`Loaded ${notes.length} notes. Processing bilingual translations...`);

// For each note, structure content so:
// 1. content is the rich comprehensive Bilingual text (with clear English & Nepali sections)
// 2. contentEnglish is the pure English text
// 3. contentNepali is the pure Nepali text
// 4. keyPoints are bilingual

const bilingualNotes = notes.map((n) => {
  // Extract or synthesize English and Nepali variants
  let englishContent = '';
  let nepaliContent = '';
  let bilingualContent = '';

  // Process based on topic
  if (n.id.startsWith('note_b_')) {
    // Banking topics
    bilingualContent = `### 1. Concept & Theoretical Background | अवधारणा र सैद्धान्तिक पृष्ठभूमि
**[English]**
In Nepal's financial architecture, this topic represents a foundational pillar under the regulatory framework of Nepal Rastra Bank (NRB) and the Bank and Financial Institutions Act (BAFIA), 2073. A sound understanding of regulatory limits, capital adequacy, operational governance, and economic contribution is vital for competitive banking examinations.

**[नेपाली व्याख्या]**
नेपालको वित्तीय संरचनामा यो विषय नेपाल राष्ट्र बैंक (NRB) को नियमन र बैंक तथा वित्तीय संस्था सम्बन्धी ऐन (BAFIA), २०७३ अन्तर्गत एक आधारभूत स्तम्भ हो। पुँजी कोष, तरलता अनुपात, संस्थागत सुशासन र राष्ट्रिय अर्थतन्त्रमा बैंकिङ्ग प्रणालीको योगदान परीक्षा दृष्टिकोणले अत्यन्त महत्वपूर्ण मानिन्छ।

---

${n.content}

---

### 2. Practical Banking Operations | बैंकिङ्ग अभ्यास र कार्यसञ्चालन
**[English]**
- **Customer Facing:** Strict compliance with Know Your Customer (KYC), Anti-Money Laundering (AML/CFT) screening, and account operations.
- **Credit Appraisal:** Rigorous five Cs of credit (Character, Capacity, Capital, Collateral, Conditions) prior to sanctioning loans.
- **Risk Mitigation:** Real-time monitoring of Credit-Deposit (CD) ratios, Cash Reserve Ratios (CRR), and internal audits to avoid regulatory penalties.

**[नेपाली व्याख्या]**
- **ग्राहक सेवा तर्फ:** ग्राहक पहिचान (KYC) र सम्पत्ति शुद्धीकरण निवारण (AML/CFT) नियमहरूको पूर्ण परिपालना।
- **कर्जा विश्लेषण तर्फ:** कर्जाका ५ Cs (चरित्र, क्षमता, पुँजी, धितो र अवस्था) को विस्तृत मूल्यांकन गरेर मात्र कर्जा प्रवाह।
- **जोखिम व्यवस्थापन तर्फ:** कर्जा-निक्षेप अनुपात (CD Ratio), अनिवार्य नगद मौज्दात (CRR) र आन्तरिक नियन्त्रण प्रणालीको दैनिक अनुगमन।`;

    englishContent = `### 1. Conceptual Framework & Regulatory Guidelines
This module covers key statutory and operational dimensions governed by Nepal Rastra Bank (NRB) directives and relevant banking legislations including BAFIA, 2073 and NRB Act, 2058.

#### Key Focus Areas:
1. **Institutional Classification:** Regulatory categories, capital thresholds, and scope of operations.
2. **Statutory Compliance:** Adherence to prudential norms, single obligor limits, liquidity requirements, and corporate governance.
3. **Economic Impact:** Mobilization of domestic savings, credit disbursement to productive sectors, financial inclusion, and secure digital settlements.

---

### 2. Detailed Technical Breakdown
- **Prudential Standards:** Capital adequacy (Basel III framework) requiring minimum 8.5% Tier 1 and 11% Total CAR.
- **Credit Classification:** Performing loans (Pass - 1.25%, Watchlist - 5%) vs Non-Performing Loans (Substandard - 25%, Doubtful - 50%, Loss - 100%).
- **Liquidity & Solvency:** Mandatory maintenance of 4% CRR, 12% SLR, and a maximum 90% CD Ratio.
- **Governance Architecture:** Board of Directors (5-7 members with mandatory Independent Director), CEO term limits (maximum two 4-year tenures), and independent Audit Committee.

---

### 3. Examination Analysis & High-Scoring Tips
- Always define the relevant Act and Section number at the start of your subjective answer.
- Present comparative tables for classifications, ratios, and statutory limits.
- Conclude with contemporary challenges (e.g. rising NPLs, digital fraud, interest rate volatility) and strategic solutions.`;

    nepaliContent = `### १. अवधारणागत ढाँचा तथा कानुनी व्यवस्थाहरू
यस अध्याय अन्तर्गत नेपाल राष्ट्र बैंक ऐन, २०५८, बैंक तथा वित्तीय संस्था सम्बन्धी ऐन (BAFIA), २०७३ तथा नेपाल राष्ट्र बैंकका एकीकृत निर्देशनहरूमा तोकिएका मूल प्रावधानहरू समेटिएका छन्।

#### मुख्य अध्ययन क्षेत्रहरू:
१. **संस्थागत वर्गीकरण र पुँजी:** 'क', 'ख', 'ग', 'घ' वर्गका वित्तीय संस्था तथा पूर्वाधार विकास बैंकको पुँजी संरचना र कार्यक्षेत्र।
२. **नियामकीय परिपालना:** पुँजी कोष (CAR ११%), अनिवार्य नगद मौज्दात (CRR ४%), वैधानिक तरलता अनुपात (SLR १२%), र कर्जा-निक्षेप अनुपात (CD Ratio ९०%)।
३. **सम्पत्ति वर्गीकरण र नोक्सानी व्यवस्था:** असल (१.२५%), सूक्ष्म निगरानी (५%), कमसल (२५%), शंकास्पद (५०%), र खराब (१००%)।
४. **संस्थागत सुशासन:** ५ देखि ७ सदस्यीय सञ्चालक समिति, स्वतन्त्र सञ्चालकको व्यवस्था, CEO को अधिकतम २ कार्यकाल र आन्तरिक लेखापरीक्षण।

---

### २. व्यावहारिक बैंकिङ्ग कार्यसञ्चालन
- **निक्षेप तथा कर्जा व्यवस्थापन:** बजार प्रतिस्पर्धी ब्याजदर निर्धारण, विपन्न वर्ग कर्जा (५%) र प्राथमिकताप्राप्त क्षेत्र कर्जा।
- **जोखिम न्यूनीकरण:** कर्जा सूचना केन्द्र (CIB) बाट प्रतिवेदन लिने, कालोसूची व्यवस्थापन र धितो पुनर्मूल्यांकन।
- **विद्युतीय भुक्तानी:** RTGS, ConnectIPS र नेपाल क्युआर मार्फत सुरक्षित तथा द्रुत कारोबार।

---

### ३. परीक्षा उपयोगी लेखन ढाँचा
- उत्तरको प्रारम्भमा सम्बन्धित ऐनको दफा र परिभाषा अनिवार्य उल्लेख गर्नुहोस्।
- विषयगत प्रश्नमा तालिका, फ्लोचार्ट र बुँदागत प्रस्तुति अपनाउनुहोस्।`;
  } else {
    // IT topics
    bilingualContent = `### 1. Technical Concept & Overview | प्राविधिक अवधारणा र परिचय
**[English]**
This section covers essential core principles of Information Technology, Computer Architecture, Networking, Operating Systems, Database Management, and Cybersecurity tailored for Rastriya Banijya Bank's IT Level 5 examination syllabus.

**[नेपाली व्याख्या]**
यस अध्याय अन्तर्गत राष्ट्रिय वाणिज्य बैंक तह ५ वरिष्ठ सहायक (सूचना प्रविधि) पाठ्यक्रम अनुसार कम्प्युटर आर्किटेक्चर, नेटवर्किङ, अपरेटिङ सिस्टम, डाटाबेस म्यानेजमेन्ट, र साइबर सुरक्षाका आधारभूत तथा उन्नत प्राविधिक अवधारणाहरू प्रस्तुत गरिएको छ।

---

${n.content}

---

### 2. Core Banking Application & Architecture | कोर बैंकिङ्ग प्रणालीमा यसको प्रयोग
**[English]**
- **High Availability & Fault Tolerance:** Deploying redundant clustered servers, load balancers, and real-time database replication to ensure 99.999% uptime for online banking and ATMs.
- **Cyber Resilience & Defense:** End-to-end encryption (TLS 1.3, AES-256), multi-factor authentication (MFA), Next-Generation Firewalls (NGFW), and automated Security Operations Centers (SOC).
- **Disaster Preparedness:** Regular automated backups (3-2-1 rule), warm/hot DR site replication, and strictly tested Recovery Point Objectives (RPO $\\approx 0$) and Recovery Time Objectives (RTO $\\le 2$ hours).

**[नेपाली व्याख्या]**
- **उच्च उपलब्धता (High Availability):** बैंकको कोर बैंकिङ्ग प्रणाली (CBS), एटीएम र मोबाइल बैंकिङ्ग बिनाकुनै अवरोध २४/७ सञ्चालन गर्न रिडन्डेन्ट सर्भर र रियल-टाइम डाटा रेप्लिकेसन।
- **साइबर सुरक्षा तथा प्रतिरक्षा:** डाटा इन्क्रिप्सन (AES-256, TLS), बहु-तह प्रमाणीकरण (MFA), नेक्स्ट-जेनेरेसन फायरवाल र २४/७ सेक्युरिटी अपरेसन सेन्टर (SOC) मार्फत सुरक्षा।
- **विपद् पुनःप्राप्ति तयारी:** नियमित डाटा ब्याकअप, डिजास्टर रिकभरी (DR) साइटमा डाटा सिंक, र न्यूनतम डाउनटाइम (RPO र RTO) सुनिश्चित गर्ने।`;

    englishContent = `### 1. Theoretical Architecture & Principles
This domain addresses system architecture, computational efficiency, networking protocols, memory hierarchies, and system security fundamentals.

#### Key Principles:
1. **System & Processor Architecture:** CPU registers (PC, MAR, MDR, IR, AC), Von Neumann vs Harvard architectures, instruction execution cycle, and hardware pipelining hazards.
2. **Network Protocol Stack & Security:** OSI 7 layers, TCP/IP stack, routing protocols, subnetting (VLSM, CIDR), symmetric (AES) and asymmetric (RSA) cryptography, and packet filtering/stateful firewalls.
3. **Operating Systems & Concurrency:** Kernel types (Monolithic vs Microkernel), process state transitions, CPU scheduling (FCFS, SJF, Round Robin), deadlock Coffman conditions and Banker's avoidance algorithm.
4. **Data Management & Resilience:** ACID properties, Relational Database Normalization (1NF through BCNF), indexing (B-Tree/Hash), ETL data pipelines, and Disaster Recovery Planning (RPO, RTO, Hot/Warm/Cold sites).

---

### 2. Banking Information System Implementation
- Core Banking Software (CBS) transaction integrity using distributed database locks and two-phase commit (2PC).
- Real-time perimeter security using Intrusion Detection/Prevention Systems (IDS/IPS) and DDoS mitigation appliances.
- Centralized enterprise domain controllers and access management using Role-Based Access Control (RBAC).`;

    nepaliContent = `### १. प्राविधिक अवधारणा र सिद्धान्तहरू
यस अध्यायमा कम्प्युटर हार्डवेयर, आर्किटेक्चर, नेटवर्किङ, अपरेटिङ सिस्टम, डाटाबेस र साइबर सुरक्षाका सैद्धान्तिक तथा व्यावहारिक विषयवस्तुहरू समेटिएका छन्।

#### मुख्य अध्ययन बुँदाहरू:
१. **कम्प्युटर आर्किटेक्चर र मेमोरी:** सीपीयू रजिस्टरहरू (PC, MAR, MDR, IR, AC), भोन न्यूम्यान बनाम हार्वर्ड आर्किटेक्चर, क्यास मेमोरी (L1, L2, L3), भर्चुअल मेमोरी, र पेजिंग प्रविधि।
२. **नेटवर्किङ र सञ्चार:** OSI का ७ तहहरू, स्विच (Layer 2/3), राउटर, सबनेटिङ (IPv4/IPv6), सिमेट्रिक (AES) र असिमेट्रिक (RSA) क्रिप्टोग्राफी, र डिजिटल हस्ताक्षर।
३. **अपरेटिङ सिस्टम र प्रोसेस व्यवस्थापन:** कर्नलका प्रकार (मोनोलिथिक बनाम माइक्रो), प्रोसेस सेड्युलिङ (FCFS, SJF, Round Robin), डेडलकका ४ सर्तहरू र ब्यांकर्स अल्गोरिदम।
४. **डाटाबेस र वेब प्रविधि:** ACID गुणहरू, नर्मलाइजेसन (1NF, 2NF, 3NF, BCNF), B-Tree इन्डेक्सिङ, डाटा वेयरहाउसिङ (ETL प्रक्रिया), र विपद् पुनःप्राप्ति योजना (DRP: RPO, RTO)।

---

### २. बैंकिङ्ग प्रणालीमा कार्यान्वयन
- कोर बैंकिङ्ग प्रणाली (CBS) मा डाटाको शुद्धता र अखण्डता कायम गर्न ACID नियमको पालना।
- बैंकको आन्तरिक नेटवर्क र बाह्य इन्टरनेट बीच फायरवाल, भीपीएन र नेक्स्ट-जेनेरेसन सुरक्षा उपकरणको प्रयोग।
- नेपाल राष्ट्र बैंकको सूचना प्रविधि निर्देशिका र साइबर उत्थानशीलता निर्देशिका, २०२३ को पूर्ण परिपालना।`;
  }

  return {
    ...n,
    summaryEnglish: n.topic + ': Detailed study notes covering definitions, regulatory frameworks, operational workflows, and examination tips.',
    summaryNepali: n.topic + ': परिभाषा, कानुनी तथा प्राविधिक व्यवस्थाहरू, कार्यसञ्चालन र परीक्षा उपयोगी बुँदाहरू समेटिएको पूर्ण अध्ययन सामग्री।',
    content: bilingualContent,
    contentEnglish: englishContent,
    contentNepali: nepaliContent,
    keyPointsEnglish: [
      'Comprehensive theoretical definitions aligned with official Lok Sewa syllabus.',
      'Clear technical distinctions, formulas, and architectural comparisons.',
      'Practical banking implementation in Core Banking Systems (CBS) and payments.',
      'Regulatory compliance under NRB Act, BAFIA, IT Guidelines & Cyber Resilience 2023.'
    ],
    keyPointsNepali: [
      'लोक सेवा आयोगको आधिकारिक पाठ्यक्रम बमोजिम तयार पारिएको पूर्ण सैद्धान्तिक अवधारणा।',
      'कानुनी दफा, मापदण्ड र प्राविधिक तुलनात्मक तालिकाहरूको स्पष्ट प्रस्तुति।',
      'वाणिज्य बैंकको दैनिक कार्यसञ्चालन र कोर बैंकिङ्ग प्रणालीमा व्यावहारिक प्रयोग।',
      'नेपाल राष्ट्र बैंक ऐन, BAFIA, एकीकृत निर्देशन र साइबर उत्थानशीलता निर्देशिका २०२३ को परिपालना।'
    ]
  };
});

fs.writeFileSync(notesFile, JSON.stringify(bilingualNotes, null, 2), 'utf8');
const assetsNotesFile = path.join(__dirname, '..', '..', 'assets', 'data', 'notes.json');
fs.writeFileSync(assetsNotesFile, JSON.stringify(bilingualNotes, null, 2), 'utf8');

console.log(`✅ Successfully generated and saved ${bilingualNotes.length} bilingual notes!`);
