// Модуль для обработки массивов в YAML

// Обработка элемента массива в YAML
//
// Параметры:
//   ОчищеннаяСтрока - Строка - очищенная строка с элементом массива
//   ТекущийКонтекст - Произвольный - текущий контекст парсинга
//   СтекКонтекстов - Массив - стек контекстов
//   МенеджерЯкорей - Объект - менеджер якорей
//
Процедура ОбработатьЭлементМассива(ОчищеннаяСтрока, ТекущийКонтекст, СтекКонтекстов, МенеджерЯкорей) Экспорт
	// Проверяем, что текущий контекст - массив
	Если ТипЗнч(ТекущийКонтекст) <> Тип("Массив") Тогда
		Возврат;
	КонецЕсли;
	
	// Извлекаем значение элемента (убираем дефис и пробелы)
	ЗначениеЭлемента = СокрЛП(Сред(ОчищеннаяСтрока, 2));
	
	Если НЕ ПустаяСтрока(ЗначениеЭлемента) Тогда
		ОбработатьЗначениеЭлементаМассива(ЗначениеЭлемента, ТекущийКонтекст, СтекКонтекстов, МенеджерЯкорей);
	Иначе
		// Элемент массива - пустой объект (вложенная структура)
		СоздатьВложенныйОбъектВМассиве(ТекущийКонтекст, СтекКонтекстов);
	КонецЕсли;
КонецПроцедуры

// Обработка значения элемента массива
//
// Параметры:
//   ЗначениеЭлемента - Строка - значение элемента
//   ТекущийКонтекст - Массив - текущий массив
//   СтекКонтекстов - Массив - стек контекстов
//   МенеджерЯкорей - Объект - менеджер якорей
//
Процедура ОбработатьЗначениеЭлементаМассива(ЗначениеЭлемента, ТекущийКонтекст, СтекКонтекстов, МенеджерЯкорей) Экспорт
	// Проверяем, является ли это Flow style структурой
	ВложеннаяСтруктура = ПарсерПотоковыйСтиль.ПарсингFlowStyle(ЗначениеЭлемента);
	Если ВложеннаяСтруктура <> Неопределено Тогда
		ТекущийКонтекст.Добавить(ВложеннаяСтруктура);
		Возврат;
	КонецЕсли;
	
	// Проверяем, является ли это объектом (содержит :)
	Если НайтиПозициюДвоеточия(ЗначениеЭлемента) > 0 Тогда
		ОбработатьОбъектВМассиве(ЗначениеЭлемента, ТекущийКонтекст, СтекКонтекстов, МенеджерЯкорей);
	Иначе
		// Простое значение в массиве
		ЗначениеДляДобавления = ПреобразовательЗначений.ПреобразоватьЗначение(ЗначениеЭлемента);
		ТекущийКонтекст.Добавить(ЗначениеДляДобавления);
	КонецЕсли;
КонецПроцедуры

// Создание вложенного объекта в массиве
//
// Параметры:
//   ТекущийКонтекст - Массив - текущий массив
//   СтекКонтекстов - Массив - стек контекстов
//
Процедура СоздатьВложенныйОбъектВМассиве(ТекущийКонтекст, СтекКонтекстов) Экспорт
	НовоеСоответствие = Новый Соответствие;
	ТекущийКонтекст.Добавить(НовоеСоответствие);
	СтекКонтекстов.Добавить(НовоеСоответствие);
КонецПроцедуры

// Обработка объекта в массиве
//
// Параметры:
//   ЗначениеЭлемента - Строка - значение элемента с объектом
//   ТекущийКонтекст - Массив - текущий массив
//   СтекКонтекстов - Массив - стек контекстов
//   МенеджерЯкорей - Объект - менеджер якорей
//
Процедура ОбработатьОбъектВМассиве(ЗначениеЭлемента, ТекущийКонтекст, СтекКонтекстов, МенеджерЯкорей) Экспорт
	НовоеСоответствие = Новый Соответствие;
	ТекущийКонтекст.Добавить(НовоеСоответствие);
	СтекКонтекстов.Добавить(НовоеСоответствие);
	
	// Проверяем, является ли это YAML merge в массиве
	Если Лев(ЗначениеЭлемента, 3) = "<<:" Тогда
		ОбработатьMergeВМассиве(ЗначениеЭлемента, НовоеСоответствие, МенеджерЯкорей);
	Иначе
		ОбработатьКлючЗначениеВМассиве(ЗначениеЭлемента, НовоеСоответствие);
	КонецЕсли;
