param workspace string

@description('Appended to workbook displayNames to make them unique')
param formattedTimeNow string = utcNow('g')

@description('Unique id for the workbook')
@minLength(1)
param workbook_id string = 'a7bf5967-9d21-4d5b-b65f-47f7549fca81'

@description('Name for the workbook')
@minLength(1)
param workbook_name string = 'ZscalerThreats'

resource workbook_id_resource 'Microsoft.Insights/workbooks@2020-02-12' = {
  name: workbook_id
  location: resourceGroup().location
  kind: 'shared'
  properties: {
    displayName: '${workbook_name} - ${formattedTimeNow}'
    serializedData: '{"version":"Notebook/1.0","items":[{"type":1,"content":{"json":"## Zscaler Threats Overview"},"name":"text - 0"},{"type":9,"content":{"version":"KqlParameterItem/1.0","parameters":[{"id":"e6ceec81-0d4d-420e-8ed3-062a7eb4129a","version":"KqlParameterItem/1.0","name":"TimeRange","type":4,"isRequired":true,"value":{"durationMs":604800000},"typeSettings":{"selectableValues":[{"durationMs":300000},{"durationMs":900000},{"durationMs":1800000},{"durationMs":3600000},{"durationMs":14400000},{"durationMs":43200000},{"durationMs":86400000},{"durationMs":172800000},{"durationMs":259200000},{"durationMs":604800000},{"durationMs":1209600000},{"durationMs":2419200000},{"durationMs":2592000000},{"durationMs":5184000000},{"durationMs":7776000000}],"allowCustom":true}}],"style":"pills","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces"},"name":"parameters - 1"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceVendor == \\"Zscaler\\"\\r\\n| where DeviceEventClassID == \\"Blocked\\"\\r\\n| where DeviceCustomString5Label == \\"threatname\\" \\r\\n| where DeviceCustomString5 != \\"None\\" \\r\\n| where DeviceCustomString5 != \\"suspiciousfile\\" \\r\\n| summarize Count = count() by [\'Threat name\'] = DeviceCustomString5, threatname = DeviceCustomString5\\r\\n| order by Count desc","size":0,"exportFieldName":"threatname","exportParameterName":"threatname","exportDefaultValue":"All","exportToExcelOptions":"visible","title":"Blocked threats","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","gridSettings":{"formatters":[{"columnMatch":"Threat name","formatter":0,"formatOptions":{"showIcon":true}},{"columnMatch":"threatname","formatter":5,"formatOptions":{"showIcon":true}},{"columnMatch":"Count","formatter":8,"formatOptions":{"palette":"greenRed","showIcon":true}}],"filter":true}},"customWidth":"30","name":"query - 3"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceVendor == \\"Zscaler\\"\\r\\n| where DeviceEventClassID == \\"Blocked\\"\\r\\n| where DeviceCustomString5Label == \\"threatname\\" \\r\\n| where DeviceCustomString5 != \\"None\\" \\r\\n| where DeviceCustomString5 != \\"suspiciousfile\\"\\r\\n| where \'{threatname}\' == \\"All\\" or \'{threatname}\' == DeviceCustomString5 \\r\\n| summarize count() by bin(TimeGenerated, {TimeRange:grain}), [\'Threat name\'] = DeviceCustomString5\\r\\n","size":0,"exportToExcelOptions":"visible","title":"Blocked threats over time","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","visualization":"barchart"},"customWidth":"70","name":"query - 2"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceVendor == \\"Zscaler\\"\\r\\n| where DeviceEventClassID contains \\"Block\\"\\r\\n| where DeviceProduct == \\"NSSWeblog\\" \\r\\n| where DeviceCustomString2 != \\"\\"\\r\\n| summarize Count = count() by urlcat = DeviceCustomString2\\r\\n| order by Count desc\\r\\n","size":0,"exportFieldName":"urlcat","exportParameterName":"urlcat","exportDefaultValue":"All","exportToExcelOptions":"visible","title":"Blocked URL categories","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","gridSettings":{"formatters":[{"columnMatch":"urlcat","formatter":0,"formatOptions":{"showIcon":true}},{"columnMatch":"Count","formatter":8,"formatOptions":{"min":0,"palette":"greenRed","showIcon":true}}],"filter":true,"labelSettings":[{"columnId":"urlcat","label":"URL categories"},{"columnId":"Count","label":""}]}},"customWidth":"30","name":"query - 4"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceVendor == \\"Zscaler\\"\\r\\n| where DeviceEventClassID contains \\"Block\\"\\r\\n| where DeviceProduct == \\"NSSWeblog\\" \\r\\n| where DeviceCustomString2 != \\"\\"\\r\\n| where \'{urlcat}\' == \\"All\\" or \'{urlcat}\' == DeviceCustomString2\\r\\n| summarize Count = count() by urlcat = DeviceCustomString2, bin(TimeGenerated, {TimeRange:grain})","size":0,"exportToExcelOptions":"visible","title":"Blocked URL categories over time","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","visualization":"areachart"},"customWidth":"70","name":"query - 5"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceEventClassID == \\"Blocked\\"\\r\\n| where Activity contains \\"IPS\\" \\r\\n| summarize Count = count()  by  Activity\\r\\n| order by Count desc","size":0,"exportFieldName":"Activity","exportParameterName":"Activity","exportDefaultValue":"All","exportToExcelOptions":"visible","title":"Transactions blocked IPS","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","gridSettings":{"formatters":[{"columnMatch":"Activity","formatter":0,"formatOptions":{"showIcon":true}},{"columnMatch":"Count","formatter":8,"formatOptions":{"palette":"greenRed","showIcon":true}}],"filter":true}},"customWidth":"30","name":"query - 7"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceEventClassID == \\"Blocked\\"\\r\\n| where Activity contains \\"IPS\\" \\r\\n| where Activity == \'{Activity}\' or \'{Activity}\' == \\"All\\"\\r\\n| summarize Count = count()  by  Activity, bin(TimeGenerated, {TimeRange:grain})\\r\\n| order by Count desc\\r\\n","size":0,"exportToExcelOptions":"visible","title":"Transactions blocked IPS over time","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","visualization":"barchart","gridSettings":{"formatters":[{"columnMatch":"Activity","formatter":5,"formatOptions":{"showIcon":true}},{"columnMatch":"SourceIP","formatter":0,"formatOptions":{"showIcon":true,"aggregation":"Unique"}},{"columnMatch":"DestinationIP","formatter":0,"formatOptions":{"showIcon":true,"aggregation":"Unique"}},{"columnMatch":"TimeGenerated","formatter":0,"formatOptions":{"showIcon":true}},{"columnMatch":"Count","formatter":8,"formatOptions":{"palette":"orangeBlue","showIcon":true,"aggregation":"Sum"}},{"columnMatch":"count_","formatter":0,"formatOptions":{"showIcon":true,"aggregation":"Sum"}},{"columnMatch":"$gen_group","formatter":0,"formatOptions":{"showIcon":true}}],"filter":true,"hierarchySettings":{"treeType":1,"groupBy":["Activity","SourceIP","DestinationIP"]}}},"customWidth":"70","name":"query - 6"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceProduct == \\"NSSWeblog\\"\\r\\n| where SourceUserPrivileges != SourceUserName \\r\\n| where DeviceCustomNumber1>=50\\r\\n| summarize Count = count() by SourceUserName, RiskScore = DeviceCustomNumber1\\r\\n| order by RiskScore desc, Count","size":0,"exportFieldName":"SourceUserName","exportParameterName":"SourceUserName","exportDefaultValue":"All","exportToExcelOptions":"visible","title":"Users accessing malicious destinations","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","gridSettings":{"formatters":[{"columnMatch":"SourceUserName","formatter":0,"formatOptions":{"showIcon":true}},{"columnMatch":"RiskScore","formatter":8,"formatOptions":{"min":50,"palette":"greenRed","showIcon":true}},{"columnMatch":"Count","formatter":4,"formatOptions":{"min":0,"palette":"blue","showIcon":true}}],"filter":true}},"customWidth":"30","name":"query - 11"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceProduct == \\"NSSWeblog\\"\\r\\n| where SourceUserPrivileges != SourceUserName \\r\\n| where SourceUserName == \'{SourceUserName}\' or \'{SourceUserName}\' == \\"All\\"\\r\\n| where DeviceCustomNumber1>=50\\r\\n| summarize count() by bin(TimeGenerated, {TimeRange:grain}), SourceUserName\\r\\n","size":0,"exportToExcelOptions":"visible","title":"Users accessing malicious destinations over time","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","visualization":"areachart"},"customWidth":"70","name":"query - 10"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceVendor == \\"Zscaler\\"\\r\\n| where DeviceEventClassID == \\"Blocked\\"\\r\\n| where FileType != \\"None\\" \\r\\n| summarize count() by FileType \\r\\n| sort by count_  desc nulls last \\r\\n| top 10 by count_","size":0,"exportToExcelOptions":"visible","title":"Blocked file types","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","visualization":"piechart"},"customWidth":"33","name":"query - 8"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceProduct == \\"NSSWeblog\\"\\r\\n|  where DeviceCustomString4 !=\\"None\\"\\r\\n| summarize count() by malwarecat = DeviceCustomString4","size":0,"exportToExcelOptions":"visible","title":"Transactions intercepted by malware protection","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","visualization":"piechart","gridSettings":{"formatters":[{"columnMatch":"malwarecat","formatter":0,"formatOptions":{"showIcon":true}},{"columnMatch":"count_","formatter":0,"formatOptions":{"showIcon":true}}],"labelSettings":[{"columnId":"malwarecat","label":"Malware Categoty"},{"columnId":"count_"}]}},"customWidth":"33","name":"query - 9"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceProduct == \\"NSSWeblog\\"\\r\\n| where DeviceCustomNumber1 != 0\\r\\n| where DeviceEventClassID !contains \\"Allow\\" \\r\\n| where DeviceCustomString4 !=\\"None\\"\\r\\n| where RequestMethod == \\"GET\\"  or  RequestMethod == \\"POST\\"\\r\\n| extend replaced= iif ( RequestMethod==\\"GET\\" , replace(\'GET\', \'Inbound Threats\', RequestMethod) , replace(\'POST\', \'Outbound Threats\', RequestMethod))\\r\\n| summarize count() by  replaced\\r\\n","size":0,"exportToExcelOptions":"visible","title":"Inbound and outbound blocked threats","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","visualization":"piechart","tileSettings":{"showBorder":false,"titleContent":{"columnMatch":"replaced","formatter":1},"leftContent":{"columnMatch":"count_","formatter":12,"formatOptions":{"palette":"auto"},"numberFormat":{"unit":17,"options":{"maximumSignificantDigits":3,"maximumFractionDigits":2}}}}},"customWidth":"33","name":"query - 12"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceProduct == \\"NSSWeblog\\" \\r\\n| parse AdditionalExtensions with * \\"urlclass=\\" urlclass \\";devicemodel=\\" devicemodel\\r\\n| where urlclass == \\"Advanced Security Risk\\" \\r\\n| summarize count() by urlcat = DeviceCustomString2","size":0,"exportToExcelOptions":"visible","title":"Blocked advanced security risk URL categories","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","visualization":"piechart"},"customWidth":"33","name":"query - 13"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceProduct == \\"NSSWeblog\\"\\r\\n| where DeviceEventClassID !contains \\"Allow\\"\\r\\n|  where DeviceCustomString4 !=\\"None\\"\\r\\n| where SourceUserPrivileges == \\"Road Warrior\\" \\r\\n| summarize count() by malwarecat = DeviceCustomString4","size":0,"exportToExcelOptions":"visible","title":"Threats blocked for Road Warriors","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","visualization":"piechart"},"customWidth":"33","name":"query - 14"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceProduct == \\"NSSWeblog\\"\\r\\n| where DeviceCustomString3 contains \\"Behavior\\" \\r\\n| summarize count() by malwarecat = DeviceCustomString4","size":0,"exportToExcelOptions":"visible","title":"Threats intercepted by Sandbox protection","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","visualization":"piechart"},"customWidth":"33","name":"query - 15"},{"type":3,"content":{"version":"KqlItem/1.0","query":"let data = CommonSecurityLog\\r\\n| where DeviceProduct == \\"NSSWeblog\\" \\r\\n| where DeviceEventClassID contains \\"Block\\"\\r\\n| where MaliciousIPCountry !=\\"\\";\\r\\nlet appData = data\\r\\n| summarize TotalCount = count() by MaliciousIPCountry\\r\\n| join kind=inner (data\\r\\n    | make-series Trend = count() default = 0 on TimeGenerated in range({TimeRange:start}, {TimeRange:end}, {TimeRange:grain}) by MaliciousIPCountry\\r\\n    | project-away TimeGenerated) on MaliciousIPCountry\\r\\n| order by TotalCount desc, MaliciousIPCountry asc\\r\\n| project MaliciousIPCountry, TotalCount, Trend\\r\\n| serialize Id = row_number();\\r\\ndata\\r\\n| summarize TotalCount = count() by Activity , MaliciousIPCountry\\r\\n| join kind=inner (data\\r\\n    | make-series Trend = count() default = 0 on TimeGenerated in range({TimeRange:start}, {TimeRange:end}, {TimeRange:grain}) by MaliciousIPCountry, Activity\\r\\n    | project-away TimeGenerated) on MaliciousIPCountry, Activity\\r\\n| order by TotalCount desc, MaliciousIPCountry asc\\r\\n| project MaliciousIPCountry, Activity, TotalCount, Trend\\r\\n| serialize Id = row_number(1000000)\\r\\n| join kind=inner (appData) on MaliciousIPCountry\\r\\n| project Id, Name = Activity, Type = \'Activity\', [\'MaliciousIPCountry Count\'] = TotalCount, Trend,  ParentId = Id1\\r\\n| union (appData \\r\\n    | project Id, Name = MaliciousIPCountry, Type = \'Operation\', [\'MaliciousIPCountry Count\'] = TotalCount,  Trend)\\r\\n| order by [\'MaliciousIPCountry Count\'] desc, Name asc\\r\\n","size":0,"exportToExcelOptions":"visible","title":"Blocked destination activities, by location","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","visualization":"table","gridSettings":{"formatters":[{"columnMatch":"Id","formatter":5,"formatOptions":{"showIcon":true}},{"columnMatch":"Name","formatter":0,"formatOptions":{"showIcon":true}},{"columnMatch":"Type","formatter":0,"formatOptions":{"showIcon":true}},{"columnMatch":"MaliciousIPCountry Count","formatter":8,"formatOptions":{"palette":"orangeRed","showIcon":true}},{"columnMatch":"Trend","formatter":9,"formatOptions":{"min":0,"palette":"grayBlue","showIcon":true}},{"columnMatch":"ParentId","formatter":5,"formatOptions":{"showIcon":true}}],"filter":true,"hierarchySettings":{"idColumn":"Id","parentColumn":"ParentId","treeType":0,"expanderColumn":"Name"}}},"customWidth":"50","name":"query - 16"},{"type":3,"content":{"version":"KqlItem/1.0","query":"CommonSecurityLog\\r\\n| where DeviceProduct == \\"NSSWeblog\\"\\r\\n| where DeviceEventClassID !contains \\"Allow\\" \\r\\n| where DestinationServiceName != \\"generalbrowsing\\"\\r\\n| summarize count() by DestinationServiceName, bin(TimeGenerated, {TimeRange:grain})","size":0,"exportToExcelOptions":"visible","title":"Blocked cloud apps over time","timeContext":{"durationMs":0},"timeContextFromParameter":"TimeRange","queryType":0,"resourceType":"microsoft.operationalinsights/workspaces","visualization":"barchart"},"customWidth":"50","name":"query - 17"}],"fromTemplateId":"sentinel-ZscalerThreats","$schema":"https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"}\r\n'
    version: '1.0'
    sourceId: '${resourceGroup().id}/providers/Microsoft.OperationalInsights/workspaces/${workspace}'
    category: 'sentinel'
    etag: '*'
  }
}
