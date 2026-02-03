############################
# USER CONFIGURATION
############################
:global wanInterface "pppoe-out1"
:global duckDomain   "DOMAIN.duckdns.org"
:global duckToken    "DUCKDNS-TOKEN"

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
    :log error ("DuckDNS: DNS resolution failed for ".$duckDomain.", skipping update")
    :return
}

# Sanity check (extra safety)
:if ($dnsIP = "0.0.0.0") do={
    :log error "DuckDNS: resolved IP is 0.0.0.0, skipping update"
    :return
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
