param location string
param workspaceId string
param AGId string
param packtag string
param solutionTag string
param solutionVersion string
param moduleprefix string = 'AMSP-VWAN'
// Alert list

var logqueryalertlist = [

]

module alertsnew '../../../modules/alerts/alerts.bicep' = {
  name: '${moduleprefix}-Alerts'
  params: {
    alertlist: logqueryalertlist
    AGId: AGId
    location: location
    moduleprefix: moduleprefix
    packtag: packtag
    solutionTag: solutionTag
    solutionVersion: solutionVersion
    workspaceId: workspaceId
  }
}

var metricsalertlist = [
  {
    alertrulename: 'AzMPacks-tunnel-drop_Alert'
    metricName: 'Tunnel Egress/Ingress Packet drop count'
    operator: 'GreaterThan' //default
    threshold: 1
    evaluationFrequency: 'PT5M' //default
    windowSize: 'PT5M' //default
    metricNamespace: 'Microsoft.Compute/virtualMachines' //default
    location: 'global'
    packtag: packtag
    solutionTag: solutionTag    
  }
]

module metricalertsnew '../../../modules/alerts/metricalerts.bicep' = {
  name: '${moduleprefix}-Alerts'
  params: {
    alertlist: metricsalertlist
    AGId: AGId
    location: location
    moduleprefix: moduleprefix
    packtag: packtag
    solutionTag: solutionTag
  }
}

