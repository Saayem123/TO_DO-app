import Express from 'express'
import taskRouter from './routes/task.js';
import connectDB from './DB/connection.js';
import cors from 'cors';
import notFoundHandler from './middlewares/not-found.js';
import errorHandler from './middlewares/errorHandler.js';
import dotenv from 'dotenv'

dotenv.config();

const app = Express();

// middlewares
app.use(cors()); // to choose which servers or hosts can use this app
app.use(Express.static('./public'));
app.use(Express.json());

connectDB();

// routes
const baseRoute = `/api/v1`;
app.use(`${baseRoute}/tasks`, taskRouter);

app.use(notFoundHandler)
app.use(errorHandler)

const port = parseInt(process.env.SERVER_PORT);
app.listen(port, console.log(`server running on port ${port}!`));