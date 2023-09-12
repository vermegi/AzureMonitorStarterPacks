# Pack Authoring

## Pack Structure

A pack is composed of the following components:

| Component name | Description |
| --- | --- |
| [DCRs](../modules/DCRs/) | Data Collection Rules. Only needed for IaaS type monitoring |
| [diagnosticssettings](../modules/diagnosticssettings/) | Diagnostics Settings. Only needed for PaaS type monitoring. |
| [Policies](../modules/policies/) | Policies to assign the DCRs to the VMs |
| [Alerts](../modules/alerts/) | |
| [Workbooks/Grafana Dashboards](../modules/workbooks/) | | 

### Details

## Packs.json structure

The [packs.json](../Packs/packs.json) file defines the available packs. It has the following structure:

![PacksJsonStructure](image-5.png)

| Setting | Description | 
| --- | --- |
| PackName | Pack name |
| RuleName | Name of the DCR to be created in Azure |
| ModuleType | IaaS and PaaS are the only supported type. Use IaaS for VM type monitoring through agents, use PaaS for monitoring through diagnostics settings. |
| Status | Enabled/Disabled. Defines whether the pack will be installed or not during setup |
| RequiredTag | Tag that will be used to assign the DCR to the VMs |
| TemplateLocation | file path to the main bicep file for that pack. The file must be in the Packs folder. |
| osTarget | (not mandatory) Type of OS to monitor. Can be Windows or Linux. Only mandatory when ModuleType is IaaS. |
| DiscoveryType | (not mandatory) Currently not used. Allowed values: OS, PackageName, RoleName |
| RoleName | (not Mandatory) Only used for IaaS type monitoring. |