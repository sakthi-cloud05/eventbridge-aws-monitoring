# 🔔 Event-Driven AWS Infrastructure Monitoring (EventBridge + SNS)

A decoupled, serverless event-driven monitoring architecture built on **Amazon EventBridge** and **Amazon SNS** to capture real-time EC2 instance state transitions (`stopped`, `stopping`, `terminated`, `shutting-down`) and route structured JSON payloads to operations administrators instantly.

---

## 🏗️ Architecture Flow

```mermaid
flowchart LR
    A[Amazon EC2 Instance\nState Change: Stopped/Terminated] -->|Emits System Event| B(Amazon EventBridge\nDefault Event Bus)
    B -->|Matches JSON Pattern| C{EventBridge Rule\ncapture-ec2-critical-state}
    C -->|Routes Raw JSON Payload| D[Amazon SNS Topic\nec2-state-change-alerts]
    D -->|Delivers Instant Alert| E[Operations Admin\nEmail / SMS / Webhook]
