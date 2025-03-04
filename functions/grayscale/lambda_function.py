import boto3
import json
from PIL import Image
import io

s3 = boto3.client('s3')
sqs = boto3.client('sqs')

FILTER_QUEUES = {
    "resize": "https://sqs.us-east-1.amazonaws.com/108782067557/resize_queue",
    "grayscale": "https://sqs.us-east-1.amazonaws.com/108782067557/grayscale_queue",
    "invert": "https://sqs.us-east-1.amazonaws.com/108782067557/invert_queue",
    "sms": "https://sqs.us-east-1.amazonaws.com/108782067557/sms_queue"
}

def lambda_handler(event, context):
    record = json.loads(event['Records'][0]['body'])
    bucket = record['bucket']
    key = record['key']
    filters = record['filters']

    if not filters:
        return

    # Descargar imagen
    response = s3.get_object(Bucket=bucket, Key=key)
    img = Image.open(io.BytesIO(response['Body'].read()))

    # Aplicar filtro Grayscale
    img = img.convert("L")

    # Guardar imagen en S3
    buffer = io.BytesIO()
    img.save(buffer, format="PNG")
    buffer.seek(0)
    new_key = f"processed/grayscale_{key.split('/')[-1]}"
    s3.put_object(Bucket=bucket, Key=new_key, Body=buffer)

    # Enviar a la siguiente cola si hay más filtros
    filters.pop(0)
    if filters:
        next_queue = FILTER_QUEUES[filters[0]]
        message = {"bucket": bucket, "key": new_key, "filters": filters}
        sqs.send_message(QueueUrl=next_queue, MessageBody=json.dumps(message))

    return {"status": "grayscale aplicado"}
