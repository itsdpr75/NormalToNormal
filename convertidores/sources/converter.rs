use std::vec::Vec;

fn convert_to_normals(data: &mut Vec<u8>) {
    for i in (0..data.len()).step_by(4) {
        let r = data[i] as f32 / 255.0;
        let g = data[i + 1] as f32 / 255.0;

        let x = (r * 2.0) - 1.0;
        let y = (g * 2.0) - 1.0;
        let z = (1.0 - x * x - y * y).sqrt();

        let length = (x * x + y * y + z * z).sqrt();
        let inv_length = 1.0 / length;
        let x_normalized = x * inv_length;
        let y_normalized = y * inv_length;
        let z_normalized = z * inv_length;

        data[i] = ((x_normalized + 1.0) / 2.0 * 255.0) as u8;
        data[i + 1] = ((y_normalized + 1.0) / 2.0 * 255.0) as u8;
        data[i + 2] = ((z_normalized + 1.0) / 2.0 * 255.0) as u8;
    }
}

fn main() {
    // Aquí se supone que tienes una variable "data" que contiene los datos de la imagen
    // let mut data: Vec<u8> = obtener_datos_de_imagen();
    // convert_to_normals(&mut data);
}
