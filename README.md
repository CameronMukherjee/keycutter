# What is KeyCutter?

Key cutter is a side-car deployable authentication service. It works in conjunction with your pre-existing services.
KeyCutter dispatches RBAC enabled JSON web tokens, allowing you to focus on developing features and not authentication.

# Key Features:

- System and user management via UI - coming soon.
- Email triggers for new users and password resets, email templates are customisable.
- Web-hook triggers for events.
- Retention periods for logs including deleting or archiving to AWS S3.
- Interface via REST ([https://hexploits.stoplight.io](https://hexploits.stoplight.io/docs/KeyCutter/)) or native
  bindings (Java, C#, Go and Typescript) - coming soon.

# Getting Started:

**Docker container is available
at: [https://hub.docker.com/r/hexploits/keycutter](https://hub.docker.com/r/hexploits/keycutter)**

The easiest way to get started with KeyCutter would be utilising Docker to run the container image. This can be done in
a standalone environment or via docker-compose (which is what we recommend).

### **Standalone Container Example:**

```bash
docker run --name keycutter -p 7314:7314 \
-e KC_ENV=prod \
-e KC_EMAIL_SENDER=info@hexploits.com \
-e KC_EMAIL_PROVIDER=SES \
-e KC_LOGS_LOGIN_STRATEGY=delete \
-e KC_LOGS_LOGIN_PERIOD=14 \
-e KC_LOGS_EVENTS_STRATEGY=s3 \
-e KC_LOGS_EVENTS_PERIOD=30 \
-e AWS_REGION=eu-west-2 \
-e AWS_ACCESS_KEY_ID=3x4mpl3_k3y \
-e AWS_SECRET_KEY=3x4mple3_s3cr3t_k3y \
-e AWS_S3_BUCKET=keycutter \
-e PG_HOST=127.0.0.1 \
-e PG_PORT=5432 \
-e PG_DATABASE=keycutter \
-e PG_USERNAME=myusername \
-e PG_PASSWORD=MY_SECURE_PASSWORD \
-e JWT_GENERATOR_SECRET=MY_SUPER_SECRET_PASSWORD \
hexploits/keycutter:main
```

### **Docker Compose Example:**

**Can also be found
here: [https://github.com/hexploits/KC/blob/main/docker-compose.yml](https://github.com/hexploits/KC/blob/main/docker-compose.yml)**

```yaml
version: "3.9"
services:
  keycutter:
    restart: always
    image: "hexploits/keycutter"
    networks:
      - keycutter-network
    ports:
      - "7314:7314"
    depends_on:
      - database
    environment:
      - KC_PORT=7314
      - KC_ENV=prod
      - KC_EMAIL_PROVIDER=ses
      - KC_EMAIL_SENDER=info@hexploits.com
      - KC_UI_ADMIN_USERNAME=operations
      - KC_UI_ADMIN_PASSWORD=operations
      - KC_LOGS_LOGIN_PERIOD=365
      - KC_LOGS_LOGIN_STRATEGY=delete
      - KC_LOGS_EVENTS_PERIOD=365
      - KC_LOGS_EVENTS=STRATEGY=delete
      - AWS_REGION=eu-west-2
      - AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY
      - AWS_SECRET_KEY=YOUR_SECRET
      - AWS_S3_BUCKET=keycutter
      - PG_HOST=database
      - PG_PORT=5432
      - PG_DATABASE=keycutter
      - PG_USERNAME=keycutter
      - PG_PASSWORD=SECURE_PASSWORD
      - JWT_GENERATOR_SECRET=YOUR_SECURE_SECRET
      -JWT_TOKEN_EXPIRATION=86400

  database:
    restart: always
    image: "postgres"
    networks:
      - keycutter-network
    ports:
      - "5432:5432"
    environment:
      - POSTGRES_USER=keycutter
      - POSTGRES_DB=keycutter
      - POSTGRES_PASSWORD=SECURE_PASSWORD

networks:
  keycutter-network:
    driver: bridge
```

To start using KeyCutter, include your service in the compose file and ensure they’re on the same network. In this case
the network is called ‘keycutter-network’.

# Getting the most out of KeyCutter:

If you’re trying to get the most out of key cutter we really advise you do the following:

### Email - AWS SES Integration:

1. Create an IAM user with programmatic access via AWS and provide the access key and secret access key to the
   configuration. Ensure this key has policies for AWS SES.
2. Ensure you have a valid email connected to AWS SES - might require clicking on a URL in your inbox.
3. Ensure your AWS SES instance is in a production environment and not sandbox (might require filling out a form on the
   AWS SES dashboard).
4. An example of the environment variables you would want to pass into the system could be:
    1. AWS_REGION=eu-west-2
    2. AWS_ACCESS_KEY_ID=xxxxxxxxxx
    3. AWS_SECRET_KEY=xxxxxxxxx
    4. KC_EMAIL_PROVIDER=ses
    5. KC_EMAIL_SENDER=yourSesVerifiedEmail@example.com

### Log Retention - AWS S3 Integration:

1. Create an IAM user with programmatic access via AWS and provide the access key and secret access key to the
   configuration. Ensure this key has policies for AWS S3.
2. Ensure you have created a bucket for KeyCutter to store logs in, KeyCutter expects this to be ‘keycutter’ by default
   however this can be changed via the environment variables.
3. An example of the environment variables you would want to pass into the system could be:
    1. AWS_REGION_eu-west-2
    2. AWS_ACCESS_KEY_ID=xxxxxxxxxx
    3. AWS_SECRET_KEY=xxxxxxxxx
    4. AWS_S3_BUCKET=keycutter
    5. KC_LOGS_EVENTS_PERIOD=30
    6. KC_LOGS_EVENTS_STRATEGY=s3
    7. KC_LOGS_LOGIN_PERIOD=30
    8. KC_LOGS_LOGIN_STRATEGY=s3

In this example you can see that for both event logs and login logs we want to archive them to S3 after 30 days, as you
can see these can be independently adjusted for your need. If you would like to keep them within the system replace ‘s3’
with ‘none’, if you would like to delete them instead simply replace 's3’ with ‘delete’. More documentation about this
feature can be found near the bottom of this doc.

# KeyCutter Environment Variables:

| Key                     | Description                                                                       | Default Value                  | Options                                                    |
|-------------------------|-----------------------------------------------------------------------------------|--------------------------------|------------------------------------------------------------|
| KC_PORT                 | The service port                                                                  | 7314                           | Integer                                                    |
| KC_ENV                  | The environment of the system.                                                    | local                          | local / prod                                               |
| KC_EMAIL_PROVIDER       | The email provider.                                                               | none                           | none / ses                                                 |
| KC_EMAIL_SENDER         | The email address that will be used when sending emails.                          | none                           | Email address                                              |
| KC_UI_ADMIN_USERNAME    | The username to login to the admin dashboard                                      | operations                     | String                                                     |
| KC_UI_ADMIN_PASSWORD    | The password to login to the admin dashboard                                      | operations                     | String                                                     |
| KC_LOGS_LOGIN_PERIOD    | How long should login logs stay in the system?                                    | 365                            | Integer value                                              |
| KC_LOGS_LOGIN_STRATEGY  | What should be done once login logs surpass the amount of retention days?         | none                           | none / delete / s3                                         |
| KC_LOGS_EVENTS_PERIOD   | How long should event logs stay in the system?                                    | 365                            | Integer value                                              |
| KC_LOGS_EVENTS_STRATEGY | What should be done once event logs surpass the amount of retention days?         | none                           | none / delete / s3                                         |
| AWS_REGION              | What region would you like SES and S3 to function in?                             | none                           | String value representing AWS region. London is: eu-west-2 |
| AWS_ACCESS_KEY_ID       | The AWS access key for your account. Requires permissions for AWS SES and AWS S3. | none                           | String                                                     |
| AWS_SECRET_KEY          | The AWS secret key for your account. Requires permissions for AWS SES and AWS S3. | none                           | String                                                     |
| AWS_S3_BUCKET           | The bucket name to store archived logs.                                           | keycutter                      | String                                                     |
| PG_HOST                 | The Postgres database url                                                         | localhost                      | String                                                     |
| PG_PORT                 | The Postgres database port                                                        | 5432                           | Integer                                                    |
| PG_DATABASE             | The Postgres database db name.                                                    | keycutter                      | String                                                     |
| PG_USERNAME             | The Postgres database username                                                    | postgres                       | String                                                     |
| PG_PASSWORD             | The Postgres database password                                                    | SECURE_PASSWORD                | String                                                     |
| JWT_TOKEN_SECRET        | The signing secret for JSON web tokens.                                           | iiiiiiiiiiiiiiiiiiiiiiiiiiiiii | String - String value of at-least 256 bits                 |
| JWT_TOKEN_EXPIRATION    | How long should the JWT be valid once a user logs in?                             | 86400                          | Integer value representing seconds                         |

### KC_ENV:

| Option | Description                                  |
|--------|----------------------------------------------|
| local  | Emails and web-hooks will NOT be dispatched. |
| prod   | Emails and web-hooks will be dispatched.     |

### KC_LOGS_*_STRATEGY:

| Option | Description                                                                     |
|--------|---------------------------------------------------------------------------------|
| none   | Do nothing when the KC_LOGS_*_PERIOD is met.                                    |
| delete | Delete logs that have existed for longer than KC_LOGS_*_PERIOD days.            |
| s3     | Archive logs to AWS S3 that have existed for longer than KC_LOGS_*_PERIOD days. |

### KC_EMAIL_SENDER:

If KC_EMAIL_PROVIDER has been set ensure the email address provided here is set up correctly with the provider. If the
email is not authorised errors will occur at runtime.