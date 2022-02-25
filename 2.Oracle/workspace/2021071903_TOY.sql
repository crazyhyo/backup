CREATE  TABLE   AURORIAN(
    AuName          VARCHAR2(50),
    Rarity          CHAR(1)         NOT NULL        CHECK(Rarity IN('3','4','5','6')),
    Ele             CHAR(1)         NOT NULL        CHECK(Ele IN('1','2','3','4')),
    Ele2            CHAR(1)                         CHECK(Ele2 IN('1','2','3','4')),
    Position        CHAR(1)         NOT NULL        CHECK(Position IN('1','2','3','4')),
    Fraction        CHAR(1)         NOT NULL        CHECK(Fraction IN('1','2','3','4','5','6','7')),

    CONSTRAINT pk_aurorian                  PRIMARY KEY(AuName)
);

CREATE  TABLE   ASCENSION(
    AuName          VARCHAR2(50),
    AscensionLev    CHAR(1)         DEFAULT '3'     CHECK(AscensionLev IN('0','1','2','3')),
    ASCBF           VARCHAR2(300),
    ASCAF           VARCHAR2(300),
    ASCCost         VARCHAR2(300),
    
    CONSTRAINT pk_ascension                 PRIMARY KEY(AuName, AscensionLev),
    CONSTRAINT fk_ascension_aurorian        FOREIGN KEY(AuName)             REFERENCES AURORIAN(AuName)
);

CREATE  TABLE   LEVELDATA(
    AuName          VARCHAR2(50),
    AscensionLev    CHAR(1)         DEFAULT '3'     CHECK(AscensionLev IN('0','1','2','3')),
    Lev             NUMBER          DEFAULT 80      CHECK(Lev <= 80 AND Lev > 0),
    ATK             NUMBER,
    DEF             NUMBER,
    HP              NUMBER,
    
    CONSTRAINT pk_leveldata                 PRIMARY KEY(AuName, AscensionLev, Lev),
    CONSTRAINT fk_leveldata_aurorian        FOREIGN KEY(AuName)                     REFERENCES AURORIAN(AuName),
    CONSTRAINT fk_leveldata_ascension       FOREIGN KEY(AuName, AscensionLev)       REFERENCES ASCENSION(AuName, AscensionLev)
);

CREATE  TABLE   BREAKTHROUGH(
    AuName          VARCHAR2(50),
    BreakthroughLev CHAR(1)         DEFAULT '0'     CHECK(BreakthroughLev IN('0','1','2','3','4','5','6')),
    DEF             NUMBER,
    HP              NUMBER,
    
    CONSTRAINT pk_breakthrough              PRIMARY KEY(AuName, BreakthroughLev),
    CONSTRAINT fk_breakthrough_aurorian     FOREIGN KEY(AuName)             REFERENCES AURORIAN(AuName)
);

CREATE  TABLE   AFFINITY(
    AuName          VARCHAR2(50),
    AffinityLev     NUMBER              DEFAULT 10     CHECK(AffinityLev >= 0 AND AffinityLev <= 10),
    ATK             NUMBER,
    DEF             NUMBER,
    HP              NUMBER,
    
    CONSTRAINT pk_affinity                  PRIMARY KEY(AuName, AffinityLev),
    CONSTRAINT fk_affinity_aurorian         FOREIGN KEY(AuName)             REFERENCES AURORIAN(AuName)
);

CREATE  TABLE   SKILL(
    AuName          VARCHAR2(50),
    SkillName       VARCHAR2(100)       NOT NULL,
    BreakthroughLev CHAR(1)             DEFAULT '0'     CHECK(BreakthroughLev IN('0','1','2','3','4','5','6')),
    SkillCD         NUMBER              DEFAULT 3       CHECK(SkillCD >= 0 AND SkillCD <= 5),
    Preemptive      CHAR(1)             DEFAULT '0'     CHECK(Preemptive IN('0','1')),
    
    CONSTRAINT pk_skill                     PRIMARY KEY(AuName, BreakthroughLev),
    CONSTRAINT fk_skill_aurorian            FOREIGN KEY(AuName)                     REFERENCES AURORIAN(AuName),
    CONSTRAINT fk_skill_breakthrough        FOREIGN KEY(AuName, BreakthroughLev)    REFERENCES BREAKTHROUGH(AuName, BreakthroughLev)
);

