param workspace string

@description('Unique id for the scheduled alert rule')
@minLength(1)
param analytic_id string = 'a924b93b-f326-4a1d-9520-6abba9bad3de'

resource workspace_Microsoft_SecurityInsights_analytic_id 'Microsoft.OperationalInsights/workspaces/providers/alertRules@2020-01-01' = {
  name: '${workspace}/Microsoft.SecurityInsights/${analytic_id}'
  kind: 'Scheduled'
  location: resourceGroup().location
  properties: {
    description: 'Identifies a list of internal Source IPs (10.x.x.x Hosts) that have triggered 10 or more non-graceful tcp server resets from one or more Destination IPs which \nresults in an "ApplicationProtocol = incomplete" designation. The server resets coupled with an "Incomplete" ApplicationProtocol designation can be an indication \nof internal to external port scanning or probing attack. \nReferences: https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000ClUvCAK and\nhttps://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000ClTaCAK'
    displayName: 'Palo Alto - possible internal to external port scanning'
    enabled: false
    query: '\nCommonSecurityLog \n| where isnotempty(DestinationPort) and DeviceAction !in ("reset-both", "deny") \n// filter out common usage ports. Add ports that are legitimate for your environment\n| where DestinationPort !in ("443", "53", "389", "80", "0", "880", "8888", "8080")\n| where ApplicationProtocol == "incomplete" \n// filter out IANA ephemeral or negotiated ports as per https://en.wikipedia.org/wiki/Ephemeral_port\n| where DestinationPort !between (toint(49512) .. toint(65535)) \n| where Computer != "" \n| where DestinationIP !startswith "10."\n// Filter out any graceful reset reasons of AGED OUT which occurs when a TCP session closes with a FIN due to aging out. \n| where AdditionalExtensions !has "reason=aged-out" \n// Filter out any TCP FIN which occurs when a TCP FIN is used to gracefully close half or both sides of a connection.\n| where AdditionalExtensions !has "reason=tcp-fin" \n// Uncomment one of the following where clauses to trigger on specific TCP reset reasons\n// See Palo Alto article for details - https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000ClUvCAK\n// TCP RST-server - Occurs when the server sends a TCP reset to the client\n// | where AdditionalExtensions has "reason=tcp-rst-from-server"  \n// TCP RST-client - Occurs when the client sends a TCP reset to the server\n// | where AdditionalExtensions has "reason=tcp-rst-from-client"  \n| extend reason = tostring(split(AdditionalExtensions, ";")[3])\n| summarize StartTimeUtc = min(TimeGenerated), EndTimeUtc = max(TimeGenerated), count() by DeviceName, SourceUserID, SourceIP, ApplicationProtocol, reason, DestinationPort, Protocol, DeviceVendor, DeviceProduct, DeviceAction, DestinationIP\n| where count_ >= 10\n| summarize StartTimeUtc = min(StartTimeUtc), EndTimeUtc = max(EndTimeUtc), makeset(DestinationIP), totalcount = sum(count_) by DeviceName, SourceUserID, SourceIP, ApplicationProtocol, reason, DestinationPort, Protocol, DeviceVendor, DeviceProduct, DeviceAction\n| extend timestamp = StartTimeUtc, IPCustomEntity = SourceIP, AccountCustomEntity = SourceUserID, HostCustomEntity = DeviceName \n'
    queryFrequency: 'PT1H'
    queryPeriod: 'PT1H'
    severity: 'Low'
    suppressionDuration: 'PT1H'
    suppressionEnabled: false
    triggerOperator: 'GreaterThan'
    triggerThreshold: 0
    tactics: [
      'Discovery'
    ]
  }
}
