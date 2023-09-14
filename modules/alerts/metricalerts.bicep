param alertlist array
param location string
param AGId string
param packtag string
param solutionTag string
param moduleprefix string

module Alerts './metricalert.bicep' = [for (alert,i) in alertlist:  {
  name: '${packtag}-Alert-${i}'
  params: {
    alertrulename: '${moduleprefix}-${alert.alertRuleName}'
    location: location
    solutionTag: solutionTag
    packtag: packtag
    resourceId: alert.resourceId
    severity: alert.severity
    evaluationFrequency: alert.evaluationFrequency
    metricName: alert.metricName
    metricNamespace: alert.metricNamespace
    operator: alert.operator
    timeAggregation: alert.timeAggregation
    threshold: alert.threshold
    actionGroupResourceId: AGId
    windowSize: alert.windowSize
  }
}]
