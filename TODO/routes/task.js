import { Router } from "express";
import * as taskControllers from "../controllers/task.js";

const router = Router();

router.get(`/`, taskControllers.getAllTasks);
router.get(`/:id`, taskControllers.getTask);
router.post(`/`, taskControllers.addTask);
router.patch(`/:id`, taskControllers.editTask);
router.delete(`/:id`, taskControllers.deleteTask);

export default router;