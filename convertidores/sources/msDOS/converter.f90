program ConvertToNormals
    implicit none

    integer, parameter :: image_size = 1000
    real*4 :: data(image_size)
    integer :: i
    real*4 :: r, g, x, y, z, length

    ! Suponiendo que los datos de la imagen están en el arreglo "data"
    ! data = ...

    do i = 1, image_size, 4
        r = data(i) / 255.0
        g = data(i + 1) / 255.0

        x = (r * 2) - 1
        y = (g * 2) - 1
        z = sqrt(1 - x * x - y * y)

        length = sqrt(x * x + y * y + z * z)
        x = x / length
        y = y / length
        z = z / length

        data(i) = int((x + 1) / 2 * 255)
        data(i + 1) = int((y + 1) / 2 * 255)
        data(i + 2) = int((z + 1) / 2 * 255)
    end do

    ! Aquí se supone que has procesado los datos de la imagen
    ! data ahora contiene los valores convertidos a normales

end program ConvertToNormals
