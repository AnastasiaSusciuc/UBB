var koa = require('koa');
var app = module.exports = new koa();
const server = require('http').createServer(app.callback());
const WebSocket = require('ws');
const wss = new WebSocket.Server({server});
const Router = require('koa-router');
const cors = require('@koa/cors');
const bodyParser = require('koa-bodyparser');

app.use(bodyParser());

app.use(cors());

app.use(middleware);

function middleware(ctx, next) {
  const start = new Date();
  return next().then(() => {
    const ms = new Date() - start;
    console.log(`${start.toLocaleTimeString()} ${ctx.request.method} ${ctx.request.url} ${ctx.response.status} - ${ms}ms`);
  });
}


const getRandomInt = (min, max) => {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min)) + min;
};

const spaces = [];
const names = ['A', 'B', 'C'];
const statuses = ['free', 'taken'];

for (let i = 0; i < 50; i++) {
  spaces.push({
    id: i + 1,
    number: names[getRandomInt(0, names.length)] + i,
    address: "location " + getRandomInt(1, 10),
    status: statuses[getRandomInt(0, statuses.length)],
    count: 0,
  });
}

const router = new Router();

router.get('/spaces', ctx => {
  ctx.response.body = spaces;
  ctx.response.status = 200;
});

const broadcast = (data) =>
  wss.clients.forEach((client) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(data));
    }
  });

router.post('/space', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.request.body;
  // console.log("body: " + JSON.stringify(headers));
  const number = headers.number;
  const address = headers.address;
  if (typeof number !== 'undefined'
    && typeof address !== 'undefined') {
    const index = spaces.findIndex(obj => obj.number == number);
    if (index !== -1) {
      console.log("Space already exists!");
      ctx.response.body = {text: 'Space already exists!'};
      ctx.response.status = 404;
    } else {
      let maxId = Math.max.apply(Math, spaces.map(function (obj) {
        return obj.id;
      })) + 1;
      let obj = {
        id: maxId,
        number,
        address,
        status: statuses[0],
        count: 0
      };
      // console.log("created: " + JSON.stringify(name));
      spaces.push(obj);
      broadcast(obj);
      ctx.response.body = obj;
      ctx.response.status = 200;
    }
  } else {
    console.log("Missing or invalid fields!");
    ctx.response.body = {text: 'Missing or invalid fields!'};
    ctx.response.status = 404;
  }
});

router.del('/space/:id', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.params;
  // console.log("body: " + JSON.stringify(headers));
  const id = headers.id;
  if (typeof id !== 'undefined') {
    const index = spaces.findIndex(obj => obj.id == id);
    if (index === -1) {
      console.log("No space with id: " + id);
      ctx.response.body = {text: 'Invalid space id'};
      ctx.response.status = 404;
    } else {
      let obj = spaces[index];
      spaces.splice(index, 1);
      ctx.response.body = obj;
      ctx.response.status = 200;
    }
  } else {
    ctx.response.body = {text: 'Id missing or invalid'};
    ctx.response.status = 404;
  }
});

router.get('/space/:id', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.params;
  const id = headers.id;
  if (typeof id !== 'undefined') {
    const index = spaces.findIndex(obj => obj.id == id);
    if (index === -1) {
      console.log("Space not available!");
      ctx.response.body = {text: 'Space not available!'};
      ctx.response.status = 404;
    } else {
      let obj = spaces[index];
      ctx.response.body = obj;
      ctx.response.status = 200;
    }
  } else {
    console.log("Missing or invalid: id!");
    ctx.response.body = {text: 'Missing or invalid: id!'};
    ctx.response.status = 404;
  }
});

router.get('/free', ctx => {
  ctx.response.body = spaces.filter(obj => obj.status == statuses[0]);
  ctx.response.status = 200;
});

router.post('/take', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.request.body;
  // console.log("body: " + JSON.stringify(headers));
  const id = headers.id;
  if (typeof id !== 'undefined') {
    const index = spaces.findIndex(obj => obj.id == id);
    if (index === -1) {
      console.log("Space not available!");
      ctx.response.body = {text: 'Space not available!'};
      ctx.response.status = 404;
    } else {
      let obj = spaces[index];
      obj.status = statuses[1];
      obj.count +=1;
      ctx.response.body = obj;
      ctx.response.status = 200;
    }
  } else {
    console.log("Missing or invalid id!");
    ctx.response.body = {text: 'Missing or invalid id!'};
    ctx.response.status = 404;
  }
});

app.use(router.routes());
app.use(router.allowedMethods());

server.listen(8080);
