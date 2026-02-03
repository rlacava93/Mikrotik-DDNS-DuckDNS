############################
# USER CONFIGURATION
############################
:global wanInterface "pppoe-out1"
:global duckDomain   "pde-alegria.duckdns.org"
:global duckToken    "bdb6f2bd-43ac-4b4e-a24c-0d01a990d54d"

############################
# INTERNAL VARIABLES
############################
:global currentIP
:global dnsIP

############################
# Get current public IP from WAN interface
############################
:set currentIP [/ip address get [find interface=$wanInterface] address]
:set currentIP [:pick $currentIP 0 [:find $currentIP "/"]]

############################
# Resolve current DuckDNS record
############################
:do {
    :set dnsIP [:resolve $duckDomain]
} on-error={
    :log warning "DuckDNS: DNS resolve failed, forcing update"
    :set dnsIP "0.0.0.0"
}

############################
# Compare & update DuckDNS
############################
:if ($currentIP != $dnsIP) do={

    :log info ("DuckDNS: updating from ".$dnsIP." to ".$currentIP)

    /tool fetch \
        url=("https://www.duckdns.org/update?domains=".$duckDomain."&token=".$duckToken."&ip=".$currentIP) \
        keep-result=no

} else={
    :log info ("DuckDNS: no update needed, IP ".$currentIP)
}
