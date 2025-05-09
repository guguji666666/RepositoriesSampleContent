param workspace string

resource workspace_UnusualNumberofRepositoryClones 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  name: '${workspace}/UnusualNumberofRepositoryClones'
  location: resourceGroup().location
  properties: {
    eTag: '*'
    displayName: 'GitHub Repo Clone - Time Series Anomly'
    category: 'Hunting Queries'
    query: '\nlet min_t = toscalar(GitHubRepo\n| summarize min(timestamp_t));\nlet max_t = toscalar(GitHubRepo\n| summarize max(timestamp_t));\nGitHubRepo\n| where Action == "Clones"\n| distinct TimeGenerated, Repository, Count\n| make-series num=sum(tolong(Count)) default=0 on TimeGenerated in range(min_t, max_t, 1h) by Repository \n| extend (anomalies, score, baseline) = series_decompose_anomalies(num, 1.5, -1, \'linefit\')\n| render timechart \n'
    version: 1
    tags: [
      {
        name: 'description'
        value: 'Attacker can exfiltrate data from you GitHub repository after gaining access to it by performing clone action. This hunting queries allows you to track the clones activities for each of your repositories. The visualization allow you to quic'
      }
      {
        name: 'tactics'
        value: 'Collection'
      }
      {
        name: 'relevantTechniques'
        value: 'T1213'
      }
    ]
  }
}
