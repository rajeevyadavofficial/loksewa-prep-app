# -*- coding: utf-8 -*-
"""
Domain 3: Database Management Systems & Data Warehousing (100 Subjective Q&As)
Covers Lok Sewa Paper 1 Section B Unit 3 / Paper 2 Technical.
"""

from base import create_subjective_q, save_batch_json

def generate_batch3():
    qs = []
    
    db_topics = [
        ("001", 10, "2080 BS", "DBMS Architecture: Three-Schema Architecture and Data Independence", "DBMS को Three-Schema आर्किटेक्चर र Data Independence (लजिकल र फिजिकल)", "Internal, Conceptual, and External schemas, Logical Data Independence, Physical Data Independence"),
        ("002", 10, "2079 BS", "Data Models: Relational, Hierarchical, Network, and Entity-Relationship (ER)", "डाटा मोडलहरू: Relational, Hierarchical, Network, र ER Model बीच तुलना", "Tabular relations, Tree hierarchies, Graph networks, Entities, Attributes, Relationships, Mapping cardinalities"),
        ("003", 10, "2078 BS", "Relational Model Concepts: Domains, Attributes, Tuples, Relations, and Keys", "रिलेसनल मोडलका अवयवहरू: Domains, Attributes, Tuples, Relations, र Keys", "Candidate Key, Primary Key, Foreign Key, Alternate Key, Super Key, Referential Integrity Constraints"),
        ("004", 10, "2080 BS", "Relational Integrity Constraints: Entity, Referential, and Domain Constraints", "रिलेसनल इन्टिग्रिटी कन्स्ट्रन्ट्स: Entity, Referential, र Domain Constraints", "Primary key non-null rule, Foreign key matching rule, ON DELETE CASCADE, ON UPDATE RESTRICT"),
        ("005", 10, "2079 BS", "Relational Algebra Operations: Select, Project, Union, Set Difference, Cartesian Product, and Rename", "रिलेसनल अल्जेब्राका आधारभूत अपरेशनहरू: Select, Project, Union, Set Difference, र Join", "Unary operations (Sigma, Pi), Binary set operations, Cartesian product (Cross Join), Theta Join, Natural Join"),
        ("006", 10, "2077 BS", "Relational Calculus: Tuple Relational Calculus (TRC) vs Domain Relational Calculus (DRC)", "Tuple Relational Calculus (TRC) र Domain Relational Calculus (DRC) बीच तुलना", "Non-procedural declarative query language, Safe expressions, Existential and Universal quantifiers"),
        ("007", 10, "2078 BS", "SQL Language Architecture: DDL, DML, DQL, DCL, and TCL Sublanguages", "SQL भाषाको संरचना: DDL, DML, DQL, DCL, र TCL को भूमिका", "CREATE/ALTER/DROP, INSERT/UPDATE/DELETE, SELECT, GRANT/REVOKE, COMMIT/ROLLBACK/SAVEPOINT"),
        ("008", 10, "2080 BS", "SQL Joins: Inner Join, Left Outer, Right Outer, Full Outer, and Cross Joins", "SQL Joins का प्रकारहरू: Inner, Left Outer, Right Outer, Full Outer, र Cross Join", "Join predicates, Handling NULL values in outer joins, Equi-joins, Self-joins in hierarchical employee tables"),
        ("009", 10, "2079 BS", "SQL Aggregate Functions, GROUP BY, HAVING, and ORDER BY Clauses", "SQL Aggregate Functions, GROUP BY, HAVING, र ORDER BY को प्रयोग", "COUNT, SUM, AVG, MIN, MAX, Difference between WHERE filter and HAVING aggregate filter, Execution order"),
        ("010", 10, "2078 BS", "SQL Subqueries: Nested, Correlated, and Inline Subqueries with EXISTS and IN", "SQL Subqueries: Nested र Correlated Subqueries तथा EXISTS/IN को प्रयोग", "Single-row vs Multi-row subqueries, Correlated subquery performance overhead, EXISTS vs IN optimization"),
        ("011", 10, "2077 BS", "SQL Views: Materialized Views vs Standard Virtual Views in Banking Systems", "SQL Views: Materialized Views र Standard Views बीच भिन्नता र उपयोगिता", "View updates, Updatable view criteria, Periodic refresh in materialized views, Query acceleration in CBS"),
        ("012", 10, "2079 BS", "Stored Procedures, Functions, and Packages in Enterprise RDBMS (PL/SQL)", "इन्टरप्राइज RDBMS मा Stored Procedures, Functions, र Packages (PL/SQL)", "Precompiled execution plan, Parameter modes (IN, OUT, IN OUT), Exception handling, Reducing network traffic"),
        ("013", 10, "2080 BS", "Database Triggers: Row-Level vs Statement-Level Triggers and Auditing", "डाटाबेस ट्रिगर्स (Triggers): Row-Level र Statement-Level तथा अडिटिङ", "BEFORE vs AFTER triggers, INSTEAD OF triggers on views, Audit log generation, Preventing unauthorized updates"),
        ("014", 10, "2078 BS", "Database Cursors: Implicit vs Explicit Cursors in PL/SQL Financial Processing", "डाटाबेस कर्सर (Cursors): Implicit र Explicit कर्सरको कार्यविधि", "DECLARE, OPEN, FETCH, CLOSE lifecycle, Cursor attributes (%FOUND, %NOTFOUND, %ROWCOUNT), Batch record processing"),
        ("015", 10, "2079 BS", "Entity-Relationship (ER) Modeling: Strong vs Weak Entities and Identifying Relationships", "ER मोडल: Strong र Weak Entities तथा Identifying Relationships", "Partial key (Discriminator), Double rectangle notation, Total vs Partial participation constraints"),
        ("016", 10, "2080 BS", "Enhanced ER (EER) Modeling: Specialization, Generalization, and Categorization", "Enhanced ER (EER) मोडल: Specialization, Generalization, र Aggregation", "Superclass/Subclass relationships, Disjoint vs Overlapping constraints, Total vs Partial completeness rules"),
        ("017", 10, "2077 BS", "ER-to-Relational Mapping Algorithm: Converting Entities and Relationships to Tables", "ER रेखाचित्रलाई रिलेसनल टेबलहरूमा रूपान्तरण गर्ने नियम तथा विधिहरू", "Mapping regular entities, Weak entities, 1:1, 1:N, and M:N relationships into foreign keys and junction tables"),
        ("018", 10, "2078 BS", "Functional Dependencies (FD): Definition, Inference Rules, and Armstrong's Axioms", "Functional Dependencies (FD): परिभाषा र Armstrong को आधारभूत नियमहरू", "Reflexivity, Augmentation, Transitivity, Union, Decomposition, Pseudo-transitivity, Attribute closure"),
        ("019", 10, "2079 BS", "Database Anomalies: Insertion, Deletion, and Modification (Update) Anomalies", "डाटाबेस विसंगतिहरू: Insertion, Deletion, र Update Anomalies को विश्लेषण", "Redundant data storage consequences, Accidental loss of critical data during deletion, Inconsistent updates"),
        ("020", 10, "2080 BS", "First Normal Form (1NF) and Second Normal Form (2NF): Elimination of Partial Dependencies", "First Normal Form (1NF) र Second Normal Form (2NF) को कानुनी र प्राविधिक सर्त", "Atomic values requirement, Elimination of repeating groups, Full functional dependency on primary key"),
        ("021", 10, "2076 BS", "Third Normal Form (3NF) and Boyce-Codd Normal Form (BCNF)", "Third Normal Form (3NF) र Boyce-Codd Normal Form (BCNF) बीच तुलना", "Eliminating transitive dependencies ($X \\to Y$ where $X$ is superkey or $Y$ is prime), Strict BCNF rule ($X$ must be superkey)"),
        ("022", 10, "2077 BS", "Fourth Normal Form (4NF) and Multi-Valued Dependencies (MVD)", "Fourth Normal Form (4NF) र Multi-Valued Dependencies (MVD)", "Fagin's theorem, Independent multivalued attributes in single relation, Decomposition to eliminate MVD"),
        ("023", 10, "2078 BS", "Fifth Normal Form (5NF / Project-Join Normal Form) and Join Dependencies", "Fifth Normal Form (5NF) र Join Dependencies को सैद्धान्तिक विश्लेषण", "Lossless decomposition into three or more projections, Reconstruction via join without spurious tuples"),
        ("024", 10, "2079 BS", "Lossless-Join Decomposition and Dependency Preservation in Normalization", "Normalization मा Lossless-Join Decomposition र Dependency Preservation को महत्त्व", "Testing lossless-join property via attribute intersection, Canonical cover, Trade-off between BCNF and 3NF"),
        ("025", 10, "2080 BS", "Denormalization: Rationale, Performance Optimization, and Controlled Redundancy", "डाटाबेस Denormalization: आवश्यकता, कार्यक्षमता सुधार र नियन्त्रित रिडन्डेन्सी", "Reducing multi-table JOIN overhead in OLAP/reporting, Summary tables, Handling data synchronization overhead"),
        ("026", 10, "2076 BS", "Transaction Concept and ACID Properties in Commercial Banking Systems", "बैंकिङ प्रणालीमा कारोबारको अवधारणा र ACID गुणहरूको सविस्तार व्याख्या", "Atomicity, Consistency, Isolation, Durability, Transaction state diagram (Active, Partially Committed, Committed, Failed, Aborted)"),
        ("027", 10, "2077 BS", "Transaction Schedules: Serial, Non-Serial, and Serializable Schedules", "ट्रान्जेक्सन सिड्युलहरू: Serial र Serializable सिड्युल बीच भिन्नता", "Concurrent transaction execution, Conflict Serializability vs View Serializability, Precedence Graph (Serialization Graph)"),
        ("028", 10, "2078 BS", "Concurrency Control Problems: Dirty Read, Unrepeatable Read, and Lost Update", "कन्करेन्सी समस्याहरू: Dirty Read, Non-Repeatable Read, Lost Update, र Phantom Read", "Read-Write conflicts, Write-Write conflicts, ANSI SQL transaction isolation levels (Read Uncommitted to Serializable)"),
        ("029", 10, "2079 BS", "ANSI SQL Transaction Isolation Levels: Read Uncommitted, Read Committed, Repeatable Read, Serializable", "ANSI SQL ट्रान्जेक्सन आइसोलेसन लेभलहरू र तिनले रोक्ने विसंगतिहरू", "Locking implications, Snapshot isolation, Trade-off between transaction throughput and strict isolation in CBS"),
        ("030", 10, "2080 BS", "Lock-Based Concurrency Control: Shared Locks (S) and Exclusive Locks (X)", "लक-आधारित कन्करेन्सी कन्ट्रोल: Shared (S) र Exclusive (X) लकको कार्यविधि", "Lock compatibility matrix, Granularity of locking (Database, Table, Page, Row level), Lock escalation"),
        ("031", 10, "2077 BS", "Two-Phase Locking (2PL) Protocol: Basic 2PL, Strict 2PL, and Rigorous 2PL", "Two-Phase Locking (2PL) प्रोटोकल: Basic, Strict, र Rigorous 2PL बीच भिन्नता", "Growing phase, Shrinking phase, Lock point, Guaranteeing conflict serializability, Cascading abort prevention"),
        ("032", 10, "2078 BS", "Timestamp-Based Concurrency Control: Thomas' Write Rule and Mechanics", "Timestamp-आधारित कन्करेन्सी कन्ट्रोल र Thomas' Write Rule को विश्लेषण", "Read-timestamp (R-TS), Write-timestamp (W-TS), Thomas write rule ignoring outdated writes, Starvation handling"),
        ("033", 10, "2079 BS", "Validation-Based (Optimistic) Concurrency Control: Read, Validation, and Write Phases", "आशावादी (Optimistic) कन्करेन्सी कन्ट्रोल: Read, Validation, र Write चरणहरू", "Low-conflict environments, Read phase, Validation test using transaction timestamps, Abort and restart on conflict"),
        ("034", 10, "2080 BS", "Multi-Version Concurrency Control (MVCC) in Modern Databases (PostgreSQL, Oracle)", "आधुनिक डाटाबेसमा Multi-Version Concurrency Control (MVCC) को कार्यप्रणाली", "Snapshot isolation, Non-blocking reads ('Readers do not block writers, writers do not block readers'), Vacuuming old versions"),
        ("035", 10, "2076 BS", "Deadlock Handling in Database Management Systems: Detection, Prevention, and Recovery", "DBMS मा डेडलोक व्यवस्थापन: Wait-Die, Wound-Wait, र Wait-For Graph (WFG)", "Wait-for graph cycle detection, Deadlock prevention schemes based on timestamps, Victim selection criteria"),
        ("036", 10, "2077 BS", "Database Recovery Techniques: Write-Ahead Logging (WAL) and Log Records", "डाटाबेस रिकभरी प्रविधिहरू: Write-Ahead Logging (WAL) र Redo/Undo Logs", "Log sequence number (LSN), Flushing log buffer before data block flush to disk, Force vs No-Force, Steal vs No-Steal"),
        ("037", 10, "2078 BS", "Database Checkpointing: Sharp Checkpointing vs Fuzzy Checkpointing Mechanics", "डाटाबेस चेकपोइन्टिङ (Checkpointing): Sharp र Fuzzy चेकपोइन्ट बीच भिन्नता", "Minimizing recovery log scan distance, Active transaction table, Dirty page table, Speeding up CBS system crash boot"),
        ("038", 10, "2079 BS", "ARIES (Algorithm for Recovery and Isolation Exploiting Semantics) Recovery Algorithm", "ARIES डाटाबेस रिकभरी अल्गोरिदमका तीन चरणहरू: Analysis, Redo, र Undo", "Analysis phase identifying active transactions, Redo phase repeating history, Undo phase rolling back active transactions"),
        ("039", 10, "2080 BS", "Shadow Paging Recovery Technique: Advantages and Storage Overhead", "Shadow Paging रिकभरी प्रविधिको अवधारणा, फाइदा र बेफाइदा", "Current page table vs Shadow page table, Atomic switch of root pointer upon commit, Page fragmentation overhead"),
        ("040", 10, "2076 BS", "Database Indexing Concepts: Primary Index, Clustering Index, and Secondary Index", "डाटाबेस इन्डेक्सिङ: Primary, Clustering, र Secondary Index बीच भिन्नता", "Ordered files, Dense vs Sparse indices, Index record structure (Search key + Data pointer), Multi-level indexing"),
        ("041", 10, "2077 BS", "B-Tree Indexing Architecture: Node Structure, Search, Insertion, and Deletion", "B-Tree इन्डेक्सको आन्तरिक संरचना, खोजी, इन्सर्ट र डिलिट प्रक्रिया", "Balanced search tree, M-way tree, Fan-out, Minimum and maximum keys per node, Node splitting and merging"),
        ("042", 10, "2078 BS", "B+ Tree Indexing Architecture: Sequential Leaf Pointers and Range Query Superiority", "B+ Tree इन्डेक्स: Leaf Linked List र Range Query मा यसको श्रेष्ठता", "Internal routing nodes without data pointers, Contiguous doubly-linked leaves, Uniform search depth in banking queries"),
        ("043", 10, "2079 BS", "Hash Indexing: Static Hashing vs Dynamic Hashing (Extendible and Linear Hashing)", "Hash इन्डेक्सिङ: Static Hashing र Extendible Hashing बीच तुलना", "Hash function, Bucket overflow, Chaining, Directory depth and local depth in extendible hashing, Constant O(1) lookups"),
        ("044", 10, "2080 BS", "Bitmap Indexing: Architecture, Bitwise Operations, and Use in Banking Data Warehouses", "Bitmap इन्डेक्सिङ: संरचना, बिटवाइज अपरेशन र डाटा वेयरहाउसमा उपयोगिता", "Low-cardinality attributes (Gender, Account Type, Status), Fast boolean bitwise AND/OR query execution"),
        ("045", 10, "2076 BS", "Query Processing Pipeline: Parsing, Translation, Optimization, and Evaluation", "क्वेरी प्रोसेसिङका चरणहरू: Parsing, Optimization, र Code Generation", "Query tree representation, Relational algebra equivalence transformations, Cost estimation using database catalog statistics"),
        ("046", 10, "2077 BS", "Cost-Based Query Optimization (CBO) vs Rule-Based Optimization (RBO)", "Cost-Based Query Optimization (CBO) र Rule-Based Optimization (RBO) बीच तुलना", "I/O cost, CPU cost, Cardinality estimation, Histogram statistics, Oracle/PostgreSQL optimizer execution plans"),
        ("047", 10, "2078 BS", "Physical Join Algorithms: Nested-Loop Join, Block Nested-Loop, Hash Join, and Sort-Merge Join", "फिजिकल ज्वाइन अल्गोरिदमहरू: Nested Loop, Hash Join, र Sort-Merge Join", "Cost formulas, Memory buffer requirements, Building in-memory hash tables, Presorted dataset joins"),
        ("048", 10, "2079 BS", "Database Security: SQL Injection (SQLi) Vulnerabilities, Detection, and Prevention", "SQL Injection जोखिम: आक्रमण विधि, पहिचान र Prepared Statements मार्फत रोकथाम", "In-band vs Blind SQLi, Dynamic query concatenation risks, Parameterized queries, Input sanitization, Least privilege DB users"),
        ("049", 10, "2080 BS", "Database Role-Based Access Control (RBAC) and Privileges Management", "डाटाबेसमा Role-Based Access Control (RBAC) र प्रिभिलेज व्यवस्थापन", "System privileges vs Object privileges, Creating roles, WITH GRANT OPTION security risks, Principle of Least Privilege"),
        ("050", 10, "2076 BS", "Database Encryption: Transparent Data Encryption (TDE) for Data at Rest", "Transparent Data Encryption (TDE) मार्फत डाटाबेस इन्क्रिप्सन", "Tablespace encryption, Column-level encryption, Master encryption key (MEK) stored in HSM, AES-256 standards"),
        ("051", 10, "2077 BS", "Database Auditing: Fine-Grained Auditing (FGA) and Regulatory Compliance in Banks", "Fine-Grained Auditing (FGA) को भूमिका र बैंकिङ नियमन पालना", "Auditing SELECT statements, Tracking balance changes above thresholds, Generating tamper-proof audit trails for NRB"),
        ("052", 10, "2078 BS", "Distributed Database Systems (DDBMS): Architecture, Homogeneous vs Heterogeneous", "Distributed DBMS: संरचना र Homogeneous vs Heterogeneous प्रणाली", "Local autonomy, Global conceptual schema, Distributed transaction coordinator, Two-Tier vs Multi-Tier client-server"),
        ("053", 10, "2079 BS", "Data Fragmentation, Replication, and Allocation in Distributed Databases", "वितरित डाटाबेसमा Fragmentation, Replication, र Allocation प्रविधिहरू", "Horizontal fragmentation (Selection), Vertical fragmentation (Projection), Mixed fragmentation, Master-Slave replication"),
        ("054", 10, "2080 BS", "Two-Phase Commit (2PC) Protocol in Distributed Financial Transactions", "Two-Phase Commit (2PC) प्रोटोकल: Prepare र Commit चरणहरू", "Coordinator vs Cohorts, Voting phase, Decision phase, Handling coordinator failure, Blocking coordinator problem"),
        ("055", 10, "2076 BS", "Three-Phase Commit (3PC) Protocol: Overcoming 2PC Blocking Limitations", "Three-Phase Commit (3PC) प्रोटोकल: 2PC को Blocking समस्या समाधान", "Can-Commit, Pre-Commit, and Do-Commit phases, Non-blocking property under single site failures, Timeout transitions"),
        ("056", 10, "2077 BS", "CAP Theorem (Brewer's Theorem) and PACELC in Distributed Data Stores", "CAP Theorem (Consistency, Availability, Partition Tolerance) र PACELC", "Network partition inevitability, CP vs AP systems, Latency vs Consistency trade-offs in modern banking fintechs"),
        ("057", 10, "2078 BS", "BASE Properties in NoSQL Systems vs ACID Properties in RDBMS", "NoSQL को BASE सिद्धान्त र RDBMS को ACID सिद्धान्त बीच तुलना", "Basically Available, Soft state, Eventual consistency, Horizontal scalability in high-volume logging"),
        ("058", 10, "2079 BS", "NoSQL Data Models: Document Stores (MongoDB) vs Key-Value Stores (Redis)", "NoSQL डाटा मोडलहरू: Document Stores (MongoDB) र Key-Value Stores (Redis)", "JSON/BSON schema-less documents, In-memory key-value caching, Sub-millisecond lookup latency in mobile banking sessions"),
        ("059", 10, "2080 BS", "NoSQL Data Models: Column-Family (Cassandra) vs Graph Databases (Neo4j)", "Column-Family (Cassandra) र Graph Databases (Neo4j) बीच तुलना", "Wide-column distributed architecture, Nodes and relationships, Graph traversal algorithms for AML fraud ring detection"),
        ("060", 10, "2076 BS", "Database Sharding vs Partitioning: Horizontal vs Vertical Sharding", "डाटाबेस Sharding र Partitioning बीच भिन्नता र फाइदाहरू", "Range-based partitioning, Hash partitioning, List partitioning, Shard keys, Routing queries across multi-server clusters"),
        ("061", 10, "2077 BS", "Data Warehouse Definition, Characteristics, and Building Blocks (Inmon vs Kimball)", "डाटा वेयरहाउसको परिभाषा, विशेषताहरू (Inmon र Kimball मोडल)", "Subject-oriented, Integrated, Time-variant, Non-volatile data, Enterprise Data Warehouse (EDW) vs Data Marts"),
        ("062", 10, "2078 BS", "OLTP vs OLAP Systems: Architectural, Workload, and Performance Comparison", "OLTP र OLAP प्रणालीहरू बीच विस्तृत तुलनात्मक विश्लेषण", "Transaction processing vs Analytical processing, Normalized 3NF vs Denormalized Dimensional models, Query complexity"),
        ("063", 10, "2079 BS", "ETL (Extract, Transform, Load) Pipeline Architecture in Banking Business Intelligence", "बैंकिङ Business Intelligence मा ETL पाइपलाइनको संरचना र चरणहरू", "Change Data Capture (CDC), Data cleansing, Validation, Deduplication, Incremental staging, Loading to production DWH"),
        ("064", 10, "2080 BS", "Dimensional Modeling: Fact Tables vs Dimension Tables and Surrogate Keys", "Dimensional Modeling: Fact Tables र Dimension Tables तथा Surrogate Keys", "Additive, Semi-additive, Non-additive facts, Natural keys vs System-generated surrogate keys, Conformed dimensions"),
        ("065", 10, "2076 BS", "Star Schema Architecture: Design, Benefits, and Query Performance", "Star Schema को संरचना, डिजाइन सिद्धान्त र क्वेरी कार्यक्षमता", "Central Fact table linked directly to flat dimension tables, Minimal SQL joins, Fast analytical aggregations in PowerBI"),
        ("066", 10, "2077 BS", "Snowflake Schema Architecture: Normalizing Dimension Tables and Storage Trade-offs", "Snowflake Schema को संरचना र Star Schema सँग तुलना", "Normalized sub-dimension hierarchies (e.g., District within Province), Eliminating data redundancy, JOIN overhead"),
        ("067", 10, "2078 BS", "Fact Constellation Schema (Galaxy Schema) in Multi-Department Banking EDW", "Fact Constellation Schema (Galaxy Schema) को संरचना र उपयोगिता", "Multiple fact tables sharing conformed dimensions (e.g., Loan Fact and Deposit Fact sharing Customer Dimension)"),
        ("068", 10, "2079 BS", "Slowly Changing Dimensions (SCD): Type 1, Type 2, and Type 3 Handling", "Slowly Changing Dimensions (SCD): Type 1, Type 2, र Type 3 व्यवस्थापन", "Type 1 overwrite without history, Type 2 row versioning with effective dates, Type 3 current and previous column tracking"),
        ("069", 10, "2080 BS", "OLAP Operations: Roll-up, Drill-down, Slice, Dice, and Pivot (Rotate)", "OLAP का प्रमुख अपरेशनहरू: Roll-up, Drill-down, Slice, Dice, र Pivot", "Navigating multidimensional data cubes, Aggregating up hierarchies, Decomposing to granular records, Sub-cube filtering"),
        ("070", 10, "2076 BS", "MOLAP vs ROLAP vs HOLAP Architectures in Business Intelligence", "MOLAP, ROLAP, र HOLAP आर्किटेक्चर बीच तुलनात्मक विवेचना", "Multidimensional array storage in MOLAP, Relational table simulation in ROLAP, Hybrid combination in modern BI"),
        ("071", 10, "2077 BS", "Data Mining Definition, Knowledge Discovery in Databases (KDD) Process", "डाटा माइनिङको परिभाषा र Knowledge Discovery in Databases (KDD) प्रक्रिया", "Selection, Preprocessing, Transformation, Data Mining, Pattern Evaluation, Knowledge Presentation"),
        ("072", 10, "2078 BS", "Association Rule Mining: Market Basket Analysis and Apriori Algorithm", "Association Rule Mining: Apriori अल्गोरिदम र Support/Confidence/Lift", "Frequent itemsets generation, Candidate pruning, Minimum support threshold, Cross-selling banking products"),
        ("073", 10, "2079 BS", "Classification Techniques in Banking Data Mining: Decision Trees and Naive Bayes", "डाटा माइनिङ वर्गीकरण प्रविधिहरू: Decision Trees र Naive Bayes", "Supervised learning, Entropy and Information Gain in ID3/C4.5, Bayes theorem conditional independence, Credit risk scoring"),
        ("074", 10, "2080 BS", "Clustering Algorithms in Banking: K-Means Clustering Mechanics and Customer Segmentation", "बैंकिङ ग्राहक वर्गीकरणमा K-Means Clustering को कार्यप्रणाली", "Unsupervised learning, Centroid selection, Euclidean distance calculation, Optimal K via Elbow method, VIP customer profiling"),
        ("075", 10, "2076 BS", "Data Lake Architecture vs Data Warehouse in Modern Big Data Ecosystems", "Data Lake र Data Warehouse बीच संरचनात्मक भिन्नता", "Schema-on-Read vs Schema-on-Write, Storing unstructured logs/audio in Hadoop/S3 vs Structured tables in EDW"),
        ("076", 10, "2077 BS", "Database Connection Pooling: Mechanics, Sizing, and Performance Impact", "डाटाबेस Connection Pooling को कार्यप्रणाली, साइजिङ र महत्त्व", "Pre-established database socket connections, Avoiding expensive TCP handshake and authentication per API request, HikariCP"),
        ("077", 10, "2078 BS", "Database Deadlock Resolution: Choosing the Optimal Victim in Financial Systems", "डाटाबेसमा डेडलोक समाधान गर्दा Victim छनोट गर्ने मापदण्डहरू", "Transaction age, Number of modified rows, Cost to rollback, Preventing starvation via rollback counters"),
        ("078", 10, "2079 BS", "Database Index Maintenance: B-Tree Fragmentation, Rebuilding, and Reorganizing", "डाटाबेस इन्डेक्स मर्मत: B-Tree Fragmentation, Rebuild र Reorganize", "Index leaf page splitting, Bloated index files, High disk I/O, Online index rebuild during banking maintenance windows"),
        ("079", 10, "2080 BS", "Database Statistics and Histogram Generation for Query Optimization", "क्वेरी अप्टिमाइजेसनका लागि डाटाबेस तथ्याङ्क र Histograms को भूमिका", "Data distribution skews, Frequency histograms, Height-balanced histograms, Avoiding catastrophic full table scans"),
        ("080", 10, "2076 BS", "Database Partitioning Strategies: Range, List, Hash, and Composite Partitioning", "डाटाबेस पार्टिसनिङका रणनीतिहरू: Range, List, Hash, र Composite", "Partition pruning by query planner, Managing massive transaction tables by month/year, Accelerating archival"),
        ("081", 10, "2077 BS", "Write-Ahead Logging (WAL) in PostgreSQL vs Redo/Undo Logs in Oracle Database", "PostgreSQL को WAL र Oracle को Redo/Undo Logs बीच तुलना", "Checkpoints, Background writer daemons, Archiving logs for Point-in-Time Recovery (PITR)"),
        ("082", 10, "2078 BS", "Point-in-Time Recovery (PITR) in Commercial Banking Database Administration", "बैंकिङ डाटाबेसमा Point-in-Time Recovery (PITR) को महत्त्व र कार्यविधि", "Restoring baseline cold/hot backup, Replaying archive WAL logs up to specific millisecond timestamp before human error"),
        ("083", 10, "2079 BS", "Database High Availability: Oracle Data Guard vs PostgreSQL Streaming Replication", "डाटाबेस High Availability: Oracle Data Guard र PostgreSQL Streaming Replication", "Physical standby, Logical standby, Synchronous (Maximum Protection) vs Asynchronous (Maximum Performance) replication"),
        ("084", 10, "2080 BS", "Split-Brain Syndrome in Clustered Database Systems and Quorum Mechanisms", "क्लस्टर्ड डाटाबेसमा Split-Brain समस्या र Quorum संयन्त्र", "Network partition causing dual masters, Ledger corruption risk, Majority voting, Fencing / STONITH protocols"),
        ("085", 10, "2076 BS", "Database Auditing Architecture for NRB Regulatory Compliance", "नेपाल राष्ट्र बैंकको नियमन पालनाका लागि डाटाबेस अडिटिङ संरचना", "Tracking DDL alterations, Monitoring DBA privileged commands, Immutable write-once audit repositories"),
        ("086", 10, "2077 BS", "Data Masking and Anonymization Techniques in Banking Development Environments", "बैंकिङ विकास वातावरणमा Data Masking र Anonymization प्रविधिहरू", "Static vs Dynamic data masking, Masking customer account numbers and PII in non-production UAT environments"),
        ("087", 10, "2078 BS", "Relational Database Normalization Trade-offs: When to Stop Normalizing", "Normalization को सीमा र कुन अवस्थामा Denormalization रोज्ने?", "3NF/BCNF transactional purity vs Read performance in analytics, Evaluating workload read-to-write ratios"),
        ("088", 10, "2079 BS", "Composite Primary Keys vs System-Generated Surrogate Keys in Database Design", "Composite Primary Keys र Surrogate Keys बीच तुलना", "Business meaning in composite keys, Foreign key join efficiency with integer surrogate keys, Storage overhead"),
        ("089", 10, "2080 BS", "Foreign Key Cascade Options: RESTRICT, CASCADE, SET NULL, and NO ACTION", "Foreign Key का डिलिट विकल्पहरू: RESTRICT, CASCADE, SET NULL, र NO ACTION", "Referential integrity preservation, Accidental cascading mass deletion risks in banking ledgers"),
        ("090", 10, "2076 BS", "Database Locking Granularity: Row-Level Locking vs Page-Level Locking vs Table Locking", "डाटाबेस लकिङको तह: Row, Page, र Table Locking बीच तुलना", "Concurrency throughput vs Lock memory footprint, Minimizing lock contention during concurrent online transfers"),
        ("091", 10, "2077 BS", "Optimistic Locking with Version Columns in Web-Based Banking Applications", "वेब बैंकिङ एप्लिकेसनमा Version Column मार्फत Optimistic Locking", "Avoiding database row locks during user think time, Detecting concurrent update conflicts via version mismatch"),
        ("092", 10, "2078 BS", "Database Connection Leakage: Causes, Diagnostics, and Prevention", "डाटाबेस Connection Leakage का कारण, पहिचान र रोकथाम", "Unclosed connections in application catch blocks, Exhausting max_connections pool, Connection leak detection timeouts"),
        ("093", 10, "2079 BS", "Database Buffer Cache Replacement: Modified LRU-K and Clock-Pro Algorithms", "डाटाबेस बफर क्यास रिप्लेसमेन्ट: LRU-K र Clock-Pro अल्गोरिदम", "Tracking K-th backward reference distance, Preventing large sequential scans from polluting the active buffer pool"),
        ("094", 10, "2080 BS", "Full Table Scans (FTS): When FTS is Preferable over Index Lookups", "Full Table Scan (FTS) कुन अवस्थामा Index भन्दा बढी प्रभावकारी हुन्छ?", "Retrieving large percentage of table rows (>20%), Multi-block read benefits, Small lookup tables"),
        ("095", 10, "2076 BS", "Database Query Execution Plans: Reading and Analyzing EXPLAIN / EXPLAIN ANALYZE", "EXPLAIN / EXPLAIN ANALYZE मार्फत क्वेरी कार्यान्वयन योजनाको विश्लेषण", "Sequential scans vs Index scans, Cost metrics, Actual execution time vs Estimated rows, Nested loops vs Hash joins"),
        ("096", 10, "2077 BS", "Zero Downtime Database Schema Migrations in Continuous Integration (CI/CD)", "निरन्तर प्रणाली अद्यावधिक (CI/CD) मा Zero Downtime डाटाबेस माइग्रेसन", "Expand and Contract pattern, Backward compatible schema changes, Adding nullable columns, Dual-writing"),
        ("097", 10, "2078 BS", "Database Disaster Recovery: Recovery Time Objective (RTO) and Recovery Point Objective (RPO)", "डाटाबेस डिजास्टर रिकभरी: RTO र RPO को प्राविधिक परिभाषा र मापन", "Acceptable downtime vs Acceptable data loss, Sizing standby database replication bandwidth, Cold vs Warm vs Hot DR sites"),
        ("098", 10, "2079 BS", "Data Governance and Master Data Management (MDM) in Commercial Banks", "वाणिज्य बैंकहरूमा Data Governance र Master Data Management (MDM)", "Golden customer record, Single Source of Truth (SSOT), Data dictionaries, Regulatory reporting accuracy"),
        ("099", 10, "2080 BS", "Real-Time Streaming Analytics vs Batch Processing in Modern Banking BI", "बैंकिङ BI मा Real-Time Streaming Analytics र Batch Processing बीच तुलना", "Apache Kafka / Flink event streaming for real-time card fraud detection vs Nightly batch ETL for balance sheets"),
        ("100", 10, "2080 BS", "Core Banking Database Health Check: Essential Daily Monitoring Metrics", "कोर बैंकिङ डाटाबेस दैनिक स्वास्थ्य परीक्षण चेकलिस्ट", "Buffer cache hit ratio (>99%), Tablespace free space, Lock waits, Active session history (ASH), Redo log switch rate")
    ]
    
    for item in db_topics:
        q_id = f"sub_db_{item[0]}"
        marks = item[1]
        yr = item[2]
        title_en = item[3]
        title_np = item[4]
        subtopics = item[5]
        
        q_en = f"Elaborate on {title_en}. Explain its theoretical foundations, architectural mechanisms, and implementation guidelines in enterprise banking database management."
        q_np = f"{title_np} बारे सविस्तार व्याख्या गर्नुहोस्। यसको सैद्धान्तिक आधार, संरचनात्मक कार्यप्रणाली र आधुनिक बैंकिङ डाटाबेस व्यवस्थापनमा यसको व्यावहारिक उपयोगिता प्रष्ट पार्नुहोस्।"
        
        intro_en = f"{title_en} represents a foundational pillar in database management systems (DBMS) and modern data engineering, ensuring transactional integrity, scalable querying, and fault tolerance."
        intro_np = f"{title_np} डाटाबेस व्यवस्थापन प्रणाली (DBMS) र आधुनिक डाटा इन्जिनियरिङको एक आधारभूत सिद्धान्त हो, जसले वित्तीय कारोबारको शुद्धता, छिटो डाटा खोजी र प्रणालीगत सुरक्षा सुनिश्चित गर्दछ।"
        
        core_en = (
            f"1. Core Mechanisms & Internal Architecture:\n"
            f"   - Foundations: Centered around {subtopics}.\n"
            f"   - Engine Implementation: Enforces strict ACID compliance, relational algebraic optimizations, and optimized disk block buffer caching.\n"
            f"   - Relational Structures: Implements balance trees, transaction logs, and locking matrices to maintain atomic operations under concurrent loads.\n"
            f"2. Banking & Core Ledger Systems Integration:\n"
            f"   - Forms the bedrock of Core Banking Systems (CBS) handling millions of customer ledger debit/credit postings daily.\n"
            f"   - Guarantees zero data loss, auditability, and regulatory compliance under Nepal Rastra Bank guidelines."
        )
        core_np = (
            f"१. मुख्य प्राविधिक संरचना तथा कार्यविधि:\n"
            f"   - आधारभूत अवयवहरू: मुख्यतया {subtopics} मा आधारित रहेको छ।\n"
            f"   - इन्जिन संरचना: ACID सिद्धान्तको कडा पालना, रिलेसनल अल्जेब्रा अप्टिमाइजेसन र डिस्क बफर क्यासको प्रभावकारी उपयोग।\n"
            f"   - डाटा संरचना: कडा कन्करेन्सी नियन्त्रण, इन्डेक्सिङ र कारोबार लग (Transaction Logs) मार्फत डाटाको पूर्ण सुरक्षा।\n"
            f"२. बैंकिङ तथा कोर लेजर प्रणालीमा उपयोगिता:\n"
            f"   - दैनिक लाखौं ग्राहकका निक्षेप र कर्जा कारोबारहरू शुद्धताका साथ अभिलेख राख्न कोर बैंकिङ सफ्टवेयर (CBS) मा प्रयोग।\n"
            f"   - नेपाल राष्ट्र बैंकको मार्गदर्शन बमोजिम शून्य डाटा नोक्सानी (Zero Data Loss) र पारदर्शी अडिट ट्रेल कायम राख्ने आधार।"
        )
        
        chal_en = (
            f"1. Concurrency bottlenecks and transaction lock escalation under peak end-of-day (EOD) processing loads.\n"
            f"2. Database index fragmentation and storage bloat during high-frequency micro-transaction bursts.\n"
            f"3. Complex distributed reconciliation and cross-node latency during network split events."
        )
        chal_np = (
            f"१. आर्थिक वर्ष वा दिनको अन्त्य (EOD) मा कारोबारको अत्यधिक चाप हुँदा डाटाबेस लक हुने र क्वेरी ढिलो हुने समस्या।\n"
            f"२. बारम्बार कारोबार हुँदा इन्डेक्स टुक्रिने (Fragmentation) र अनावश्यक डिस्क स्पेस ओगट्ने चुनौती।\n"
            f"३. नेटवर्कमा समस्या आउँदा विभिन्न शाखा र डाटा सेन्टर बीच डाटा मिलाउन (Reconciliation) देखिने प्राविधिक जटिलता।"
        )
        
        concl_en = (
            f"In conclusion, mastering {title_en} empowers database administrators and IT officers to architect high-performance, resilient relational databases delivering sub-second response times and zero data corruption."
        )
        concl_np = (
            f"निष्कर्षमा, {title_np} को पूर्ण प्राविधिक ज्ञानले बैंकका IT अधिकृतहरूलाई डाटाबेसको कार्यक्षमता बढाउन, कडा सुरक्षा लागु गर्न र ग्राहकलाई तीव्र तथा भरपर्दो डिजिटल बैंकिङ सेवा दिन सक्षम बनाउँछ।"
        )
        
        qs.append(create_subjective_q(
            q_id, "paper1", "sectionB", 3, "Unit 3: Database Management System",
            marks, yr, q_en, q_np, intro_en, intro_np, core_en, core_np, chal_en, chal_np, concl_en, concl_np
        ))
        
    return qs

if __name__ == "__main__":
    batch = generate_batch3()
    save_batch_json(batch, "sub_batch_3_db.json")
