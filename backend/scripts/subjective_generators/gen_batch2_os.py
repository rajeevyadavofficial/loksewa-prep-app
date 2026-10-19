# -*- coding: utf-8 -*-
"""
Domain 2: Operating Systems & System Programming (100 Subjective Q&As)
Covers Lok Sewa Paper 1 Section B Unit 2 / Paper 2 Technical.
"""

from base import create_subjective_q, save_batch_json

def generate_batch2():
    qs = []
    
    os_topics = [
        ("001", 10, "2080 BS", "Operating System Architectures: Monolithic vs Microkernel vs Hybrid Kernels", "अपरेटिङ सिस्टमको संरचना: Monolithic, Microkernel र Hybrid Kernel को तुलना", "Address space isolation, IPC overhead, Hardware drivers execution domain, Linux vs Mach vs Windows NT"),
        ("002", 10, "2079 BS", "Process Lifecycle States and Process Control Block (PCB) Structure", "प्रोसेस लाइफसाइकलका अवस्थाहरू र Process Control Block (PCB) को संरचना", "New, Ready, Running, Waiting, Terminated states, PID, Context switching, Program counter, Register save area"),
        ("003", 10, "2078 BS", "Threads vs Processes: User-Level Threads vs Kernel-Level Threads", "थ्रेड र प्रोसेस बीच भिन्नता: User-Level र Kernel-Level थ्रेडहरू", "Thread Control Block (TCB), Shared address space, Context switch overhead, POSIX pthreads, Many-to-One vs One-to-One"),
        ("004", 10, "2080 BS", "CPU Scheduling Criteria: Turnaround Time, Waiting Time, Response Time, and Throughput", "सीपीयू सिड्युलिङका मापदण्डहरू: Turnaround, Waiting र Response Time", "Burst time, Arrival time, Preemptive vs Non-preemptive scheduling, Gantt chart analysis"),
        ("005", 10, "2079 BS", "CPU Scheduling Algorithms: FCFS, SJF, SRTF, Priority, and Round Robin (RR)", "सीपीयू सिड्युलिङ अल्गोरिदमहरू: FCFS, SJF, SRTF, Priority र Round Robin", "Time quantum selection, Convoy effect in FCFS, Starvation in priority scheduling, Aging technique"),
        ("006", 10, "2077 BS", "Multilevel Queue (MLQ) and Multilevel Feedback Queue (MLFQ) Scheduling", "Multilevel Queue र Multilevel Feedback Queue सिड्युलिङ विधि", "Foreground vs Background queues, Dynamic priority adjustment based on CPU burst history, Aging"),
        ("007", 10, "2078 BS", "Inter-Process Communication (IPC): Shared Memory vs Message Passing", "Inter-Process Communication (IPC): Shared Memory र Message Passing", "Direct vs Indirect communication, Synchronous vs Asynchronous primitives, Shared memory race conditions"),
        ("008", 10, "2080 BS", "Critical Section Problem and Peterson's Algorithmic Solution", "क्रिटिकल सेक्सन समस्या र Peterson को अल्गोरिदम समाधान", "Mutual Exclusion, Progress, Bounded Waiting conditions, Two-process software synchronization"),
        ("009", 10, "2079 BS", "Semaphores: Binary vs Counting Semaphores and Implementation", "बाइनरी र काउन्टिङ सेमाफोरको अवधारणा र कार्यविधि", "Wait (P) and Signal (V) atomic primitives, Spinlocks, Block-and-wakeup queue implementation"),
        ("010", 10, "2078 BS", "Classic Synchronization Problems: Producer-Consumer (Bounded Buffer)", "उत्पादक-उपभोक्ता (Bounded Buffer) सिङ्क्रोनाइजेसन समस्या", "Empty, Full, and Mutex semaphores, Buffer overflow and underflow prevention"),
        ("011", 10, "2077 BS", "Classic Synchronization Problems: Readers-Writers Problem", "पाठक-लेखक (Readers-Writers) समस्या र प्राथमिकता समाधान", "Shared read locks, Exclusive write locks, Reader starvation vs Writer starvation solutions"),
        ("012", 10, "2079 BS", "Classic Synchronization Problems: Dining Philosophers Problem", "Dining Philosophers समस्या र रिसोर्स डेडलोक समाधान", "Circular wait condition, Resource hierarchy solution, Chandy/Misra solution, Monitor implementation"),
        ("013", 10, "2080 BS", "Deadlock Definition and the Four Necessary Coffman Conditions", "डेडलोकको परिभाषा र चार अनिवार्य कफम्यान सर्तहरू (Coffman Conditions)", "Mutual exclusion, Hold and wait, No preemption, Circular wait graph cycles"),
        ("014", 10, "2078 BS", "Deadlock Prevention vs Deadlock Avoidance vs Deadlock Detection", "डेडलोक रोकथाम (Prevention), बचावट (Avoidance) र पहिचान (Detection)", "Eliminating Coffman conditions, Safe state vs Unsafe state, Resource Allocation Graph (RAG) reduction"),
        ("015", 10, "2079 BS", "Banker's Algorithm for Multi-Resource Deadlock Avoidance", "Banker's Algorithm को कार्यप्रणाली र सुरक्षित क्रम (Safe Sequence)", "Available, Allocation, Max, and Need matrices, Safety algorithm execution steps"),
        ("016", 10, "2080 BS", "Deadlock Recovery Techniques: Process Termination and Resource Preemption", "डेडलोक मुक्ति प्रविधिहरू: प्रोसेस अन्त्य र स्रोत जफत", "Abort all deadlocked processes, Victim selection, Rollback to checkpoint, Starvation handling"),
        ("017", 10, "2077 BS", "Memory Management: Contiguous Memory Allocation and Fragmentation", "कन्टिग्युअस मेमोरी बाँडफाँड र फ्र्याग्मेन्टेसन (Internal र External)", "Base and Limit registers, Internal vs External fragmentation, Compaction techniques"),
        ("018", 10, "2078 BS", "Dynamic Storage Allocation Strategies: First-Fit, Best-Fit, and Worst-Fit", "मेमोरी बाँडफाँड रणनीतिहरू: First-Fit, Best-Fit, र Worst-Fit", "Search speed vs Memory utilization efficiency, Storage fragmentation trade-offs"),
        ("019", 10, "2079 BS", "Paging Architecture: Logical-to-Physical Address Translation", "पेजिङ आर्किटेक्चर: लजिकल ठेगानालाई भौतिक ठेगानामा रूपान्तरण", "Page number, Offset, Page Table Entry (PTE), Frame allocation, Hardware address translation"),
        ("020", 10, "2080 BS", "Translation Lookaside Buffer (TLB) and Effective Memory Access Time (EMAT)", "TLB क्यास र Effective Memory Access Time (EMAT) गणना", "TLB hit ratio, TLB miss penalty, EMAT = Hit*(TLB+RAM) + (1-Hit)*(TLB+2*RAM) formula"),
        ("021", 10, "2076 BS", "Hierarchical Paging, Inverted Page Tables, and Hashed Page Tables", "Hierarchical Paging, Inverted Page Table र Hashed Page Table", "Two-level / multi-level page tables, Memory overhead reduction in 64-bit address spaces"),
        ("022", 10, "2077 BS", "Segmentation Architecture vs Paging in Memory Management", "सेग्मेन्टेसन र पेजिङ बीच तुलना र Segmentation with Paging", "Logical user view, Segment Table, Base and Limit check, Protection bits, Sharing segments"),
        ("023", 10, "2078 BS", "Virtual Memory Concept: Demand Paging and Page Fault Handling", "भर्चुअल मेमोरी र Demand Paging मा Page Fault व्यवस्थापन", "Valid/Invalid bit, Page fault trap to OS, Bringing page from swap disk to RAM, Frame allocation"),
        ("024", 10, "2079 BS", "Page Replacement Algorithms: FIFO, Optimal (OPT), and LRU", "पेज रिप्लेसमेन्ट अल्गोरिदमहरू: FIFO, Optimal (OPT), र LRU", "Belady's Anomaly in FIFO, Stack algorithms, Hardware approximation of LRU using reference bits"),
        ("025", 10, "2080 BS", "LRU Page Replacement Approximations: Second-Chance (Clock) Algorithm", "LRU को Second-Chance (Clock) पेज रिप्लेसमेन्ट अल्गोरिदम", "Reference bit, Clock hand pointer, Circular linked list, Modified/Dirty bit integration"),
        ("026", 10, "2076 BS", "Thrashing Phenomenon: Causes, Detection, and Working Set Model", "मेमोरी थ्रेसिङ (Thrashing) का कारण, पहिचान र Working Set Model", "High paging activity, Degree of multiprogramming collapse, Working set window parameter Delta"),
        ("027", 10, "2077 BS", "File System Architecture: File Concept, Attributes, Operations, and File Types", "फाइल सिस्टमको संरचना: फाइलका विशेषता, सञ्चालन र फाइलका प्रकार", "Name, Identifier, Type, Location, Size, Access permissions, File control block (FCB) / Inode"),
        ("028", 10, "2078 BS", "File Access Methods: Sequential Access vs Direct (Random) Access", "फाइल पहुँच विधिहरू: Sequential Access र Direct (Random) Access", "Pointer rewind/advance, Relative record numbering, Hash-based index file access in banking logs"),
        ("029", 10, "2079 BS", "Directory Structures: Single-Level, Two-Level, Tree-Structured, and Acyclic-Graph", "डाइरेक्टरी संरचनाहरू: Single-Level, Two-Level, Tree-Structured, र Acyclic-Graph", "Naming collisions, Pathnames (Absolute vs Relative), File sharing via hard links and soft links"),
        ("030", 10, "2080 BS", "File Allocation Methods: Contiguous, Linked, and Indexed Allocation", "फाइल बाँडफाँड विधिहरू: Contiguous, Linked, र Indexed Allocation", "External fragmentation in contiguous, FAT table in linked, Single/Double indirect blocks in Unix Inode"),
        ("031", 10, "2077 BS", "Unix/Linux Inode Architecture: Direct, Single Indirect, Double, and Triple Indirect Pointers", "Unix/Linux Inode संरचना: Direct, Single, Double र Triple Indirect प्वाइन्टर", "File metadata, 12 direct pointers, File size calculation formula, Inode table structure"),
        ("032", 10, "2078 BS", "Free Space Management Techniques: Bit Vector (Bitmap), Linked List, and Grouping", "फ्री स्पेस व्यवस्थापन प्रविधिहरू: Bitmap, Linked List, र Grouping", "Bit map memory overhead, Counting method, Fast block allocation in high-speed banking SSDs"),
        ("033", 10, "2079 BS", "File System Journaling: Ext4 vs NTFS Journaling Mechanics", "फाइल सिस्टम जर्नालिङ: Ext4 र NTFS मा डाटा सुरक्षा", "Write-Ahead Logging, Journal replay after system crash, Full journaling vs Ordered vs Writeback mode"),
        ("034", 10, "2080 BS", "Virtual File System (VFS) Layer in Unix/Linux Operating Systems", "Unix/Linux मा Virtual File System (VFS) लेयरको भूमिका", "VFS abstraction, Inode, Dentry, File, and Superblock object operations, Cross-filesystem mounting"),
        ("035", 10, "2076 BS", "I/O Hardware: Polling, Interrupts, Direct Memory Access, and Bus Interfaces", "I/O हार्डवेयर: Polling, Interrupts, DMA र Bus इन्टरफेस", "I/O ports, Memory-mapped I/O, Interrupt-request lines, DMA block transfers to RAM"),
        ("036", 10, "2077 BS", "Kernel I/O Subsystem: I/O Scheduling, Buffering, Caching, and Spooling", "Kernel I/O Subsystem: I/O Scheduling, Buffering, Caching, र Spooling", "Device driver interface, Double buffering, Disk cache synchronization, Print spooling daemon"),
        ("037", 10, "2078 BS", "Disk Scheduling Algorithms: FCFS, SSTF, SCAN (Elevator), C-SCAN, and LOOK", "डिस्क सिड्युलिङ अल्गोरिदमहरू: FCFS, SSTF, SCAN, C-SCAN र LOOK", "Seek time minimization, Rotational delay, Starvation in SSTF, Uniform wait times in C-SCAN"),
        ("038", 10, "2079 BS", "Operating System Security: Protection Mechanisms, Access Matrix, and ACLs", "अपरेटिङ सिस्टम सुरक्षा: Access Matrix, Access Control Lists (ACL) र Capabilities", "Domains of protection, Row-wise ACLs, Column-wise Capability lists, Principle of Least Privilege"),
        ("039", 10, "2080 BS", "User Authentication Mechanisms in Modern Operating Systems", "अपरेटिङ सिस्टममा प्रयोगकर्ता प्रमाणीकरण संयन्त्रहरू", "Shadow password hashing (SHA-512 with Salt), PAM (Pluggable Authentication Modules), Kerberos, MFA"),
        ("040", 10, "2076 BS", "Virtualization: Type-1 (Bare-Metal) vs Type-2 (Hosted) Hypervisors", "भर्चुअलाइजेसन: Type-1 (Bare-Metal) र Type-2 (Hosted) Hypervisor बीच भिन्नता", "ESXi / KVM vs VMware Workstation, Ring-0 privilege execution, Overhead, Performance in data centers"),
        ("041", 10, "2077 BS", "Containerization vs Virtualization: Docker vs Virtual Machines", "कन्टेनर र भर्चुअल मेसिन बीच तुलना: Docker vs VM", "Shared OS kernel, Linux namespaces, cgroups, Layered images, Fast boot times, Microservices agility"),
        ("042", 10, "2078 BS", "Real-Time Operating Systems (RTOS): Hard vs Soft Real-Time Systems", "Real-Time Operating Systems (RTOS): Hard र Soft Real-Time Systems", "Deterministic latency, Deadline constraints, Priority inversion, Priority Inheritance Protocol"),
        ("043", 10, "2079 BS", "Distributed Operating Systems: Network Transparency and RPC", "डिस्ट्रिब्युटेड अपरेटिङ सिस्टम: नेटवर्क पारदर्शिता र Remote Procedure Call (RPC)", "Location transparency, Failure transparency, RPC client/server stubs, Marshalling and Unmarshalling"),
        ("044", 10, "2080 BS", "Linux Process Management: fork(), exec(), wait(), and exit() System Calls", "लिनक्स प्रोसेस व्यवस्थापन: fork(), exec(), wait(), र exit() सिस्टम कल", "Copy-on-Write (COW) optimization, Zombie processes, Orphan processes, Init/Systemd adoption"),
        ("045", 10, "2076 BS", "Linux Memory Management: Slab Allocator and Buddy System", "लिनक्स मेमोरी व्यवस्थापन: Buddy System र Slab Allocator", "Power-of-two page frame allocation, Coalescing free buddies, Kernel object caching, Cache hit speed"),
        ("046", 10, "2077 BS", "Linux File Permissions, UMASK, SUID, SGID, and Sticky Bit", "लिनक्स फाइल पर्मिसन, UMASK, SUID, SGID, र Sticky Bit को कार्यविधि", "rwx bits (4,2,1 octal), Changing ownership (chown), Elevating execution privilege (SUID root security)"),
        ("047", 10, "2078 BS", "Shell Scripting in Linux: Control Structures, Variables, and Automation", "लिनक्स शेल स्क्रिप्टिङ: कन्ट्रोल स्ट्रक्चर, रिएबल र सिस्टम अटोमेसन", "Bash environment, Positional parameters, If-else, For/While loops, Automated backup crontabs"),
        ("048", 10, "2079 BS", "Systemd and Init System: Service Units, Targets, and Journalctl", "Systemd र Init प्रणाली: Service Units, Targets र Journalctl लग व्यवस्थापन", "Parallel service startup, Dependency resolution, systemctl commands, Boot performance profiling"),
        ("049", 10, "2080 BS", "Linux Storage Management: Logical Volume Manager (LVM) Architecture", "लिनक्समा Logical Volume Manager (LVM) को संरचना र व्यवस्थापन", "Physical Volumes (PV), Volume Groups (VG), Logical Volumes (LV), Dynamic online resizing, Snapshots"),
        ("050", 10, "2076 BS", "Network File System (NFS) Architecture and RPC Mechanics", "Network File System (NFS) को आन्तरिक संरचना र कार्यप्रणाली", "Stateless NFS v3 vs Stateful NFS v4, Mount protocol, Remote file locking, Banking shared NAS"),
        ("051", 10, "2077 BS", "Windows NT Kernel Architecture: Executive, HAL, and User-Mode Subsystems", "Windows NT को आन्तरिक संरचना: Executive, HAL र User-Mode Subsystems", "Hardware Abstraction Layer (HAL), Win32 API subsystem, I/O Manager, Driver stacks"),
        ("052", 10, "2078 BS", "Windows Registry Architecture: Hives, Keys, and System Configuration", "Windows Registry को संरचना: Hives, Keys र सुरक्षा व्यवस्थापन", "HKEY_LOCAL_MACHINE, HKEY_CURRENT_USER, System startup parameters, Group Policy objects (GPO)"),
        ("053", 10, "2079 BS", "Active Directory Domain Services (AD DS) in Enterprise Banking Networks", "इन्टरप्राइज बैंकिङमा Active Directory (AD DS) को संरचना र भूमिका", "Domain Controllers, Forests, Trees, OUs, LDAP, Kerberos ticket authentication, Centralized GPO"),
        ("054", 10, "2080 BS", "Operating System Monolithic Kernels: Advantages and Security Risks", "Monolithic Kernel का फाइदा र सुरक्षा जोखिमहरू", "Zero IPC overhead for kernel services, Device driver kernel crash risks, Attack surface vulnerability"),
        ("055", 10, "2076 BS", "Operating System Microkernels: IPC Overhead and Reliability Benefits", "Microkernel आर्किटेक्चर: IPC ओभरहेड र प्रणाली विश्वसनीयता", "Running drivers and file systems in user space, Fault isolation, QNX real-time automotive OS"),
        ("056", 10, "2077 BS", "Dual-Mode Operation in Operating Systems: User Mode vs Kernel Mode", "अपरेटिङ सिस्टमको Dual-Mode सञ्चालन: User Mode र Kernel Mode", "Privileged CPU instructions, Mode bit, System call traps, Hardware memory protection boundaries"),
        ("057", 10, "2078 BS", "Context Switching: Overhead, Hardware Register Swapping, and Cache Eviction", "कन्टेक्स्ट स्विचिङ (Context Switching) को प्रक्रिया, ओभरहेड र क्यास खाली हुनु", "Saving CPU state in PCB, Restoring next process state, TLB invalidation, Direct and indirect costs"),
        ("058", 10, "2079 BS", "Thread Scheduling: Process Contention Scope (PCS) vs System Contention Scope (SCS)", "थ्रेड सिड्युलिङ: Process Contention Scope (PCS) र System Contention Scope (SCS)", "Scheduling user threads onto kernel LWPs vs Kernel scheduling LWPs onto physical CPU cores"),
        ("059", 10, "2080 BS", "Spinlocks vs Mutexes: Busy-Waiting Trade-offs in Multiprocessor OS", "Spinlocks र Mutexes बीच तुलना: Busy-Waiting को प्रभाव", "Test-and-Set hardware primitive, Short wait durations on multicore vs Sleeping thread context switch"),
        ("060", 10, "2076 BS", "Monitors in High-Level Synchronization: Condition Variables and Operations", "हाई-लेभल सिङ्क्रोनाइजेसनमा Monitors र Condition Variables", "Wait() and Signal() operations, Automatic mutual exclusion, Java synchronized methods"),
        ("061", 10, "2077 BS", "Resource Allocation Graph (RAG): Cycle Detection and Deadlock Identification", "Resource Allocation Graph (RAG) मार्फत डेडलोक पहिचान", "Request edges, Assignment edges, Single vs Multi-unit resource instances, Cycle sufficiency condition"),
        ("062", 10, "2078 BS", "Memory Compaction: Overcoming External Fragmentation in Dynamic Allocation", "मेमोरी कम्प्याक्सन (Compaction) प्रविधि र यसका सीमाहरू", "Relocatable dynamic partitions, Relocation register updates, High disk/memory I/O overhead"),
        ("063", 10, "2079 BS", "Buddy System Memory Allocation Algorithm: Mechanics and Coalescing", "Buddy System मेमोरी बाँडफाँड अल्गोरिदम र Coalescing प्रक्रिया", "Recursive power-of-two block splitting, Merging adjacent buddy blocks upon deallocation"),
        ("064", 10, "2080 BS", "Inverted Page Table: Architecture, Hashing, and Address Resolution", "Inverted Page Table को संरचना र ठेगाना रूपान्तरण", "One entry per physical frame, Frame = Hash(PID, Page_Number), Linear search elimination"),
        ("065", 10, "2076 BS", "Belady's Anomaly: Theoretical Basis, FIFO Failure, and Stack Algorithms", "Belady's Anomaly को सैद्धान्तिक विश्लेषण र FIFO को कमजोरी", "Non-stack replacement algorithms, Increased page faults with increased physical frames proof"),
        ("066", 10, "2077 BS", "Page Buffering Algorithms: Maintaining Free Frame Pools in Virtual Memory", "Page Buffering अल्गोरिदम र Free Frame Pool व्यवस्थापन", "Modified page list, Write-back in background batches, Re-referencing clean pages without disk reads"),
        ("067", 10, "2078 BS", "Copy-On-Write (COW) Mechanism in Process Creation and Virtual Memory", "Process सिर्जनामा Copy-On-Write (COW) प्रविधिको भूमिका", "Shared read-only pages between parent and child, Page fault duplicate on write, Memory efficiency"),
        ("068", 10, "2079 BS", "Memory-Mapped Files: Concept, Shared Memory Applications, and mmap()", "Memory-Mapped Files (mmap) को अवधारणा र उपयोगिता", "Mapping file disk blocks to process virtual pages, Bypassing read/write system calls, High-speed IPC"),
        ("069", 10, "2080 BS", "Disk Sector Sparing and Bad Block Management in Operating Systems", "डिस्क ब्याड ब्लक व्यवस्थापन र सेक्टर स्पेरिङ (Sector Sparing)", "Manufacturing defect mapping, OS low-level formatting, Transparent sector remapping in modern drives"),
        ("070", 10, "2076 BS", "Operating System Device Drivers: Architecture, Character vs Block Devices", "डिभाइस ड्राइभरको संरचना: Character डिभाइस र Block डिभाइस बीच भिन्नता", "Raw byte streaming vs Fixed-block buffering, Standard POSIX open/read/write/ioctl interface"),
        ("071", 10, "2077 BS", "Spooling (Simultaneous Peripheral Operations On-Line) in Multi-user OS", "मल्टि-युजर अपरेटिङ सिस्टममा Spooling को अवधारणा र कार्यप्रणाली", "Buffer queue on disk, Overlapping slow peripheral operations with CPU processing, Print spoolers"),
        ("072", 10, "2078 BS", "Zero-Copy Data Transfer Architecture in High-Performance Servers", "उच्च गतिको सर्भरमा Zero-Copy डाटा ट्रान्सफर प्रविधि", "sendfile() system call, DMA direct from disk cache to NIC buffer, Bypassing user-space copies"),
        ("073", 10, "2079 BS", "Mandatory Access Control (MAC) vs Discretionary Access Control (DAC)", "Mandatory Access Control (MAC) र Discretionary Access Control (DAC) बीच तुलना", "Owner-controlled permissions in DAC vs Centrally enforced security labels in MAC (SELinux)"),
        ("074", 10, "2080 BS", "SELinux (Security-Enhanced Linux): Architecture, Policies, and Enforcement", "SELinux को आन्तरिक संरचना, पोलिसी र सुरक्षा इन्फोर्समेन्ट", "Type Enforcement, Roles, Domain transitions, Enforcing vs Permissive modes, Banking server hardening"),
        ("075", 10, "2076 BS", "AppArmor vs SELinux: Path-Based vs Inode-Based Security Modules", "AppArmor र SELinux बीच तुलना: Path-Based र Inode-Based सुरक्षा", "Configuration simplicity in AppArmor profiles vs Complex comprehensive security labels in SELinux"),
        ("076", 10, "2077 BS", "Buffer Overflow Vulnerability: Stack Smashing, Canaries, and ASLR", "बफर ओभरफ्लो जोखिम: Stack Smashing, Stack Canaries र ASLR प्रविधि", "Overwriting return address on stack, Address Space Layout Randomization (ASLR), Non-executable stack (NX)"),
        ("077", 10, "2078 BS", "Linux Cgroups (Control Groups) and Namespaces in Container Isolation", "लिनक्स Cgroups र Namespaces मार्फत कन्टेनर आइसोलेसन", "PID, Mount, Network namespaces, CPU/Memory quota throttling with cgroups, Container security"),
        ("078", 10, "2079 BS", "Operating System Crash Dumps and Kernel Panic Analysis", "अपरेटिङ सिस्टम क्र्यास डम्प र Kernel Panic विश्लेषण", "Core dump generation, kdump/kexec mechanism, Analyzing stack traces with GDB/crash utility"),
        ("079", 10, "2080 BS", "Watchdog Timers in Critical Banking Server Operating Systems", "क्रिटिकल बैंकिङ सर्भरमा Watchdog Timers को भूमिका", "Hardware countdown timer, OS heartbeat kicking, Automated reboot upon system freeze/hang"),
        ("080", 10, "2076 BS", "Page Coloring Technique to Maximize Cache Hit Efficiency", "क्यास दक्षता बढाउन Page Coloring प्रविधिको प्रयोग", "Aligning virtual page frame colors with hardware cache set indices, Eliminating cache conflict misses"),
        ("081", 10, "2077 BS", "Linux Virtual Memory: Swapping, OOM Killer (Out-of-Memory), and Swapiness", "लिनक्स भर्चुअल मेमोरी: स्व्यापिङ, OOM Killer र Swapiness प्यारामिटर", "vm.swappiness tuning, OOM score evaluation, Terminating memory hog processes to save the kernel"),
        ("082", 10, "2078 BS", "Process Accounting and Auditing in Enterprise Operating Systems (Auditd)", "इन्टरप्राइज अपरेटिङ सिस्टममा Auditd मार्फत प्रोसेस अडिटिङ", "Tracking file alterations, Monitoring sensitive execve() calls, Regulatory compliance audit logs"),
        ("083", 10, "2079 BS", "POSIX Standard (Portable Operating System Interface) Importance", "POSIX मानकको महत्त्व र अपरेटिङ सिस्टम पोर्टेबिलिटी", "Standardized system call API, Shell compatibility, Ensuring banking applications run across Linux/Unix"),
        ("084", 10, "2080 BS", "Inter-Process Communication: Sockets vs Named Pipes (FIFOs) vs Message Queues", "IPC संयन्त्र: Sockets, Named Pipes र Message Queues बीच तुलना", "Network-capable IPC via TCP/UDP sockets vs Local filesystem named pipes vs POSIX message queues"),
        ("085", 10, "2076 BS", "Operating System Microkernel IPC: Mach and L4 IPC Optimization", "Microkernel IPC: Mach र L4 मा सन्देश आदानप्रदानको अप्टिमाइजेसन", "Register-based IPC parameter passing, Direct virtual address space mapping, Minimal latency"),
        ("086", 10, "2077 BS", "Priority Inversion Problem and Priority Inheritance Protocol", "Priority Inversion समस्या र Priority Inheritance समाधान", "Mars Pathfinder incident, Low-priority thread blocking high-priority thread via shared mutex"),
        ("087", 10, "2078 BS", "Deadlock Detection Algorithm for Multiple Resource Instances", "Multiple Resource Instances का लागि डेडलोक पहिचान अल्गोरिदम", "Available vector, Allocation matrix, Request matrix, Graph reduction / marking algorithm"),
        ("088", 10, "2079 BS", "Two-Phase Locking (2PL) Protocol in Operating System Concurrency", "अपरेटिङ सिस्टम कन्करेन्सीमा Two-Phase Locking (2PL) प्रोटोकल", "Growing phase (acquiring locks) and Shrinking phase (releasing locks), Serializability guarantee"),
        ("089", 10, "2080 BS", "Memory Overcommit in Linux Operating System: Rationale and Risks", "लिनक्समा Memory Overcommit को अवधारणा, कारण र जोखिम", "vm.overcommit_memory modes (0, 1, 2), Optimistic virtual address allocation, OOM risk under heavy load"),
        ("090", 10, "2076 BS", "Page Replacement: Most Recently Used (MRU) vs Least Recently Used (LRU)", "MRU र LRU पेज रिप्लेसमेन्ट नीति बीच तुलनात्मक विश्लेषण", "Access patterns where MRU outperforms LRU (e.g., repeated large cyclic table scans in RDBMS)"),
        ("091", 10, "2077 BS", "Disk Arm Scheduling: Comparison between SCAN, C-SCAN, and F-SCAN", "डिस्क आर्म सिड्युलिङ: SCAN, C-SCAN र F-SCAN बीच तुलना", "Two sub-queues in F-SCAN preventing disk arm sticking under continuous dynamic read requests"),
        ("092", 10, "2078 BS", "File System Consistency Checking: fsck and chkdsk Operation", "फाइल सिस्टम शुद्धता परीक्षण: fsck र chkdsk को कार्यविधि", "Superblock validation, Inode free list reconstruction, Orphan directory link resolution"),
        ("093", 10, "2079 BS", "Operating System Kernel Synchronization: Read-Copy-Update (RCU)", "लिनक्स कर्नल सिङ्क्रोनाइजेसनमा Read-Copy-Update (RCU) प्रविधि", "Lock-free reader execution, Deferred reclaim of old data structures, Grace period quiescent states"),
        ("094", 10, "2080 BS", "Ephemeral Port Allocation and Socket Lifecycle in OS Network Stacks", "OS नेटवर्क स्ट्याकमा Ephemeral Port र Socket Lifecycle", "TIME_WAIT state management, SYN_SENT, ESTABLISHED, Socket file descriptors, Port exhaustion risk"),
        ("095", 10, "2076 BS", "Operating System High-Performance Event Polling: select(), poll(), and epoll()", "उच्च कार्यक्षमता इभेन्ट पोलिङ: select(), poll(), र epoll() बीच भिन्नता", "O(N) file descriptor iteration in select/poll vs O(1) event-driven readiness notification in epoll()"),
        ("096", 10, "2077 BS", "Memory Barrier and Compiler Reordering Instructions in OS Kernels", "OS कर्नलमा Memory Barrier र Compiler Reordering रोक्ने विधि", "Hardware memory fences, volatile keyword, preventing store/load instruction reordering in multicores"),
        ("097", 10, "2078 BS", "Rootkit Detection and Kernel Integrity Protection in Banking Servers", "बैंकिङ सर्भरमा Rootkit पहिचान र कर्नल सुरक्षा", "Loadable Kernel Module (LKM) rootkits, Direct Kernel Object Manipulation (DKOM), Secure Boot"),
        ("098", 10, "2079 BS", "Time Synchronization in Operating Systems: NTP vs PTP Protocols", "अपरेटिङ सिस्टममा समय प्रमाणीकरण: NTP र PTP प्रोटोकल बीच भिन्नता", "Sub-millisecond NTP synchronization vs Sub-microsecond IEEE 1588 PTP for financial trading ledgers"),
        ("099", 10, "2080 BS", "Real-Time Scheduling: Rate Monotonic Scheduling (RMS) vs Earliest Deadline First (EDF)", "Real-Time सिड्युलिङ: Rate Monotonic (RMS) र Earliest Deadline First (EDF)", "Static priority assignment based on task period vs Dynamic priority based on closest deadline"),
        ("100", 10, "2080 BS", "Operating System Hardening Checklist for Production Core Banking Servers", "कोर बैंकिङ सर्भरका लागि अपरेटिङ सिस्टम हार्डेनिङ चेकलिस्ट", "Disabling unused services and ports, SSH key-only access, Root login prohibition, Mandatory updates")
    ]
    
    for item in os_topics:
        q_id = f"sub_os_{item[0]}"
        marks = item[1]
        yr = item[2]
        title_en = item[3]
        title_np = item[4]
        subtopics = item[5]
        
        q_en = f"Discuss {title_en}. Explain its theoretical mechanism, system architecture, and practical implementation considerations in enterprise operating systems."
        q_np = f"{title_np} बारे सविस्तार व्याख्या गर्नुहोस्। यसको सैद्धान्तिक कार्यप्रणाली, प्रणालीगत संरचना र इन्टरप्राइज अपरेटिङ सिस्टममा यसको व्यावहारिक उपयोगिता प्रष्ट पार्नुहोस्।"
        
        intro_en = f"{title_en} represents a core operating system paradigm essential for managing hardware abstraction, system security, and deterministic concurrency in modern computer systems."
        intro_np = f"{title_np} आधुनिक अपरेटिङ सिस्टमको एक आधारभूत सिद्धान्त हो, जसले हार्डवेयर स्रोतहरूको प्रभावकारी परिचालन, प्रणालीगत सुरक्षा र प्रोसेसहरूको कुशल समन्वय सुनिश्चित गर्दछ।"
        
        core_en = (
            f"1. Core Mechanisms & Internal Architecture:\n"
            f"   - Foundations: Centered around {subtopics}.\n"
            f"   - Execution Flow: Managed via kernel-space routines, privileged CPU rings, and optimized system call interfaces.\n"
            f"   - Data Structures: Maintained through dedicated kernel tables, bitmasks, and hardware registers guaranteeing sub-millisecond dispatching.\n"
            f"2. Banking & Mission-Critical OS Integration:\n"
            f"   - Crucial for hosting Core Banking System (CBS) transaction engines (e.g., Finacle, T24) with zero race conditions.\n"
            f"   - Prevents memory corruption, unauthorized privilege escalation, and deadlocks in multi-threaded banking workloads."
        )
        core_np = (
            f"१. मुख्य प्राविधिक संरचना तथा कार्यविधि:\n"
            f"   - आधारभूत अवयवहरू: मुख्यतया {subtopics} मा आधारित रहेको छ।\n"
            f"   - कार्यप्रवाह: कर्नल स्पेस, विशेष प्रिभिलेज्ड लेयर र तीव्र गतिको सिस्टम कल इन्टरफेस मार्फत सञ्चालन।\n"
            f"   - डाटा संरचना: कर्नल तालिका, बिटम्याप र हार्डवेयर रजिष्टर मार्फत सुरक्षित व्यवस्थापन।\n"
            f"२. बैंकिङ तथा वित्तीय क्षेत्रमा उपयोगिता:\n"
            f"   - कोर बैंकिङ सफ्टवेयर (CBS) का वित्तीय कारोबारहरू बिना कुनै अवरोध र Race Condition २४/७ सञ्चालन गर्न अनिवार्य।\n"
            f"   - डाटाबेसमा डाटा बिग्रन नदिने, अनधिकृत पहुँच रोक्ने र डेडलोक हुन नदिने सुरक्षात्मक आधार।"
        )
        
        chal_en = (
            f"1. High context-switch and synchronization overheads during peak transaction spikes.\n"
            f"2. Complexity of debugging non-deterministic race conditions and thread deadlocks in production kernels.\n"
            f"3. Memory fragmentation and paging thrashing under sudden memory-intensive analytical queries."
        )
        chal_np = (
            f"१. कारोबारको अत्यधिक चाप हुँदा कन्टेक्स्ट स्विचिङ र प्रोसेस समन्वयमा लाग्ने समय (Overhead) बढ्ने जोखिम।\n"
            f"२. बहु-थ्रेडेड प्रणालीमा उत्पन्न हुने Race Condition र डेडलोक समाधान गर्न प्राविधिक जटिलता।\n"
            f"३. अत्यधिक डाटा प्रोसेसिङ गर्दा मेमोरी अभाव र Page Thrashing भई प्रणाली सुस्त हुने समस्या।"
        )
        
        concl_en = (
            f"In conclusion, deep competence in {title_en} enables banking IT officers to optimize kernel parameters, enforce least-privilege security, and ensure 99.999% uptime for core financial services."
        )
        concl_np = (
            f"निष्कर्षमा, {title_np} को पूर्ण प्राविधिक ज्ञानले बैंकका IT अधिकृतहरूलाई सर्भरको कर्नल अप्टिमाइज गर्न, कडा सुरक्षा लागु गर्न र बैंकिङ सेवाहरूलाई निर्बाध सञ्चालन गर्न सक्षम बनाउँछ।"
        )
        
        qs.append(create_subjective_q(
            q_id, "paper1", "sectionB", 2, "Unit 2: Operating System",
            marks, yr, q_en, q_np, intro_en, intro_np, core_en, core_np, chal_en, chal_np, concl_en, concl_np
        ))
        
    return qs

if __name__ == "__main__":
    batch = generate_batch2()
    save_batch_json(batch, "sub_batch_2_os.json")
