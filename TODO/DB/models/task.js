import mongoose from "mongoose";

const taskSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'must provide the task name!'],
        trim: true,
        maxlength: [20, `name can't be more than 20 characters!`]
    },
    completed: {
        type: Boolean,
        default: false
    }
});

export default mongoose.model('tasks', taskSchema);
