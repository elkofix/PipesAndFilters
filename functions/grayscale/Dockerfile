# Usa la imagen oficial de AWS Lambda con Python 3.13
FROM public.ecr.aws/lambda/python:3.13

# Instalar Pillow en /opt/python para que AWS Lambda la reconozca
RUN pip install --no-cache-dir pillow -t /opt/python

# Copiar el código de la Lambda a /var/task
COPY lambda_function.py /var/task/

# Comando de entrada para AWS Lambda
CMD ["lambda_function.lambda_handler"]
