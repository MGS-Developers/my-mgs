import shajs from "sha.js";

export const sha256 = (token: string): string => {
    return shajs('sha256').update(token).digest('hex');
}

export const randomCode = (length = 6): string => {
    let code = '';
    for (let i = 0; i < length; i++) {
        code += Math.floor(Math.random() * 10).toString();
    }

    return code;
}
