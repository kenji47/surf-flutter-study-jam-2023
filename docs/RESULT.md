# Результаты

Использован flutter_bloc для стейт-менеджмента и get_it для инжектирования зависимостей.

 ## Валидация pdf url ссылки в BottomSheet
Url считается валидным если:
- строка не пустая
- строка является url (Uri.parse(url).isAbsolute == true)
- файл имеет расширение pdf
<p align="center">
<img src="./assets/url_validation.gif" width=300 controls/>
</p>
<br/><br/>

## Скачивание файла pdf и сохранение в AppDirectory
Файлы сохраняются в /app_flutter. Должны были сохраняться в cache/AsyncTour
<p align="center">
<img src="./assets/file_save_directory.png" width="300"/>
</p>
<br/><br/>

## Прогресс загрузки файла
<p align="center">
<video width="320"  controls>
  <source src="./assets/pdf_progress.mp4" >
</video>
</p>
<br/><br/>

## Отмена загрузки
<p align="center">
<video width="320" controls>
  <source src="./assets/cancel_download.mp4" >
</video>
</p>
<br/><br/>

## Отображение снекбара при добавлении билета
<p align="center">
<img src="./assets/add_message.png" width="300"/>
</p>
<br/><br/>

## Удаление билета через свайп в сторону (Dismissable)
<p align="center">
<video width="320" controls>
  <source src="./assets/delete.mp4" >
</video>
</p>
<br/><br/>

## Просмотр pdf
<p align="center">
<video width="320" controls>
  <source src="./assets/view_pdf.mp4" >
</video>
</p>
