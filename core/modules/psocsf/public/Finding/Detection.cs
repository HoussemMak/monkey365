﻿using System;
using System.Globalization;
using System.Collections.Generic;
using Ocsf.Objects.Vulnerability;
using Ocsf.Objects.Interface;
using Ocsf.Objects.Finding;
using Ocsf.Objects.Entity;
using Ocsf.Objects.Data;
using Ocsf.Objects;

namespace Ocsf.Finding {
    public class Detection {
        public API API { get; set; }
        public string ActivityName { get; set; }
        public ActivityId ActivityId { get; set; }
        public ResourceDetails[] Resources { get; set; }
        public string CategoryName { get; set; }
        public int CategoryId { get; set; }
        public string ClassName { get; set; }
        public int ClassId { get; set; }
        public Cloud Cloud { get; set; }
        public string Comment { get; set; }
        public string Confidence { get; set; }
        public ConfidenceId ConfidenceId { get; set; }
        public int ConfidenceScore { get; set; }
        public int Count { get; set; }
        public int Duration { get; set; }
        public DateTime EndTime { get; set; }
        public Enrichment[] Enrichments { get; set; }
        public DateTime Time { get; set; }
        public Evidence[] Evidences { get; set; }
        public FindingInfo FindingInfo { get; set; }
        public string Impact { get; set; }
        public int ImpactScore { get; set; }
        public ImpactId ImpactId { get; set; }
        public string Message { get; set; }
        public Metadata Metadata { get; set; }
        public Observable[] Observables { get; set; }
        public string RawData { get; set; }
        public Remediation Remediation { get; set; }
        public string RiskLevel { get; set; }
        public RiskLevelId RiskLevelId { get; set; }
        public string RiskScore { get; set; }
        public string Severity { get; set; }
        public SeverityId SeverityId { get; set; }
        public DateTime StartTime { get; set; }
        public string Status { get; set; }
        public string StatusCode { get; set; }
        public string StatusDetail { get; set; }
        public StatusId StatusId { get; set; }
        public int TimeZoneOffset { get; set; }
        public TypeId TypeId { get; set; }
        public string TypeName { get; set; }
        public Dictionary<string,string> Unmapped { get; set; }
        public VulnerabilityDetails[] Vulnerabilities { get; set; }
    }
}