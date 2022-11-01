# LestaTest :notebook_with_decorative_cover:
Тестовое задание по программированию.

## Знакомство с игрой :newspaper:

Управление в игре осуществляется с помощью мыши, путём нажатия на кнопки.

По условию, существуют 3 вида фишек - *основных игровых кнопок*, которые различаются по цветам и рисункам:
  1) Зелёный слайм;
  2) Оранжевая тыква;
  3) Белая свеча.

В игре представлены 4 вида кнопок:
  1) Обычная пустая ячейка. Имеет рисунок квадрата.
  2) Выделенная пустая ячейка, куда можно переставлять фишки.
  3) Блок - ячейка, с которой нельзя взаимодествовать. Остаётся на месте до конца игры. Имеет рисунок надгробия.
  4) Фишка - *основная игровая кнопка*. Имеет 3 вида по 5 фишек.

Игровое поле - 25 кнопок, в числе которых 15 фишек, 6 блоков и 4 обычные пустые ячейки.
Над игровым полем расположены рисунки 3-х видов фишек, в соответствии с которыми нужно расположить фишки.
А именно, в столбец под каждым рисунком должно оказаться 5 фишек того же вида, что и рисунок.

<picture>
    <img alt="Выигрышное положение фишек." src="https://github.com/N0TKEY/self_limited_resourses/blob/cc4ff772edcf912d916bf245233312f4960a0313/lestaTest_winExample.PNG">
</picture>

## Описание процесса :scroll:

При запуске игра перемешивает положение фишек в рандомном порядке.
При нажатии на одну из фишек игра предоставляет возможность выбрать свободную ячейку в пределе 1 ячейки по вертикали, горизонтали и диагонали.
После выбора свободной ячейки, игра сохраняет выделение выбранной ранее фишки, что позволяет продолжить выбор для неё.
Чтобы отменить выделение, необходимо нажать повторно на эту фишку, нажать на блок или обычную пустую ячейку.
Изменить выбор выделенной фишки можно без отмены выделения, путём нажатия на любую другую фишку.

## Цель игры :label:

Надо расположить все фишки под соответствующие им рисунки.
При верном расположении фишек появится окно с поздравлением, закрытие или игнорирование которого приведёт к закрытию игры.

Приятной игры.
