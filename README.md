# eventbridge-aws-monitoring
eventbridge-aws-monitoring/
├── README.md
├── architecture.png
├── config/
│   ├── ec2-state-change-rule.json   (EventBridge JSON pattern capturing stopped/terminated EC2s)
│   └── sns-topic-policy.json        (IAM/SNS permission policy allowing EventBridge to publish)
└── screenshots/
    ├── eventbridge-rule.png
    └── sns-email-alert.png
