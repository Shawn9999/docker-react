# Docker

### Dockerfile for different environment
* Dockerfile.dev is used for development environment
* Dockerfile is used for production environment

### Duplicate dependencies
* If we `RUN npm install` in creating image, we don't need node_modules in our local project
* we can delete node_modules folder in current project

### Docker Volumes
* create reference in the image to reference back to local folder so that the change of src code can automatically show up in the container.
* docker run -p 3000:3000 -v /app/node_modules -v $(pwd):/app <image_id>
    * `-v $(pwd):/app` maps the pwd into the '/app' folder by folder
    * `-v /app/node_modules` without `:` says don't map back to local folder because there isn't node_modules folder in local

### React App Exited With Code 0
* Recently, a bug was introduced with the latest Create React App version that is causing the React app to exit when starting with Docker Compose.
* To Resolve this:
    * Add stdin_open property to your docker-compose.yml file
```sh
      web:
        stdin_open: true
```
* Make sure you rebuild your containers after making this change with `docker-compose down && docker-compose up --build`

### Run test inside docker  
* Static test `docker run -it 117634b07303 npm run test`
* Live updating test
    * 1st way
        * Use docker-compose that has volume mapping, 
        * start a 2nd process `docker exec -it 93e4c4972521 npm run test`
    * 2nd way
        * Create a separate service only for test in docker-compose.yml
        * cons: cannot do test interactively.

### Multi-Step Docker Builds
* Build Phase
    * FROM node:alpine
    * COPY package.json
    * Install dependencies
    * RUN npm run build
* Run Phase
    * FROM niginx
    * COPY build
    * RUN niginx

### Commands
```sh
    $ docker build -f Dockerfile.dev .    # build for dev
    $ docker run -p 3000:3000 117634b07303
    $ docker run -it -p 3000:3000 CONTAINER_ID
    $ docker run -p 3000:3000 -v /app/node_modules -v $(pwd):/app 117634b07303
    $ docker run -it 117634b07303 npm run test
    $ docker-compose up --build
    $ docker build .                      # build for production 
    $ docker run -p 8080:80 82b89774273a

```

# ###########################################################

# Getting Started with Create React App

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.\
You will also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.\
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can’t go back!**

If you aren’t satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you’re on your own.

You don’t have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn’t feel obligated to use this feature. However we understand that this tool wouldn’t be useful if you couldn’t customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: [https://facebook.github.io/create-react-app/docs/code-splitting](https://facebook.github.io/create-react-app/docs/code-splitting)

### Analyzing the Bundle Size

This section has moved here: [https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size](https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size)

### Making a Progressive Web App

This section has moved here: [https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app](https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app)

### Advanced Configuration

This section has moved here: [https://facebook.github.io/create-react-app/docs/advanced-configuration](https://facebook.github.io/create-react-app/docs/advanced-configuration)

### Deployment

This section has moved here: [https://facebook.github.io/create-react-app/docs/deployment](https://facebook.github.io/create-react-app/docs/deployment)

### `npm run build` fails to minify

This section has moved here: [https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify](https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify)
