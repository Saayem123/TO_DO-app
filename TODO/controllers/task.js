import task from "../DB/models/task.js"
import { createCustomError } from "../errors/custom-error.js";
import asyncWrapper from "../middlewares/asyncWrapper.js";

export const getAllTasks = asyncWrapper(
    async (req, res) => {
        const tasks = await task.find({});
        res.status(200).json({ tasks });
    }
);

export const getTask = asyncWrapper(
    async (req, res, next) => {
        const { id } = req.params;
        const singleTask = await task.findById(id);

        if (singleTask) {
            return res.status(200).json({ singleTask });
        }

        const error = createCustomError('Task Not Found', 404);
        next(error);
    }
);

export const editTask = asyncWrapper(
    async (req, res, next) => {

        // get the task to be updated
        const { id } = req.params;
        const targetTask = await task.findById(id);

        // check if the task not found
        if (!targetTask) {
            const error = createCustomError('Task Not Found', 404);
            next(error);
        }

        // update the chosen one
        const updatedTask = await task.findByIdAndUpdate(id, req.body, {
            new: true,
            runValidators: true
        });

        return res.status(200).json({ message: `task updated successfully!`, updatedTask });
    }
);

export const addTask = asyncWrapper(
    async (req, res, next) => {

        const { name } = req.body;
        const foundTask = await task.findOne({ name });

        // check if this task is already existed
        if (foundTask) {

            const error = createCustomError(`this task name already existed!`, 409);
            next(error);

        }

        const newTask = await task.create(req.body);

        return res.status(201).json({
            message: 'added new task successfully!',
            newTask
        });

    }
);

export const deleteTask = asyncWrapper(
    async (req, res, next) => {
        const { id } = req.params;
        const singleTask = await task.findById(id);

        // check if the task found to delete
        if (!singleTask) {
            const error = createCustomError('Task Not Found to delete!', 404);
            next(error);
        }

        // delete the chosen one
        const deletedTask = await task.findByIdAndDelete(id);

        return res.status(200).json({ message: 'Task Deleted Successfully!' });
    }
);