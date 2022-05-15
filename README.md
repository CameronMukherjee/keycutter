# KeyCutter Docs:

# What is KeyCutter?

Key cutter is a side-car deployable authentication service. It works in conjunction with your pre-existing services.
KeyCutter dispatches RBAC compliant JSON web tokens, allowing you to focus on developing features and not
authentication.

# Key Features:

- System and user management via UI.
- Email triggers for new users and password resets, email templates are customisable.
- Web-hook triggers for events.
- Retention periods for logs including deleting or archiving to AWS S3.
- KeyCutter has native bindings in Java, C#, Go and Typescript.
- Interface via REST (hexploits.stoplight.io) or native bindings (Java, C#, Go and Typescript).

# KeyCutter Environment Variables:

| Key                     | Description                                                                       | Default Value   | Options                                                    |
|-------------------------|-----------------------------------------------------------------------------------|-----------------|------------------------------------------------------------|
| KC_PORT                 | The service port                                                                  | 7314            | Integer                                                    |
| KC_ENV                  | The environment of the system.                                                    | local           | local / prod                                               |
| KC_EMAIL_PROVIDER       | The email provider.                                                               | none            | none / ses                                                 |
| KC_EMAIL_SENDER         | The email address that will be used when sending emails.                          | none            | Email address                                              |
| KC_UI_ADMIN_USERNAME    | The username to login to the admin dashboard                                      | operations      | String                                                     |
| KC_UI_ADMIN_PASSWORD    | The password to login to the admin dashboard                                      | operations      | String                                                     |
| KC_LOGS_LOGIN_PERIOD    | How long should login logs stay in the system?                                    | 365             | Integer value                                              |
| KC_LOGS_LOGIN_STRATEGY  | What should be done once login logs surpass the amount of retention days?         | none            | none / delete / s3                                         |
| KC_LOGS_EVENTS_PERIOD   | How long should event logs stay in the system?                                    | 365             | Integer value                                              |
| KC_LOGS_EVENTS_STRATEGY | What should be done once event logs surpass the amount of retention days?         | none            | none / delete / s3                                         |
| AWS_REGION              | What region would you like SES and S3 to function in?                             | none            | String value representing AWS region. London is: eu-west-2 |
| AWS_ACCESS_KEY_ID       | The AWS access key for your account. Requires permissions for AWS SES and AWS S3. | none            | String                                                     |
| AWS_SECRET_KEY          | The AWS secret key for your account. Requires permissions for AWS SES and AWS S3. | none            | String                                                     |
| AWS_S3_BUCKET           | The bucket name to store archived logs.                                           | keycutter       | String                                                     |
| PG_HOST                 | The Postgres database url                                                         | localhost       | String                                                     |
| PG_PORT                 | The Postgres database port                                                        | 5432            | Integer                                                    |
| PG_DATABASE             | The Postgres database db name.                                                    | keycutter       | String                                                     |
| PG_USERNAME             | The Postgres database username                                                    | postgres        | String                                                     |
| PG_PASSWORD             | The Postgres database password                                                    | SECURE_PASSWORD | String                                                     |
| JWT_GENERATOR_SECRET    | The signing secret for JSON web tokens.                                           | SECURE_PASSWORD | String                                                     |

### KC_ENV:

| Option | Description                                  |
|--------|----------------------------------------------|
| local  | Emails and web-hooks will NOT be dispatched. |
| prod   | Emails and web-hooks will be dispatched.     |

### KC_LOGS_*_STRATEGY:

| Option | Description                                                                           |
|--------|---------------------------------------------------------------------------------------|
| none   | Do nothing when the KC_LOGS_EVENTS_PERIOD is met.                                     |
| delete | Delete logs that have existed for longer than KC_LOGS_EVENTS_PERIOD days.             |
| s3     | Archive logs to AWS S3 that have existed for longer than KC_LOGS_EVENTS_PERIOD` days. |

### KC_EMAIL_SENDER:

If KC_EMAIL_PROVIDER has been set ensure the email address provided here is setup correctly with the provider. If the
email is not authorised errors will occur at runtime.