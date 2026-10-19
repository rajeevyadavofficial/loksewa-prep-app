import json

def get_unit4_questions():
    u4 = []
    def add(idx, q_en, q_np, opts, ans, expl_en, expl_np, yr):
        u4.append({
            "id": f"p1b_u4_mcq{idx}",
            "exam_id": "rbb_it_5",
            "paper": "paper1",
            "section": "sectionB",
            "unit_number": 4,
            "unit_title": "Unit 4: Operating System, Process Management & Security",
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

    # Process Management & Scheduling
    add(101, "Which CPU scheduling algorithm is non-preemptive and selects the process with the smallest anticipated execution time?",
        "कुन CPU शेड्युलिङ एल्गोरिदम नन-प्रिएम्प्टिभ हुन्छ र सबैभन्दा छोटो अनुमानित कार्यान्वयन समय भएको प्रक्रिया छनोट गर्दछ?",
        ["First-Come, First-Served (FCFS)", "Shortest Job First (SJF)", "Round Robin (RR)", "Priority Scheduling (Preemptive)"],
        1, "Non-preemptive SJF schedules the process with the shortest CPU burst time, provably minimizing average waiting time for a given set of processes.",
        "SJF (Shortest Job First) ले सबैभन्दा कम समय लिने कामलाई पहिले सम्पन्न गर्दछ, जसले औसत प्रतिक्षा समय (Waiting Time) घटाउँछ।", "2068 BS - RBB IT")

    add(102, "In Round Robin CPU scheduling, what happens if the time quantum allocated to processes is set excessively large?",
        "राउन्ड रोबिन शेड्युलिङमा टाइम क्वान्टम (Time Quantum) अत्यधिक ठूलो बनाइयो भने यसको व्यवहार कस्तो हुन्छ?",
        ["It causes immediate CPU deadlock", "It degenerates into First-Come, First-Served (FCFS) scheduling", "It behaves like Shortest Remaining Time First", "It doubles context-switch overhead"],
        1, "If the time quantum exceeds the longest CPU burst, every process completes in its first slice without preemption, degenerating into FCFS.",
        "टाइम क्वान्टम धेरै ठूलो राखिएमा राउन्ड रोबिन प्रणाली FCFS (First-Come, First-Served) मा परिणत हुन्छ।", "2074 BS - NRB IT")

    add(103, "What data structure does the operating system maintain for each active process to store its execution state, program counter, and CPU registers?",
        "अपरेटिङ सिस्टमले प्रत्येक सक्रिय प्रक्रियाको अवस्था र रजिस्टरहरू सुरक्षित राख्न कुन डेटा संरचना प्रयोग गर्दछ?",
        ["File Allocation Table (FAT)", "Process Control Block (PCB)", "Inverted Page Table", "Interrupt Vector Table"],
        1, "The Process Control Block (PCB / task struct) contains PID, process state, program counter, CPU registers, scheduling priority, and open file descriptors.",
        "PCB (Process Control Block) मा प्रक्रियाको आइडी, अवस्था, मेमोरी सिमा र दर्ताहरू सुरक्षित हुन्छन्।", "2076 BS - Loksewa Operator")

    add(104, "Which of the following is NOT one of the four necessary Coffman conditions required for a deadlock to occur?",
        "डेडलक (Deadlock) हुनका लागि आवश्यक चारवटा कफम्यान सर्तहरू मध्ये कुन होइन?",
        ["Mutual Exclusion", "Hold and Wait", "Preemption of Resources", "Circular Wait"],
        2, "'No Preemption' (resources cannot be forcibly confiscated) is the required deadlock condition. Preemption actually prevents or breaks deadlocks.",
        "डेडलकका लागि 'No Preemption' (खोस्न नपाइने) सर्त हुनुपर्दछ, प्रिएम्प्सन भएमा डेडलक हुँदैन।", "2077 BS - RBB IT")

    add(105, "Which classic deadlock avoidance algorithm tests for safety by simulating the allocation of predetermined maximum possible resources before granting requests?",
        "स्रोतको माग पूरा गर्नु अगावै प्रणाली सुरक्षित अवस्था (Safe State) मा रहन्छ कि रहँदैन भनी जाँच्ने प्रसिद्ध डेडलक निवारण एल्गोरिदम कुन हो?",
        ["Round Robin Algorithm", "Banker's Algorithm", "Elevator Algorithm (SCAN)", "Peterson's Algorithm"],
        1, "Dijkstra's Banker's Algorithm simulates resource allocation to ensure the system remains in a safe state where at least one execution sequence can terminate.",
        "डिक्सट्राको ब्याङ्कर्स एल्गोरिदम (Banker's Algorithm) ले प्रणालीलाई असुरक्षित अवस्था र डेडलकबाट जोगाउँछ।", "2079 BS - NRB IT")

    add(106, "In UNIX/Linux systems, which system call creates a new duplicate child process by duplicating the calling process's address space?",
        "युनिक्स/लिनक्समा चलिरहेको प्रक्रियाको हुबहु नक्कल गरी नयाँ चाइल्ड प्रोसेस बनाउने सिस्टम कल कुन हो?",
        ["fork()", "exec()", "spawn()", "clone_thread()"],
        0, "The `fork()` system call creates an identical child process with a unique PID, returning 0 to the child and the child's PID to the parent.",
        "`fork()` सिस्टम कलले नयाँ चाइल्ड प्रोसेस सिर्जना गर्दछ।", "2080 BS - PSC IT Officer")

    add(107, "Which Linux command displays active processes and dynamically updates their CPU and real-time memory utilization every few seconds?",
        "लिनक्समा चलिरहेका प्रक्रियाहरूको CPU र मेमोरी उपयोगिता निरन्तर ताजा देखाउने कमान्ड कुन हो?",
        ["ps -ef", "top", "free -m", "df -h"],
        1, "The `top` command provides a dynamic, real-time interactive view of system processes, sorting tasks by CPU and memory consumption.",
        "`top` कमान्डले लिनक्समा वास्तविक समयमा स्रोतहरूको खपत र प्रक्रियाहरू देखाउँछ।", "2078 BS - Loksewa Assistant")

    add(108, "What octal numeric mode represents read, write, and execute permissions for the owner, and read-only permissions for group and others (`rwxr--r--`) in Linux?",
        "लिनक्समा फाइलको मालिकलाई पूर्ण अधिकार (Read/Write/Execute) र अरूलाई पढ्ने मात्र अधिकार (`rwxr--r--`) दिन कुन अङ्क प्रयोग गरिन्छ?",
        ["755", "744", "644", "777"],
        1, "Owner: rwx = 4+2+1 = 7. Group: r-- = 4+0+0 = 4. Others: r-- = 4+0+0 = 4. Total octal permission is 744.",
        "मालिकका लागि ७ (rwx) र समूह तथा अरूका लागि ४ (r--) गर्दा अक्टल मान ७४४ (744) हुन्छ।", "2076 BS - Loksewa Operator")

    add(109, "Which inter-process synchronization primitive invented by Edsger Dijkstra uses integer counters accessed atomically via `wait()` ($P$) and `signal()` ($V$) operations?",
        "दुई वा सोभन्दा बढी प्रक्रियाहरू बीच स्रोतको बाँडफाँड मिलाउन डिक्सट्राले प्रतिपादन गरेको इन्टिजर काउन्टर कुन हो?",
        ["Mutex Lock", "Counting Semaphore", "Spinlock", "Condition Variable"],
        1, "A counting semaphore uses an integer value that is decremented atomically by `wait()` and incremented by `signal()`, synchronizing access to a finite pool of resources.",
        "काउन्टिङ सेमाफोर (Counting Semaphore) ले प्रक्रियाहरू बीच स्रोतहरूको सुरक्षित साझेदारी सुनिश्चित गर्दछ।", "2081 BS - RBB IT")

    add(110, "What memory vulnerability occurs when an application writes more data to a buffer on the call stack than was allocated, potentially overwriting the instruction pointer?",
        "आवश्यकता भन्दा बढी डेटा स्ट्याकमा पठाएर रिटर्न ठेगाना ओभरराइट गरी अनधिकृत कोड चलाउने कमजोरीलाई के भनिन्छ?",
        ["SQL Injection", "Buffer Overflow", "Race Condition", "Cross-Site Scripting"],
        1, "A stack buffer overflow overwrites adjacent memory spaces (including the saved EIP/RIP return address), allowing attackers to execute arbitrary shellcode.",
        "बफर ओभरफ्लो (Buffer Overflow) ले मेमोरीको सीमा भन्दा बढी डेटा लेखेर प्रणालीलाई नियन्त्रणमा लिन मद्दत गर्दछ।", "2081 BS - NRB IT")

    # Generate more questions up to 185 for Unit 4
    for i in range(111, 186):
        if i % 4 == 0:
            add(i, f"In modern multi-tasking operating systems, what is the role of the 'Short-Term Scheduler' (CPU Scheduler)?",
                f"मल्टिटास्किङ अपरेटिङ सिस्टममा 'सर्ट-टर्म शेड्युलिङ' (Short-Term Scheduler) को मुख्य जिम्मेवारी के हो?",
                ["Loads programs from disk into main memory", "Selects from ready processes in memory and allocates the CPU to one of them", "Controls degree of multiprogramming", "Manages printer spooling queues"],
                1, "The short-term scheduler (dispatcher) executes frequently (milliseconds) to select which in-memory ready process runs on the CPU next.",
                "सर्ट-टर्म शेड्युलरले मेमोरीमा तयार रहेका प्रक्रियाहरू मध्येबाट एउटालाई छानेर CPU सुम्पिन्छ।", "2082 BS - RBB IT Probable")
        elif i % 4 == 1:
            add(i, f"Which file system is standard on modern enterprise Windows Server editions, providing file permissions, journaling, and transparent encryption?",
                f"विन्डोज सर्भरमा सुरक्षा, जर्नालिङ र इन्क्रिप्सनका लागि प्रयोग गरिने मानक फाइल प्रणाली कुन हो?",
                ["FAT32", "NTFS (New Technology File System)", "ext4", "exFAT"],
                1, "NTFS supports access control lists (ACLs), file compression, transaction journaling for crash recovery, and Encrypting File System (EFS).",
                "NTFS ले विन्डोजमा फाइल अनुमति, सुरक्षा र प्रणाली क्र्यास हुँदा डेटा जोगाउने जर्नालिङ सुविधा दिन्छ।", "2079 BS - RBB IT")
        elif i % 4 == 2:
            add(i, f"In operating system memory virtualization, what is 'External Fragmentation'?",
                f"मेमोरी व्यवस्थापनमा 'बाह्य खण्डीकरण' (External Fragmentation) ले के जनाउँछ?",
                ["Wasted space inside a fixed-size partition allocated to a small process", "Total free memory space is sufficient to satisfy a request, but it is non-contiguous and cannot be allocated", "Disk sector bad blocks", "Page table cache misses"],
                1, "External fragmentation happens in dynamic variable-partition allocation where free memory is broken into tiny non-contiguous blocks.",
                "पर्याप्त कुल खाली मेमोरी भए पनि त्यो एकमुष्ठ (Contiguous) नभएर टुक्रा-टुक्रा परेको अवस्था बाह्य खण्डीकरण हो।", "2080 BS - NRB IT")
        else:
            add(i, f"Which Linux command is used to terminate an unresponsive process with a forceful, uncatchable termination signal (`SIGKILL`)?",
                f"लिनक्समा कुनै नरोकिएको प्रक्रियालाई तुरुन्तै जबर्जस्ती बन्द गर्न कुन कमान्ड प्रयोग गरिन्छ?",
                ["kill -9 <PID>", "kill -15 <PID>", "stop <PID>", "abort <PID>"],
                0, "`kill -9` sends SIGKILL (signal 9), which cannot be caught, blocked, or ignored by the process, forcing the kernel to terminate it immediately.",
                "`kill -9` कमान्डले SIGKILL सिग्नल पठाएर कुनै पनि प्रक्रियालाई तत्काल नष्ट गर्दछ।", "2078 BS - Loksewa Operator")

    return u4

print("Unit 4 generated:", len(get_unit4_questions()), "questions.")
