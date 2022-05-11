# KC - KayCey

Generate JWTs and authenticate your users with this side-car deployable service.

API documentation can be found here: [hexploits.stoplight.io](https://hexploits.stoplight.io/docs/kaycey/)

[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)

## License

[MIT](https://choosealicense.com/licenses/mit/)

# Environment Variables:

- JWT_GENERATOR_SECRET - The secret that will be used to genereate your JWTs.
- KC_PORT - The service port where requests will be received.
- PG_HOST - The host / ip address of your postgres instance.
- PG_DATABASE - The database name of your postgres instance.
- PG_USERNAME - The username for your postgres instance.
- PG_PASSWORD - THe password for your postgres instance.
- KC_UI_ADMIN_USERNAME - The username to access the UI. (Not yet available)
- KC_UI_ADMIN_PASSWORD - The password to access the UI. (Not yet available)