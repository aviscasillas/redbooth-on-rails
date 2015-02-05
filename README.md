# RedboothOnRails
This is a stand-alone application example, created to show how authentication and comunication to Redbooth can be implemented.

# Setup
1. First of all, you will need to have a Redobooth account.

2. Go to https://redbooth.com/oauth2/applications/new and register an application.

3. Clone the repo, setup your app credentials and run the server.

```bash
$ git clone git@github.com:aviscasillas/redbooth-on-rails.git
$ cd redbooth-on-rails
$ export REDBOOTH_APP_ID=<your-app-id>
$ export REDBOOTH_APP_SECRET=<your-app-secret>
$ rails s
```

You are ready!
Open your browser and go to *http://localhost:3000*. Enjoy it! ;P
