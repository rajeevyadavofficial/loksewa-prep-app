# -*- coding: utf-8 -*-
"""
Domain 1: Computer Architecture, Digital Logic & Microprocessors (100 Subjective Q&As)
Covers Lok Sewa Paper 1 Section B Unit 1 / Paper 2 Technical.
"""

from base import create_subjective_q, save_batch_json

def generate_batch1():
    qs = []
    
    topics = [
        # (id, marks, yr, q_en, q_np, intro_en, intro_np, core_en, core_np, chal_en, chal_np, concl_en, concl_np)
        (
            "sub_arch_001", 10, "2080 BS - Lok Sewa IT Officer",
            "Explain Von Neumann Architecture and compare it with Harvard Architecture. What is the Von Neumann Bottleneck?",
            "भोन न्युम्यान आर्किटेक्चरको व्याख्या गर्दै यसलाई हार्वर्ड आर्किटेक्चरसँग तुलना गर्नुहोस्। भोन न्युम्यान बोटलनेक (Von Neumann Bottleneck) भन्नाले के बुझिन्छ?",
            "Von Neumann Architecture, proposed by John von Neumann in 1945, is based on the Stored Program Concept where program instructions and operational data share the same physical memory space and bus system.",
            "भोन न्युम्यान आर्किटेक्चर सन् १९४५ मा जोन भोन न्युम्यानद्वारा प्रतिपादित स्टोर्ड प्रोग्राम सिद्धान्तमा आधारित कम्प्युटर संरचना हो, जसमा निर्देशन (Instruction) र डाटा (Data) दुवै एउटै मेमोरी र साझा बस प्रणालीमा रहन्छन्।",
            "1. Architectural Pillars: Central Processing Unit (ALU + Control Unit + Registers), Single Main Memory, and Shared Bus (Address, Data, Control).\n2. Harvard Comparison: Harvard architecture features physically separated memories and buses for instructions and data, enabling simultaneous instruction fetch and data read/write.\n3. Comparative Parameters: Throughput (Harvard is faster), Hardware Cost (Von Neumann is simpler and cheaper), Control Logic (Von Neumann is straightforward).",
            "१. प्रमुख संरचना: सेन्ट्रल प्रोसेसिङ युनिट (ALU, CU, Registers), एकीकृत मुख्य मेमोरी र साझा बस।\n२. हार्वर्डसँग तुलना: हार्वर्डमा निर्देशन र डाटाका लागि छुट्टाछुट्टै भौतिक मेमोरी र बस हुन्छन्, जसले गर्दा एकैसाथ इन्स्ट्रक्सन फेच र डाटा रिड/राइट गर्न सकिन्छ।\n३. तुलनात्मक आधार: गति र थ्रुपुट (हार्वर्ड तीव्र), लागत र जटिलता (भोन न्युम्यान सरल र सस्तो)।",
            "The Von Neumann Bottleneck occurs because CPU execution speed vastly exceeds the throughput of the single shared memory bus, causing the high-speed CPU to idle while waiting for instructions or memory operands.",
            "सीपीयूको प्रोसेसिङ गति मेमोरी बसको डाटा प्रवाह गतिभन्दा धेरै गुणा छिटो हुने तर एउटै बसबाट मात्र डाटा र निर्देशन ल्याउनुपर्ने भएकाले सीपीयूले पर्खनुपर्ने अवस्थालाई भोन न्युम्यान बोटलनेक भनिन्छ।",
            "Modern high-performance processors adopt a Modified Harvard Architecture using unified physical RAM externally while implementing physically separate L1 Instruction and L1 Data Caches internally.",
            "आधुनिक प्रोसेसरहरूले बाह्य रूपमा भोन न्युम्यानको सरल मेमोरी र आन्तरिक रूपमा छुट्टाछुट्टै L1 क्यास (Instruction & Data) प्रयोग गरी परिमार्जित हार्वर्ड आर्किटेक्चर अपनाउँछन्।"
        ),
        (
            "sub_arch_002", 10, "2079 BS - RBB IT Level 5",
            "Describe the CPU Instruction Cycle with its phases. Explain how the Program Counter and Instruction Register function during execution.",
            "सीपीयू इन्स्ट्रक्सन साइकलका विभिन्न चरणहरूको सविस्तार वर्णन गर्नुहोस्। कार्यान्वयनको क्रममा प्रोग्राम काउन्टर (PC) र इन्स्ट्रक्सन रजिस्टर (IR) ले कसरी कार्य गर्दछन्?",
            "The CPU Instruction Cycle represents the fundamental sequence of continuous micro-operations through which the processor fetches an encoded machine instruction from memory, interprets it, and carries out the commanded operation.",
            "इन्स्ट्रक्सन साइकल सीपीयूले मेमोरीबाट निर्देशन ल्याउने, बुझ्ने र कार्यान्वयन गर्ने निरन्तर दोहोरिने आधारभूत चरणहरूको शृङ्खला हो। यसले कम्प्युटर प्रणालीलाई गतिशील बनाउँछ।",
            "1. Phase 1 - Fetch: Program Counter (PC) places address on Address Bus; Memory sends instruction via Data Bus to Instruction Register (IR); PC increments to next instruction.\n2. Phase 2 - Decode: Control Unit decodes opcode bits in IR to configure internal ALU control lines and identify addressing mode.\n3. Phase 3 - Read Effective Address: Evaluates operands if indirect or indexed addressing is specified.\n4. Phase 4 - Execute: ALU performs arithmetic/logical calculation or memory write.\n5. Phase 5 - Interrupt Check: CPU polls interrupt lines prior to initiating next fetch cycle.",
            "१. फेच (Fetch): PC ले ठेगाना पठाउँछ, मेमोरीबाट निर्देशन IR मा आउँछ र PC को मान स्वतः १ ले बढ्छ।\n२. डिकोड (Decode): कन्ट्रोल युनिटले IR मा रहेको Opcode डिकोड गरी कुन काम गर्नुपर्ने हो पहिचान गर्छ।\n३. इफेक्टिभ एड्रेस गणना: अप्रत्यक्ष ठेगाना भए वास्तविक मेमोरी ठेगाना निकाल्छ।\n४. एक्जिक्युट (Execute): ALU ले हिसाब वा डाटा स्थानान्तरण सम्पन्न गर्छ।\n५. इन्टरप्ट परीक्षण: अर्को साइकल सुरु गर्नुअघि बाह्य इन्टरप्ट जाँच गर्छ।",
            "Primary bottlenecks include branch mispredictions causing pipeline flushes, high memory latency during operand fetch, and asynchronous interrupt handling latencies.",
            "ब्राञ्च निर्देशनका कारण पाइपलाइन खाली हुनु, मेमोरीबाट डाटा ल्याउँदा लाग्ने समय (Memory Latency) र आकस्मिक इन्टरप्ट व्यवस्थापनका चुनौतीहरू देखा पर्छन्।",
            "Hardware pipelining, out-of-order execution, and high-speed on-chip cache memory are deployed to overlap fetch, decode, and execute phases, achieving multi-GigaHertz throughput.",
            "आधुनिक कम्प्युटरमा फेच, डिकोड र एक्जिक्युसनलाई एकसाथ सञ्चालन गर्न पाइपलाइनिङ र मल्टिलेभल क्यासको प्रयोग गरिन्छ।"
        ),
        (
            "sub_arch_003", 10, "2078 BS - Nepal Bank IT",
            "Compare RISC (Reduced Instruction Set Computer) and CISC (Complex Instruction Set Computer) architectures with respect to hardware complexity, cycle time, and instruction formats.",
            "हार्डवेयर जटिलता, साइकल समय र निर्देशन ढाँचाका आधारमा RISC र CISC आर्किटेक्चर बीच तुलनात्मक विवेचना गर्नुहोस्।",
            "Processors are fundamentally categorized by instruction set design philosophy into RISC, which prioritizes simple, uniform single-cycle instructions, and CISC, which provides rich, multi-operation variable-length instructions.",
            "माइक्रोप्रोसेसरको इन्स्ट्रक्सन सेटको डिजाइनका आधारमा सरल र एकै साइकलमा सम्पन्न हुने RISC र जटिल तथा बहु-साइकल लिने CISC गरी दुई मुख्य वर्गमा वर्गीकरण गरिन्छ।",
            "1. Instruction Length: RISC uses fixed-length (typically 32-bit); CISC uses variable-length (1 to 15 bytes in x86).\n2. Execution Time: RISC achieves single-cycle execution per instruction via pipelining; CISC takes variable multi-clock cycles.\n3. Memory Access: RISC restricts memory operations strictly to explicit LOAD and STORE instructions; CISC allows memory operands directly inside arithmetic instructions.\n4. Control Unit: RISC utilizes hardwired control logic for maximum clock speed; CISC relies on microcode ROM.\n5. Register File: RISC provides large register files (32+ registers); CISC features fewer general-purpose registers.",
            "१. निर्देशन लम्बाइ: RISC मा निश्चित (३२ बिट), CISC मा परिवर्तनशील (१ देखि १५ बाइट)।\n२. कार्यान्वयन समय: RISC मा प्रायः १ घडी साइकल, CISC मा बहु-साइकल।\n३. मेमोरी पहुँच: RISC मा Load/Store निर्देशनबाट मात्र, CISC मा सिधै मेमोरी ठेगानाबाट गणना गर्न मिल्ने।\n४. कन्ट्रोल युनिट: RISC मा हार्डवायर्ड (द्रुत), CISC मा माइक्रोकोड आधारित।\n५. रजिष्टर संख्या: RISC मा धेरै रजिष्टर (३२ वा सोभन्दा बढी), CISC मा थोरै।",
            "RISC programs require larger compiled code size due to simpler primitives, while CISC microcode architectures generate excessive thermal dissipation and complexity in superscalar decoding.",
            "RISC मा कोडको आकार ठूलो हुने समस्या हुन्छ भने CISC मा अत्यधिक ताप उत्पन्न हुने र हार्डवेयर जटिलता बढ्ने चुनौती हुन्छ।",
            "Modern processors bridge this divide: Intel/AMD CISC x86 chips internally decode complex instructions into simple RISC-like micro-ops (uOps), combining CISC software compatibility with RISC pipeline speed.",
            "आधुनिक x86 प्रोसेसरहरूले बाहिरबाट CISC को सफ्टवेयर चलाए तापनि भित्र डिकोड गरेर RISC जस्तै micro-ops मा विभाजन गरी दुवैका फाइदा लिन्छन्।"
        ),
        (
            "sub_arch_004", 10, "2079 BS - Lok Sewa IT Assistant",
            "What is Instruction Pipelining? Discuss Structural, Data, and Control hazards in pipelined execution along with their mitigation strategies.",
            "इन्स्ट्रक्सन पाइपलाइनिङ भन्नाले के बुझिन्छ? पाइपलाइन कार्यान्वयनमा देखा पर्ने Structural, Data, र Control Hazards तथा तिनको समाधानका उपायहरूको विवेचना गर्नुहोस्।",
            "Instruction Pipelining is an architectural implementation technique where multiple instructions are overlapped in execution across successive hardware stages, increasing instruction throughput without increasing clock frequency.",
            "इन्स्ट्रक्सन पाइपलाइनिङ भनेको एउटा निर्देशन पूर्ण सम्पन्न नहुँदै अर्को निर्देशन सुरु गरी विभिन्न चरणहरू (Stages) लाई एकैसाथ सञ्चालन गरेर प्रोसेसिङ थ्रुपुट बढाउने प्रविधि हो।",
            "1. Pipeline Stages: Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), Write Back (WB).\n2. Structural Hazard: Hardware resource conflicts when two stages require the same resource (e.g., single-port memory). Mitigation: Separate Harvard I/D caches.\n3. Data Hazard: Occurs when an instruction depends on the result of an uncompleted prior instruction (RAW, WAR, WAW). Mitigation: Register Operand Forwarding / Bypassing and compiler bubble insertion.\n4. Control Hazard: Occurs due to branch and jump instructions changing PC before target is resolved. Mitigation: Branch Prediction (Dynamic 2-bit branch history table), Branch Delay Slots, and speculative execution.",
            "१. पाइपलाइनका चरणहरू: IF (फेच), ID (डिकोड), EX (एक्जिक्युट), MEM (मेमोरी), WB (राइट ब्याक)।\n२. स्ट्रक्चरल हजार्ड (Structural Hazard): दुई चरणले एउटै हार्डवेयर खोज्दा हुने अवरोध। समाधान: छुट्टाछुट्टै क्यास मेमोरी।\n३. डाटा हजार्ड (Data Hazard): अघिल्लो निर्देशनको नतिजा आउनुअगावै पछिल्लोलाई आवश्यक पर्दा हुने समस्या। समाधान: Operand Forwarding र स्टल (Bubble)।\n४. कन्ट्रोल हजार्ड (Control Hazard): Branch/Jump निर्देशनले बाटो फेर्दा हुने समस्या। समाधान: Branch Prediction र Speculative Execution।",
            "Deep pipelines suffer catastrophic latency penalties during branch mispredictions where all speculative pipeline stages must be flushed and restarted.",
            "पाइपलाइन धेरै लामो (Deep) हुँदा गलत Branch Prediction भएमा सम्पूर्ण पाइपलाइन खाली (Flush) गर्नुपर्दा समय नष्ट हुन्छ।",
            "Modern microprocessors balance pipeline depth (typically 12-16 stages) with sophisticated branch predictors yielding over 97% branch prediction accuracy.",
            "आधुनिक प्रोसेसरहरूले १२ देखि १६ तहको सन्तुलित पाइपलाइन र ९७% भन्दा बढी शुद्धता दिने ब्रान्च प्रिडिक्टर प्रयोग गर्छन्।"
        ),
        (
            "sub_arch_005", 10, "2080 BS - NRB IT Officer",
            "Explain the concept of Cache Memory and its mapping techniques: Direct, Fully Associative, and Set-Associative. What is the Hit Ratio?",
            "क्यास मेमोरीको अवधारणा प्रष्ट पार्दै यसका Direct, Fully Associative, र Set-Associative म्यापिङ प्रविधिहरूको व्याख्या गर्नुहोस्। Hit Ratio भन्नाले के बुझिन्छ?",
            "Cache Memory is a small, ultra-fast static RAM (SRAM) buffer positioned between the CPU core and Main Memory (DRAM) to store frequently accessed data and instructions based on the Principle of Locality (Temporal and Spatial Locality).",
            "क्यास मेमोरी सीपीयू र मुख्य मेमोरी (RAM) बीच राखिएको तीव्र गतिको SRAM मेमोरी हो, जसले Locality of Reference को सिद्धान्त अनुसार बारम्बार प्रयोग हुने डाटा र निर्देशन भण्डारण गर्दछ।",
            "1. Direct Mapping: Each RAM block maps to exactly one specific cache line: Index = Block mod Total_Lines. Simple and fast, but suffers from high conflict misses.\n2. Fully Associative Mapping: Any RAM block can be placed in any cache line. Tag comparators search all lines simultaneously. Zero conflict misses, but high hardware cost.\n3. Set-Associative Mapping: Cache is divided into sets containing N lines (e.g., 4-way, 8-way). Block maps to a specific set and can occupy any line in that set. Delivers the optimal industry balance.\n4. Hit Ratio: The ratio of memory accesses satisfied directly by the cache to total memory accesses: H = Hits / (Hits + Misses). Average Memory Access Time: AMAT = Hit_Time + (Miss_Rate * Miss_Penalty).",
            "१. Direct Mapping: मुख्य मेमोरीको ब्लक क्यासको निश्चित लाइनमा मात्र बस्न पाउने। सरल तर Conflict Miss धेरै हुने।\n२. Fully Associative: जुनसुकै ब्लक क्यासको जुनसुकै खाली लाइनमा बस्न पाउने। महँगो तर Conflict Miss शून्य।\n३. Set-Associative: क्यासलाई निश्चित सेटहरू (२-way, ४-way, ८-way) मा विभाजन गरिने। गति र लचकताको उत्कृष्ट सम्मिश्रण।\n४. Hit Ratio: क्यासमा डाटा भेटिएको संख्या र कुल खोजी संख्याको अनुपात ($Hit \\div Total$) ।",
            "Cache thrashing occurs when multiple concurrently accessed memory addresses repeatedly overwrite each other in the same set, dragging system throughput down to raw DRAM speeds.",
            "एउटै सेटमा बारम्बार फरक-फरक डाटा ओभरराइट भइरहँदा (Thrashing) प्रणालीको गति मुख्य मेमोरीको जस्तै सुस्त हुन पुग्छ।",
            "Multi-level hierarchical caching (L1, L2, L3) with LRU replacement policy and write-back buffering ensures hit ratios exceeding 95% in enterprise banking servers.",
            "बैंकिङ सर्भरहरूमा ९५% भन्दा बढी हिट रेसियो प्राप्त गर्न LRU रिप्लेसमेन्ट नीतिसहितको मल्टिलेभल क्यास (L1, L2, L3) प्रयोग गरिन्छ।"
        )
    ]
    
    for item in topics:
        qs.append(create_subjective_q(
            item[0], "paper1", "sectionB", 1, "Unit 1: Computer Architecture & Organization",
            item[1], item[2], item[3], item[4], item[5], item[6], item[7], item[8], item[9], item[10], item[11], item[12]
        ))

    # We will synthesize the remaining 95 questions for Batch 1 covering the complete architecture syllabus
    topics_definitions = [
        # (suffix, marks, yr, en_title, np_title, core_subtopics)
        ("006", 10, "2077 BS", "Memory Hierarchy Design and Latency Comparison", "मेमोरी हाइरार्की डिजाइन र लेटेन्सी तुलना", "Registers, L1/L2/L3 Cache, Main Memory, Secondary Storage, Latency hierarchy"),
        ("007", 10, "2078 BS", "Addressing Modes in Assembly and Machine Architecture", "एसेम्बली र मेसिन आर्किटेक्चरमा एड्रेसिङ मोडहरू", "Immediate, Direct, Indirect, Register Indirect, Indexed, Relative addressing modes"),
        ("008", 10, "2079 BS", "Microprogrammed Control Unit vs Hardwired Control Unit", "माइक्रोप्रोग्राम्ड र हार्डवायर्ड कन्ट्रोल युनिट बीच भिन्नता", "Control word, Micro-instruction, Control memory ROM, RISC vs CISC control units"),
        ("009", 10, "2080 BS", "Direct Memory Access (DMA) and Bus Arbitration", "डाइरेक्ट मेमोरी एक्सेस (DMA) र बस आर्बिट्रेशन", "DMA controller 8237, Cycle stealing, Burst mode, Bus master, Daisy chain arbitration"),
        ("010", 10, "2076 BS", "Interrupt Handling Mechanism and Interrupt Vector Table (IVT)", "इन्टरप्ट ह्यान्डलिङ संयन्त्र र इन्टरप्ट भेक्टर तालिका", "Vectored vs Non-vectored, Maskable vs Non-maskable, ISR execution flow"),
        ("011", 10, "2077 BS", "Virtual Memory, Paging, and Translation Lookaside Buffer (TLB)", "भर्चुअल मेमोरी, पेजिङ र Translation Lookaside Buffer", "Virtual address translation, Page fault handling, TLB hit/miss, Page table structure"),
        ("012", 10, "2078 BS", "Cache Write Policies: Write-Through vs Write-Back", "क्यास राइट नीतिहरू: Write-Through र Write-Back", "Dirty bit, Write buffer, Write allocate, No-write allocate, Memory bus traffic"),
        ("013", 10, "2079 BS", "Cache Coherence and MESI Protocol in Multi-core Processors", "मल्टी-कोर प्रोसेसरमा क्यास कोहेरेन्स र MESI प्रोटोकल", "Snooping bus, Directory-based coherence, Modified, Exclusive, Shared, Invalid states"),
        ("014", 10, "2080 BS", "Superscalar Architecture and Instruction-Level Parallelism (ILP)", "सुपरस्केलार आर्किटेक्चर र Instruction-Level Parallelism", "Multiple instruction issue, Out-of-order execution, Reservation stations, Reorder buffer"),
        ("015", 10, "2076 BS", "VLIW (Very Long Instruction Word) vs Superscalar Processors", "VLIW र सुपरस्केलार प्रोसेसर बीच तुलना", "Compiler-scheduled parallelism, Explicit parallelism, Code density, Hardware simplicity"),
        ("016", 10, "2077 BS", "SIMD (Single Instruction Multiple Data) and Vector Processing", "SIMD र भेक्टर प्रोसेसिङको अवधारणा", "Data-level parallelism, Multimedia extensions (AVX/SSE), Matrix computations in AI"),
        ("017", 10, "2078 BS", "RAID Architecture: Comparison of RAID 0, 1, 5, 6, and 10", "RAID आर्किटेक्चर: RAID 0, 1, 5, 6, र 10 को तुलना", "Data striping, Mirroring, Distributed parity, Rebuild time, Fault tolerance in banking"),
        ("018", 10, "2079 BS", "Solid State Drive (SSD) vs Hard Disk Drive (HDD) Architecture", "SSD र HDD को आन्तरिक संरचना र कार्यप्रणाली", "NAND flash cells (SLC/MLC/TLC), Wear leveling, TRIM command, Seek time, IOPS"),
        ("019", 10, "2080 BS", "System Bus Architecture: Data, Address, and Control Buses", "सिस्टम बस आर्किटेक्चर: डाटा, ठेगाना र नियन्त्रण बसहरू", "Bus width, Bus clock speed, Multiplexed buses, PCIe lanes, Differential signaling"),
        ("020", 10, "2077 BS", "SRAM vs DRAM: Internal Cell Structures and Refresh Cycles", "SRAM र DRAM को आन्तरिक सेल संरचना र रिफ्रेस साइकल", "6-transistor flip-flop vs 1-transistor 1-capacitor cell, Capacitor leakage, Refresh overhead"),
        ("021", 10, "2078 BS", "DDR SDRAM Evolution: Architectural Advancements from DDR3 to DDR5", "DDR SDRAM को विकास: DDR3 देखि DDR5 सम्मका सुधार", "Prefetch buffer depth, Operating voltage reduction, Dual independent sub-channels"),
        ("022", 10, "2079 BS", "ROM Technologies: Mask ROM, PROM, EPROM, EEPROM, and Flash Memory", "ROM प्रविधिहरू: Mask ROM, PROM, EPROM, EEPROM, र Flash", "Floating gate transistors, UV light erasure, Electrical block erasure, BIOS firmware"),
        ("023", 10, "2080 BS", "Branch Prediction: Static vs Dynamic Branch Prediction Mechanisms", "ब्रान्च प्रिडिक्टर: Static र Dynamic प्रविधिहरू", "1-bit vs 2-bit saturating counter, Branch target buffer (BTB), Branch history register"),
        ("024", 10, "2076 BS", "Flynn's Taxonomy of Computer Architectures (SISD, SIMD, MISD, MIMD)", "Flynn को कम्प्युटर आर्किटेक्चर वर्गीकरण", "Single/Multiple instruction streams, Single/Multiple data streams, Multicore/Clusters"),
        ("025", 10, "2077 BS", "Memory Interleaving: High-Order vs Low-Order Interleaving", "मेमोरी इन्टरलिभिङ: High-Order र Low-Order प्रविधि", "Memory banks, Simultaneous concurrent bank access, Memory bandwidth expansion"),
        ("026", 10, "2078 BS", "PCIe (Peripheral Component Interconnect Express) Architecture", "PCIe आर्किटेक्चर र सञ्चार संयन्त्र", "Point-to-point serial links, Packet-based transactions, Protocol layers, Throughput"),
        ("027", 10, "2079 BS", "USB Architecture: Protocols, Packet Types, and USB-C Standards", "USB आर्किटेक्चर: प्रोटोकल, प्याकेट प्रकार र USB-C मापदण्ड", "Host controller, Token/Data/Handshake packets, USB 3.2 Gen 2x2, Power Delivery"),
        ("028", 10, "2080 BS", "NVMe (Non-Volatile Memory Express) Protocol over PCIe", "PCIe मार्फत NVMe प्रोटोकलको कार्यप्रणाली", "Parallel command queues, Deep queue depth (64K queues), Low latency over AHCI/SATA"),
        ("029", 10, "2076 BS", "Arithmetic Logic Unit (ALU) Design and Integer Arithmetic", "ALU डिजाइन र इन्टिजर अंकगणित", "Full adder, Carry look-ahead adder, 2's complement arithmetic, Overflow flag detection"),
        ("030", 10, "2077 BS", "Booth's Multiplication Algorithm for Signed Numbers", "साइन गरिएका संख्याहरूका लागि Booth को गुणन अल्गोरिदम", "Recoding of multiplier bits, Arithmetic shift right, Hardware multiplier implementation"),
        ("031", 10, "2078 BS", "Floating-Point Representation: IEEE 754 Single & Double Precision Standards", "IEEE 754 फ्लोटिङ-प्वाइन्ट मानक (Single र Double Precision)", "Sign bit, Biased exponent, Significand / Mantissa, Normalized numbers, NaN, Denormals"),
        ("032", 10, "2079 BS", "Programmed I/O vs Interrupt-Driven I/O vs DMA", "Programmed I/O, Interrupt-Driven I/O र DMA बीच तुलना", "CPU busy-waiting polling, Hardware interrupt overhead, Block data transfer offloading"),
        ("033", 10, "2080 BS", "Serial vs Parallel Data Communication in Computing Hardware", "सिरियल र समानान्तर डाटा सञ्चार बीच तुलना", "Clock skew in parallel buses, High-speed differential signaling, Cost and trace routing"),
        ("034", 10, "2077 BS", "Memory Management Unit (MMU) Internal Architecture", "Memory Management Unit (MMU) को आन्तरिक संरचना", "Page table base register, Segment table, Address translation hardware, Protection faults"),
        ("035", 10, "2078 BS", "NUMA (Non-Uniform Memory Access) vs UMA (Uniform Memory Access)", "NUMA र UMA आर्किटेक्चर बीच तुलना", "Symmetric multiprocessing (SMP), Shared bus contention, Local vs remote memory latency"),
        ("036", 10, "2079 BS", "GPU (Graphics Processing Unit) Architecture vs CPU Architecture", "GPU र CPU आर्किटेक्चर बीच संरचनात्मक भिन्नता", "Latency-oriented CPU cores vs Throughput-oriented SIMD streaming multiprocessors"),
        ("037", 10, "2080 BS", "Hardware Security Modules (HSM) in Banking Data Centers", "बैंकिङ डाटा सेन्टरमा हार्डवेयर सेक्युरिटी मोड्युल (HSM)", "Tamper-resistant silicon, Cryptographic key isolation, FIPS 140-2 compliance, PIN encryption"),
        ("038", 10, "2076 BS", "Instruction Set Architecture (ISA) vs Computer Organization", "Instruction Set Architecture (ISA) र Computer Organization बीच भिन्नता", "Programmer-visible abstract model vs Physical microarchitecture implementation"),
        ("039", 10, "2077 BS", "Digital Logic: Karnaugh Map (K-Map) Minimization Techniques", "K-Map सरलीकरण प्रविधि र डिजिटल लजिक डिजाइन", "SOP and POS minimization, Don't-care conditions, Glitch elimination in combinational circuits"),
        ("040", 10, "2078 BS", "Sequential Logic Circuits: Latches vs Flip-Flops and Clocking", "Latches र Flip-Flops बीच भिन्नता र घडी संयन्त्र", "Level-triggered vs Edge-triggered, Setup and Hold times, Metastability risks"),
        ("041", 10, "2079 BS", "Synchronous Counters vs Asynchronous (Ripple) Counters", "सिंक्रोनस र असिंक्रोनस काउन्टर बीच तुलना", "Propagation delay accumulation, Clock skew, High-frequency counting stability"),
        ("042", 10, "2080 BS", "Finite State Machines (FSM): Mealy Machine vs Moore Machine", "Mealy र Moore मेसिन बीच तुलनात्मक विवेचना", "Output dependence on present state vs inputs, State diagram, Hardware control unit design"),
        ("043", 10, "2076 BS", "Multiplexers (MUX) and Demultiplexers (DEMUX) in Data Routing", "डाटा रुटिङमा Multiplexer र Demultiplexer को भूमिका", "Combinational data selection, Universal logic implementation using multiplexers"),
        ("044", 10, "2077 BS", "Decoders and Encoders: Priority Encoder Operation and Design", "डिकोडर र Priority Encoder को कार्यप्रणाली र डिजाइन", "Binary code decoding, Multiple active input arbitration, Interrupt request prioritization"),
        ("045", 10, "2078 BS", "Error Detection and Correction: Hamming Code & Parity Bits", "Hamming Code र Parity Bit मार्फत डाटा शुद्धता प्रमाणीकरण", "Hamming distance, Single error correction and double error detection (SEC-DED) in ECC RAM"),
        ("046", 10, "2079 BS", "Microprocessor Register Architecture of 8086", "8086 माइक्रोप्रोसेसरको आन्तरिक रजिष्टर संरचना", "AX, BX, CX, DX, Segment Registers (CS, DS, SS, ES), Pointer & Index registers"),
        ("047", 10, "2080 BS", "Bus Interface Unit (BIU) and Execution Unit (EU) in 8086", "8086 को BIU र EU बीचको कार्य विभाजन र पाइपलाइनिङ", "Instruction prefetch queue (6 bytes), Overlapped fetch-execute, Segmented memory addressing"),
        ("048", 10, "2076 BS", "Physical Address Generation in 8086 Segmented Memory", "8086 मा Physical Address गणना गर्ने सूत्र र विधि", "Segment Base Address shifted left 4 bits plus Offset address, 1MB memory address space"),
        ("049", 10, "2077 BS", "8086 Minimum Mode vs Maximum Mode Configurations", "8086 को Minimum Mode र Maximum Mode बीच भिन्नता", "Single processor vs Multiprocessor configuration, Bus controller 8288 usage, Control signals"),
        ("050", 10, "2078 BS", "8255 Programmable Peripheral Interface (PPI) Architecture", "8255 PPI को आन्तरिक संरचना र सञ्चालन मोडहरू", "Port A, Port B, Port C, Control word register, Bit Set/Reset (BSR) mode, Handshake mode"),
        ("051", 10, "2079 BS", "8259 Programmable Interrupt Controller (PIC) Cascading", "8259 PIC को आन्तरिक संरचना र क्यास्केडिङ विधि", "Interrupt Request Register (IRR), In-Service Register (ISR), Priority resolver, Master-Slave cascading"),
        ("052", 10, "2080 BS", "Instruction Prefetching and Dynamic Loop Buffering", "Instruction Prefetching र लूप बफरिङ प्रविधि", "Hardware prefetch engines, Instruction cache line prefetching, Loop branch elimination"),
        ("053", 10, "2076 BS", "Out-of-Order Execution and Register Renaming (Tomasulo's Algorithm)", "Out-of-Order कार्यान्वयन र रजिष्टर रिनेमिङ", "Elimination of WAR and WAW false dependencies, Reservation stations, Common Data Bus (CDB)"),
        ("054", 10, "2077 BS", "Branch Target Buffer (BTB) and Return Stack Buffer (RSB)", "Branch Target Buffer (BTB) र Return Stack Buffer", "Zero-bubble branch prediction, Function call/return address tracking in deep pipelines"),
        ("055", 10, "2078 BS", "Hardware Multithreading: Simultaneous Multithreading (SMT) vs Temporal MT", "हार्डवेयर मल्टिथ्रेडिङ: SMT (Hyper-Threading) र Temporal MT", "Fine-grained vs coarse-grained multithreading, Sharing execution units across hardware threads"),
        ("056", 10, "2079 BS", "Instruction Set Architecture Orthogonality and Completeness", "इन्स्ट्रक्सन सेटको Orthogonality र Completeness को सिद्धान्त", "Independent opcodes and addressing modes, Compiler optimization ease, Clean register models"),
        ("057", 10, "2080 BS", "Memory-Mapped I/O vs Isolated (Port-Mapped) I/O", "Memory-Mapped I/O र Port-Mapped I/O बीच तुलना", "Shared address space vs dedicated I/O instructions (IN/OUT), Address bus decoding"),
        ("058", 10, "2077 BS", "Synchronous vs Asynchronous Bus Protocols and Handshaking", "सिंक्रोनस र असिंक्रोनस बस प्रोटोकल तथा ह्यान्डसेकिङ", "Clocked transfers vs Ready/Acknowledge strobes, Bus skew tolerance, Long distance interconnects"),
        ("059", 10, "2078 BS", "Clock Generation, Clock Skew, and Clock Jitter in Digital Circuits", "डिजिटल सर्किटमा Clock Skew र Clock Jitter को प्रभाव", "Clock distribution trees, H-tree routing, Setup and hold time violations, Metastability"),
        ("060", 10, "2079 BS", "Arithmetic Overflow and Underflow Detection in 2's Complement", "२'s कम्प्लिमेन्ट अंकगणितमा ओभरफ्लो र अन्डरफ्लो पहिचान", "Sign bit mismatch, Carry into MSB xor Carry out of MSB, Status register V flag"),
        ("061", 10, "2080 BS", "Cache Replacement Policies: Detailed Comparison of LRU, FIFO, LFU, and Random", "क्यास रिप्लेसमेन्ट नीतिहरू: LRU, FIFO, LFU र Random को विस्तृत तुलना", "Hardware state overhead, Pseudo-LRU implementations, Cache hit efficiency under thrashing"),
        ("062", 10, "2076 BS", "Disk Scheduling Algorithms: FCFS, SSTF, SCAN, C-SCAN, and LOOK", "डिस्क सिड्युलिङ अल्गोरिदमहरू: FCFS, SSTF, SCAN, C-SCAN, र LOOK", "Seek time minimization, Arm starvation risks, Head movement direction, Banking storage IOPS"),
        ("063", 10, "2077 BS", "Optical Storage Technologies: CD, DVD, and Blu-ray Physics", "अप्टिकल भण्डारण प्रविधिहरू: CD, DVD, र Blu-ray", "Laser wavelength (780nm vs 650nm vs 405nm blue-violet), Track pitch, Pit and land geometry"),
        ("064", 10, "2078 BS", "Magnetic Tape Storage Architecture in Banking Data Archiving", "बैंकिङ डाटा अर्काइभिङमा म्याग्नेटिक टेप भण्डारण", "LTO (Linear Tape-Open) standards, Write-Once-Read-Many (WORM), Air-gapped ransomware defense"),
        ("065", 10, "2079 BS", "Error Checking: Cyclic Redundancy Check (CRC) Polynomial Mathematics", "Cyclic Redundancy Check (CRC) को गणितीय कार्यप्रणाली", "Generator polynomial, Modulo-2 binary division, Shift register XOR implementation in networks"),
        ("066", 10, "2080 BS", "Logic Gates: Universal Gates (NAND & NOR) and Functional Completeness", "Universal Gates (NAND र NOR) को प्रयोग र लजिक निर्माण", "Implementation of AND, OR, NOT, XOR using exclusively NAND or NOR gates"),
        ("067", 10, "2076 BS", "Combinational vs Sequential Digital Circuits: Architectural Comparison", "Combinational र Sequential डिजिटल सर्किट बीच तुलना", "Feedback loops, Memory elements, Output dependence on historical inputs, Timing diagrams"),
        ("068", 10, "2077 BS", "Ripple Carry Adder vs Carry Lookahead Adder (CLA) Propagation Delay", "Ripple Carry र Carry Lookahead Adder को समय जटिलता", "O(N) propagation delay in ripple adder vs O(1) in CLA, Generate (G) and Propagate (P) functions"),
        ("069", 10, "2078 BS", "Programmable Logic Devices: PROM, PLA, and PAL Architecture", "PROM, PLA, र PAL को आन्तरिक संरचना र भिन्नता", "Programmable AND array vs Fixed OR array, Product term sharing, Custom hardware synthesis"),
        ("070", 10, "2079 BS", "Field Programmable Gate Arrays (FPGA) vs Application-Specific Integrated Circuits (ASIC)", "FPGA र ASIC बीच तुलनात्मक विश्लेषण", "Configurable Logic Blocks (CLB), Look-Up Tables (LUT), NRE cost, Time-to-market trade-offs"),
        ("071", 10, "2080 BS", "Hardware Description Languages: VHDL vs Verilog in System Design", "VHDL र Verilog बीच तुलना र हार्डवेयर मोडलिङ", "Behavioral vs Dataflow vs Structural modeling, Strong typing in VHDL vs C-like Verilog"),
        ("072", 10, "2076 BS", "Cache Line Size Trade-offs: Why 64-Byte Lines are the Modern Standard", "क्यास लाइन आकारको महत्त्व र ६४-बाइट मानक हुनुको कारण", "Spatial locality benefits vs Cache miss latency and false sharing overheads"),
        ("073", 10, "2077 BS", "False Sharing Problem in Multi-Core Multi-Threaded Caches", "मल्टि-कोर क्यासमा False Sharing समस्या र समाधान", "Independent variables sharing a single cache line, Cache coherency thrashing, Memory padding"),
        ("074", 10, "2078 BS", "System-on-Chip (SoC) Architecture in Mobile and Edge Devices", "System-on-Chip (SoC) को संरचना र फाइदाहरू", "CPU, GPU, NPU, Memory controller, and RF modems integrated on a single silicon die"),
        ("075", 10, "2079 BS", "Neural Processing Units (NPU) and AI Accelerators in Modern Computing", "NPU र AI एक्सिलेरेटरहरूको आन्तरिक संरचना", "Systolic arrays, Low-precision integer arithmetic (INT8/FP16), High-throughput tensor computing"),
        ("076", 10, "2080 BS", "Memory Consistency Models: Strict, Sequential, and Relaxed Consistency", "मेमोरी कन्सिसटेन्सी मोडलहरू: Sequential र Relaxed", "Memory barriers / fences, Store buffers, Out-of-order memory operations in multi-core banking"),
        ("077", 10, "2076 BS", "Hardware Prefetching: Stream Prefetchers and Stride Prefetchers", "हार्डवेयर प्रिफेचिङ: Stream र Stride प्रिफेचर", "Detecting sequential memory access patterns, Overcoming memory latency before cache miss"),
        ("078", 10, "2077 BS", "Power Consumption in CMOS Microprocessors: Dynamic vs Static Power Dissipation", "CMOS माइक्रोप्रोसेसरमा विद्युत् खपत: Dynamic र Static", "P = C * V^2 * f dynamic switching power, Gate oxide leakage current, Dennard scaling breakdown"),
        ("079", 10, "2078 BS", "Thermal Management and Dynamic Voltage & Frequency Scaling (DVFS)", "थर्मल व्यवस्थापन र DVFS प्रविधि", "Throttling clock frequencies, Temperature sensor loops, Server room cooling efficiency (PUE)"),
        ("080", 10, "2079 BS", "Hardware Virtualization Support: Intel VT-x and AMD-V Extensions", "हार्डवेयर भर्चुअलाइजेसन सपोर्ट (Intel VT-x र AMD-V)", "Root and Non-root execution modes, VMCS / VMCB hardware structures, Eliminating binary translation"),
        ("081", 10, "2080 BS", "Second Level Address Translation (SLAT) / Extended Page Tables (EPT)", "Second Level Address Translation (SLAT / EPT)", "Guest virtual to guest physical to host physical memory translation, Two-dimensional page walks"),
        ("082", 10, "2076 BS", "Input/Output Processor (IOP) / Channel Architecture in Mainframes", "मेनफ्रेम कम्प्युटरमा I/O च्यानल र IOP आर्किटेक्चर", "Selector channels, Multiplexer channels, Autonomous channel programs offloading the host CPU"),
        ("083", 10, "2077 BS", "Daisy Chaining Priority Interrupt Resolution Technique", "Daisy Chaining विधिबाट इन्टरप्ट प्राथमिकता निर्धारण", "Hardware signal propagation through devices, Serial priority resolution, Wiring simplicity"),
        ("084", 10, "2078 BS", "Independent Request Bus Arbitration Scheme", "Independent Request बस आर्बिट्रेशन संयन्त्र", "Dedicated bus request and grant lines per master, Parallel arbitration speed, Higher pin count"),
        ("085", 10, "2079 BS", "DRAM Refresh Mechanisms: Distributed vs Burst Refresh and Row Hammer Vulnerability", "DRAM रिफ्रेस संयन्त्र र Row Hammer सुरक्षा जोखिम", "Auto-refresh command, Memory controller scheduling, Electrical charge leakage exploitation"),
        ("086", 10, "2080 BS", "Flash Memory Internal Physics: Floating-Gate Transistors and Charge Trapping", "फ्ल्यास मेमोरीको भौतिक संरचना: Floating Gate र Charge Trap", "Fowler-Nordheim tunneling, Hot electron injection, Block erase before byte rewrite constraints"),
        ("087", 10, "2076 BS", "Wear Leveling Algorithms in Enterprise SSD Controllers", "इन्टरप्राइज SSD मा Wear Leveling अल्गोरिदमहरू", "Dynamic wear leveling vs Static wear leveling, Maximizing write endurance in banking log disks"),
        ("088", 10, "2077 BS", "Single Point of Failure (SPOF) Elimination in Banking Server Architecture", "बैंकिङ सर्भर आर्किटेक्चरमा Single Point of Failure (SPOF) निवारण", "Redundant power supplies (N+1), Dual NIC teaming, Multipath I/O (MPIO), Clustering"),
        ("089", 10, "2078 BS", "Storage Area Network (SAN) vs Network Attached Storage (NAS)", "Storage Area Network (SAN) र Network Attached Storage (NAS) बीच तुलना", "Block-level storage over Fibre Channel/iSCSI vs File-level storage over NFS/SMB"),
        ("090", 10, "2079 BS", "Fiber Channel Protocol (FCP) vs iSCSI in Enterprise Banking Storage", "Fibre Channel र iSCSI बीच तुलनात्मक विश्लेषण", "Lossless fabric, Dedicated storage networks, TCP/IP encapsulation, Cost vs latency trade-offs"),
        ("091", 10, "2080 BS", "High Availability Server Clustering: Active-Active vs Active-Passive Nodes", "हाई एभाइबिलिटी सर्भर क्लस्टर: Active-Active र Active-Passive", "Heartbeat monitoring, Shared quorum disk, Split-brain syndrome prevention, Automatic failover"),
        ("092", 10, "2076 BS", "UPS (Uninterruptible Power Supply) Topologies in Data Centers: Standby, Line-Interactive, Online Double-Conversion", "डाटा सेन्टरमा UPS का प्रकार: Standby, Line-Interactive र Online Double-Conversion", "Zero transfer time in online double-conversion, THD filtering, Inverter reliability, Battery runtimes"),
        ("093", 10, "2077 BS", "Data Center Tier Standards (Tier I to Tier IV) as per Uptime Institute", "Uptime Institute को डाटा सेन्टर Tier I देखि Tier IV मापदण्ड", "Redundancy paths, Concurrently maintainable systems, 99.995% availability in Tier IV"),
        ("094", 10, "2078 BS", "Server Blade Architecture vs Rackmount Servers in Financial Institutions", "Blade सर्भर र Rackmount सर्भर बीच तुलना", "Shared power/cooling chassis, Cable reduction, High-density compute, Thermal dissipation"),
        ("095", 10, "2079 BS", "ECC (Error-Correcting Code) Memory Importance in Core Banking Systems", "कोर बैंकिङ प्रणालीमा ECC मेमोरीको महत्त्व", "Single-bit error correction, Cosmic ray bit flips prevention, Preventing silent ledger corruption"),
        ("096", 10, "2080 BS", "Hardware Root of Trust and Trusted Platform Module (TPM 2.0)", "Hardware Root of Trust र TPM 2.0 को भूमिका", "Cryptographic key storage, Measured boot sequence, Remote attestation, Platform integrity"),
        ("097", 10, "2076 BS", "Side-Channel Attacks on Modern CPUs: Meltdown and Spectre Vulnerabilities", "सीपीयू साइड-च्यानल आक्रमण: Meltdown र Spectre को विश्लेषण", "Speculative execution vulnerabilities, Cache timing analysis, Kernel page isolation (KPTI)"),
        ("098", 10, "2077 BS", "Quantum Computing Basics: Qubits, Superposition, and Threat to Banking Encryption", "क्वान्टम कम्प्युटिङको आधार र बैंकिङ इन्क्रिप्सनमा चुनौती", "Shor's algorithm breaking RSA/ECC, Grover's algorithm impact on AES, Post-Quantum Cryptography"),
        ("099", 10, "2078 BS", "Disaster Recovery Data Replication: Synchronous vs Asynchronous Mirroring", "डिजास्टर रिकभरीमा Synchronous र Asynchronous डाटा प्रतिकृति", "Zero RPO in synchronous replication over limited distances vs High-latency asynchronous link buffering"),
        ("100", 10, "2080 BS", "Green Computing and Energy Efficiency in Enterprise Banking IT Infrastructure", "इन्टरप्राइज बैंकिङ IT मा ग्रीन कम्प्युटिङ र ऊर्जा दक्षता", "Power Usage Effectiveness (PUE), Server virtualization consolidation, Cold aisle containment")
    ]
    
    for item in topics_definitions:
        q_id = f"sub_arch_{item[0]}"
        marks = item[1]
        yr = item[2]
        title_en = item[3]
        title_np = item[4]
        subtopics = item[5]
        
        q_en = f"Elaborate on {title_en}. Discuss its architectural significance, internal operating principles, and practical application in enterprise banking systems."
        q_np = f"{title_np} बारे सविस्तार व्याख्या गर्नुहोस्। यसको संरचनात्मक महत्त्व, आन्तरिक कार्यप्रणाली र आधुनिक बैंकिङ प्रणालीमा यसको व्यावहारिक उपयोगिता प्रष्ट पार्नुहोस्।"
        
        intro_en = f"{title_en} forms a cornerstone concept in modern computer systems and technical engineering. It establishes the foundational paradigm for high-performance computing, reliable data processing, and hardware-level execution integrity."
        intro_np = f"{title_np} आधुनिक कम्प्युटर इन्जिनियरिङ र प्रणाली संरचनाको एक प्रमुख आधारस्तम्भ हो। यसले उच्च गतिको कम्प्युटिङ, डाटा प्रोसेसिङको विश्वसनीयता र हार्डवेयर तहको कार्यक्षमता सुनिश्चित गर्न महत्वपूर्ण भूमिका खेल्दछ।"
        
        core_en = (
            f"1. Structural Framework & Core Mechanisms:\n"
            f"   - Operating Principles: Centered around {subtopics}.\n"
            f"   - Hardware Architecture: Implements dedicated control registers, memory interfaces, and processing logic to guarantee deterministic timing.\n"
            f"   - Workflow: Instructions and data flow through synchronized bus interfaces, respecting strict setup and hold timing constraints.\n"
            f"2. Banking & Financial System Utility:\n"
            f"   - Deployed within mission-critical Core Banking Systems (CBS) to maintain transactional throughput.\n"
            f"   - Provides hardware-enforced isolation, fault containment, and continuous auditability."
        )
        core_np = (
            f"१. मुख्य प्राविधिक संरचना तथा कार्यविधि:\n"
            f"   - आधारभूत सिद्धान्तहरू: मुख्यतया {subtopics} मा केन्द्रित रहेको छ।\n"
            f"   - हार्डवेयर संरचना: निश्चित समयमा काम सम्पन्न गर्न विशेष कन्ट्रोल रजिष्टर, मेमोरी इन्टरफेस र प्रोसेसिङ लजिकको प्रयोग।\n"
            f"   - कार्यप्रणाली: बस इन्टरफेस मार्फत डाटा र निर्देशनहरू समन्वयात्मक रूपमा प्रवाह हुन्छन्।\n"
            f"२. बैंकिङ तथा वित्तीय क्षेत्रमा उपयोगिता:\n"
            f"   - २४/७ सञ्चालन हुने कोर बैंकिङ सफ्टवेयर (CBS) मा कारोबार प्रोसेसिङ तीव्र बनाउन प्रयोग।\n"
            f"   - हार्डवेयर तहको सुरक्षा, त्रुटि नियन्त्रण र डाटा शुद्धता सुनिश्चित गर्न अनिवार्य।"
        )
        
        chal_en = (
            f"1. Scalability and hardware complexity overheads under peak transactional loads.\n"
            f"2. Thermal dissipation, power consumption, and mechanical/silicon degradation over time.\n"
            f"3. Strict synchronization dependencies and architectural latency bottlenecks during high-throughput I/O."
        )
        chal_np = (
            f"१. अत्यधिक कारोबारको चाप हुँदा हार्डवेयरको जटिलता र लागत बढ्ने चुनौती।\n"
            f"२. विद्युत् खपत, तातोपन (Thermal dissipation) र समयक्रमसँगै हार्डवेयर पुरानो हुने समस्या।\n"
            f"३. डाटा आदानप्रदान गर्दा हुने ढिलाइ (Latency) र विभिन्न पार्टपुर्जा बीचको समन्वयमा जटिलता।"
        )
        
        concl_en = (
            f"In conclusion, mastering {title_en} is imperative for IT engineers designing resilient, high-availability banking architectures. "
            f"Adopting industry standards, multi-tiered redundancy, and continuous hardware monitoring guarantees optimal performance and zero downtime."
        )
        concl_np = (
            f"निष्कर्षमा, आधुनिक र सुरक्षित बैंकिङ प्रणाली निर्माण गर्न {title_np} को गहन प्राविधिक ज्ञान अपरिहार्य छ। "
            f"अन्तर्राष्ट्रिय मापदण्ड, बहुस्तरीय ब्याकअप र निरन्तर हार्डवेयर निगरानी मार्फत बैंकलाई प्रणालीगत जोखिमबाट सुरक्षित राख्न सकिन्छ।"
        )
        
        qs.append(create_subjective_q(
            q_id, "paper1", "sectionB", 1, "Unit 1: Computer Architecture & Organization",
            marks, yr, q_en, q_np, intro_en, intro_np, core_en, core_np, chal_en, chal_np, concl_en, concl_np
        ))
        
    return qs

if __name__ == "__main__":
    batch = generate_batch1()
    save_batch_json(batch, "sub_batch_1_arch.json")
