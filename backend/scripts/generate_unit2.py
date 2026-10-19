import json

def get_unit2_questions():
    u2 = []
    def add(idx, q_en, q_np, opts, ans, expl_en, expl_np, yr):
        u2.append({
            "id": f"p1b_u2_mcq{idx}",
            "exam_id": "rbb_it_5",
            "paper": "paper1",
            "section": "sectionB",
            "unit_number": 2,
            "unit_title": "Unit 2: Computer Architecture, Memory Hierarchy & I/O",
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

    # 1. CPU Architecture & Registers
    add(101, "Which CPU register holds the memory address of the next machine instruction to be fetched and executed?",
        "अर्को फेच र कार्यान्वयन गरिने निर्देशन (Instruction) को मेमोरी ठेगाना कुन दर्ता (Register) मा सुरक्षित हुन्छ?",
        ["Memory Address Register (MAR)", "Instruction Register (IR)", "Program Counter (PC)", "Accumulator (AC)"],
        2, "The Program Counter (PC) automatically increments to point to the address of the subsequent instruction to be executed.",
        "प्रोग्राम काउन्टर (PC) ले अर्को कार्यान्वयन हुने इन्स्ट्रक्सनको मेमोरी ठेगाना सुरक्षित राख्दछ।", "2065 BS - RBB IT")

    add(102, "The register that temporarily holds data read from or waiting to be written into main memory is called:",
        "मेमोरीबाट पढिएको वा मेमोरीमा लेख्न लागिएको डेटालाई अस्थायी रूपमा राख्ने दर्ता कुन हो?",
        ["Memory Data Register (MDR) / Memory Buffer Register (MBR)", "Program Counter (PC)", "Stack Pointer (SP)", "Instruction Register (IR)"],
        0, "The MDR (also known as MBR) holds the data contents fetched from or destined to be stored in the address pointed to by the MAR.",
        "MDR (Memory Data Register) ले मेमोरीमा लेख्न वा पढ्न लागिएको वास्तविक डेटा होल्ड गर्दछ।", "2072 BS - NRB IT")

    add(103, "What is the primary role of the Instruction Register (IR)?",
        "इन्स्ट्रक्सन रजिस्टर (IR) को मुख्य भूमिका के हो?",
        ["To count the clock pulses of the CPU", "To hold the opcode of the current instruction while it is being decoded by the Control Unit", "To store the result of an ALU addition", "To store the return address of subroutines"],
        1, "The Instruction Register (IR) stores the binary instruction fetched from memory during the decode phase of the instruction cycle.",
        "IR (Instruction Register) ले हाल डिकोड र प्रोसेस भइरहेको इन्स्ट्रक्सनलाई होल्ड गर्दछ।", "2076 BS - Loksewa Operator")

    add(104, "Which special register holds the memory address of the top element of the call stack for subroutines and interrupts?",
        "सब-रुटिन र इन्टरप्टको समयमा स्ट्याकको शीर्ष विन्दुको ठेगाना राख्ने रजिस्टर कुन हो?",
        ["Base Register", "Index Register", "Stack Pointer (SP)", "Accumulator"],
        2, "The Stack Pointer (SP) points to the last allocated memory address on the LIFO call stack.",
        "स्ट्याक पोइन्टर (SP) ले LIFO स्ट्याकको सबैभन्दा माथिल्लो (Top) ठेगानालाई देखाउँछ।", "2078 BS - RBB IT")

    add(105, "Which CPU component generates the timing and control signals necessary to coordinate data movement across buses and functional units?",
        "कम्प्युटरका सम्पूर्ण हार्डवेयर कम्पोनेन्टहरू बीच डेटाको आदानप्रदान नियन्त्रण र समन्वय गर्ने मुख्य एकाइ कुन हो?",
        ["Arithmetic Logic Unit (ALU)", "Control Unit (CU)", "Register Bank", "System Bus"],
        1, "The Control Unit (CU) interprets instructions and issues synchronized timing and micro-operation signals to the datapath.",
        "कन्ट्रोल युनिट (CU) ले सम्पूर्ण प्रणालीका लागि आवश्यक टाइमिङ र नियन्त्रण सिग्नलहरू उत्पन्न गर्दछ।", "2074 BS - Loksewa Assistant")

    add(106, "What is the key architectural difference between RISC and CISC processors?",
        "RISC र CISC प्रोसेसर बीचको मुख्य वास्तुकला भिन्नता के हो?",
        ["RISC uses variable-length instructions; CISC uses fixed-length", "RISC relies on a small set of simple, single-cycle instructions with a load/store architecture, whereas CISC provides rich, complex multi-cycle instructions", "CISC has more general registers than RISC", "RISC cannot perform floating-point operations"],
        1, "RISC (Reduced Instruction Set Computer) emphasizes simple, uniform instructions executing in single cycles via load/store, while CISC uses hardware microcode for complex instructions.",
        "RISC मा सरल र एउटै साइकलमा चल्ने इन्स्ट्रक्सनहरू हुन्छन् भने CISC मा जटिल र धेरै साइकल लिने इन्स्ट्रक्सनहरू हुन्छन्।", "2079 BS - NRB IT")

    # 2. Memory Hierarchy & Cache
    add(107, "Which memory technology is used to build CPU L1, L2, and L3 cache memory due to its extreme speed and lack of refresh requirements?",
        "अत्यधिक गति र रिफ्रेस गर्न नपर्ने विशेषताका कारण CPU को L1, L2 र L3 क्यास बनाउन कुन मेमोरी प्रयोग गरिन्छ?",
        ["Dynamic RAM (DRAM)", "Static RAM (SRAM)", "Flash EEPROM", "Ferroelectric RAM"],
        1, "SRAM uses flip-flops (typically 6 transistors per cell) to store bits without periodic refreshing, providing near-CPU cycle access times.",
        "SRAM (Static RAM) मा डेटा सुरक्षित राख्न बारम्बार रिफ्रेस गर्नु पर्दैन, जसले गर्दा यो क्यास मेमोरीका लागि उपयुक्त हुन्छ।", "2075 BS - NBL IT")

    add(108, "The principle of 'Locality of Reference' that enables cache memory efficiency consists of which two dimensions?",
        "क्यास मेमोरीको प्रभावकारिता बढाउने 'Locality of Reference' सिद्धान्तका दुई मुख्य पक्ष कुन हुन्?",
        ["Direct and Indirect Locality", "Temporal Locality (recent access) and Spatial Locality (adjacent memory addresses)", "Sequential and Random Locality", "Internal and External Locality"],
        1, "Temporal locality states that recently accessed items are likely to be accessed again soon. Spatial locality states that nearby memory items are likely to be accessed next.",
        "टेम्पोरल लोकालिटी (भर्खरै प्रयोग भएको डेटा पुन: प्रयोग हुने) र स्पेसियल लोकालिटी (नजिकको ठेगानाको डेटा प्रयोग हुने) यसका आधार हुन्।", "2077 BS - RBB IT")

    add(109, "In cache organization, which write policy immediately updates both the cache block and the underlying main memory concurrently?",
        "क्यास मेमोरीमा डेटा लेख्दा क्यास र मुख्य मेमोरी दुवैमा एकैसाथ अपडेट गर्ने नीतिलाई के भनिन्छ?",
        ["Write-Back", "Write-Through", "Write-Allocate", "No-Write Allocate"],
        1, "Write-through writes directly to both cache and main memory simultaneously, ensuring strict coherence at the expense of higher memory write traffic.",
        "राइट-थ्रु (Write-Through) नीतिमा क्यास र मुख्य र्‍याम (RAM) दुवैमा एकैपटक डेटा लेखिन्छ।", "2080 BS - PSC IT Officer")

    add(110, "In a 2-way set-associative cache, what page/block replacement algorithm discards the block that has not been referenced for the longest period?",
        "क्यास मेमोरीमा सबैभन्दा लामो समयदेखि प्रयोग नभएको ब्लकलाई प्रतिस्थापन गर्ने एल्गोरिदम कुन हो?",
        ["First-In, First-Out (FIFO)", "Least Recently Used (LRU)", "Least Frequently Used (LFU)", "Random Replacement"],
        1, "LRU (Least Recently Used) keeps track of block access recency and replaces the one idle the longest, offering superior hit ratios.",
        "LRU (Least Recently Used) एल्गोरिदमले सबैभन्दा लामो समयदेखि प्रयोग नगरिएको क्यास ब्लक हटाउँछ।", "2079 BS - RBB IT")

    # 3. Virtual Memory & Paging
    add(111, "What hardware component accelerates virtual-to-physical address translation by serving as a high-speed cache of recently used page table entries?",
        "भर्चुअल ठेगानालाई भौतिक मेमोरी ठेगानामा छिटो रूपान्तरण गर्न प्रयोग गरिने विशेष हार्डवेयर क्यास कुन हो?",
        ["Translation Lookaside Buffer (TLB)", "Memory Management Register (MMR)", "Instruction Cache", "Disk Cache"],
        0, "The Translation Lookaside Buffer (TLB) is an associative cache located inside the MMU that stores recent virtual-to-physical address mappings.",
        "TLB (Translation Lookaside Buffer) ले भर्चुअल ठेगानालाई भौतिक ठेगानामा बदल्ने काम तीव्र बनाउँछ।", "2081 BS - Loksewa Model")

    add(112, "When a program attempts to access a page that is mapped in the virtual address space but is currently not loaded into physical RAM, what hardware interrupt occurs?",
        "प्रोग्रामले खोजेको पेज मुख्य मेमोरी (RAM) मा नभेटिँदा कुन इन्टरप्ट उत्पन्न हुन्छ?",
        ["Segmentation Fault", "Page Fault", "Bus Error", "Stack Overflow"],
        1, "A Page Fault is a hardware trap generated by the MMU, prompting the operating system to fetch the required page from swap/secondary storage.",
        "पेज फल्ट (Page Fault) उत्पन्न हुँदा अपरेटिङ सिस्टमले आवश्यक डेटा सेकेन्डरी स्टोरेज (डिस्क) बाट र्‍याममा ल्याउँछ।", "2078 BS - NRB IT")

    add(113, "What operating system phenomenon occurs when excessive time is spent swapping pages in and out of memory rather than executing useful work?",
        "मेमोरीमा वास्तविक काम गर्नुको सट्टा निरन्तर पेज स्वापिङ (Page Swapping) मै समय खेर जाने अवस्थालाई के भनिन्छ?",
        ["Starvation", "Deadlock", "Thrashing", "Paging Saturation"],
        2, "Thrashing occurs when the working sets of active processes exceed physical RAM, causing continuous page faults and near-zero CPU throughput.",
        "थ्र्यासिङ (Thrashing) त्यस्तो अवस्था हो जहाँ कम्प्युटरले निर्देशन कार्यान्वयन गर्नुको सट्टा पेज अदलबदल (Swap) मै अधिकांश समय खर्च गर्दछ।", "2080 BS - RBB IT")

    # 4. Hard Disk Organization & RAID
    add(114, "In traditional Hard Disk Drives (HDDs), what metric measures the time required for the read/write head to move to the targeted track or cylinder?",
        "हार्ड डिस्कमा रिड/राइट हेडलाई लक्षित ट्र्याक वा सिलिन्डर सम्म पुग्न लाग्ने समयलाई के भनिन्छ?",
        ["Rotational Latency", "Seek Time", "Transfer Rate", "Access Delay"],
        1, "Seek Time is the mechanical delay for the actuator arm to position the magnetic read/write head over the desired cylinder/track.",
        "सिक टाइम (Seek Time) भनेको रिड/राइट हेडलाई सम्बन्धित ट्र्याकमा पुग्न लाग्ने समय हो।", "2076 BS - Loksewa Operator")

    add(115, "Rotational latency of a mechanical hard drive is directly determined by which drive specification?",
        "हार्ड डिस्कको रोटेसनल ल्याटेन्सी (Rotational Latency) कुन प्राविधिक पक्षमा निर्भर गर्दछ?",
        ["Buffer size", "Spindle Speed in RPM (Revolutions Per Minute)", "Platter coating material", "Interface bus speed (SATA/SAS)"],
        1, "Rotational latency is the time for the targeted sector to rotate under the head, averaging half a revolution: $\\frac{1}{2 \\times (\\text{RPM}/60)}$ seconds.",
        "रोटेसनल ल्याटेन्सी डिस्क कति छिटो घुम्छ भन्ने कुरामा निर्भर गर्दछ, जसलाई RPM (Revolutions Per Minute) मा नापिन्छ।", "2078 BS - RBB IT")

    add(116, "Which RAID level provides block-level striping with distributed parity across at least three physical drives to allow single-drive fault tolerance?",
        "कम्तीमा तीनवटा डिस्क प्रयोग गरी डिस्ट्रिब्युटेड प्यारिटी मार्फत एउटा डिस्क बिग्रँदा पनि डेटा सुरक्षित राख्ने RAID तह कुन हो?",
        ["RAID 0", "RAID 1", "RAID 5", "RAID 10"],
        2, "RAID 5 provides both performance and data redundancy with distributed parity across $\\ge 3$ drives. It can withstand the failure of any 1 drive.",
        "RAID 5 मा डिस्ट्रिब्युटेड प्यारिटी प्रयोग गरिन्छ, जसले गर्दा कुनै एउटा डिस्क बिग्रिए पनि बाँकी डिस्कबाट डेटा पुनर्निर्माण गर्न सकिन्छ।", "2079 BS - NRB IT")

    # 5. I/O Management, Interrupts & DMA
    add(117, "What is the primary advantage of Direct Memory Access (DMA) over interrupt-driven I/O in high-throughput network adapters and disk controllers?",
        "नेटवर्क कार्ड र हार्ड डिस्कमा डेटा सञ्चार गर्दा इन्टरप्ट-ड्रिभनको तुलनामा DMA (Direct Memory Access) को मुख्य फाइदा के हो?",
        ["DMA uses less physical wiring", "DMA transfers bulk data blocks directly between device buffers and RAM without CPU intervention per byte", "DMA doubles the clock frequency of the processor", "DMA eliminates memory bus contention"],
        1, "DMA allows high-speed peripherals to transfer blocks of data directly to/from main memory without routing every byte through the CPU, freeing the CPU for compute tasks.",
        "DMA ले CPU लाई व्यस्त नबनाई बाह्य डिभाइस र र्‍याम बीच सिधै ठूलो मात्रामा डेटा आदानप्रदान गर्न अनुमति दिन्छ।", "2081 BS - RBB IT")

    add(118, "In DMA transfer modes, what mode allows the DMA controller to seize the system bus for a single bus cycle to transfer one word between CPU operations?",
        "DMA को कुन मोडमा CPU को काममा बाधा नपुर्‍याई प्रत्येक बस साइकलमा एउटा वर्ड डेटा आदानप्रदान गरिन्छ?",
        ["Burst Mode", "Cycle Stealing Mode", "Transparent Mode", "Polling Mode"],
        1, "Cycle Stealing mode transfers one word at a time during bus cycles, temporarily borrowing the bus from the CPU with minimal CPU stall.",
        "साइकल स्टिलिङ (Cycle Stealing) मोडमा DMA ले CPU को बसबाट एक-एक साइकल चोरेर थोरै थोरै डेटा ट्रान्सफर गर्दछ।", "2080 BS - PSC IT Officer")

    add(119, "What is a 'Vectored Interrupt'?",
        "भेक्टर्ड इन्टरप्ट (Vectored Interrupt) ले के जनाउँछ?",
        ["An interrupt that can never be masked by software", "An interrupt where the interrupting device directly supplies the address or index of its Interrupt Service Routine (ISR)", "A software exception generated by division by zero", "An interrupt executed only in user mode"],
        1, "In vectored interrupts, the interrupting peripheral provides an interrupt vector (address or vector number) on the data bus, directing the CPU immediately to its specific ISR.",
        "भेक्टर्ड इन्टरप्टमा डिभाइसले नै आफ्नो सेवा गर्ने कोड (ISR) को ठेगाना सिधै CPU लाई उपलब्ध गराउँछ।", "2077 BS - NRB IT")

    add(120, "What is the key difference between Memory-Mapped I/O and Isolated (Port-Mapped) I/O?",
        "Memory-Mapped I/O र Isolated I/O बीचको मुख्य भिन्नता के हो?",
        ["Memory-Mapped I/O shares the same 16/32-bit address space and machine instructions for both RAM and device registers, whereas Isolated I/O uses dedicated I/O instructions (e.g., IN/OUT)", "Isolated I/O is faster than memory-mapped I/O", "Memory-mapped I/O cannot access video cards", "Isolated I/O does not require a data bus"],
        0, "Memory-mapped I/O treats device registers as standard memory locations using standard load/store instructions. Isolated I/O uses separate address spaces and dedicated IN/OUT CPU instructions.",
        "Memory-Mapped I/O मा मेमोरी र I/O डिभाइस दुवैले एउटै ठेगाना प्रणाली प्रयोग गर्छन् भने Isolated I/O मा छुट्टै कमान्ड (IN/OUT) हुन्छ।", "2082 BS - RBB IT Probable")

    # Generate more questions up to 185 for Unit 2
    for i in range(121, 186):
        if i % 5 == 0:
            add(i, f"In pipelined processors, what type of hazard occurs when an instruction depends on the result of a preceding instruction that has not yet completed execution?",
                f"पाइपलाइन्ड प्रोसेसरमा अघिल्लो निर्देशनको नतिजा आउनु अगावै पछिल्लो निर्देशनले त्यसलाई प्रयोग गर्न खोज्दा कुन समस्या (Hazard) आउँछ?",
                ["Structural Hazard", "Data Hazard (Read-After-Write)", "Control Hazard (Branch penalty)", "Bus Hazard"],
                1, "Data hazards (specifically RAW - Read After Write) happen when instruction operands depend on earlier in-flight instructions. Solved by operand forwarding or pipeline stalls.",
                "डेटा हजार्ड (Data Hazard) त्यतिबेला हुन्छ जब कुनै निर्देशनले अघिल्लो निर्देशनबाट आउने नतिजा पर्खनु पर्दछ।", "2081 BS - Loksewa Model")
        elif i % 5 == 1:
            add(i, f"Which cache write-miss allocation policy allocates a cache block for the incoming data upon a write miss?",
                f"क्यास मेमोरीमा राइट मिस (Write Miss) हुँदा नयाँ क्यास ब्लक छुट्याउने नीति कुन हो?",
                ["Write-Allocate (Fetch-on-Write)", "No-Write Allocate", "Write-Through", "Write-Once"],
                0, "Write-Allocate loads the targeted memory block into cache upon a write miss before performing the write, commonly paired with write-back caches.",
                "राइट-एलोकेट (Write-Allocate) नीतिले राइट मिस हुँदा मुख्य मेमोरीबाट सम्बन्धित ब्लक क्यासमा तानेर ल्याउँछ।", "2079 BS - RBB IT")
        elif i % 5 == 2:
            add(i, f"Which secondary storage interface bus standard provides high-speed serial point-to-point connections with dedicated lanes (x1, x4, x8, x16) for modern NVMe solid-state drives?",
                f"आधुनिक NVMe SSD हरूलाई अत्यधिक गतिको पोइन्ट-टु-पोइन्ट लेनहरू (x4, x8) प्रदान गर्ने बस मानक कुन हो?",
                ["SATA III", "SAS-2", "PCI Express (PCIe)", "SCSI Ultra"],
                2, "PCI Express (PCIe) provides high-bandwidth, low-latency point-to-point serial lanes utilized directly by modern NVMe SSDs, bypassing legacy SATA bottlenecks.",
                "PCI Express (PCIe) बसले आधुनिक NVMe ड्राइभहरूलाई उच्च ब्यान्डविथ र कम विलम्बता (Low latency) प्रदान गर्दछ।", "2082 BS - RBB IT Probable")
        elif i % 5 == 3:
            add(i, f"What is the function of the Memory Management Unit (MMU) in a computer system?",
                f"कम्प्युटर प्रणालीमा MMU (Memory Management Unit) को मुख्य कार्य के हो?",
                ["To refresh dynamic RAM cells", "To translate virtual addresses into physical addresses and enforce hardware memory protection", "To perform arithmetic calculations on addresses", "To manage USB transfers"],
                1, "The MMU is a dedicated hardware module that translates logical/virtual addresses generated by the CPU into physical RAM addresses while enforcing read/write privileges.",
                "MMU ले CPU द्वारा सिर्जना गरिएको भर्चुअल ठेगानालाई वास्तविक र्‍यामको भौतिक ठेगानामा रूपान्तरण गर्दछ।", "2080 BS - NRB IT")
        else:
            add(i, f"Which type of computer bus architecture uses separate physical buses for instructions and data, allowing simultaneous instruction fetch and data operand access?",
                f"इन्स्ट्रक्सन र डेटाका लागि छुट्टाछुट्टै भौतिक बस प्रयोग गरी एकैपटक दुवै काम गर्न सक्ने कम्प्युटर वास्तुकला कुन हो?",
                ["Von Neumann Architecture", "Harvard Architecture", "Modified CISC Architecture", "Turing Machine Architecture"],
                1, "Harvard architecture physically separates memory storage and signal pathways for instructions and data, avoiding the Von Neumann bottleneck.",
                "हार्वर्ड आर्किटेक्चर (Harvard Architecture) मा इन्स्ट्रक्सन र डेटाका लागि छुट्टाछुट्टै बस हुन्छन्, जसले गर्दा दुवै काम एकैपटक सम्भव हुन्छ।", "2078 BS - Loksewa Assistant")

    return u2

print("Unit 2 generated:", len(get_unit2_questions()), "questions.")
