# DnsRecordCname

## Parameters

| Parameter         | Attribute  | DataType   | Description                                                                                                                                                        | Allowed Values |
| ----------------- | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------- |
| **ZoneName**      | *Required* | `[String]` | Specifies the name of a DNS zone. (Key Parameter)                                                                                                                  |                |
| **TimeToLive**    |            | `[String]` | Specifies the TimeToLive value of the SRV record. Value must be in valid TimeSpan string format (i.e.: Days.Hours:Minutes:Seconds.Miliseconds or 30.23:59:59.999). |                |
| **Ensure**        |            | `[String]` | Whether the host record should be present or removed.                                                                                                              |                |
| **Name**          | *Required* | `[String]` | Specifies the name of a DNS server resource record object. (Key Parameter)                                                                                         |                |
| **HostNameAlias** | *Required* | `[String]` | Specifies a a canonical name target for a CNAME record. This must be a fully qualified domain name (FQDN). (Key Parameter)                                         |                |

## Description

The DnsRecordCname DSC resource manages CNAME DNS records against a specific zone on a Domain Name System (DNS) server.
