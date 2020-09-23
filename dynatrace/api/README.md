# Dynatrace Automation Samples

## 1. Metric Ingest for Testing Tools

The new Dynatrace Metric Ingest API allows us to send any type of multi-dimensional metrics based on the [Metric ingest protocol](https://www.dynatrace.com/support/help/how-to-use-dynatrace/metrics/metric-ingestion/metric-ingestion-protocol/). 
The dimensions can also include dynatrace entities such as host, service, progress group ... which allows us to send metrics to existing Dynatrace entities.
This is in particular interesting for testing tools such as load testing tools that can send their global test metrics (VUCount, Transaction Rate, Error Rate ...) as well as test transaction metrics (Response Time, Failure Rate, Bytes Sent ... per Transaction) to Dynatrace.

The script loadtest_metricingest.sh shows how to use that metric ingest API. It requires a DT_API_TOKEN, DT_TENANT and DT_SERVICE_ID as it will send some test data points to your Dynatrace Tenant and also allows you to specify a SERVICE-ID as an additional dimension.

```
export DT_API_TOKEN=YOURTOKEN
export DT_TENANT=abc12312.live.dynatrace.com
export DT_SERVICE_ID=SERVICE-B021B9B139D8D7BB
./loadtesting_metricingest.sh
```

The script creates a payload.txt where you can see the actual payload for the REST Call in detail. 
But - best is to simply look into loadtesting_metricingest.sh to see how the API works.

Once the data is in Dynatrace you can use the new Metric explorer to create charts:
![](loadtest_metrics.png)
