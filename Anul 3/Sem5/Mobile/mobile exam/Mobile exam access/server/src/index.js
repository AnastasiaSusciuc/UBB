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

const rules = [];
const names = ['entry', 'ground', 'main', 'top'];
const statuses = ['prepared', 'in-use', 'canceled', 'old'];

for (let i = 0; i < 50; i++) {
  rules.push({
    id: i + 1,
    name: names[getRandomInt(0, names.length)],
    level: getRandomInt(1, 10),
    status: statuses[getRandomInt(0, statuses.length)],
    from: getRandomInt(1, 10),
    to: getRandomInt(11, 20)
  });
}

const router = new Router();

router.get('/rules', ctx => {
  ctx.response.body = rules;
  ctx.response.status = 200;
});

const broadcast = (data) =>
  wss.clients.forEach((client) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(data));
    }
  });

router.post('/rule', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.request.body;
  // console.log("body: " + JSON.stringify(headers));
  const name = headers.name;
  const level = headers.level;
  const from = headers.from;
  const to = headers.to;
  if (typeof name !== 'undefined'
    && typeof level !== 'undefined'
    && typeof from !== 'undefined'
    && typeof to !== 'undefined') {
    const index = rules.findIndex(obj => obj.name == name && obj.level == level);
    if (index !== -1) {
      console.log("Rule already exists!");
      ctx.response.body = {text: 'Rule already exists!'};
      ctx.response.status = 404;
    } else {
      let maxId = Math.max.apply(Math, rules.map(function (obj) {
        return obj.id;
      })) + 1;
      let obj = {
        id: maxId,
        name,
        level,
        status: statuses[0],
        from,
        to
      };
      // console.log("created: " + JSON.stringify(name));
      rules.push(obj);
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

router.get('/rule/:id', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.params;
  const id = headers.id;
  if (typeof id !== 'undefined') {
    const index = rules.findIndex(obj => obj.id == id);
    if (index === -1) {
      console.log("Rule not available!");
      ctx.response.body = {text: 'Rule not available!'};
      ctx.response.status = 404;
    } else {
      let obj = rules[index];
      ctx.response.body = obj;
      ctx.response.status = 200;
    }
  } else {
    console.log("Missing or invalid: id!");
    ctx.response.body = {text: 'Missing or invalid: id!'};
    ctx.response.status = 404;
  }
});

router.post('/update', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.request.body;
  // console.log("body: " + JSON.stringify(headers));
  const id = headers.id;
  const name = headers.name;
  const level = headers.level;
  const status = headers.status;
  const from = headers.from;
  const to = headers.to;
  if (typeof name !== 'undefined'
    && typeof level !== 'undefined'
    && typeof status !== 'undefined'
    && typeof from !== 'undefined'
    && typeof to !== 'undefined') {
    const index = rules.findIndex(obj => obj.id == id);
    if (index === -1) {
      console.log("Rule not available!");
      ctx.response.body = {text: 'Rule not available!'};
      ctx.response.status = 404;
    } else {
      let obj = rules[index];
      obj.name = name;
      obj.level = level;
      obj.status = status;
      obj.from = from;
      obj.to = to;
      ctx.response.body = obj;
      ctx.response.status = 200;
    }
  } else {
    console.log("Missing or invalid fields!");
    ctx.response.body = {text: 'Missing or invalid fields!'};
    ctx.response.status = 404;
  }
});

router.get('/level/:level', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.params;
  const level = headers.level;
  if (typeof level !== 'undefined') {
    ctx.response.body = rules.filter(obj => obj.level == level);
    ctx.response.status = 200;
  } else {
    console.log("Missing or invalid: level!");
    ctx.response.body = {text: 'Missing or invalid: level!'};
    ctx.response.status = 404;
  }
});

app.use(router.routes());
app.use(router.allowedMethods());

server.listen(8080);