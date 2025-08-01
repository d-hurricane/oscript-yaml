#Использовать asserts
#Использовать ".."
#Использовать "."

&ТестовыйНабор
Процедура ПриСозданииОбъекта() Экспорт
КонецПроцедуры

&Тест
Процедура ТестПарсингаСкалярнойСтроки() Экспорт
    // Дано
    СодержимоеФайла = ТестовыеУтилиты.ПрочитатьТекстФайла(ТестовыеУтилиты.ПолучитьПутьКТестовымДанным("scalar_string.yaml"));
    ЧтениеYaml = ТестовыеУтилиты.СоздатьЭкземплярПарсера();
    
    // Когда
    Результат = ЧтениеYaml.ПрочитатьYaml(СодержимоеФайла);
    
    // Тогда
    Ожидаем.Что(Результат).Равно("Hello World");
КонецПроцедуры

&Тест
Процедура ТестПарсингаСкалярнойСтрокиВКавычках() Экспорт
    // Дано
    СодержимоеФайла = ТестовыеУтилиты.ПрочитатьТекстФайла(ТестовыеУтилиты.ПолучитьПутьКТестовымДанным("scalar_quoted_string.yaml"));
    ЧтениеYaml = ТестовыеУтилиты.СоздатьЭкземплярПарсера();
    
    // Когда
    Результат = ЧтениеYaml.ПрочитатьYaml(СодержимоеФайла);
    
    // Тогда
    Ожидаем.Что(Результат).Равно("Hello World");
КонецПроцедуры

&Тест
Процедура ТестПарсингаСкалярногоЦелогоЧисла() Экспорт
    // Дано
    СодержимоеФайла = ТестовыеУтилиты.ПрочитатьТекстФайла(ТестовыеУтилиты.ПолучитьПутьКТестовымДанным("scalar_integer.yaml"));
    ЧтениеYaml = ТестовыеУтилиты.СоздатьЭкземплярПарсера();
    
    // Когда
    Результат = ЧтениеYaml.ПрочитатьYaml(СодержимоеФайла);
    
    // Тогда
    Ожидаем.Что(Результат).Равно(42);
КонецПроцедуры

&Тест
Процедура ТестПарсингаСкалярногоВещественногоЧисла() Экспорт
    // Дано
    СодержимоеФайла = ТестовыеУтилиты.ПрочитатьТекстФайла(ТестовыеУтилиты.ПолучитьПутьКТестовымДанным("scalar_float.yaml"));
    ЧтениеYaml = ТестовыеУтилиты.СоздатьЭкземплярПарсера();
    
    // Когда
    Результат = ЧтениеYaml.ПрочитатьYaml(СодержимоеФайла);
    
    // Тогда
    Ожидаем.Что(Результат).Равно(3.14);
КонецПроцедуры

&Тест
Процедура ТестПарсингаСкалярногоБулевогоИстина() Экспорт
    // Дано
    СодержимоеФайла = ТестовыеУтилиты.ПрочитатьТекстФайла(ТестовыеУтилиты.ПолучитьПутьКТестовымДанным("scalar_boolean_true.yaml"));
    ЧтениеYaml = ТестовыеУтилиты.СоздатьЭкземплярПарсера();
    
    // Когда
    Результат = ЧтениеYaml.ПрочитатьYaml(СодержимоеФайла);
    
    // Тогда
    Ожидаем.Что(Результат).Равно(Истина);
КонецПроцедуры

&Тест
Процедура ТестПарсингаСкалярногоБулевогоЛожь() Экспорт
    // Дано
    СодержимоеФайла = ТестовыеУтилиты.ПрочитатьТекстФайла(ТестовыеУтилиты.ПолучитьПутьКТестовымДанным("scalar_boolean_false.yaml"));
    ЧтениеYaml = ТестовыеУтилиты.СоздатьЭкземплярПарсера();
    
    // Когда
    Результат = ЧтениеYaml.ПрочитатьYaml(СодержимоеФайла);
    
    // Тогда
    Ожидаем.Что(Результат).Равно(Ложь);
КонецПроцедуры

&Тест
Процедура ТестПарсингаСкалярногоNull() Экспорт
    // Дано
    СодержимоеФайла = ТестовыеУтилиты.ПрочитатьТекстФайла(ТестовыеУтилиты.ПолучитьПутьКТестовымДанным("scalar_null.yaml"));
    ЧтениеYaml = ТестовыеУтилиты.СоздатьЭкземплярПарсера();
    
    // Когда
    Результат = ЧтениеYaml.ПрочитатьYaml(СодержимоеФайла);
    
    // Тогда
    Ожидаем.Что(Результат).ЭтоНеопределено();
КонецПроцедуры

&Тест
Процедура ТестПарсингаМассиваВерхнегоУровня() Экспорт
    // Дано
    СодержимоеФайла = ТестовыеУтилиты.ПрочитатьТекстФайла(ТестовыеУтилиты.ПолучитьПутьКТестовымДанным("scalar_top_level_array.yaml"));
    ЧтениеYaml = ТестовыеУтилиты.СоздатьЭкземплярПарсера();
    
    // Когда
    Результат = ЧтениеYaml.ПрочитатьYaml(СодержимоеФайла);
    
    // Тогда
    Ожидаем.Что(Результат).ИмеетТип("Массив");
    Ожидаем.Что(Результат.Количество()).Равно(3);
    Ожидаем.Что(Результат[0]).Равно("item1");
    Ожидаем.Что(Результат[1]).Равно("item2");
    Ожидаем.Что(Результат[2]).Равно("item3");
КонецПроцедуры

&Тест
Процедура ТестПарсингаМассиваВерхнегоУровнявФлоуНотации() Экспорт
    // Дано
    СодержимоеФайла = ТестовыеУтилиты.ПрочитатьТекстФайла(ТестовыеУтилиты.ПолучитьПутьКТестовымДанным("scalar_top_level_array_flow.yaml"));
    ЧтениеYaml = ТестовыеУтилиты.СоздатьЭкземплярПарсера();
    
    // Когда
    Результат = ЧтениеYaml.ПрочитатьYaml(СодержимоеФайла);
    
    // Тогда
    Ожидаем.Что(Результат).ИмеетТип("Массив");
    Ожидаем.Что(Результат.Количество()).Равно(3);
    Ожидаем.Что(Результат[0]).Равно("item1");
    Ожидаем.Что(Результат[1]).Равно("item2");
    Ожидаем.Что(Результат[2]).Равно("item3");
КонецПроцедуры