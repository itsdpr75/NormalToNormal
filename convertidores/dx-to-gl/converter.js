document.getElementById('fileInput').addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function() {
            const img = new Image();
            img.onload = function() {
                const previewInput = document.getElementById('previewInput');
                previewInput.innerHTML = ''; // Limpiar la vista previa

                // Calcular el tamaño de escala para la vista previa de entrada
                let scaleFactorInput = 1;
                if (img.width > 400 || img.height > 400) {
                    scaleFactorInput = Math.min(400 / img.width, 400 / img.height);
                }

                const canvasInput = document.createElement('canvas');
                const ctxInput = canvasInput.getContext('2d');
                canvasInput.width = img.width * scaleFactorInput; // Establecer el ancho del lienzo
                canvasInput.height = img.height * scaleFactorInput; // Establecer el alto del lienzo
                ctxInput.drawImage(img, 0, 0, canvasInput.width, canvasInput.height); // Dibujar la imagen en el lienzo con el tamaño de escala
                previewInput.appendChild(canvasInput); // Mostrar la imagen seleccionada en la vista previa de entrada
            };
            img.src = reader.result;
        };
        reader.readAsDataURL(file);
    }
});

document.getElementById('convertButton').addEventListener('click', function() {
    const fileInput = document.getElementById('fileInput');
    const file = fileInput.files[0];

    if (file) {
        const reader = new FileReader();
        reader.onload = function() {
            const img = new Image();
            img.onload = function() {
                const canvasInput = document.createElement('canvas');
                const ctxInput = canvasInput.getContext('2d');
                canvasInput.width = img.width;
                canvasInput.height = img.height;
                ctxInput.drawImage(img, 0, 0);

                const imageDataInput = ctxInput.getImageData(0, 0, canvasInput.width, canvasInput.height);
                const dataInput = imageDataInput.data;

                for (let i = 0; i < dataInput.length; i += 4) {
                    let r = dataInput[i] / 255;
                    let g = dataInput[i + 1] / 255;
                    let b = dataInput[i + 2] / 255;

                    let x = (r * 2) - 1;
                    let y = (g * 2) - 1;
                    let z = (b * 2) - 1;

                    let length = Math.sqrt(x * x + y * y + z * z);
                    x /= length;
                    y /= length;
                    z /= length;

                    dataInput[i] = (x + 1) / 2 * 255;
                    dataInput[i + 1] = (y + 1) / 2 * 255;
                    dataInput[i + 2] = (z + 1) / 2 * 255;
                }

                ctxInput.putImageData(imageDataInput, 0, 0);

                const previewOutput = document.getElementById('previewOutput');
                previewOutput.innerHTML = ''; // Limpiar la vista previa de salida

                const canvasOutput = document.createElement('canvas');
                const ctxOutput = canvasOutput.getContext('2d');
                canvasOutput.width = 400; // Establece el ancho del canvas de salida a 400px
                canvasOutput.height = 400; // Establece la altura del canvas de salida a 400px
                ctxOutput.drawImage(canvasInput, 0, 0, canvasInput.width, canvasInput.height, 0, 0, canvasOutput.width, canvasOutput.height); // Escalar y copiar la imagen de entrada convertida en la de salida
                previewOutput.appendChild(canvasOutput); // Mostrar la imagen de salida en la vista previa de salida

                const downloadLink = document.getElementById('downloadLink');
                downloadLink.href = canvasInput.toDataURL('image/png'); // Guardar la imagen de salida en su resolución original
            };
            img.src = reader.result;
        };
        reader.readAsDataURL(file);
    }
});

document.getElementById('saveButton').addEventListener('click', function() {
    document.getElementById('downloadLink').click();
});
