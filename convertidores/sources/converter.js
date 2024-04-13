for (let i = 0; i < dataInput.length; i += 4) {
    let r = dataInput[i] / 255;
    let g = dataInput[i + 1] / 255;

    let x = (r * 2) - 1;
    let y = (g * 2) - 1;
    let z = Math.sqrt(1 - x * x - y * y);

    let length = Math.sqrt(x * x + y * y + z * z);
    x /= length;
    y /= length;
    z /= length;

    dataInput[i] = (x + 1) / 2 * 255;
    dataInput[i + 1] = (y + 1) / 2 * 255;
    dataInput[i + 2] = (z + 1) / 2 * 255;
}
