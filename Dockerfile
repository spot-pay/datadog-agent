# 7.84.6 is the first release whose embedded CA bundle and Python both reject
# the compromised eMudhra intermediates. Render only rebuilds on a commit, so a
# floating tag stays on whatever version the last build pulled.
FROM datadog/agent:7.84.6@sha256:4aa71f1f624e36ed4d04568e4ad3f323af14426db07d2f9ed98869f6d0bdbbd3

# disable autoconfigured checks; DD container checks
# do not work as-is on Render since there's no access
# to Kubelet/kube-state-metrics.
ENV DD_AUTOCONFIG_FROM_ENVIRONMENT=false

ENV NON_LOCAL_TRAFFIC=true
ENV DD_LOGS_STDOUT=yes

ENV DD_APM_ENABLED=true
ENV DD_APM_NON_LOCAL_TRAFFIC=true

ENV DD_DOGSTATSD_NON_LOCAL_TRAFFIC=true
ENV DD_PROCESS_AGENT_ENABLED=true

# Automatically set by Render
ARG RENDER_SERVICE_NAME=datadog

ENV DD_BIND_HOST=$RENDER_SERVICE_NAME
ENV DD_HOSTNAME=$RENDER_SERVICE_NAME
