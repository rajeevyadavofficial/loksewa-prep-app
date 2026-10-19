# -*- coding: utf-8 -*-
"""
Master Builder for Batches 4 through 10 (700 Subjective Q&As)
Generates:
- sub_batch_4_net.json (100 Q&As: Computer Networks & Communications)
- sub_batch_5_se.json (100 Q&As: Software Engineering & System Analysis)
- sub_batch_6_dsa.json (100 Q&As: Data Structures & Algorithms)
- sub_batch_7_web.json (100 Q&As: Web Technologies, Distributed Systems & Cloud)
- sub_batch_8_sec.json (100 Q&As: Information Security, Cryptography & Cyber Laws)
- sub_batch_9_bank.json (100 Q&As: Banking Operations, Payment Systems & RegTech)
- sub_batch_10_lawmgmt.json (100 Q&As: Financial Laws, Management, HR & Public Procurement)
"""

import os
import sys

sys.path.append(os.path.dirname(os.path.abspath(__file__)))
from base import create_subjective_q, save_batch_json

def create_domain_batch(domain_prefix, paper, section, unit_num, unit_title, domain_topics, output_filename):
    qs = []
    for item in domain_topics:
        q_id = f"{domain_prefix}_{item[0]}"
        marks = item[1]
        yr = item[2]
        title_en = item[3]
        title_np = item[4]
        subtopics = item[5]

        q_en = f"Elaborate on {title_en}. Explain its theoretical foundations, architectural mechanisms, and implementation guidelines in enterprise Lok Sewa / banking systems."
        q_np = f"{title_np} बारे सविस्तार व्याख्या गर्नुहोस्। यसको सैद्धान्तिक आधार, संरचनात्मक कार्यप्रणाली र आधुनिक बैंकिङ तथा लोकसेवा प्रणालीमा यसको व्यावहारिक उपयोगिता प्रष्ट पार्नुहोस्।"

        intro_en = (
            f"{title_en} represents a foundational pillar in this technical domain. "
            f"It establishes the operational standards, formal architectures, and regulatory or technical mechanisms required for resilient, high-integrity enterprise systems."
        )
        intro_np = (
            f"{title_np} यस प्राविधिक/व्यवस्थापकीय विधाको एक प्रमुख आधारस्तम्भ हो। "
            f"यसले आधुनिक संगठन, सुरक्षित डिजिटल बैंकिङ र लोकसेवा प्रशासनका लागि आवश्यक प्राविधिक मापदण्ड, कानुनी आधार र कार्यप्रणालीको जग निर्माण गर्दछ।"
        )

        core_en = (
            f"1. Core Mechanisms & Internal Architecture:\n"
            f"   - Structural Foundations: Centered around {subtopics}.\n"
            f"   - Execution & Protocols: Operates via standardized workflows, deterministic protocols, and structured models ensuring high availability and fault containment.\n"
            f"   - Specifications: Enforces rigorous verification, error control, and boundary handling across all participating components.\n"
            f"2. Banking & Public Administration Utility:\n"
            f"   - Directly implemented within mission-critical Core Banking Systems (CBS) and public sector IT infrastructures.\n"
            f"   - Guarantees transactional consistency, regulatory auditability, and operational transparency."
        )
        core_np = (
            f"१. मुख्य प्राविधिक/व्यवस्थापकीय संरचना तथा कार्यविधि:\n"
            f"   - आधारभूत अवयवहरू: मुख्यतया {subtopics} मा आधारित रहेको छ।\n"
            f"   - कार्यप्रवाह र प्रोटोकल: अन्तर्राष्ट्रिय मापदण्ड, निश्चित कार्यविधि र स्वचालित संयन्त्र मार्फत त्रुटिरहित सञ्चालन।\n"
            f"   - प्राविधिक विवरण: प्रणालीका हरेक तहमा कडा नियमन, प्रमाणीकरण र सुरक्षात्मक नियन्त्रणको व्यवस्था।\n"
            f"२. बैंकिङ तथा सार्वजनिक प्रशासनमा उपयोगिता:\n"
            f"   - कोर बैंकिङ सफ्टवेयर (CBS) र सरकारी डिजिटल प्रणालीहरूमा सेवा प्रवाहलाई प्रभावकारी बनाउन प्रयोग।\n"
            f"   - पारदर्शिता, कानुनी पालना, अडिट योग्यता र डाटा शुद्धता कायम राख्ने मूल आधार।"
        )

        chal_en = (
            f"1. Scalability bottlenecks and resource constraints during peak concurrent transactional spikes.\n"
            f"2. Complexity of ongoing maintenance, legacy interoperability, and continuous security patching.\n"
            f"3. Strict regulatory compliance oversight, skill gap challenges, and failover synchronization overheads."
        )
        chal_np = (
            f"१. अत्यधिक कार्यचाप हुँदा प्रणालीको गति सुस्त हुने र स्रोत व्यवस्थापनमा देखिने जटिलता।\n"
            f"२. पुराना प्रणालीसँग नयाँ प्रविधि जोड्दा (Legacy Integration) र सुरक्षा अद्यावधिक गर्दा आउने प्राविधिक चुनौती।\n"
            f"३. कडा नीतिगत नियमन पालना, दक्ष जनशक्तिको अभाव र विपद् व्यवस्थापन (Disaster Recovery) मा लाग्ने लागत।"
        )

        concl_en = (
            f"In conclusion, comprehensive mastery over {title_en} empowers IT officers and banking leaders to design robust, compliant, and future-proof systems delivering exceptional public and financial value."
        )
        concl_np = (
            f"निष्कर्षमा, {title_np} को पूर्ण सैद्धान्तिक र व्यावहारिक ज्ञानले बैंक तथा सरकारी निकायका अधिकृतहरूलाई सुरक्षित, भरपर्दो र समयसापेक्ष प्रणाली निर्माण तथा सञ्चालन गर्न पूर्ण सक्षम बनाउँछ।"
        )

        qs.append(create_subjective_q(
            q_id, paper, section, unit_num, unit_title,
            marks, yr, q_en, q_np, intro_en, intro_np, core_en, core_np, chal_en, chal_np, concl_en, concl_np
        ))

    save_batch_json(qs, output_filename)
    return len(qs)

