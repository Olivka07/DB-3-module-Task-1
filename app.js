// католог с модулем для синхр. работы с MySQL, который должен быть усталовлен командой: sync-mysql
const dir_nms = 'C:\\nodejs\\node_modules\\sync-mysql';

// работа с базой данных.
const Mysql = require('sync-mysql')
const connection = new Mysql({
    host:'localhost', 
    user:'root', 
    password:'', 
    database:'lr1_1'
})

// обработка параметров из формы.
var qs = require('querystring');
 function reqPost (request, response) {
    if (request.method == 'POST') {
        var body = '';


        request.on('data', function (data) {
            body += data;
        });

        request.on('end', function () {
			try {
				var post = qs.parse(body);
				const id = Number(post['col0']);
				const candidate =  connection.query(`SELECT * FROM individual WHERE id_individual=${id}`);
				if (candidate.length > 0) {
					var sUpdate = `UPDATE individual SET${post['col1'] !== '' ?` id_borrowers=${post['col1']},` : ''}${post['col2'] !== '' ? ` first_name='${post['col2']}',` : ''}${post['col3'] !== '' ? ` last_name='${post['col3']}',`: ''}${post['col4'] !== '' ? ` surname='${post['col4']}',` : ''}${post['col5']!== '' ? ` passport='${post['col5']}',` : ''}${post['col6'] !== '' ? ` inn='${post['col6']}',` : ''}${post['col7'] !== '' ? ` snils='${post['col7']}',` : ''}${post['col8'] !== '' ? ` driver_license='${post['col8']}',` : ''}${post['col9'] !== '' ? ` additional_docs='${post['col9']}',` : ''}${post['col10'] !== '' ? ` comment='${post['col10']}',` : ''}`.slice(0,-1) + ` where id_individual = ${id}`;
					console.log(sUpdate)
					var results =  connection.query(sUpdate);
					console.log('Done. Hint: '+sUpdate);
				} else {
					console.log('Fail. Hint: no rows with this id');
				}
			} catch(e) {
				console.log(e)
			}
			
			
        });
    }
}

// выгрузка массива данных.
function ViewSelect(res) {
	var results = connection.query('SHOW COLUMNS FROM individual');
	res.write('<tr>');
	for(let i=0; i < results.length; i++)
		res.write('<td>'+results[i].Field+'</td>');
	res.write('</tr>');

	var results = connection.query('SELECT * FROM individual ORDER BY id_individual DESC');
	for(let i=0; i < results.length; i++)
		res.write(`
		<tr>
			<td>${String(results[i].id_individual)}</td>
			<td>${String(results[i].id_borrowers)}</td>
			<td>${String(results[i].first_name)}</td>
			<td>${String(results[i].last_name)}</td>
			<td>${String(results[i].surname)}</td>
			<td>${String(results[i].passport)}</td>
			<td>${String(results[i].inn)}</td>
			<td>${String(results[i].snils)}</td>
			<td>${String(results[i].driver_license)}</td>
			<td>${String(results[i].additional_docs)}</td>
			<td>${String(results[i].comment)}</td>
		</tr>`);
}
function ViewVer(res) {
	var results = connection.query('SELECT VERSION() AS ver');
	res.write(results[0].ver);
}

// создание ответа в браузер, на случай подключения.
const http = require('http');
const server = http.createServer((req, res) => {
 	reqPost(req, res);
	console.log('Loading...1');
	
	res.statusCode = 200;
//	res.setHeader('Content-Type', 'text/plain');

	// чтение шаблока в каталоге со скриптом.
	var fs = require('fs');
	var array = fs.readFileSync(__dirname+'\\select.html').toString().split("\n");
	console.log(__dirname+'\\select.html');
	for(i in array) {
		// подстановка.
		if ((array[i].trim() != '@tr') && (array[i].trim() != '@ver')) res.write(array[i]);
		if (array[i].trim() == '@tr') ViewSelect(res);
		if (array[i].trim() == '@ver') ViewVer(res);
	}
	res.end();
	console.log('1 User Done.');
});

// запуск сервера, ожидание подключений из браузера.
const hostname = '127.0.0.1';
const port = 3000;
server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
