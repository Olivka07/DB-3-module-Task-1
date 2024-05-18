-- Creation of a test base...

CREATE DATABASE lr1_1;

--
-- База данных: `lr1_1`
--

-- --------------------------------------------------------

--
-- Структура таблицы `borrowed_funds`
--

CREATE TABLE `borrowed_funds` (
  `id_borrowedfunds` int(11) NOT NULL,
  `id_individual` int(11) NOT NULL,
  `sum` double NOT NULL,
  `percent` double NOT NULL,
  `rate` double NOT NULL,
  `time` varchar(20) NOT NULL,
  `conditionals` text NOT NULL,
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `borrowers`
--

CREATE TABLE `borrowers` (
  `id_borrowers` int(11) NOT NULL,
  `inn` varchar(10) NOT NULL,
  `binary_borrower` binary(1) NOT NULL,
  `address` varchar(20) NOT NULL,
  `sum` double NOT NULL,
  `conditionals` text NOT NULL,
  `lawyer_comment` text NOT NULL,
  `list_docs` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `borrowers`
--

INSERT INTO `borrowers` (`id_borrowers`, `inn`, `binary_borrower`, `address`, `sum`, `conditionals`, `lawyer_comment`, `list_docs`) VALUES
(10, '234234234', 0x31, 'Street Galact', 100, 'Some cond', 'No comments', 'No list docs');

-- --------------------------------------------------------

--
-- Структура таблицы `individual`
--

CREATE TABLE `individual` (
  `id_individual` int(11) NOT NULL,
  `id_borrowers` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `surname` varchar(20) NOT NULL,
  `passport` varchar(11) NOT NULL,
  `inn` varchar(10) NOT NULL,
  `snils` varchar(11) NOT NULL,
  `driver_license` varchar(11) NOT NULL,
  `additional_docs` text NOT NULL,
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `individual`
--

INSERT INTO `individual` (`id_individual`, `id_borrowers`, `first_name`, `last_name`, `surname`, `passport`, `inn`, `snils`, `driver_license`, `additional_docs`, `comment`) VALUES
(18, 10, 'Alexander', 'Piryushov', 'Sergeevich', '2222 441441', '101101', '555', '12345', 'Zagran passport: 1321312', 'No comments'),
(19, 10, 'Максим', 'Пирюшов', 'Сергеевич', '2223 441443', '111101', '155', '22345', 'Загран.паспорт: 1221312', 'No comments'),
(20, 10, 'Валерий', 'Белов', 'Михайлович', '2234 441432', '102101', '586', '12945', 'Загран.паспорт: 9321312', 'No comments'),
(21, 10, 'Алла', 'Васильева', 'Олеговна', '2452 120441', '111111', '777', '44444', 'Загран.паспорт: 1321399', 'No comments'),
(22, 10, 'Алиса', 'Сильникова', 'Николаевна', '7227 741447', '001100', '151', '44378', 'Загран.паспорт: 8888312', 'No comments');

-- --------------------------------------------------------

--
-- Структура таблицы `loans`
--

CREATE TABLE `loans` (
  `id_loans` int(11) NOT NULL,
  `id_organization` int(11) NOT NULL,
  `id_individual` int(11) NOT NULL,
  `sum` double NOT NULL,
  `time` varchar(20) NOT NULL,
  `percent` double NOT NULL,
  `conditionals` text NOT NULL,
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `borrowed_funds`
--
ALTER TABLE `borrowed_funds`
  ADD PRIMARY KEY (`id_borrowedfunds`),
  ADD KEY `id_individual` (`id_individual`);

--
-- Индексы таблицы `borrowers`
--
ALTER TABLE `borrowers`
  ADD PRIMARY KEY (`id_borrowers`);

--
-- Индексы таблицы `individual`
--
ALTER TABLE `individual`
  ADD PRIMARY KEY (`id_individual`),
  ADD KEY `id_borrowers` (`id_borrowers`);

--
-- Индексы таблицы `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id_loans`),
  ADD KEY `id_individual` (`id_individual`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `borrowed_funds`
--
ALTER TABLE `borrowed_funds`
  MODIFY `id_borrowedfunds` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `borrowers`
--
ALTER TABLE `borrowers`
  MODIFY `id_borrowers` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `individual`
--
ALTER TABLE `individual`
  MODIFY `id_individual` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT для таблицы `loans`
--
ALTER TABLE `loans`
  MODIFY `id_loans` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `borrowed_funds`
--
ALTER TABLE `borrowed_funds`
  ADD CONSTRAINT `borrowed_funds_ibfk_1` FOREIGN KEY (`id_individual`) REFERENCES `individual` (`id_individual`);

--
-- Ограничения внешнего ключа таблицы `individual`
--
ALTER TABLE `individual`
  ADD CONSTRAINT `individual_ibfk_1` FOREIGN KEY (`id_borrowers`) REFERENCES `borrowers` (`id_borrowers`);

--
-- Ограничения внешнего ключа таблицы `loans`
--
ALTER TABLE `loans`
  ADD CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`id_individual`) REFERENCES `individual` (`id_individual`);
COMMIT;