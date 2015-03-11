# puppet-nxlog

#### Table of Contents
1. [Overview](#overview)
2. [Description](#description)
3. [Dependencies](#dependencies)
4. [Development](#development)

## Overview
This is a very simple module that will install nxlog on a Windows host and then point all System, Security, and Application logs to a logstash host for indexing.

## Description
In params.pp you should update variable to meet your needs. Example:  
class nxlog::params {  
  $nxlog_version = '2.8.1248'  
  $logstash_dest = '192.168.10.10'  
  $logstash_dest_port = '3515'  
  $service_enabled = 'true'  
}  

## Dependencies
windows_facts - https://github.com/Simspace/puppet-windows_facts  
nxlog installer in the files directory.  