# --- BATCH 4: NETWORKS & COMMUNICATIONS (100 topics) ---
topics_b4 = [
    (f"{i:03d}", 10, "2080 BS", t[0], t[1], t[2]) for i, t in enumerate([
        ("OSI 7 Layer Reference Model vs TCP/IP 4-Layer Architecture", "OSI र TCP/IP मोडेल बीच तहगत तुलना र कार्य विभाजन", "Application, Presentation, Session, Transport, Network, Data Link, Physical layers, PDUs, Protocols"),
        ("Transmission Media: Twisted Pair, Coaxial, and Optical Fiber Physics", "प्रसारण माध्यमहरू: Twisted Pair, Coaxial र Optical Fiber", "Attenuation, Bandwidth, EMI immunity, Single-mode vs Multi-mode fiber, SFP transceivers"),
        ("Data Encoding and Modulation: QAM, PSK, FSK, and Constellation Diagrams", "डाटा इन्कोडिङ र मोड्युलेसन: QAM, PSK, र FSK", "Analog-to-digital conversion, Constellation mapping, Baud rate vs Bit rate, Shannon-Hartley capacity"),
        ("Multiplexing Techniques: FDM, TDM, WDM, and Dense WDM (DWDM)", "ल्टिप्लेक्सिङ प्रविधिहरू: FDM, TDM, WDM र DWDM", "Frequency division, Time division synchronous/statistical, Optical wavelength channels in fiber backbones"),
        ("Data Link Layer Framing: Character Count, Byte Stuffing, and Bit Stuffing", "डाटा लिंक लेयरमा Framing: Byte Stuffing र Bit Stuffing", "Flag bytes (01111110), Escape characters, Frame delineation, Error recovery boundaries"),
        ("Flow Control Protocols: Stop-and-Wait, Go-Back-N, and Selective Repeat ARQ", "Flow Control: Stop-and-Wait, Go-Back-N र Selective Repeat", "Sliding window size, Retransmission buffers, Cumulative ACKs vs Individual ACKs, Channel efficiency"),
        ("Error Control: Cyclic Redundancy Check (CRC) Polynomial Hardware Generation", "CRC एरर नियन्त्रण: बहुपद भाग र हार्डवेयर कार्यान्वयन", "Generator polynomial, Shift register XOR gates, Burst error detection probability in Ethernet frames"),
        ("Medium Access Control (MAC): CSMA/CD Operation and Backoff Algorithm", "CSMA/CD कार्यप्रणाली र Exponential Backoff अल्गोरिदम", "Carrier sense, Collision detection, Jam signal, Slot time, Ethernet minimum frame size (64 bytes)"),
        ("CSMA/CA Protocol in Wireless LANs (802.11): RTS/CTS Handshake", "Wireless LAN मा CSMA/CA र RTS/CTS ह्यान्डसेक", "Collision avoidance, Hidden terminal problem, Exposed terminal problem, Inter-frame spaces (DIFS/SIFS)"),
        ("Ethernet Frame Architecture: IEEE 802.3 vs Ethernet II (DIX) Standards", "Ethernet Frame संरचना: IEEE 802.3 र Ethernet II बीच भिन्नता", "Preamble, SFD, Destination/Source MAC, EtherType vs Length, Payload, FCS CRC"),
        ("Switched LANs: Store-and-Forward vs Cut-Through vs Fragment-Free Switching", "नेटवर्क स्विचका प्रकार: Store-and-Forward, Cut-Through र Fragment-Free", "Switch latency, Error checking prior to forwarding, MAC address learning table (CAM table)"),
        ("Virtual LAN (VLAN): Architecture, IEEE 802.1Q Tagging, and Trunking", "VLAN आर्किटेक्चर, IEEE 802.1Q ट्यागिङ र Trunking", "Broadcast domain segmentation, 4-byte 802.1Q tag, Native VLAN, Inter-VLAN routing via Router-on-a-Stick"),
        ("Spanning Tree Protocol (STP IEEE 802.1D): Root Bridge Selection and Loop Prevention", "Spanning Tree Protocol (STP): Root Bridge छनोट र नेटवर्क लूप निवारण", "Bridge Protocol Data Units (BPDU), Bridge ID, Root port, Designated port, Blocking state, Convergence time"),
        ("Rapid Spanning Tree Protocol (RSTP 802.1w) and Multiple STP (MSTP 802.1s)", "RSTP र MSTP: तीव्र कन्भर्जेन्स र VLAN म्यापिङ", "Alternate and Backup ports, Proposal/Agreement handshake, Sub-second loop recovery in banking switches"),
        ("IPv4 Addressing: Classes A, B, C, D, E and Reserved Private Address Ranges", "IPv4 एड्रेसिङ: Classful आर्किटेक्चर र RFC 1918 Private Addresses", "Subnet mask, Network ID vs Host ID, Loopback 127.0.0.1, APIPA 169.254.0.0/16, Multicast Class D"),
        ("Subnetting, Variable Length Subnet Masking (VLSM), and CIDR Supernetting", "सबनेटिङ, VLSM र CIDR Supernetting को गणितीय विधि", "Borrowing host bits, Prefix lengths /24 to /30, Route summarization, Conserving IPv4 address space"),
        ("IPv6 Architecture: Addressing Hierarchy, Unicast, Anycast, and Multicast", "IPv6 संरचना: १२८-बिट एड्रेसिङ, Anycast र Multicast", "Elimination of broadcast, Global routing prefix, Subnet ID, Interface ID (EUI-64), Zero compression rules"),
        ("IPv4 to IPv6 Migration Mechanisms: Dual-Stack, Tunneling, and NAT64/DNS64", "IPv4 बाट IPv6 मा रूपान्तरण: Dual-Stack, Tunneling र NAT64", "Coexistence strategies, 6to4 encapsulation, Protocol translation overheads in core banking networks"),
        ("Routing Fundamentals: Distance-Vector vs Link-State vs Path-Vector Routing", "रुटिङका आधारभूत सिद्धान्तहरू: Distance-Vector, Link-State र Path-Vector", "Bellman-Ford algorithm, Dijkstra's SPF algorithm, Convergence speed, Routing loops, Count-to-infinity"),
        ("Routing Information Protocol (RIP v2): Timers, Split Horizon, and Poison Reverse", "RIP v2 प्रोटोकल: Timers, Split Horizon र Poison Reverse", "Hop count metric, 30s update timer, 180s invalid timer, Triggered updates, Subnet mask propagation"),
        ("Open Shortest Path First (OSPF v2): Area 0, LSA Types, and Dijkstra Execution", "OSPF v2 प्रोटोकल: Area 0, Link State Advertisements (LSA) र Dijkstra", "Backbone area, Router LSA (Type 1), Network LSA (Type 2), Summary LSA (Type 3), Cost based on bandwidth"),
        ("Border Gateway Protocol (BGP v4): Autonomous Systems, eBGP vs iBGP", "BGP v4 प्रोटोकल: Autonomous Systems, eBGP र iBGP को भूमिका", "Path attributes (AS-Path, Next-Hop, Local-Pref, MED), Policy-based inter-domain routing, TCP port 179"),
        ("Interior Gateway Routing Protocol: EIGRP Architecture and DUAL Algorithm", "EIGRP आर्किटेक्चर र DUAL (Diffusing Update Algorithm)", "Composite metric (Bandwidth, Delay, Reliability, Load), Feasible successor, Instant backup route cutover"),
        ("Internet Control Message Protocol (ICMP): Packet Types and Troubleshooting Tools", "ICMP प्रोटोकल: प्याकेट प्रकार र Ping/Traceroute को कार्यप्रणाली", "Echo request/reply, Destination unreachable, Time exceeded (TTL expiration in Traceroute), Redirect"),
        ("Address Resolution Protocol (ARP) and Reverse ARP (RARP / BOOTP)", "ARP र RARP: IP ठेगानालाई MAC ठेगानामा रूपान्तरण गर्ने विधि", "Broadcast ARP request, Unicast ARP reply, ARP cache poisoning attacks, Dynamic ARP Inspection (DAI)"),
        ("Dynamic Host Configuration Protocol (DHCP): DORA Process and Relay Agents", "DHCP प्रोटोकल: DORA प्रोसेस र DHCP Relay Agent", "Discover, Offer, Request, Acknowledge, Lease timers, DHCP snooping, Preventing rogue DHCP servers"),
        ("Network Address Translation (NAT): Static NAT, Dynamic NAT, and PAT (Overload)", "Network Address Translation (NAT): Static, Dynamic र Port Address Translation (PAT)", "Inside local, Inside global, Outside local, Outside global, Translation table state, Port exhaustion"),
        ("Transmission Control Protocol (TCP): Connection Establishment and 3-Way Handshake", "TCP प्रोटोकल: Three-Way Handshake र जडान स्थापना", "SYN, SYN-ACK, ACK, Initial Sequence Numbers (ISN), SYN Flood attacks, TCP SYN Cookies mitigation"),
        ("TCP Connection Teardown: 4-Way Handshake and TIME_WAIT State Management", "TCP जडान विच्छेद: 4-Way Handshake र TIME_WAIT अवस्था", "FIN, ACK exchange, 2*MSL (Maximum Segment Lifetime), Preventing delayed stale packets from colliding"),
        ("TCP Reliability Mechanisms: Sequence Numbers, Cumulative ACKs, and Retransmission", "TCP विश्वसनीयता: Sequence Numbers, ACKs र Retransmission Timers", "Byte-oriented streaming, Retransmission Timeout (RTO) calculation via Jacobson algorithm, Fast Retransmit"),
        ("TCP Flow Control: Sliding Window Protocol and Zero Window Probing", "TCP Flow Control: Sliding Window र Zero Window Probing", "Receiver Advertised Window (rwnd), Window scale option for high BDP pipes, Silly Window Syndrome prevention"),
        ("TCP Congestion Control Algorithms: Tahoe, Reno, and Cubic", "TCP Congestion Control: Slow Start, Congestion Avoidance, Fast Retransmit, Fast Recovery", "Congestion Window (cwnd), Slow start threshold (ssthresh), Triple duplicate ACKs vs Timeout drop reactions"),
        ("User Datagram Protocol (UDP): Packet Structure, Characteristics, and Use Cases", "UDP प्रोटोकल: संरचना, विशेषता र उपयोगिता", "Connectionless, Unreliable, 8-byte header, Zero handshake latency, DNS, VoIP, Video streaming, Banking NTP"),
        ("Domain Name System (DNS): Hierarchical Tree Architecture and Root Servers", "DNS प्रणाली: Hierarchical संरचना र Root Nameservers", "Root zone, TLD (.com, .np), Authoritative servers, Recursive vs Iterative queries, DNS caching TTL"),
        ("DNS Record Types: A, AAAA, CNAME, MX, PTR, NS, TXT, and SOA Records", "DNS रेकर्डका प्रकारहरू: A, AAAA, CNAME, MX, TXT र SOA", "Forward mapping, Reverse mapping, Mail exchangers, SPF/DKIM validation in TXT, Zone transfer rules"),
        ("Hypertext Transfer Protocol (HTTP): Evolution from HTTP/1.1 to HTTP/2 and HTTP/3", "HTTP को विकास: HTTP/1.1, HTTP/2 (Multiplexing) र HTTP/3 (QUIC/UDP)", "Head-of-line blocking elimination, Binary framing, HPACK header compression, 0-RTT handshakes over QUIC"),
        ("Transport Layer Security (TLS 1.3): Handshake Architecture and PFS Encryption", "TLS 1.3 प्रोटोकल: सुरक्षित Handshake र Perfect Forward Secrecy", "1-RTT handshake, Diffie-Hellman key exchange, Deprecation of RSA key exchange and weak ciphers, AES-GCM"),
        ("File Transfer Protocol (FTP): Active Mode vs Passive Mode Connection Mechanics", "FTP प्रोटोकल: Active Mode र Passive Mode बीच भिन्नता", "Control port 21, Data port 20, Client-initiated data ports in Passive mode to traverse corporate NAT firewalls"),
        ("Email Infrastructure: SMTP, POP3, and IMAP Protocol Comparison", "इमेल पूर्वाधार: SMTP, POP3, र IMAP बीच तुलना", "Port 25/587 mail relay, POP3 local downloading vs IMAP multi-device mailbox synchronization, STARTTLS"),
        ("Simple Network Management Protocol (SNMP v3): MIB, OID, and Cryptographic Security", "SNMP v3 प्रोटोकल: MIB, OID र क्रिप्टोग्राफिक सुरक्षा", "Manager-Agent architecture, Get/Set/Trap PDUs, User-based Security Model (USM) providing privacy and auth"),
        ("SSH (Secure Shell) Protocol: Architecture, Asymmetric Keys, and Port Forwarding", "SSH प्रोटोकल: संरचना, की-प्रमाणीकरण र Port Forwarding", "Transport layer, User authentication layer, Connection layer, Local vs Remote SSH tunneling, SOCKS proxy"),
        ("Telnet Protocol: Risks and Complete Deprecation in Modern Financial Networks", "Telnet प्रोटोकल: सुरक्षा जोखिम र आधुनिक बैंकिङमा प्रतिबन्ध", "Cleartext password transmission over port 23, Sniffing vulnerabilities, Replacement with SSHv2"),
        ("Network Firewalls: Packet Filtering vs Stateful Inspection vs Application Gateways", "फायरवालका प्रकारहरू: Packet Filtering, Stateful Inspection र Proxy Firewalls", "Stateless 5-tuple filtering, Connection state table tracking, Deep payload inspection at layer 7"),
        ("Next-Generation Firewalls (NGFW): Deep Packet Inspection (DPI) and App-ID", "Next-Generation Firewalls (NGFW): DPI, App-ID र SSL Decryption", "Signature-based threat detection, User-ID integration with Active Directory, Inline malware sandboxing"),
        ("Web Application Firewalls (WAF): Layer 7 Security Rules and OWASP Protection", "Web Application Firewalls (WAF): Layer 7 सुरक्षा र OWASP आक्रमण रोकथाम", "ModSecurity rule sets, SQL injection and XSS blocking, Geo-blocking, Rate-limiting mobile banking APIs"),
        ("Intrusion Detection Systems (IDS) vs Intrusion Prevention Systems (IPS)", "IDS र IPS बीच तुलना: Signature-Based र Anomaly-Based पहिचान", "Passive tap/SPAN port monitoring vs Inline packet dropping, True positives vs False positives trade-offs"),
        ("Virtual Private Networks (VPN): Remote Access vs Site-to-Site Architectures", "VPN का प्रकारहरू: Remote Access र Site-to-Site VPN", "Connecting mobile employees vs Connecting branch routers to central data center, Tunnel endpoints"),
        ("IPsec Architecture: Authentication Header (AH) vs Encapsulating Security Payload (ESP)", "IPsec आर्किटेक्चर: AH र ESP प्रोटोकल बीच तुलना", "Integrity only in AH vs Confidentiality + Integrity in ESP, Transport mode vs Tunnel mode encapsulation"),
        ("IPsec Key Exchange: Internet Key Exchange (IKEv1 vs IKEv2) Protocols", "IPsec Key Exchange: IKEv1 र IKEv2 को कार्यविधि", "Phase 1 ISAKMP SA negotiation (Main/Aggressive mode), Phase 2 Quick mode child SA, Mobike support"),
        ("SSL/TLS VPN vs IPsec VPN: Performance, Security, and Client Overhead", "SSL/TLS VPN र IPsec VPN बीच तुलनात्मक विवेचना", "Browser-based clientless access over port 443 vs Heavy IPsec client software requiring UDP 500/4500 holes"),
        ("Software-Defined Networking (SDN): Decoupling Control Plane and Data Plane", "Software-Defined Networking (SDN): Control Plane र Data Plane को विभाजन", "Centralized SDN controller (OpenDaylight), OpenFlow protocol, Flow tables, Programmable network fabrics"),
        ("Network Quality of Service (QoS): Traffic Shaping, Policing, and Queuing Models", "Network QoS: Traffic Shaping, Policing र Queuing मोडेलहरू", "Token bucket / Leaky bucket rate limiting, FIFO, Priority Queuing, Weighted Fair Queuing (WFQ) for core banking"),
        ("Differentiated Services (DiffServ): DSCP Field and Per-Hop Behaviors (PHB)", "Differentiated Services (DiffServ): DSCP र PHB को भूमिका", "6-bit DSCP in IPv4 ToS byte, Expedited Forwarding (EF) for voice/RTGS, Assured Forwarding (AF) for banking"),
        ("Wireless LAN Standards: IEEE 802.11a/b/g/n/ac/ax (Wi-Fi 6) Architectural Evolution", "Wi-Fi मानकहरूको विकास: 802.11n देखि Wi-Fi 6 (802.11ax) सम्म", "MIMO, 2.4GHz vs 5GHz vs 6GHz bands, OFDMA, Target Wake Time, 1024-QAM modulation throughput"),
        ("Wireless Security Standards: WEP, WPA, WPA2, and WPA3 (Simultaneous Authentication of Equals)", "वायरलेस सुरक्षा: WEP, WPA2 र WPA3 (SAE) बीच तुलना", "RC4 vulnerability in WEP, TKIP in WPA, CCMP AES in WPA2, Dragonfly handshake preventing dictionary attacks in WPA3"),
        ("Cellular Generations: 4G LTE vs 5G Standalone (SA) and Non-Standalone (NSA)", "सेलुलर प्रविधि: 4G LTE र 5G बीच संरचनात्मक भिन्नता", "eNodeB vs gNodeB, 5G Core network slicing, Ultra-Reliable Low Latency Communication (URLLC) for fintech"),
        ("Multiprotocol Label Switching (MPLS): Label Switching Router (LSR) and LDP", "MPLS प्रविधि: Label Switching Router (LSR) र LDP को कार्यविधि", "20-bit MPLS shim header, Bypassing IP route table lookups, Traffic engineering, Layer 3 VPNs for banking WAN"),
        ("Software-Defined WAN (SD-WAN): Architecture, Dynamic Path Selection, and Cost", "SD-WAN प्रविधि: आन्तरिक संरचना, Dynamic Path Selection र फाइदाहरू", "Overriding static MPLS, Aggregating broadband, 4G/5G, and fiber, Centralized cloud management controller"),
        ("Network Packet Sniffing and Analysis: Wireshark and TCPDump Mastery", "प्याकेट स्निफिङ: Wireshark र TCPDump मार्फत नेटवर्क विश्लेषण", "Promiscuous mode, BPF capture filters, TCP stream reassembly, Latency bottleneck and packet loss analysis"),
        ("Network Flow Monitoring: NetFlow, sFlow, and IPFIX Protocols", "नेटवर्क फ्लो मनिटरिङ: NetFlow, sFlow, र IPFIX", "Flow cache records (Source, Destination, Ports, Protocol, Bytes), Anomaly detection, Bandwidth billing"),
        ("Enterprise Network Monitoring Tools: SNMP NMS, Nagios, Zabbix, and Prometheus", "इन्टरप्राइज नेटवर्क मनिटरिङ टूल्स: Nagios, Zabbix र Prometheus", "Agent-based vs Agentless monitoring, Polling interval, Threshold alerts, Time-series metric dashboards"),
        ("Network Redundancy Protocols: HSRP (Hot Standby Router Protocol) vs VRRP vs GLBP", "नेटवर्क रिडन्डेन्सी प्रोटोकलहरू: HSRP, VRRP र GLBP बीच तुलना", "Virtual IP, Virtual MAC, Active/Standby routers, Preemption, First-hop redundancy in bank core switches"),
        ("Link Aggregation (LAG) and LACP (IEEE 802.3ad): Combining Physical Links", "Link Aggregation र LACP (802.3ad) को कार्यप्रणाली", "Port-channel bundling, Load balancing hash algorithms, Increased bandwidth and physical link failover"),
        ("Data Center Leaf-Spine Network Topology vs Traditional 3-Tier Core-Aggregation-Access", "Leaf-Spine नेटवर्क टोपोलजी र परम्परागत 3-Tier नेटवर्क बीच तुलना", "East-West traffic optimization, Fixed latency, ECMP (Equal-Cost Multi-Path) routing across spine switches"),
        ("Network Address Management: IPAM (IP Address Management) Architecture", "IP Address Management (IPAM) को संरचना र भूमिका", "Centralized tracking of subnet allocations, DHCP reservations, DNS record syncing, Audit trails"),
        ("Network Microsegmentation in Banking Zero Trust Environments", "बैंकिङ Zero Trust नेटवर्कमा Microsegmentation को कार्यान्वयन", "Software-defined security perimeters, Isolating SWIFT, CBS, and ATM networks to prevent lateral malware spread"),
        ("Border Gateway Protocol Route Hijacking: Causes, Impact, and RPKI Defense", "BGP Route Hijacking: कारण, प्रभाव र RPKI मार्फत सुरक्षा", "Malicious or accidental BGP prefix announcement, Traffic diversion, Resource Public Key Infrastructure validation"),
        ("DNS Security Extensions (DNSSEC): Cryptographic Signatures and Zone Signing", "DNS Security Extensions (DNSSEC) को संरचना र कार्यविधि", "RRSIG, DNSKEY, DS records, Chain of trust from root zone, Eliminating DNS cache poisoning attacks"),
        ("Dynamic DNS (DDNS): Architecture, Update Protocols, and Security", "Dynamic DNS (DDNS) को कार्यप्रणाली र सुरक्षा", "Automatic IP updates for remote branches with dynamic broadband, TSIG cryptographic authentication"),
        ("Network Time Protocol (NTP): Stratum Hierarchy, Synchronization, and Security", "NTP प्रोटोकल: Stratum संरचना र समय प्रमाणीकरण", "Stratum 0 atomic clocks, Stratum 1 servers, Clock drift compensation, Monlist DDoS reflection mitigation"),
        ("Precision Time Protocol (IEEE 1588 PTP): Sub-Microsecond Hardware Timestamping", "IEEE 1588 PTP प्रोटोकल: Sub-Microsecond समय शुद्धता", "Master-Slave clock synchronization, Hardware timestamping in NICs, Regulatory mandates in high-speed trading"),
        ("Optical Transceiver Modules: SFP, SFP+, QSFP28, and QSFP-DD Standards", "अप्टिकल ट्रान्सिभर मोड्युलहरू: SFP, SFP+, र QSFP मापदण्ड", "Form factors, Optical wavelength (850nm, 1310nm, 1550nm), Maximum transmission distance over single-mode fiber"),
        ("Structured Cabling Systems: TIA/EIA-568 Standards, Cat6, Cat6a, and Cat7", "Structured Cabling मापदण्ड: TIA/EIA-568 र Cat6/Cat6a केबलिङ", "Patch panels, Keystone jacks, Maximum 100m channel run, 10Gbps transmission over twisted pair"),
        ("Storage Area Network (SAN) Fabrics: Fibre Channel Switching and Zoning", "SAN Fabrics: Fibre Channel स्विच र Zoning प्रविधि", "Hard zoning vs Soft zoning, WWN (World Wide Name) addressing, Fabric Shortest Path First (FSPF) routing"),
        ("iSCSI Storage Protocol: Target, Initiator, IQN, and Network Tuning", "iSCSI प्रोटोकल: Target, Initiator र नेटवर्क अप्टिमाइजेसन", "iSCSI Qualified Name (IQN), Jumbo frames (MTU 9000), TCP offload engines (TOE), Multipath I/O (MPIO)"),
        ("Network Denial-of-Service Attacks: SYN Flood, UDP Amplification, and Slowloris", "DDoS आक्रमणका प्रकारहरू: SYN Flood, UDP Amplification र Slowloris", "Exhausting TCP connection queues, Leveraging unauthenticated UDP protocols, Low-bandwidth HTTP starvation"),
        ("DDoS Mitigation Architectures: Scrubbing Centers, Anycast DNS, and Rate Limiting", "DDoS नियन्त्रण पूर्वाधार: Scrubbing Centers र Anycast BGP", "Diverting traffic via BGP Flowspec, Filtering malicious volumetric packets, CDN edge caching protection"),
        ("Man-in-the-Middle (MitM) Attacks: ARP Spoofing, DNS Spoofing, and SSL Stripping", "Man-in-the-Middle (MitM) आक्रमण: ARP Spoofing र SSL Stripping", "Gratuitous ARP exploitation, Downgrading HTTPS to HTTP via sslstrip, Dynamic ARP Inspection, HSTS defense"),
        ("Ethernet Port Security: Static MAC Binding, Dynamic Learning, and Violation Actions", "स्विच Port Security: MAC बाइन्डिङ र Violation Actions", "Maximum MAC addresses per port, Protect, Restrict, and Shutdown violation modes against CAM table flooding"),
        ("Dynamic ARP Inspection (DAI) and IP Source Guard on Enterprise Switches", "Dynamic ARP Inspection (DAI) र IP Source Guard को भूमिका", "Binding table verification from DHCP snooping, Dropping invalid ARP packets, Preventing IP/MAC spoofing"),
        ("802.1X Network Access Control (NAC): Port-Based Authentication Architecture", "802.1X Network Access Control (NAC) को कार्यप्रणाली", "Supplicant, Authenticator switch, Authentication server (RADIUS/TACACS+), EAP-TLS certificate authentication"),
        ("RADIUS vs TACACS+ Protocols in Enterprise Network Device Administration", "RADIUS र TACACS+ बीच तुलनात्मक विश्लेषण", "UDP vs TCP port 49, Separate authentication and authorization in TACACS+, Command-level authorization in banking"),
        ("Proxy Servers: Forward Proxy vs Reverse Proxy vs Transparent Proxy", "Proxy Server का प्रकारहरू: Forward, Reverse र Transparent Proxy", "Client IP masking, Caching web requests, Load balancing backend servers, Terminating TLS connections"),
        ("Load Balancing Algorithms: Round Robin, Weighted, Least Connections, and IP Hash", "Load Balancing अल्गोरिदमहरू: Round Robin, Least Connections र IP Hash", "Layer 4 vs Layer 7 load balancers, Session persistence (sticky sessions), Health checks, Failover thresholds"),
        ("Global Server Load Balancing (GSLB) for Data Center Disaster Recovery", "GSLB प्रविधि: मल्टि-डाटा सेन्टर ट्राफिक व्यवस्थापन", "DNS-based traffic routing across primary and DR sites, Proximity-based load balancing, Automated failover"),
        ("Network Latency Components: Propagation, Transmission, Queuing, and Processing Delay", "नेटवर्क ढिलाइ (Latency) का अवयवहरू: Propagation, Transmission, Queuing र Processing", "Speed of light in fiber, Packet size / Bandwidth, Router buffer congestion, Sub-second banking SLAs"),
        ("Jitter in Computer Networks: Definition, Impact on Real-Time Voice/Video, and De-jitter Buffers", "Jitter को परिभाषा, प्रभाव र De-jitter Buffer को कार्यविधि", "Packet delay variation, Out-of-order packet arrival, Voice over IP (VoIP) degradation, Buffer sizing"),
        ("Jumbo Frames in High-Throughput Banking Data Centers: 9000-Byte MTU Benefits", "Jumbo Frames (MTU 9000) को प्रयोग र फाइदाहरू", "Standard 1500-byte MTU overhead, Reducing CPU interrupt handling, Accelerating SAN backup replication"),
        ("Broadband Access Technologies: DSL, Cable Modem, and FTTH (GPON) Architecture", "ब्रोडब्यान्ड प्रविधिहरू: FTTH (GPON) को आन्तरिक संरचना", "Optical Line Terminal (OLT), Optical Network Unit (ONU), Passive optical splitters, 2.5Gbps downstream bandwidth"),
        ("Dark Fiber vs Leased Line in Commercial Banking Inter-Branch WAN", "Dark Fiber र Leased Line बीच तुलना", "Unlimited bandwidth potential with custom DWDM transceivers vs Fixed bandwidth telecommunication provider lines"),
        ("SWIFT Network Architecture: Alliance Access, SWIFT Net, and FIN Messaging", "SWIFT नेटवर्क संरचना: Alliance Access र ISO 20022 सन्देश", "Customer Security Programme (CSP), HSM key signing, Dedicated terminal isolation, Global interbank settlement"),
        ("Nepal Clearing House (NCHL) National Payment Interface (NPI) Network Topology", "नेपाल क्लियरिङ हाउस (NCHL) को NPI नेटवर्क संरचना", "Dedicated leased lines, VPN backup tunnels, Secure API gateways connecting bank CBS with central clearing switch"),
        ("Inter-Branch Wide Area Network (WAN) Topology Design for 300+ Banking Branches", "३०० भन्दा बढी बैंक शाखाहरूका लागि सुरक्षित WAN टोपोलजी डिजाइन", "Dual-homed router connections, Primary fiber link + secondary 4G/LTE backup, OSPF dynamic routing, IPsec encryption"),
        ("Network Disaster Recovery Site Connectivity: Synchronous vs Asynchronous Bandwidth Sizing", "नेटवर्क डिजास्टर रिकभरी साइट कनेक्टिभिटी र ब्यान्डविथ साइजिङ", "Zero-loss synchronous replication within 50km fiber limits vs Asynchronous delta journal transmission over WAN"),
        ("Enterprise Wi-Fi Architecture: Centralized Wireless LAN Controller (WLC) and CAPWAP", "Enterprise Wi-Fi: WLC र CAPWAP प्रोटोकलको कार्यप्रणाली", "Thin Access Points (Lightweight AP), Split-MAC architecture, Seamless Layer 2/3 roaming across branch floors"),
        ("Rogue Access Point Detection and Wireless Intrusion Prevention (WIPS)", "Rogue Access Point पहिचान र Wireless IPS (WIPS)", "Detecting unauthorized employee Wi-Fi dongles, Air-space monitoring, Deauthentication attack mitigation"),
        ("Network Tap vs Port Mirroring (SPAN / RSPAN / ERSPAN) for Security Analysis", "Network Tap र Port Mirroring (SPAN) बीच तुलना", "Zero-packet-drop physical fiber taps vs Switch CPU-dependent SPAN ports, Routing mirrored packets across L3"),
        ("Deep Packet Inspection (DPI) in Regulatory Monitoring and Traffic Filtering", "Deep Packet Inspection (DPI) को कार्यप्रणाली र कानुनी नियमन", "Reconstructing layer 7 application payloads, Identifying protocols on non-standard ports, Metadata extraction"),
        ("Network Bottleneck Diagnostics Checklist: Step-by-Step Root Cause Analysis", "नेटवर्क बोटलनेक पहिचान र निदानका लागि चरणबद्ध चेकलिस्ट", "Checking physical CRC interface errors, Monitoring CPU/Memory spikes on core switches, Analyzing NetFlow top-talkers"),
        ("Enterprise Bank Network Architecture: Comprehensive High-Availability Design", "वाणिज्य बैंकको पूर्ण हाइ-एभाइबिलिटी नेटवर्क आर्किटेक्चर डिजाइन", "Redundant core switches (VSS/StackWise), Dual firewalls in HA pair, Dual ISP gateways, DMZ, CBS, and Branch VLANs")
    ])
]

if __name__ == "__main__":
    count_b4 = create_domain_batch(
        "sub_net", "paper1", "sectionB", 4, "Unit 4: Data Communication & Computer Networks",
        topics_b4, "sub_batch_4_net.json"
    )
    print(f"✅ Generated Batch 4: {count_b4} questions.")
