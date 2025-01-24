export class custom_error extends Error {
    constructor(msg, statusCode) {
        super(msg)
        this.statusCode = statusCode
    }
};

export const createCustomError = (message, statusCode) => {
    return new custom_error(message, statusCode);
}