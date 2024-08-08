AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Description: >
  ordersapi

  Sample SAM Template for ordersapi

Globals:
  Function:
      Runtime: java11
      MemorySize: 512
     
      Environment:
        Variables:
          ORDERS_TABLE: !Ref OrdersTable

Resources:
  OrdersTable:
    Type: AWS::Serverless::SimpleTable
    Properties:
      PrimaryKey:
        Name: id
        Type: Number
  CreateOrderFunction:
    Type: AWS::Serverless::Function # More info about Function Resource: https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md#awsserverlessfunction
    Properties:
      CodeUri: HelloWorldFunction
      Handler: com.aws.lamdba.apis.CreateOrderLambda::createOrder
      Policies:
        - DynamoDBCrudPolicy:
            TableName: !Ref OrdersTable
      Events:
        OrderEvents:
          Type: Api
          Properties:
            Path: /orders
            Method: POST
  ReadOrdersFunction:
    Type: AWS::Serverless::Function # More info about Function Resource: https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md#awsserverlessfunction
    Properties:
      CodeUri: HelloWorldFunction
      Handler: com.aws.lamdba.apis.ReadOrdersLambda::getOrders
     
      Events:
        OrderEvents:
          Type: Api
          Properties:
            Path: /orders
            Method: GET
