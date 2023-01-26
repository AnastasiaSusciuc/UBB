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

const titles = ['Anna Karenina by Lev Tolstoy',
  'Madame Bovary by Gustave Flaubert',
  'War and Peace by Lev Tolstoy',
  'The Great Gatsby by F. Scott Fitzgerald',
  'Lolita by Vladimir Nabokov',
  'Middlemarch by George Eliot',
  'The Adventures of Huckleberry Finn by Mark Twain',
  'The Stories of Anton Chekhov by Anton Chekhov',
  'In Search of Lost Time by Marcel Proust',
  'Hamlet by William Shakespeare'];
const statuses = ['available', 'missing', 'borrowed', 'canceled'];
const students = ['John', 'Joe', 'Jim', 'Jone', 'Joan'];
const books = [];

for (let i = 0; i < 50; i++) {
  books.push({
    id: (i + 1).toString(),
    title: titles[getRandomInt(0, titles.length)],
    status: statuses[getRandomInt(0, statuses.length)],
    student: students[getRandomInt(0, students.length)],
    pages: getRandomInt(200, 2000),
    usedCount: getRandomInt(0, 10)
  });
}

const router = new Router();

router.get('/api/all', ctx => {
  ctx.response.body = books;
  ctx.response.status = 200;
});

router.get('/api/available', ctx => {
  ctx.response.body = books.filter(book => book.status === 'available');
  ctx.response.status = 200;
});


router.get('/api/books/:student', ctx => {
  const headers = ctx.params;
  const student = headers.student;
  if (typeof student !== 'undefined') {
    ctx.response.body = books.filter(book => book.student == student);
    ctx.response.status = 200;
  } else {
    console.log("Missing or invalid: student!");
    ctx.response.body = {text: 'Missing or invalid: student!'};
    ctx.response.status = 404;
  }
});

router.post('/api/borrow', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.request.body;
  // console.log("body: " + JSON.stringify(headers));
  const id = headers.id;
  const student = headers.student;
  if (typeof id !== 'undefined' && typeof student !== 'undefined') {
    const index = books.findIndex(book => book.id == id);
    if (index === -1) {
      console.log("Book not available!");
      ctx.response.body = {text: 'Book not available!'};
      ctx.response.status = 404;
    } else {
      let book = books[index];
      book.student = student;
      book.status = 'borrowed';
      // console.log("student changed: " + JSON.stringify(book));
      ctx.response.body = book;
      ctx.response.status = 200;
    }
  } else {
    console.log("Missing or invalid: id or student!");
    ctx.response.body = {text: 'Missing or invalid: id or student!'};
    ctx.response.status = 404;
  }
});

const broadcast = (data) =>
  wss.clients.forEach((client) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(data));
    }
  });

router.post('/api/book', ctx => {
  // console.log("ctx: " + JSON.stringify(ctx));
  const headers = ctx.request.body;
  // console.log("body: " + JSON.stringify(headers));
  const title = headers.title;
  const student = headers.student;
  const pages = headers.pages;
  const usedCount = headers.usedCount;
  if (typeof title !== 'undefined' && typeof student !== 'undefined'
    && typeof pages !== 'undefined' && usedCount !== 'undefined') {
    const index = books.findIndex(book => book.title == title && book.student == student);
    if (index !== -1) {
      console.log("Book already exists!");
      ctx.response.body = {text: 'Book already exists!'};
      ctx.response.status = 404;
    } else {
      let maxId = Math.max.apply(Math, books.map(function (book) {
        return book.id;
      })) + 1;
      let obj = {
        id: maxId.toString(),
        title,
        status: 'available',
        student,
        pages,
        usedCount
      };
      // console.log("created: " + JSON.stringify(title));
      books.push(obj);
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


app.use(router.routes());
app.use(router.allowedMethods());

server.listen(8080);