#!/usr/bin/env bash
# ==============================================================================
# Script Name: deploy-cli.sh
# Description: Automates SNS topic creation and EventBridge EC2 alert rule setup
# Author:      Sakthivel
# ==============================================================================

set -euo pipefail

REGION="ap-south-1"
TOPIC_NAME="ec2-state-change-alerts"
RULE_NAME="capture-ec2-critical-state-changes"
ADMIN_EMAIL="your-email@example.com"

echo "[1/4] Creating SNS Topic..."
TOPIC_ARN=$(aws sns create-topic --name "$TOPIC_NAME" --region "$REGION" --query 'TopicArn' --output text)
echo "Created Topic ARN: $TOPIC_ARN"

echo "[2/4] Subscribing Admin Email to SNS Topic..."
aws sns subscribe \
  --topic-arn "$TOPIC_ARN" \
  --protocol email \
  --notification-endpoint "$ADMIN_EMAIL" \
  --region "$REGION"

echo "[3/4] Creating EventBridge Rule for EC2 State Changes..."
aws events put-rule \
  --name "$RULE_NAME" \
  --event-pattern file://config/ec2-state-change-rule.json \
  --state ENABLED \
  --description "Triggers alert when EC2 instances stop or terminate" \
  --region "$REGION"

echo "[4/4] Attaching SNS Topic as Target..."
aws events put-targets \
  --rule "$RULE_NAME" \
  --targets "Id"="1","Arn"="$TOPIC_ARN" \
  --region "$REGION"

echo "[SUCCESS] EventBridge monitoring pipeline deployed! Check $ADMIN_EMAIL to confirm SNS subscription."
