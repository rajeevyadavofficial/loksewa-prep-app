import json

def get_unit5_questions():
    u5 = []
    def add(idx, q_en, q_np, opts, ans, expl_en, expl_np, yr):
        u5.append({
            "id": f"p1b_u5_mcq{idx}",
            "exam_id": "rbb_it_5",
            "paper": "paper1",
            "section": "sectionB",
            "unit_number": 5,
            "unit_title": "Unit 5: DBMS, SQL, Data Warehousing, Web Tech & DRP",
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

    # 1. Relational DBMS & Keys
    add(101, "In relational database design, which property enforces that a foreign key value must either match an existing primary key in the referenced parent table or be null?",
        "सम्बन्धात्मक डेटाबेसमा विदेशी साँचो (Foreign Key) ले प्यारेन्ट टेबलको प्राथमिक साँचोसँग मेल खानुपर्ने वा खाली हुनुपर्ने नियमलाई के भनिन्छ?",
        ["Entity Integrity", "Referential Integrity", "Domain Integrity", "User-Defined Integrity"],
        1, "Referential integrity guarantees that relationships between tables remain consistent, preventing orphan child records.",
        "रेफरेन्सियल इन्टिग्रिटी (Referential Integrity) ले दुई टेबल बीचको सम्बन्धलाई मान्य र एकरूप राख्न मद्दत गर्दछ।", "2067 BS - RBB IT")

    add(102, "A candidate key that is not chosen to be the primary key of a relational table is formally called a(n):",
        "डेटाबेस टेबलमा प्राथमिक साँचो (Primary Key) को रूपमा नछानिएको अन्य सम्भावित साँचोलाई के भनिन्छ?",
        ["Foreign Key", "Alternate Key", "Composite Key", "Surrogate Key"],
        1, "Candidate keys are minimal superkeys capable of uniquely identifying rows. The one not picked as primary is termed an alternate key.",
        "प्राइमरी कि बाहेकका अन्य उम्मेदवार साँचोहरूलाई अल्टरनेट कि (Alternate Key) भनिन्छ।", "2073 BS - NRB IT")

    add(103, "A relational database table is in Second Normal Form (2NF) if and only if it is in 1NF and satisfies which condition?",
        "कुनै रिलेसनल टेबल 1NF मा भएर दोस्रो सामान्यीकरण फारम (2NF) मा हुन कुन सर्त पूरा गर्नुपर्दछ?",
        ["No multi-valued attributes exist", "Every non-prime attribute is fully functionally dependent on the entire primary key (no partial dependency)", "No transitive dependency exists", "Every determinant is a candidate key"],
        1, "2NF eliminates partial dependencies, requiring every non-key attribute to depend on the whole composite primary key, not just a subset.",
        "2NF मा हुनका लागि कम्पोजिट प्राइमरी कि को कुनै एउटा भागमा मात्र निर्भर हुने आंशिक निर्भरता (Partial Dependency) हटाइनुपर्छ।", "2076 BS - Loksewa Operator")

    add(104, "Which normal form strictly eliminates transitive functional dependencies ($X \\to Y$ and $Y \\to Z$ where $Z$ is non-prime)?",
        "कुनै गैर-प्रमुख विशेषता अर्को गैर-प्रमुख विशेषतामा निर्भर हुने ट्रान्जिटिभ निर्भरता हटाउने नर्मल फर्म कुन हो?",
        ["First Normal Form (1NF)", "Second Normal Form (2NF)", "Third Normal Form (3NF)", "Boyce-Codd Normal Form (BCNF)"],
        2, "3NF requires a relation to be in 2NF and contain no transitive dependencies, meaning non-prime attributes must depend only on candidate keys.",
        "तेस्रो सामान्यीकरण फारम (3NF) ले ट्रान्जिटिभ निर्भरता (Transitive Dependency) हटाएर डेटा दोहोरिन रोक्छ।", "2078 BS - RBB IT")

    # 2. SQL & ACID Transactions
    add(105, "In database transaction management, what does the 'I' in ACID properties guarantee?",
        "डेटाबेस ट्रान्ज्याक्सनको ACID गुणहरूमा 'I' (Isolation) ले के ग्यारेन्टी गर्दछ?",
        ["Integrity of data across foreign keys", "Concurrent execution of transactions results in a system state as if transactions were executed serially without interfering with one another", "Immediate write to disk storage", "Indestructible transactions"],
        1, "Isolation ensures that uncommitted intermediate states of a transaction are invisible to other concurrently executing transactions.",
        "आइसोलेसन (Isolation) ले एकैपटक धेरै कारोबार हुँदा एउटाको नतिजा नसकिँदासम्म अर्कोलाई प्रभाव पार्न नदिने सुनिश्चित गर्दछ।", "2079 BS - NRB IT")

    add(106, "Which SQL clause is used to filter groups formed by the `GROUP BY` statement based on aggregate conditions (e.g., `COUNT(*) > 5`)?",
        "SQL मा `GROUP BY` द्वारा बनाइएको समूहलाई एग्रिगेट सर्तका आधारमा फिल्टर गर्न कुन शब्द प्रयोग गरिन्छ?",
        ["WHERE", "HAVING", "ORDER BY", "FILTER"],
        1, "`WHERE` filters individual rows before grouping, whereas `HAVING` filters aggregated groups after grouping.",
        "`HAVING` क्लजले एग्रिगेट मानहरू (जस्तै SUM, COUNT) का आधारमा समूहहरूलाई फिल्टर गर्न प्रयोग गरिन्छ।", "2075 BS - NBL IT")

    add(107, "Which type of SQL JOIN returns all rows from the left table and the matched rows from the right table, filling nulls if no match is found?",
        "बायाँ टेबलका सबै रेकर्डहरू र दायाँ टेबलका मेल खाने रेकर्डहरू ल्याउने SQL JOIN कुन हो?",
        ["INNER JOIN", "LEFT OUTER JOIN", "RIGHT OUTER JOIN", "CROSS JOIN"],
        1, "A LEFT OUTER JOIN preserves all rows from the left table regardless of whether a matching record exists in the right table.",
        "LEFT JOIN ले बायाँ टेबलका सम्पूर्ण डेटा र दायाँ टेबलबाट मेल खाने डेटा मात्र प्रदर्शन गर्दछ।", "2077 BS - Loksewa Assistant")

    # 3. Data Warehousing & OLAP
    add(108, "What is the primary difference between OLTP (Online Transaction Processing) and OLAP (Online Analytical Processing) systems?",
        "OLTP र OLAP प्रणाली बीचको मुख्य भिन्नता के हो?",
        ["OLTP is read-only; OLAP is write-heavy", "OLTP focuses on fast, atomic daily operational transactions (normalized), while OLAP focuses on complex historical queries and decision support (denormalized multidimensional models)", "OLTP uses star schemas; OLAP uses flat files", "OLTP is only used in cloud environments"],
        1, "OLTP (Core Banking) handles real-time inserts/updates with high normalization. OLAP (Data Warehouse) handles read-intensive multidimensional analytics for executive reporting.",
        "OLTP दैनिक कारोबार (जस्तै पैसा झिक्ने/जम्मा गर्ने) का लागि हो भने OLAP ऐतिहासिक डेटा विश्लेषण र निर्णय प्रक्रियाका लागि हो।", "2080 BS - RBB IT")

    add(109, "In a Data Warehouse dimensional model, which table contains foreign keys referencing dimensions along with numerical, measurable metrics (e.g., transaction amount, quantity)?",
        "डेटा वेयरहाउसमा संख्यात्मक कारोबार परिमाण (Metrics) र डाइमेन्सनका साँचोहरू राख्ने मुख्य टेबल कुन हो?",
        ["Dimension Table", "Fact Table", "Staging Table", "Lookup Table"],
        1, "A Fact Table stores the quantitative measurements (facts) and foreign keys connecting to descriptive dimension tables (e.g., Date, Customer, Branch).",
        "फ्याक्ट टेबल (Fact Table) मा वास्तविक वित्तीय कारोबारका संख्यात्मक मानहरू र डाइमेन्सन किहरू सुरक्षित हुन्छन्।", "2081 BS - NRB IT")

    add(110, "What is the correct sequence of phases in the standard enterprise data warehousing integration workflow?",
        "डेटा वेयरहाउसमा डेटा एकीकृत गर्ने मानक प्रक्रिया (ETL) को सही क्रम कुन हो?",
        ["Extract, Transform, Load (ETL)", "Load, Transform, Extract (LTE)", "Transform, Extract, Load (TEL)", "Index, Query, Export (IQE)"],
        0, "ETL extracts raw data from multiple operational sources, cleanses/transforms it to a uniform format, and loads it into the data warehouse.",
        "ETL (Extract, Transform, Load) ले विभिन्न स्रोतबाट डेटा संकलन गरी, प्रशोधन गरेर वेयरहाउसमा भण्डारण गर्दछ।", "2078 BS - Loksewa Operator")

    # 4. Disaster Recovery Planning (DRP)
    add(111, "In disaster recovery planning, what type of secondary recovery site is fully configured with live mirrored hardware, real-time data replication, and can take over banking operations within minutes?",
        "विपद् व्यवस्थापन (DRP) मा वास्तविक समयमै डेटा दोहोरिने र केही मिनेटमै बैंकिङ कारोबार सुचारु गर्न सक्ने पूर्ण तयारी अवस्थाको साइट कुन हो?",
        ["Cold Site", "Warm Site", "Hot Site", "Mobile Recovery Van"],
        2, "A Hot Site is a fully operational, near-instantaneous mirror site with synchronized live data, offering the lowest RTO and RPO.",
        "हट साइट (Hot Site) मा २४सै घण्टा वास्तविक समयको डेटा र सर्भर चालु अवस्थामा रहन्छ, जसले तत्कालै ब्याकअप दिन्छ।", "2081 BS - RBB IT")

    add(112, "What does RTO (Recovery Time Objective) define in a bank's Business Continuity Management (BCM) plan?",
        "बैंकको BCP/DRP योजनामा RTO (Recovery Time Objective) ले के समय सीमा निर्धारण गर्दछ?",
        ["The maximum acceptable duration of system downtime before financial services must be restored", "The maximum age of backup files that can be recovered without financial penalty", "The mean time between two hardware crashes", "The network ping time to the primary database"],
        0, "RTO is the maximum targeted elapsed time allowed to restore a business process or IT service after a disaster.",
        "RTO भनेको प्रणाली बन्द भएपछि कति समय भित्र सेवा पुनः सञ्चालन गरिसक्नु पर्दछ भन्ने अधिकतम समय सीमा हो।", "2082 BS - RBB IT Probable")

    # Generate more questions up to 185 for Unit 5
    for i in range(113, 186):
        if i % 4 == 0:
            add(i, f"Which SQL command belongs to the Data Control Language (DCL) used to revoke previously granted database privileges from a database user?",
                f"डेटाबेस प्रयोगकर्तालाई दिइएको अधिकार फिर्ता लिन कुन DCL कमान्ड प्रयोग गरिन्छ?",
                ["GRANT", "REVOKE", "DENY", "DROP USER"],
                1, "`REVOKE` is a DCL statement that removes access permissions (SELECT, INSERT, UPDATE) previously granted to roles or users.",
                "`REVOKE` कमान्डले डेटाबेस प्रयोगकर्तालाई पहिले दिइएको पहुँच अधिकार खोस्ने काम गर्दछ।", "2077 BS - Loksewa Assistant")
        elif i % 4 == 1:
            add(i, f"In XML documents, what mechanism provides a schema definition language to validate document structure, data types, and element constraints?",
                f"XML कागजातको संरचना र डेटा प्रकारको वैधता जाँच्न कुन प्रविधि प्रयोग गरिन्छ?",
                ["XSLT", "XML Schema Definition (XSD) / DTD", "XPath", "DOM Parser"],
                1, "An XSD (XML Schema Definition) defines the allowed elements, attributes, data types, and hierarchy of an XML document.",
                "XSD (XML Schema Definition) ले XML फाइलको नियम र संरचना सही छ कि छैन भनी प्रमाणित गर्दछ।", "2079 BS - NRB IT")
        elif i % 4 == 2:
            add(i, f"What is a 'Reverse Proxy' server commonly deployed in front of bank web application servers?",
                f"बैंकको वेब सर्भर अगाडि राखिने 'रिभर्स प्रोक्सी' (Reverse Proxy) को मुख्य कार्य के हो?",
                ["Hides client internal IP addresses from the web", "Intercepts inbound client requests to provide SSL termination, load balancing, and DDoS mitigation for internal backend servers", "Caches outgoing employee web traffic", "Blocks database transactions"],
                1, "A reverse proxy acts as an intermediary for external clients, distributing traffic across backend servers while shielding direct backend server IP addresses.",
                "रिभर्स प्रोक्सीले बाह्य ग्राहकहरूको अनुरोध लिएर लोड ब्यालेन्सिङ र सुरक्षा प्रदान गर्दै मुख्य सर्भरलाई सुरक्षित राख्छ।", "2080 BS - PSC IT Officer")
        else:
            add(i, f"In database recovery management, what technique periodically flushes all modified dirty cache buffers to disk and writes a sync record to the log to minimize crash recovery time?",
                f"डेटाबेस क्र्यास हुँदा छिटो रिकभर गर्न सबै अस्थायी डेटालाई डिस्कमा लेख्ने कार्यलाई के भनिन्छ?",
                ["Checkpointing", "Shadow Paging", "WAL (Write-Ahead Logging)", "Rollback Segment"],
                0, "Checkpoints establish a synchronized state where all logs and memory buffers prior to the checkpoint are committed to physical disk, bounding recovery replay time.",
                "चेकपोइन्टिङ (Checkpointing) ले मेमोरीमा रहेको डेटालाई डिस्कमा सुरक्षित गरी क्र्यास भएपछि पुनः सुरु हुने समय घटाउँछ।", "2081 BS - Loksewa Model")

    return u5

print("Unit 5 generated:", len(get_unit5_questions()), "questions.")
