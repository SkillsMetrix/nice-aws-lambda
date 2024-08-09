AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Description: >
  patient DB

  Sample SAM Template for patient

Globals:
  Function:
      Runtime: java11
      MemorySize: 512
      Timeout: 30
     

Resources:
  PatientCheckoutBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Sub ${AWS::StackName}-${AWS::Accountid}-${AWS::Region}
  PatientCheckoutFunction:
    Type: AWS::Serverless::Function # More info about Function Resource: https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md#awsserverlessfunction
    Properties:
      CodeUri: HelloWorldFunction
      Handler: helloworld.BillManagementLambda::handler
      Policies:
        - S3ReadPolicy:
            BucketName: !Sub ${AWS::StackName}-${AWS::Accountid}-${AWS::Region}
      Events:
        S3Events:
          Type: S3
          Properties:
            Bucket: !Ref PatientCheckoutBucket
            Event: s3:ObjectCreated:*
  
