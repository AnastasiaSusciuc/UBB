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

const exams = [];
const names = ['exam', 'test', 'lab'];
const groups = ['931', '932', '933', '934', '935', '936', '937'];
const statuses = ['draft', 'pending', 'ready', 'canceled', 'done'];
const types = ['license', 'master', 'unk'];

for (let i = 0; i < 50; i++) {
  exams.push({
    id: i + 1,
    name: names[getRandomInt(0, names.length)],
    group: groups[getRandomInt(0, groups.length)],
    details: "just details",
    status: statuses[getRandomInt(0, statuses.length)],
    students: getRandomInt(2, 20),
    type: types[getRandomInt(0, types.length)]
  });
}

const router = new Router();

router.get('/exams', ctx => {
  ctx.response.body = exams;
  ctx.response.status = 200;
});

const broadcast = (data) =>
  wss.clients.forEach((client) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(data));
    }
  });

router.post('/exam', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.request.body;
  // console.log("body: " + JSON.stringify(headers));
  const name = headers.name;
  const group = headers.group;
  const details = headers.details;
  const type = headers.type;
  if (typeof name !== 'undefined'
    && typeof group !== 'undefined'
    && typeof details !== 'undefined'
    && typeof type !== 'undefined') {
    const index = exams.findIndex(obj => obj.name == name && obj.group == group && obj.type == type);
    if (index !== -1) {
      console.log("Exam already exists!");
      ctx.response.body = {text: 'Exam already exists!'};
      ctx.response.status = 404;
    } else {
      let maxId = Math.max.apply(Math, exams.map(function (obj) {
        return obj.id;
      })) + 1;
      let obj = {
        id: maxId,
        name,
        group,
        details,
        status: 'draft',
        students: 0,
        type
      };
      // console.log("created: " + JSON.stringify(name));
      exams.push(obj);
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

router.get('/exam/:id', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.params;
  const id = headers.id;
  if (typeof id !== 'undefined') {
    const index = exams.findIndex(order => order.id == id);
    if (index === -1) {
      console.log("Exam not available!");
      ctx.response.body = {text: 'Exam not available!'};
      ctx.response.status = 404;
    } else {
      let obj = exams[index];
      ctx.response.body = obj;
      ctx.response.status = 200;
    }
  } else {
    console.log("Missing or invalid: id!");
    ctx.response.body = {text: 'Missing or invalid: id!'};
    ctx.response.status = 404;
  }
});

router.get('/draft', ctx => {
  ctx.response.body = exams.filter(obj => obj.status === statuses[0])
  ctx.response.status = 200;
});

router.post('/join', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.request.body;
  // console.log("body: " + JSON.stringify(headers));
  const id = headers.id;
  if (typeof id !== 'undefined') {
    const index = exams.findIndex(obj => obj.id == id);
    if (index === -1) {
      console.log("Exam not available!");
      ctx.response.body = {text: 'Exam not available!'};
      ctx.response.status = 404;
    } else {
      let obj = exams[index];
      obj.students += 1;
      ctx.response.body = obj;
      ctx.response.status = 200;
    }
  } else {
    console.log("Missing or invalid id!");
    ctx.response.body = {text: 'Missing or invalid id!'};
    ctx.response.status = 404;
  }
});

router.get('/group/:name', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.params;
  const name = headers.name;
  if (typeof name !== 'undefined') {
    ctx.response.body = exams.filter(obj => obj.group == name);
    ctx.response.status = 200;
  } else {
    console.log("Missing or invalid: group name!");
    ctx.response.body = {text: 'Missing or invalid: group name!'};
    ctx.response.status = 404;
  }
});

app.use(router.routes());
app.use(router.allowedMethods());

server.listen(8080);