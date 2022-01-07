# DnsRecordCnameScoped

## Parameters

| Parameter         | Attribute  | DataType   | Description                                                                                                                | Allowed Values |
| ----------------- | ---------- | ---------- | -------------------------------------------------------------------------------------------------------------------------- | -------------- |
| **Name**          | *Required* | `[String]` | Specifies the name of a DNS server resource record object. (Key Parameter)                                                 |                |
| **HostNameAlias** | *Required* | `[String]` | Specifies a a canonical name target for a CNAME record. This must be a fully qualified domain name (FQDN). (Key Parameter) |                |
| **ZoneScope**     | *Required* | `[String]` | Specifies the name of a zone scope. (Key Parameter)                                                                        |                |

## Description

The DnsRecordCnameScoped DSC resource manages CNAME DNS records against a specific zone and zone scope on a Domain Name System (DNS) server.