CREATE  TABLE   SKILLDETAIL(
    AuName          VARCHAR2(50),
    SkillName       VARCHAR2(100)       NOT NULL,
    AscensionLev    CHAR(1)             DEFAULT '3'     CHECK(AscensionLev IN('0','1','2','3')),
    BreakthroughLev CHAR(1)             DEFAULT '0'     CHECK(BreakthroughLev IN('0','1','2','3','4','5','6')),
    SkillDesc       VARCHAR(500),
    
    CONSTRAINT pk_skilldetail               PRIMARY KEY(SkillName, AscensionLev, BreakthroughLev),
    CONSTRAINT fk_skilldetail_skill         FOREIGN KEY(AuName, BreakthroughLev)     REFERENCES SKILL(AuName, BreakthroughLev),
    CONSTRAINT fk_skilldetail_ascension     FOREIGN KEY(AuName, AscensionLev)        REFERENCES ASCENSION(AuName, AscensionLev),
    CONSTRAINT fk_skilldetail_breakthrough  FOREIGN KEY(AuName, BreakthroughLev)     REFERENCES BREAKTHROUGH(AuName, BreakthroughLev)
);

CREATE  TABLE   CHAINCOMBO(
    AuName          VARCHAR2(50),
    AscensionLev    CHAR(1)             DEFAULT '3'     CHECK(AscensionLev IN('0','1','2','3')),
    BreakthroughLev CHAR(1)             DEFAULT '0'     CHECK(BreakthroughLev IN('0','1','2','3','4','5','6')),
    ChainComboTile  NUMBER                              CHECK(ChainComboTile >= 0 AND ChainComboTile <= 15),
    ChainComboDesc  VARCHAR2(300),
    
    CONSTRAINT pk_chaincombo                PRIMARY KEY(AuName, AscensionLev, BreakthroughLev),
    CONSTRAINT fk_chaincombo_aurorian       FOREIGN KEY(AuName)                     REFERENCES AURORIAN(AuName),
    CONSTRAINT fk_chaincombo_ascension      FOREIGN KEY(AuName, AscensionLev)       REFERENCES ASCENSION(AuName, AscensionLev),
    CONSTRAINT fk_chaincombo_breakthrough   FOREIGN KEY(AuName, BreakthroughLev)    REFERENCES BREAKTHROUGH(AuName, BreakthroughLev)
);

CREATE  TABLE   EQUIPMENT(
    AuName          VARCHAR2(50),
    EquipmentName   VARCHAR2(100)       NOT NULL,
    EquipmentLev    NUMBER              DEFAULT 10     CHECK(EquipmentLev >= 0 AND EquipmentLev <= 10),
    EquipmentDesc   VARCHAR2(300),
    ATK             NUMBER,
    DEF             NUMBER,
    HP              NUMBER,
    EleDMG          NUMBER,
    
    CONSTRAINT pk_equipment                 PRIMARY KEY(AuName, EquipmentLev),
    CONSTRAINT fk_equipment_aurorian        FOREIGN KEY(AuName)                    REFERENCES AURORIAN(AuName)
);

--DROP TABLE AURORIAN;
--DROP TABLE ASCENSION;
--DROP TABLE LEVELDATA;
--DROP TABLE BREAKTHROUGH;
--DROP TABLE AFFINITY;
--DROP TABLE SKILL;
--DROP TABLE SKILLDETAIL;
--DROP TABLE CHAINCOMBO;
--DROP TABLE EQUIPMENT;
