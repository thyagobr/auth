# Auth

This service aims to remove the need to keep creating Authentication strcutures from simple prototypes I'm building.

Simple manually create the App and the User entries, and copy the generated token to the client app.

The client app can then use a `POST /api/login` passing:

```
{
  "email": "...",
  "password": "..."
}
```

...and it will be validated (or not).
