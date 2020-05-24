# Streaming Finance Data with AWS Lambda

## DataCollector

### Lambda Function URL

### Lambda Function Source Code

- API endpoint: https://1253iy35aa.execute-api.us-east-1.amazonaws.com/default/finance-stream-collector

- `data_collector.py`

```
import json
import boto3
import os
import subprocess
import sys

subprocess.check_call([sys.executable, "-m", "pip", "install", "--target", "/tmp", 'yfinance'])
sys.path.append('/tmp')

import yfinance as yf

tickers = ['FB', 'SHOP', 'BYND', 'NFLX', 'PINS', 'SQ', 'TTD', 'OKTA', 'SNAP', 'DDOG']
start = '2020-05-14'
end = '2020-05-15'

def lambda_handler(event, context):
    fh = boto3.client("firehose", "us-east-1")
    for ticker in tickers:
        data = yf.download(ticker, start=start, end=end, interval = "1m")
        for datetime, row in data.iterrows():
            output = {'name': ticker}
            output['high'] = row['High']
            output['low'] = row['Low']
            output['ts'] = str(datetime)
            as_jsonstr = json.dumps(output)
            fh.put_record(
                DeliveryStreamName="finance-stream", 
                Record={"Data": as_jsonstr.encode('utf-8')})
    return {
        'statusCode': 200,
        'body': json.dumps(f'Done! Recorded: {as_jsonstr}')
    }
```

## DataTransformer

### AWS Kinesis Firehose Delivery Stream 

- Monitoring Page



## DataAnalyzer

- `query.sql`

```

```

- `results.csv`
