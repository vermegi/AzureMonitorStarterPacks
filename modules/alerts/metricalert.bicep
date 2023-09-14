@description('the name of the metric alert rule')
param alertrulename string
param location string
param solutionTag string
param packtag string
@description('the resource id that this metric alert is scoped to.')
param resourceId string
@allowed([0,1,2,3,4])
@description('the severity of the alert rule. Defaults to 3.')
param severity int = 3
@allowed([
  'PT1M'
  'PT5M'
  'PT15M'
  'PT30M'
  'PT1H'
])
@description('the frequency at which the alert rule is evaluated in ISO 8601 duration format. Defaults to PT5M, which checks every 5 minutes.')
param evaluationFrequency string = 'PT5M'

@description('the name of the metric to alert on.')
param metricName string
@description('the namespace of the metric to alert on.')
param metricNamespace string 

@allowed([
  'GreaterThan'
  'GreaterThanOrEqual'
  'LessThan'
  'LessThanOrEqual'
])
@description('the operator to use when comparing the metric value against the threshold. Defaults to GreaterThan.')
param operator string = 'GreaterThan'

@allowed([
  'Average'
  'Minimum'
  'Maximum'
  'Total'
  'Count'
])
@description('the aggregation type to use when comparing the metric value against the threshold. Defaults to Average.')
param timeAggregation string = 'Average'

@description('the threshold value to compare the metric value against.')
param threshold int

param metricDescription string = 'Metric Alert for ${metricName} on ${resourceId}'

@description('the resource id of the action group to use when the alert is triggered.')
param actionGroupResourceId string

@allowed([
  'PT1M'
  'PT5M'
  'PT15M'
  'PT30M'
  'PT1H'
])
@description('the time window to use when evaluating the metric alert in ISO 8601 duration format. Defaults to PT5M, which checks every 5 minutes.')
param windowSize string = 'PT5M'

resource metricalert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: alertrulename
  location: location
  tags: {
    '${solutionTag}': packtag
  }
  properties: {
    actions: [
      {
        actionGroupId: actionGroupResourceId
      }
    ]
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          metricName: metricName
          name: metricName
          operator: operator
          threshold: threshold
          timeAggregation: timeAggregation
          metricNamespace: metricNamespace
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    description: metricDescription
    enabled: true
    evaluationFrequency: evaluationFrequency
    scopes: [
      resourceId
    ]
    severity: severity
    windowSize: windowSize
  }
}
