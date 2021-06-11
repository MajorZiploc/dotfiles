using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using Acadian.Utility.Extensions;

namespace SmsPdfReader {
    public class Parser : IParsePdfs {

        private Dictionary<string, RegexSetting> patterns;
        private List<TestResultMap> TestResultMaps;
        private string LabName;

        public Parser(ParserSettingsModel settings) {
            patterns = new Dictionary<string, RegexSetting>();
            settings.Fields.ForEach(f => patterns.Add(f.Name, new RegexSetting { Regex = new Regex(f.Pattern), OrderedGroups = f.OrderedGroups }));
            TestResultMaps = settings.TestResultMaps;
            LabName = settings.LabName;
        }

        private string GetMatchString(Match match, List<int> orderedGroups, string groupJoinSymbol) {
            return orderedGroups.Select(g => match.Groups[g].Value.Trim()).StringJoin(groupJoinSymbol);
        }

        public LabResult ParseToResult(string pdfText, string fileName) {
            var collectionDateText = GetMatchString(patterns[nameof(LabResult.CollectionDate)].Regex.Match(pdfText), patterns[nameof(LabResult.CollectionDate)].OrderedGroups, patterns[nameof(LabResult.CollectionDate)].GroupJoinSymbol);
            var collectionDate = DateTime.Parse(collectionDateText).ToShortDateString();
            var dobText = GetMatchString(patterns[nameof(LabResult.Dob)].Regex.Match(pdfText), patterns[nameof(LabResult.Dob)].OrderedGroups, patterns[nameof(LabResult.Dob)].GroupJoinSymbol);
            var dob = DateTime.Parse(dobText).ToShortDateString();
            var reportDateText = GetMatchString(patterns[nameof(LabResult.ReportDate)].Regex.Match(pdfText), patterns[nameof(LabResult.ReportDate)].OrderedGroups, patterns[nameof(LabResult.ReportDate)].GroupJoinSymbol);

            DateTime? nullableDateTime = null;
            DateTime reportDate;
            if (DateTime.TryParse(reportDateText, out reportDate)) {
                nullableDateTime = reportDate;
            }

            var testResultMatch = patterns[nameof(LabResult.TestResult)].Regex.Match(pdfText);
            var testResult =
                GetMatchString(testResultMatch,
                    patterns[nameof(LabResult.TestResult)].OrderedGroups, patterns[nameof(LabResult.TestResult)].GroupJoinSymbol).ToLower();

            var testResultType = TestResultMaps
                    .Find(tm => (new Regex(tm.Matcher))
                         .Match(testResult).Success)
                    ?.Name;

            var result = new LabResult {
                LabName = LabName,
                Dob = dob,
                TestResult = testResultType,
                CollectionDate = collectionDate,
                SampleId = GetMatchString(patterns[nameof(LabResult.SampleId)].Regex.Match(pdfText), patterns[nameof(LabResult.SampleId)].OrderedGroups, patterns[nameof(LabResult.SampleId)].GroupJoinSymbol),
                ReportDate = nullableDateTime,
                NeedsReview = false,
                FileName = fileName,
            };

            if (new List<string> { result.SampleId, result.TestResult}.Any(string.IsNullOrEmpty)
                || result.CollectionDate == result.Dob || !testResultMatch.Success) {
                result.NeedsReview = true;
            }
            return result;
        }
    }
}