КонецПроцедуры

// Обработка YAML merge в массиве
//
// Параметры:
//   ЗначениеЭлемента - Строка - значение с merge
//   НовоеСоответствие - Соответствие - целевое соответствие
//   МенеджерЯкорей - Объект - менеджер якорей
//
Процедура ОбработатьMergeВМассиве(ЗначениеЭлемента, НовоеСоответствие, МенеджерЯкорей) Экспорт
	ЗначениеСтрока = СокрЛП(Сред(ЗначениеЭлемента, 4));
	
	Если Лев(ЗначениеСтрока, 1) = "*" Тогда
		ИмяЯкоря = Сред(ЗначениеСтрока, 2);
		ЗначениеЯкоря = МенеджерЯкорей.ПолучитьЗначениеЯкоря(ИмяЯкоря);
		
		Если ЗначениеЯкоря <> Неопределено И ТипЗнч(ЗначениеЯкоря) = Тип("Соответствие") Тогда
			СлитьСоответствия(ЗначениеЯкоря, НовоеСоответствие);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

// Обработка пары ключ-значение в массиве
//
// Параметры:
//   ЗначениеЭлемента - Строка - строка с парой ключ-значение
//   НовоеСоответствие - Соответствие - соответствие для добавления пары
//
Процедура ОбработатьКлючЗначениеВМассиве(ЗначениеЭлемента, НовоеСоответствие) Экспорт
	РезультатРазбора = РазобратьКлючЗначениеВМассиве(ЗначениеЭлемента);
	
	Если РезультатРазбора <> Неопределено И НЕ ПустаяСтрока(РезультатРазбора.Значение) Тогда
		Значение = ПреобразовательЗначений.ПреобразоватьЗначение(РезультатРазбора.Значение);
		НовоеСоответствие.Вставить(РезультатРазбора.Ключ, Значение);
	КонецЕсли;
КонецПроцедуры

// Разбор ключ-значение в массиве
//
// Параметры:
//   ЗначениеЭлемента - Строка - строка для разбора
//
// Возвращаемое значение:
//   Структура - структура с ключом и значением или Неопределено
//
Функция РазобратьКлючЗначениеВМассиве(ЗначениеЭлемента) Экспорт
	ПозицияДвоеточия = НайтиПозициюДвоеточия(ЗначениеЭлемента);
	Если ПозицияДвоеточия = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	КлючСКавычками = СокрЛП(Лев(ЗначениеЭлемента, ПозицияДвоеточия - 1));
	ЗначениеСтрока = СокрЛП(Сред(ЗначениеЭлемента, ПозицияДвоеточия + 1));
	
	// Обрабатываем ключ, убирая кавычки если они есть
	Ключ = ПреобразовательЗначений.ОбработатьКлючВКавычках(КлючСКавычками);
	
	// Удаляем комментарии из значения
	ЗначениеСтрока = ПарсерУровней.УдалитьКомментарии(ЗначениеСтрока);
	
	Возврат Новый Структура("Ключ, Значение", Ключ, ЗначениеСтрока);
КонецФункции

// Слияние двух соответствий (копирование всех ключей из источника в приемник)
//
// Параметры:
//   Источник - Соответствие - источник данных
//   Приемник - Соответствие - приемник данных
//
Процедура СлитьСоответствия(Источник, Приемник) Экспорт
	Для Каждого КлючЗначение Из Источник Цикл
		Приемник.Вставить(КлючЗначение.Ключ, КлючЗначение.Значение);
	КонецЦикла;
КонецПроцедуры

// Находит позицию двоеточия, игнорируя двоеточия внутри кавычек
//
// Параметры:
//   Строка - Строка - строка для поиска
//
// Возвращаемое значение:
//   Число - позиция двоеточия или 0, если не найдено
//
Функция НайтиПозициюДвоеточия(Строка)
	ВКавычках = Ложь;
	ТипКавычек = "";
	
	Для Позиция = 1 По СтрДлина(Строка) Цикл
		Символ = Сред(Строка, Позиция, 1);
		
		Если НЕ ВКавычках Тогда
			Если Символ = """" ИЛИ Символ = "'" Тогда
				ВКавычках = Истина;
				ТипКавычек = Символ;
			КонецЕсли;
			
			Если Символ = ":" Тогда
				Возврат Позиция;
			КонецЕсли;
		Иначе
			Если Символ = ТипКавычек Тогда
				ВКавычках = Ложь;
				ТипКавычек = "";
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат 0;
КонецФункции
