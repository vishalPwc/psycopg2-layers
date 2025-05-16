# psycopg2 Lambda Layer for AWS

This repository provides pre-built AWS Lambda layers for [`psycopg2-binary`](https://pypi.org/project/psycopg2-binary/), compiled for:

- Python 3.11
- Python 3.12

The layers are publicly available to be used in AWS Lambda functions for PostgreSQL access without bundling the dependency yourself.

---

## ✅ Public Layer ARNs

| Python Version | Layer ARN (Region: us-east-1) |
|----------------|-------------------------------|
| Python 3.11    | `arn:aws:lambda:us-east-1:<your-account-id>:layer:psycopg2-py311:<version>` |
| Python 3.12    | `arn:aws:lambda:us-east-1:<your-account-id>:layer:psycopg2-py312:<version>` |

> Replace `<your-account-id>` and `<version>` with your actual values (visible in AWS Console after publish).

---

## 🧱 Folder Structure

